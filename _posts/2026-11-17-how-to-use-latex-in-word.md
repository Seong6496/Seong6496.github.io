---
title: "How to Use LaTeX in Word: Typing Equations, and Fixing a Document Full of Pasted LaTeX"
date: 2026-11-17 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/how-to-use-latex-in-word/
categories: [LaTeX, Tutorial]
tags: [latex, word, microsoft-word, equations, docx, scan, paste, guide]
math: false
pin: false
description: "How to use LaTeX in Word: type it into an equation and convert it, paste LaTeX that Word turns into equations by itself, or select LaTeX text and use Insert › Equation. Which Word versions do what, which LaTeX Word does not understand, and what to do with a whole .docx already full of $…$ formulas."
---

<!-- Sources: Microsoft Learn "LaTeX Support in Microsoft 365" (learn.microsoft.com/en-us/office/math/latex, ms.date 2026-04-22, read 2026-11-03): paste recognition needs $…$, $$…$$, \(…\), \[…\]; Insert Equation / Convert to Professional need no delimiters; Version 2606 (Windows) / 16.110 (Mac); unsupported commands; \tag / \label discarded. Web Scan facts: 11-07 post. Our tool never outputs Word equations (OMML) - images with LaTeX in alt text. -->

You can use LaTeX in Word in three ways: type it inside an equation and convert it, paste LaTeX wrapped in `$…$` or `\[…\]` and let Word turn it into an equation, or select LaTeX text already in the document and use **Insert › Equation**. All three make real Word equations, one formula at a time; for a document that already holds dozens of formulas as LaTeX text, a converter such as the free [LaTeXFlow Scan](/latexflow/web/) does them all in one pass.

The details below follow Microsoft's own [LaTeX support page](https://learn.microsoft.com/en-us/office/math/latex) (dated 22 April 2026, read on 3 November 2026). Features differ by Word version, so the version notes matter.

## 1. Type LaTeX into a Word equation

This is the route for writing a new formula.

1. Put the cursor where the equation should go and press **Alt+=** (or **Insert › Equation**). An equation box appears, and the **Equation** tab opens on the ribbon.
2. On the Equation tab, choose **LaTeX** as the input format.
3. Type the LaTeX without delimiters, for example `\frac{-b \pm \sqrt{b^2-4ac}}{2a}`.
4. Convert it to the built-up (**Professional**) form from the Equation tab. The text becomes a formatted Word equation.

<!-- TODO shot: Word (Microsoft 365, version shown in File › Account) with an equation box containing \frac{-b \pm \sqrt{b^2-4ac}}{2a} typed in LaTeX mode, the Equation tab open with the LaTeX input option selected. -->
<!-- TODO shot: the same equation after converting to Professional. -->

The equation stays editable in Word's equation editor, and Word can turn it back into LaTeX later.

## 2. Paste LaTeX and let Word convert it

In **Word in Microsoft 365, version 2606 or later on Windows (16.110 or later on Mac)**, pasting text that is clearly LaTeX converts it into a Word equation as it lands. "Clearly LaTeX" means it is wrapped in one of four delimiter pairs:

| Wrapped in | Becomes |
|---|---|
| `$…$` or `\(…\)` | an inline equation |
| `$$…$$` or `\[…\]` | a display equation |

Text without one of those delimiters is pasted as ordinary text. Older versions support some of this but not all of it, according to the same page.

This is the simplest route when you paste a fresh answer from ChatGPT or Gemini into an up-to-date Word. One exception: ChatGPT answers often lose their backslashes on the way and arrive as bare `[ … ]`, which is not one of the four pairs, so Word pastes those as text ([where that shape comes from](/blog/en/posts/chatgpt-bracket-math-to-latex/)).

## 3. Convert LaTeX that is already in the document

If the LaTeX is already sitting in the document as text, select one formula and use **Insert › Equation**. Word converts the selection into an equation; delimiters are optional here.

That is one formula per selection. Fine for three formulas, slow for sixty.

## 4. Which LaTeX Word does not understand

Word's converter covers the common maths: fractions, roots, sums and integrals, Greek letters, `\left…\right`, matrices, `cases`, and multi-line environments such as `align*`, `aligned`, `gather*` and `multline*`. A few things are worth knowing before you rely on it:

- **Unsupported commands are kept as literal text** inside the equation, for example `\smash{x}`, `\DeclareMathOperator`, `\dv{f}{x}` from the physics package, or `\SI{3}{m}` from siunitx. Rewrite those with plain commands (`\frac{d f}{d x}`, `3\,\mathrm{m}`).
- **Equation numbers are dropped:** `\tag`, `\label` and `\eqref` are read and silently discarded.
- **Sizes are simplified:** `\dfrac` and `\tfrac` become `\frac`; `\big`, `\Big` and the rest become auto-sized brackets.

## 5. A whole .docx full of LaTeX at once

Sometimes the formulas are already in a document as LaTeX text: an AI answer saved into Word, notes typed with `$…$` to keep going, a file from a colleague. Selecting each one is the slow part. LaTeXFlow Scan converts them all in one pass:

1. Open [LaTeXFlow Scan](/latexflow/web/) in the browser. Dragging a `.docx` in needs no account.
2. Drop the `.docx` onto the drop area.
3. Review the cards, one per formula with a live preview. Press **Skip** on anything that is not maths, such as a price like `$100`.
4. Press **Render PNG · Export** and download the new `.docx`.

What comes back is worth stating plainly: every formula is a rendered **image** with its LaTeX kept in the alt text, **not** an editable Word equation. It looks the same everywhere the file is opened, and the LaTeX is still there when you need it. If you need editable Word equations instead, use sections 2 and 3. Scan also reads bare `[ … ]` from chatbots, which Word's paste does not.

The step-by-step with screenshots is in [LaTeX to Word Equation Converter: Every Equation in a .docx at Once](/blog/en/posts/latex-to-word-equation-converter/).

## 6. FAQ

**Can you use LaTeX in Word?**
Yes. Word converts LaTeX into its own equations in three ways: typed into an equation box in LaTeX mode, pasted with `$…$`-type delimiters (version 2606 or later), or selected and converted with Insert › Equation.

**How do I write LaTeX in Word?**
Press Alt+=, choose LaTeX as the input format on the Equation tab, type the LaTeX without dollar signs, and convert it to Professional (section 1).

**Why is my LaTeX not converting in Word?**
Usually one of three reasons: the Word version is older than 2606, so pasting does not convert; the formula has no delimiter, so it was pasted as text; or it uses a command Word does not support, which stays as literal text (section 4).

**Is there a LaTeX add-in for Word?**
Word's built-in LaTeX input covers single formulas. For a whole document of LaTeX text, LaTeXFlow Scan is a web page, not an add-in: nothing is installed in Word (section 5).

## 7. Summary

- **One new formula:** Alt+=, LaTeX input, type, convert to Professional.
- **A fresh AI answer:** paste it into Word 2606 or later; `$…$`, `$$…$$`, `\(…\)` and `\[…\]` convert on their own.
- **A few formulas already in the text:** select each, **Insert › Equation**.
- **A whole document of LaTeX text:** drop the `.docx` on [LaTeXFlow Scan](/latexflow/web/), review, **Render PNG · Export**. Free, and every formula comes back rendered with its LaTeX kept alongside it.
