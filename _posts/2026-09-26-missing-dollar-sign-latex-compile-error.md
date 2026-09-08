---
title: "One Missing Dollar Sign, One Failed Compile: Finding It Before LaTeX Does"
date: 2026-09-26 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/missing-dollar-sign-latex-compile-error/
categories: [LaTeX, Troubleshooting]
tags: [latex, compile-error, missing-dollar, math-mode, pdflatex, troubleshooting]
math: true
pin: false
description: "Missing dollar inserted, and the line number it points at is not where the problem is. Why an unclosed math delimiter poisons everything after it, why one mistake produces a cascade of errors, and how to catch the odd-count paragraph while it is still a manuscript."
---

Hours before a deadline, `pdflatex` stops with this:

```
! Missing $ inserted.
<inserted text>
                $
l.137 be positive.
```

You open line 137. The dollar signs there look balanced. They are — because **line 137 is where the parser gave up, not where the mistake is.** The unclosed delimiter is somewhere above, possibly pages above.

The cause is usually mundane: one inline equation missing its closing `$`, or half of a `$$…$$` block deleted by accident. The difficulty is entirely that the compiler reports *where things stopped making sense*, not *where they stopped being correct*.

Two things follow, and this post covers both: how to narrow the search in a `.tex` file, and how to catch the same mistake earlier, while the document is still a manuscript.

## 1. Why an unclosed delimiter is hard to find

### 1-1. Mode leakage contaminates the sentences after it

The key fact is that `$` is a **switch**. An opening `$` moves from text mode into math mode; a closing `$` moves back. Drop one and the switch is left on, so every ordinary sentence that follows is parsed as mathematics. This is usually called mode leakage.

The error then surfaces somewhere unrelated. In math mode spaces are ignored and letters are set in maths italic, so a perfectly good phrase like `be positive` is read as the product of the variables `b·e·p·o·s·i·t·i·v·e`. Nothing is wrong with that yet — it is legal maths. Only when the parser meets a token that math mode does not allow does it raise `! Missing $ inserted.` That token is on line 137. The delimiter you actually dropped is above it.

This is a direct consequence of the dollar sign's design: **the opener and the closer are the same character.** With `\(` and `\)`, the pair is distinguishable and a mismatch is reported where it happens. With `$`, there is no way to tell an unmatched opener from an unmatched closer, which is [one of the real trade-offs between the four delimiters](/blog/en/posts/latex-math-delimiters-which-to-use/).

### 1-2. One mistake, a cascade of errors

Once the mode is wrong, one error rarely stays one error. Commands like `\section`, `\item` and `\begin{...}` behave unexpectedly inside math mode, and you get a train of secondary failures — `! Missing } inserted.`, `! LaTeX Error: Something's wrong--perhaps a missing \item.` The rule is to work from the top error down, but the top error's line number is not the cause either, which makes tracing worse.

Editor syntax highlighting is little help. Because `$` opens and closes with the same character, dropping one just inverts the colouring of everything after it; it does not tell you *which* pair broke. That leaves counting dollar signs by eye, paragraph by paragraph — and the more equations the document has, the longer that takes.

**Narrowing it down in a `.tex` file:**

- The problem is *above* the reported line, never below it.
- Look for the last place the document typeset correctly. In a PDF from a previous successful build, the point where the text starts rendering in maths italic is the paragraph you want.
- Count dollar signs per paragraph, not per line. An inline `$` must open and close within one paragraph, so a paragraph with an odd count is the paragraph at fault.
- Suspect the usual sources first — see section 5.

That last rule is the useful one, because it is mechanical enough to automate.

## 2. Catching it before the compile

If your manuscript is a `.docx` rather than a `.tex` file — which it often is, up until the point where everything gets converted — the odd-count rule can be applied while you are still writing.

The [web app](/latexflow/web/) does exactly that. Drop the file in, and while it scans for equations it also counts `$` per paragraph. Any paragraph with an odd count cannot have its equation boundaries determined, so rather than guess, it is pulled out into an **ambiguity card** before anything is converted. The warning line reads:

```
⚠ Odd number of $ — equation boundaries are ambiguous
```

with a guide underneath headed *"Likely a missed closing $"*.

The header then shows a count like *Selected 5 · Skipped 0 · Unresolved ambiguity 2* — five equations detected cleanly, two paragraphs where the pairing cannot be settled.

Each card shows the paragraph's text as it is. For instance:

- `3) Let $\alpha + 1 be positive.` — one `$`, never closed.
- `6) The formulas $\int e^x\, dx = e^x + C$ and $\lim_{n \to \infty} (1 + 1/n)^n = e$ hold but $a + b = c fails without closure.` — the third `$` is never closed.

Where `pdflatex` gives you one line number, this gives you the paragraph, with the text in front of you.

**Note this is a feature of the web app only.** The Google Docs add-on has no odd-dollar logic at all; its patterns simply pair left to right, which in the same situation swallows a stretch of prose as if it were an equation. There is no ambiguity card in the add-on to look for.

## 3. Fixing the paragraph

A card has two buttons: **Edit text** and **Skip**.

**Edit text** opens the paragraph in a text box. Below the box is a live preview that re-scans as you type, showing:

```
Detected: 0 equations · still ambiguous
```

Add the missing `$` and the preview updates immediately, so you can see *where the pair closes* before saving. No compile, no log to read — you confirm the delimiter is balanced in the same screen where you are writing.

A warning sits above the edit box: *"Editing will remove any formatting (bold, italic, colors) from this entire paragraph."* followed by *"Fix the LaTeX or add the missing $ delimiter, then Save."* The paragraph is replaced as plain text, so any bold, italics or colour on it is lost.

Change `3) Let $\alpha + 1 be positive.` to `3) Let $\alpha + 1$ be positive.`, press Save, and the header counts move: *Selected 5 → 6*, *Unresolved 2 → 1*. The newly closed `$\alpha + 1$` joins the detected equations, and only paragraph 6 remains.

The preview earns its place on the second one. In `but $a + b = c fails`, you can close the delimiter after `c` or after `fails`, and the two give different equations. The preview renders `a+b=c` cleanly in the first case, so the intended boundary is obvious immediately — rather than discovering after a compile that the word *fails* got dragged into the equation.

When every card is resolved the header reads *Unresolved ambiguity 0*, the cards disappear, and only the detected equation list is left.

## 4. Real dollar signs are not errors

An economics or statistics paper full of `$100` and `$5.99` will raise ambiguity cards, because those dollar signs are counted like any other. That is not a mistake being found; it is the tool declining to guess.

Press **Skip** on the card and the paragraph drops out of equation detection, leaving the `$100` in the text exactly as it is.

One detail worth knowing, because it looks like a bug otherwise: **skipping an ambiguity card does not increase the `Skipped` count in the header.** That counter tracks skipped *equations*. Skipping an ambiguity card removes the card, so the visible effect is `Unresolved ambiguity` going down and nothing else.

If a document has a lot of currency in it, escaping the amounts as `\$100` up front avoids the whole interaction.

## 5. Where these creep in

An unclosed `$` is less a matter of carelessness than of specific working patterns. Knowing them tells you which paragraph to suspect.

- **A dollar lost while copying.** Dragging an equation out of another document, a chat window or an old draft frequently selects only one of the two delimiters. It is especially easy when a sentence-final `$` is followed by a full stop — the stop survives the selection and the `$` does not.
- **Tables and captions.** Cells and captions are narrow, so equations get compressed and a delimiter gets dropped. Worse, the compiler's line number for an error in these points inside the table or figure environment, which makes tracing harder still.
- **Currency read as maths.** As above — real money, not an error.
- **Documents merged from several authors.** In a co-authored paper where one person writes `$...$` and another writes `\(...\)`, the seams are where pairs break.

## 6. FAQ

**How can it know about a `$` error without compiling?**
It does not parse the syntax the way a compiler does. It counts `$` delimiters per paragraph. An inline `$` must open and close, so the count within a paragraph has to be even — an odd count means one side is missing. That one rule is enough to identify the paragraph exactly, which is precisely what the compiler's line number fails to do.

**Can it fix my `.tex` file directly?**
No. It does not compile LaTeX and does not edit `.tex` files. It works on `.docx` manuscripts, and what it does is (1) check for mismatched `$` at the manuscript stage and (2) render the equations to PNG images and export a `.docx`. For a `.tex` source you still need a real LaTeX compile.

**Can I use it alongside Overleaf?**
That is the intended use. It complements a compiler rather than replacing one. Balance the delimiters in the manuscript to remove the `Missing $ inserted` round trips, and leave final typesetting, bibliography and cross-references to Overleaf or a local `pdflatex`.

**What renders the preview?**
Temml and MathJax, in the browser. There can be small differences from final typesetting, but for confirming that a pair is closed and a boundary is where you meant it, it is sufficient.

## 7. Summary

- `Missing $ inserted` points at where parsing broke, not where the delimiter was dropped. Look **above** the reported line.
- Because `$` opens and closes with the same character, one omission leaks math mode into the following text and produces a cascade of unrelated errors.
- The reliable manual rule is to count dollar signs **per paragraph**, not per line — an odd count is the culprit.
- On a `.docx` manuscript that check can happen before the compile, and the odd-count paragraph is shown to you with its text and a live preview.
- Genuine currency raises the same flag. Skip it, or escape it as `\$100`.

Fixing one mismatched delimiter early is worth more than the one error it removes. That single `$` leaks into the paragraphs after it and generates secondary and tertiary failures; closing it at the manuscript stage means the errors you do meet at compile time are the real typesetting ones — references, cross-references, package conflicts.

---

- The four delimiters and their trade-offs → [which to use, and where each breaks](/blog/en/posts/latex-math-delimiters-which-to-use/)
- Nothing detected at all → [detected 0 equations](/blog/en/posts/no-latex-delimiters-recover-document/)
