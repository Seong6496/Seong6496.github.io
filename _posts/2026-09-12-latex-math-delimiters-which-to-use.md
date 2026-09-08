---
title: "LaTeX Math Delimiters: Which of the Four to Use, and Where Each Breaks"
date: 2026-09-12 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/latex-math-delimiters-which-to-use/
categories: [LaTeX, Reference]
tags: [latex, delimiters, inline-math, display-math, tex, reference]
math: true
pin: false
description: "One dollar sign, two dollar signs, backslash-paren, backslash-bracket. Four ways to wrap the same equation, from two different eras, with different failure modes in Markdown, in chatbot answers, and in conversion tools. Which one to reach for, and what each one costs."
---

There are four ways to wrap the same equation, and they are not interchangeable.

```
$x^2 + y^2 = r^2$
$$x^2 + y^2 = r^2$$
\(x^2 + y^2 = r^2\)
\[x^2 + y^2 = r^2\]
```

The short answer, if you only need one: **in a `.tex` file use `\(…\)` and `\[…\]`; everywhere else — Markdown, Notion, Obsidian, Jupyter, a Word or Google Docs file you intend to convert, a prompt to a chatbot — use `$…$` and `$$…$$`.** The rest of this post is why, and what goes wrong when you pick the other one.

Two axes separate the four: **inline or display**, and **TeX notation or LaTeX notation**.

## 1. The four, at a glance

| Delimiter | Kind | Origin | Example |
|---|---|---|---|
| `$ … $` | inline | plain TeX | `$a^2+b^2$` |
| `$$ … $$` | display | plain TeX | `$$E = mc^2$$` |
| `\( … \)` | inline | LaTeX | `\(a_i\)` |
| `\[ … \]` | display | LaTeX | `\[\int_a^b f\,dx\]` |

## 2. Inline versus display

**Inline** math sits in the flow of a sentence. The typesetter squeezes it so it does not disturb the line height.

> A circle of radius $r$ has area $\pi r^2$.

**Display** math is pulled out of the paragraph onto its own centred line, with vertical space around it.

$$\int_0^1 x^2\,dx = \frac{1}{3}$$

The difference is not only whitespace — the same commands typeset differently. Compare a sum:

- Inline: $\sum_{n=1}^{\infty} \frac{1}{n^2}$ — the limits sit **beside** the sigma.
- Display:

$$\sum_{n=1}^{\infty} \frac{1}{n^2} = \frac{\pi^2}{6}$$

The limits move **above and below**. A limit behaves the same way: inline $\lim_{x \to 0}$ keeps its subscript on the side, display puts it underneath.

So the choice follows from the content:

- A single symbol or variable mid-sentence → **inline**.
- Multi-line, stacked fractions, layered subscripts, anything the reader should stop and look at → **display**.

Forcing a tall expression inline gives you ragged line spacing and crushed subscripts. Pulling a lone variable into display breaks the sentence in half.

## 3. Where each notation came from

**The dollar signs are TeX.** In Knuth's plain TeX, `$` is a switch that toggles math mode on and off. The defining property is that the opening and closing marks are *the same character*. `$$` extends that to display mode.

**The backslash forms are LaTeX's own.** LaTeX is a system where commands begin with a backslash, so its math delimiters were made to match. `\(` and `\[` open; `\)` and `\]` close — *different characters* on each end.

That distinction has three practical consequences.

**① Mismatches are much easier to locate with the backslash forms.**

Because `$` opens and closes with the same character, dropping one does not produce an error at the drop site. Every `$` after it silently swaps roles, and the compiler complains somewhere far below — usually pointing at a line where the dollar count looks perfectly balanced. With `\(` and `\)` the pair is unambiguous, so the mismatch shows up where it is.

**② Double dollars are discouraged inside LaTeX documents.**

If you are writing a `.tex` file, prefer `\[…\]` over `$$…$$`. Double dollars ignore document options such as `fleqn` (which left-aligns display math), and the vertical spacing they produce varies with context. The `amsmath` documentation recommends `\[…\]` or a proper `equation` environment for the same reason.

**③ In the Markdown world the dollar sign is the de facto standard.**

Markdown, Notion, Obsidian, Jupyter and most static-site math renderers expect `$…$` and `$$…$$`. These are not LaTeX documents — they are Markdown with a math renderer bolted on, and the convention there went the other way.

## 4. Which to use when

| Where | Use | Why |
|---|---|---|
| LaTeX document (`.tex`) | `\(…\)` · `\[…\]` | consistent with document options and spacing |
| Markdown · Notion · Obsidian | `$…$` · `$$…$$` | the de facto standard in that ecosystem |
| Word or Google Docs, to be converted later | `$…$` · `$$…$$` | short to type, easy to spot by eye |
| A prompt to a chatbot | `$…$` · `$$…$$` | survives the copy path |

The last row has a separate reason. When a chatbot answer passes through the chat window's own Markdown rendering, the backslashes can be eaten. `\[…\]` degrades into a bare `[…]`, which is at least recoverable by a heuristic. `\(…\)` degrades into a bare `( … )`, and **that is not recoverable at all** — parentheses are far too common in ordinary prose for any tool to guess. Dollar signs come through intact. That is the whole argument for asking a chatbot for `$…$` and `$$…$$`.

## 5. Delimiters are not environments

LaTeX also has math *environments*, which get discussed as if they were the same layer. They are not.

```latex
\begin{equation}
  E = mc^2
\end{equation}
```

`\[…\]` does almost the same job — precisely, it is equivalent to the unnumbered `equation*`.

| Written as | Result |
|---|---|
| `\[ … \]` | unnumbered display equation |
| `equation*` environment | same |
| `equation` environment | numbered display equation |
| `align` · `gather` environments | multi-line, numbered per line |

If you need numbering so the prose can say *"as shown in equation (3)"*, you need an environment, not a delimiter.

**This matters to conversion tools, for one specific reason:** a converter reads delimiters. It does not read environments. So if a Word or Google Docs file contains

```
\begin{equation} E = mc^2 \end{equation}
```

typed out as ordinary text, it will **not** be detected — `\begin` is not a delimiter. (It will still surface as a *looks like math* candidate paragraph, because there are backslashes in it.) If you are writing in a word processor with conversion in mind, wrap in `$$…$$` instead.

And if you genuinely need numbering and cross-references, write the document in LaTeX to begin with. A converter is aimed at making an *existing* document usable; it does not manage equation numbers for you.

## 6. How conversion tools treat the four

LaTeXFlow reads all four — in both of its forms, the [web app](/latexflow/web/) and the Google Docs add-on. But the two are separate programs with separate scanners, and on one point they behave very differently. It is worth keeping them apart.

**Double dollars are always unambiguous.** `$$` is a two-character pair, so the open and close positions are determined. There is nothing to guess. The same is true of `\(…\)` and `\[…\]`: opener and closer are different strings, so pairing is automatic.

**A single dollar with an odd count is where the two diverge.** If a paragraph contains an odd number of `$`, there is genuinely no way to know which one opens.

- In the **web app**, that paragraph is pulled out into an **ambiguity card** — `⚠ Odd number of $ — equation boundaries are ambiguous` — and nothing from it is converted until you deal with it. The card gives you two buttons, *Edit text* and *Skip*.
- In the **add-on**, there is no such card and no odd/even logic at all. The regular expressions simply pair left to right. Given the sentence *"when the price rises by \$5, demand is \$x\$"*, the pairing starts at the currency symbol and the match runs from `5` through to the `$` before `x` — so a stretch of prose is captured as an equation, and the equation you meant is missed. The card preview shows you the prose, so you can skip it.

Escaping currency as `\$5` avoids this in both.

**Overlap is resolved differently too.** In something like `$\(x\)$` the same span could be claimed twice.

- The **web app** has each scanner precompute the paragraph's `$` and `$$` spans and skip any match overlapping one — in effect, dollars win.
- The **add-on** collects every match from all four patterns, sorts by starting position (longer match wins a tie), and drops anything overlapping a span already accepted — earliest start wins.

Either way a given span is claimed exactly once; the winner just differs.

## 7. The fifth case: bare brackets from a chatbot

There is one more thing a converter will pick up:

```
[\lim_{x\to0}\frac{\sin x}{x}]
```

**That is not LaTeX.** It is what `\[ … \]` degrades into when a ChatGPT answer is copied out and the outer backslashes are eaten along the way. Bracket mode exists to recover exactly that.

Treating every bare bracket as math would produce unusable false positives, so there is a condition: the bracket must contain at least one of `\`, `^`, `_`, or `=`.

- `[\frac{1}{2}]` → has a backslash → matched ✅
- `[y=2x]` → has an equals sign → matched ✅
- `[note]`, `[1]`, `[Table 1]` → no signal → not matched ✅
- `[1,5]` (an interval) → no signal → **not matched** ❌ — wrap it yourself as `$[1,5]$`

Nesting is handled: in `[\sqrt{[a+b]}]` the scanner counts depth to find the outer pair. Brackets already inside math are protected — the `[X^2]` in `$E[X^2]$` sits inside a dollar span and is not claimed a second time.

Bracket mode is **additive**. It runs as a separate pass whose results are merged with the standard hits. Turning it on takes nothing away, and turning it off changes nothing about how the four standard delimiters are read.

**One known limitation, in the web app only.** There, the bracket scanner's exclusion list covers the `$` and `$$` spans but not `\[…\]`. So a document containing a genuine `\[E=mc^2\]` can have `[E=mc^2\]` claimed a second time, and the same equation appears twice in the list. Skip one of them, or turn bracket mode off. The add-on is not affected — its exclusion list covers all four standard patterns, so the `[` inside a real `\[` is skipped.

**The default differs between the two products.**

| | Bracket mode default |
|---|---|
| Web app | **on** |
| Google Docs add-on (*Extensions → LatexFlow → Open Equation Panel*) | **off** |

The web app mostly receives `.docx` files with pasted chatbot answers in them, so it is on by default. The add-on is working inside a document you are actively writing, where a bracket is more likely to be prose. Either way it is a checkbox.

## 8. Traps

**Prices get matched as math.** A lone `$100` looks exactly like an opening delimiter. This is expected behaviour — skip it in the review screen, or, in the web app, resolve it from the ambiguity card. In a document full of currency it is easier to escape them as `\$100` up front.

**Display math split across paragraphs.**

```
$$
E = mc^2
$$
```

Written on three lines in a word processor, that is three *paragraphs*. The opening and closing `$$` land in different paragraphs and never pair up. Keep it in one paragraph, or use a line break (`Shift` + `Enter`) rather than a paragraph break.

**A line break inside single-dollar math.** The add-on's inline pattern does not step over line breaks. Inline math has to open and close on one line.

**Mixing an opener with the wrong closer.**

```
\(x^2$
```

Nothing pairs with anything here. Open and close each equation with the same notation.

## 9. Quick decision

- Short, inside a sentence → `$…$` (in a `.tex` file, `\(…\)`)
- Standalone and large → `$$…$$` (in a `.tex` file, `\[…\]`)
- Asking a chatbot → dollar signs only
- Got an answer back with nothing but bare brackets → turn bracket mode on

If the document you want to convert is a Google Doc, the delimiters above are exactly what the add-on looks for: [how to convert LaTeX in Google Docs](/blog/en/posts/convert-latex-in-google-docs/).

## 10. FAQ

**Can I mix all four in one document?**
Yes. The scanners run independently and overlaps are resolved, so a mixed document still detects correctly. It is harder for a human to read later, though, so pick one per document.

**What if I just write `\frac{1}{2}` with no delimiter at all?**
It will not be detected. LaTeX without delimiters is ordinary text. The tool will still offer the paragraph as a *looks like math* candidate, but it will not convert it on its own.

**Which delimiter should I put around an equation made with the equation editor?**
None of them will help. An equation inserted by an equation editor is not text — it is an object in the file, with nowhere to put a delimiter. What Google Docs stores for such an equation is worth knowing in its own right: [what the Google Docs equation editor actually stores](/blog/en/posts/google-docs-equation-editor-internals/).

**Is there a triple dollar, or some other notation?**
Not in standard use. The four above plus the LaTeX math environments (`equation`, `align`, and friends) are effectively all of it.

## 11. Summary

- Two inline (`$…$`, `\(…\)`) and two display (`$$…$$`, `\[…\]`). That is the whole axis.
- Dollar signs are TeX notation, backslash forms are LaTeX notation. Use the latter in `.tex` files, the former in Markdown and in conversion workflows.
- Whether the opener and closer are the same character decides how painful a mismatch is to find.
- Bracket mode is not LaTeX. It is a recovery device for the chatbot copy path — on by default in the web app, off in the add-on.
