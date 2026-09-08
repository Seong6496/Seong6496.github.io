---
title: "ChatGPT Wrote Your Math in Square Brackets: How to Convert It Anyway"
date: 2026-09-16 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/chatgpt-bracket-math-to-latex/
categories: [LaTeXFlow, Guide]
tags: [chatgpt, latex, bracket-mode, markdown, docx, ai]
math: true
pin: false
description: "Copy a ChatGPT answer into a document and the display equations arrive as bare square brackets, backslashes gone. Which backslashes Markdown eats and why, which delimiters survive the trip, and how bracket mode recovers the ones that did not."
---

You asked ChatGPT for twenty AP Calculus BC practice problems, copied the answer, and pasted it into a document. On screen the equations were rendered beautifully. In the document they look like this:

```
[\lim_{x \to 2} \frac{x^2-4}{x-2}]
```

Not `$…$`, not `\[ … \]` — **LaTeX sitting inside a bare square bracket**. Conversion tools look for `$…$`, `$$…$$`, `\(…\)` and `\[…\]`, so they walk straight past this.

The short version: the outer backslashes were eaten by the chat window's own Markdown rendering, and this specific damage *is* recoverable — that is what **bracket mode** is for. In the [web app](/latexflow/web/) it is on by default, so you can drag the file in as-is. In the Google Docs add-on it ships **off**, and you tick it yourself.

The longer version — why only the outer backslashes vanish, which delimiters survive intact, and how to stop it happening again — is below.

## 1. The symptom: a bracket pair with the backslashes missing

### 1-1. What went wrong

What ChatGPT actually emitted was a perfectly normal display equation. The damage happens when the answer is rendered to your screen. The delimiter's backslashes are absorbed by the renderer; the backslashes of the commands inside survive. Copy that, paste it, and you get:

```
ChatGPT emitted: \[\lim_{x \to 2} \frac{x^2-4}{x-2}\]
Arrived in doc:  [\lim_{x \to 2} \frac{x^2-4}{x-2}]
```

`\lim` and `\frac` are intact; only the outer `\[` `\]` became `[` `]`. To a human it still reads as an equation. To a parser it is an ordinary sentence with no math delimiter in it.

### 1-2. Why only the outer backslashes disappear

The first time you see this, the obvious question is why `\frac` survived and `\[` did not. The answer is that the backslash was not deleted — the chat UI **renders the answer as Markdown before showing it to you**.

In the model's raw text, `\[ … \]` is a signal meaning *this span is display math*. The chat window reads that signal and draws the equation. The moment it draws it, the delimiters themselves have done their job and drop out of the visual output. What you drag-select and copy is not the raw text — it is **the rendered result**. So the delimiter backslashes never come along, and what remains is the bracket shell plus the `\lim` and `\frac` that make up the equation itself. Inner commands leave a trace in the rendering; the outer delimiter is a signpost that gets taken down once you have arrived.

The important part is that the leftover shape differs by delimiter:

| Original delimiter | What survives the paste | Recoverable? |
|---|---|---|
| `$ … $` (inline) | `$ … $`, unchanged | No loss — detected normally |
| `$$ … $$` (display) | `$$ … $$`, unchanged | No loss — detected normally |
| `\[ … \]` (display) | `[ … ]` (outer backslashes lost) | **Yes** — bracket mode catches it |
| `\( … \)` (inline) | `( … )` (outer backslashes lost) | **No** — see below |

The dollar forms survive Markdown rendering as literal text, so they never become a problem in the first place. `\[…\]` is flattened to `[…]`, but the bracket shell is enough to work with. The last row is the one that hurts.

### 1-3. Why the inline paren form cannot be recovered

Render `\(…\)` and what is left is a plain parenthesis, `( … )`. Parentheses are far too common in ordinary writing — *the function f(x)*, *the interval (0, 1)*, *a remark (see above)*. A tool that treated parentheses as equation candidates would turn every document into a pile of false positives.

So the bracket scanner only considers candidates that open with a square bracket `[`. Round parentheses are deliberately left alone. The consequence is that a `( … )` descended from `\(…\)` cannot be brought back — there is simply no evidence left that it was ever math. That is why the table says *no*, and why the next section tells you to ask chatbots not to use it.

### 1-4. Why the standard patterns do not match

Detection is delimiter matching. `$…$` looks for a pair of dollars; `\[…\]` looks for a pair of backslashed brackets. A bare `[ … ]` is neither.

But treating every square bracket as math is not an option either. Real documents are full of `[note]`, `[1]`, `[Table 1]`. A single twenty-problem answer can bring dozens of them along. What is needed is a rule that opens up brackets *without* touching prose.

## 2. Asking the chatbot differently

The most reliable fix is not a better tool — it is **getting the chatbot to emit a safe format in the first place**. As the table shows, the dollar forms survive the paste intact, so if the answer arrives wrapped in dollars, bracket mode never has to do anything.

Say this before you ask for the content:

> Write every formula in LaTeX — `$...$` for inline, `$$...$$` for display. Do not use `\(...\)` or `\[...\]`. Never write math as plain text.

Three things matter there:

- **Standardise on `$…$` and `$$…$$`** — the only forms with no copy loss.
- **Ban `\(...\)`** — rendering turns it into `( … )` and it is gone for good (see 1-3). `\[...\]` is also best avoided, but at worst bracket mode recovers it.
- **Ban plain text** — writing `x^2` as *"x squared"* removes the LaTeX entirely, and then no tool can help.

One request to avoid: **do not ask for a .docx file.** A chatbot-generated `.docx` stores its equations as Word equation objects (`<m:oMath>`), and a tool that reads raw LaTeX text in a document cannot read those. Take the answer as text and paste it into an empty document yourself.

## 3. Bracket mode

If you already have an answer flattened into `[…]`, this is what it is for.

### 3-1. The checkbox

Open the [web app](/latexflow/web/) and there is a checkbox under the drop zone.

![The tool's first screen, showing the bracket mode checkbox](/assets/img/posts/2026-07-17/01-bracket-mode-option.png){: width="720" }

*"Also detect bracket `[\...]` equations (common in AI chatbot output)"* — **on by default** in the web app. If you came here while cleaning up a chatbot answer, drop the file in without touching anything. Your file is read in the browser and is not uploaded to us.

Ticking it does not push `$…$` or `\[…\]` equations aside. The dollar scan, the backslash scan and the bracket scan each run and add their results to the same detection list, so a document mixing several forms gets all of them. It is an **additive** mode, not a replacement. That is also why the default is on — in a document with no bracket equations, leaving it on changes nothing at all.

The Google Docs add-on has the same checkbox but ships it **off**, because a document you are actively writing in Docs is more likely to contain brackets that are genuinely prose.

### 3-2. What it looks for inside the brackets

Upload the file and the bracket equations appear in *Detected Equations* alongside the standard ones.

![Bracket equations in the detection list](/assets/img/posts/2026-07-17/02-bracket-detection.png){: width="720" }

The rule is simple: a bracket counts as math **only if it contains a LaTeX signature — one of `\`, `^`, `_`, `=`**. `[\lim_{x \to 2} \frac{x^2-4}{x-2}]` has a backslash and an underscore, so it matches. `[note]`, `[1]`, `[Table 1]` have none, so they do not. The *open brackets without touching prose* requirement from the previous section is satisfied by that one line.

Nesting is handled by depth counting, so `[\sqrt{[a+b]}]` finds its outer pair correctly, and brackets already inside a dollar span — the `[X^2]` in `$E[X^2]$` — are not claimed twice.

Cards in the list behave exactly like standard equations: check the preview, correct it with **Edit LaTeX**, or drop a non-equation with **Skip**.

### 3-3. Render and export

When the review is done, press **Render PNG · Export** at the top.

![Ready to render and export](/assets/img/posts/2026-07-17/03-render-export.png){: width="720" }

Every selected equation is rendered to PNG and placed back where it was, in a new `.docx` download. Body formatting is untouched and only the equation positions are replaced, so the problem numbers and section breaks the chatbot produced survive intact. Each PNG carries the original LaTeX in its alt text, so the source of an equation can be recovered later.

## 4. False positives

Treating brackets as equation candidates is convenient, and occasionally it catches a bracket that is not math. The signature filter removes most prose, but not all of it:

- **Citation numbers** — `[1]` has no signature and is safe, but something like `[1=main]`, or a bracket in a table sitting against LaTeX characters, can surface.
- **Interval and array notation** — `[a, b]` is safe, but if a `^` or `_` happens to fall inside the brackets it will match.

Since bracket detection is deliberately generous, the assumption is that **you filter at the review step**. Find the card that is not an equation in *Detected Equations* and press **Skip**; that position keeps its original text and is not turned into an image. That is how a misfired citation or array gets removed.

Note that one bracket case is *not* a false positive but a genuine double-catch: in the web app, a document containing a real `\[E=mc^2\]` can also have `[E=mc^2\]` claimed by the bracket scanner, listing the same equation twice. Skip one, or turn bracket mode off. The add-on excludes those spans and is not affected.

## 5. Which answers need bracket mode

Chatbot answers arrive in `$…$` / `$$…$$` more often than not, and those go down the standard detection path with no involvement from bracket mode at all.

Bracket mode is for the case above: the outer backslashes lost during Markdown rendering. If you can see shapes like `[\frac{...}{...}]` in the pasted document, that is this.

You do not have to work out which case you have in advance. In the web app both paths run at once with bracket mode already on, so whatever form the answer took, just drop the file in.

## 6. FAQ

**Does it differ between chatbots?**
It depends on the chatbot and its settings. Any UI that renders the answer as Markdown on screen can flatten the outer delimiters. Some chatbots tend to emit display math wrapped in `$$`, which loses less on copy — Gemini, for instance. But that can change with version and settings, so rather than assume, check the pasted document for `[\...]` shapes yourself. Either way the remedy is the same.

**Why can `\(...\)` not be saved?**
Rendering leaves only `( … )`, and parentheses are so common in prose that treating them as candidates would produce an explosion of false positives. The scanner therefore only looks at candidates opening with `[`. So a `( … )` that came from `\(...\)` has no evidence left to act on. Ask chatbots for `$...$` inline as well.

**Where does the original LaTeX go?**
Into the alt text of each equation image in the exported `.docx`. Turning the equation into a picture does not throw the source away.

**Can I turn bracket mode off if false positives worry me?**
Yes. The cost is that `[\...]` shapes are then not detected at all and you fix them by hand. Leaving it on and pressing **Skip** on the occasional bad card is usually less work. In a document with no bracket equations, leaving it on changes nothing.

**Can I just ask the chatbot to produce the .docx?**
Not recommended. A chatbot-produced `.docx` puts the equations in as Word equation objects (`<m:oMath>`), and a tool reading raw LaTeX text in the document cannot read them. Take the answer as text and paste it into an empty document.

---

- Not sure which delimiter to use where → [the four delimiters, and which is safe where](/blog/en/posts/latex-math-delimiters-which-to-use/)
- Nothing detected at all → [detected 0 equations](/blog/en/posts/no-latex-delimiters-recover-document/)
- Working in Google Docs rather than a `.docx` → [how to convert LaTeX in Google Docs](/blog/en/posts/convert-latex-in-google-docs/)
