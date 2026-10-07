---
title: "Download as Markdown from Google Docs™: What Happens to Your Equations"
date: 2026-10-20 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/google-docs-markdown-export-equations/
categories: [Google Docs, Reference]
tags: [google-docs, markdown, export, equations, latex, equation-editor, copy-as-markdown, reference]
math: false
pin: false
description: "Google Docs™ has two ways to get Markdown out — File > Download > Markdown (.md) and Edit > Copy as Markdown — and they treat equations differently. Measured on one test document: Download keeps equation-editor equations as real LaTeX in $…$; Copy as Markdown flattens them to bare characters and drops Greek letters; LaTeX typed as text comes out escaped (\\$E \\= mc^2\\$); an inline image keeps its alt text, with Markdown escapes, and the image becomes a base64 data URI. Paste from Markdown does not turn $…$ back into equations."
---

You have a Google Docs™ document with equations in it and you want Markdown — for a static site, a notes app, a README, or to hand the text to a tool that reads Markdown. Docs has two built-in ways to get it, and on the same document they do not agree about equations.

This post is one table of what each way produced on a test document, followed by what that means for each kind of equation. Everything here was measured on 2026-10-07 in Chrome, with the Docs interface in English, on one test document that holds each case once. Nothing below is a claim about documents we did not test.

## 1. The two ways out, and the switch that hides one of them

- **A. File > Download > Markdown (.md)** — always in the File menu, no setting needed. Saves a `.md` file.
- **B. Edit > Copy as Markdown** — not visible until you turn on **Tools > Preferences > General > Enable Markdown**. On the account we tested, that box was unchecked by default. The same switch adds **Edit > Paste from Markdown**, which goes the other way (column C below).

The equations in the test document were made three ways: with the Docs equation editor (**Insert > Symbols > Equation**), as an inline image with the LaTeX in its alt text, and as LaTeX typed as ordinary text between dollar signs.

## 2. The result table

| Item in the document | A. Download as Markdown | B. Copy as Markdown | C. Paste from Markdown |
|---|---|---|---|
| 1. Editor equation (`a/b + Σ_{i=1}^n x_i² + α`) | `$\frac{a}{b}+\sum\limits_{i=1}^{n}{{x}_{i}}^{2}+\alpha$` — real LaTeX in `$…$` | `ab+i=1nxi2+` — flattened to bare characters, no delimiters; **α dropped** | n/a |
| 1b. Editor equation in a table cell (β²) | `${\beta }^{2}$` inside the table row (see below) | `2` — **β dropped**, only `2` left | n/a |
| 2. Inline image, alt text = `\int_0^1 x^2\,dx = \frac{1}{3}` | `![\\int\_0^1 x^2\\,dx = \\frac{1}{3}][image1]` + at file end `[image1]: <data:image/png;base64,…>` — alt text kept (Markdown-escaped), image embedded as base64 data URI | same shape as A | image inserted from `![…](url)`, alt becomes `\int_0^1 x^2,dx = \frac{1}{3}` (**`\,` lost its backslash** — read as a Markdown escape) |
| 2-raw. Same LaTeX left as text (`$\int_0^1 x^2\,dx = \frac{1}{3}$`) | `\$\\int\_0^1 x^2\\,dx \= \\frac{1}{3}\$` | identical to A | — |
| 3. Plain inline text `$E = mc^2$` | `\$E \= mc^2\$` — every `$`, `\`, `_`, `=` escaped | identical to A | `$x^2$` stays literal text, no equation created |
| 3b. Plain display text `$$\nabla \cdot \mathbf{E} = \rho/\varepsilon_0$$` | `\$\$\\nabla \\cdot \\mathbf{E} \= \\rho/\\varepsilon\_0\$\$` | identical to A | `$$\frac{a}{b}$$` stays literal text, no equation |
| 4a. Heading 1 | `# Probe heading` | `# Probe heading` | not measured |
| 4b. Bold | `**bold**` | `**bold**` | not measured |
| 4c. Bulleted list | `* First bullet` / `* Second bullet` | identical | not measured |
| 4d. 2×2 table | pipe table, first row becomes the header | identical (cell equation degraded as in 1b) | not measured |
| 4e. Footnote | `footnote[^1]` … `[^1]:  Footnote body text.` | identical | not measured |

The table row for 1b, exactly as each export wrote it:

```text
A:  | Cell  A | ${\beta }^{2}$ |
B:  | Cell  A | 2 |
```

For B, the dropped letters were checked by code point, not by eye: the copied text for item 1 contains no U+03B1 (α).

One side effect that touches every document: separate Normal-text paragraphs came out joined with trailing two-space line breaks, and a `-` in running text was escaped as `\-`.

## 3. Equation-editor equations: Download keeps them, Copy loses them

This is the one place where the choice between A and B matters most.

**Download as Markdown** writes each editor equation as LaTeX between single dollar signs. The LaTeX is the editor's own spelling rather than what you might type: the sum came out as `\sum\limits_{i=1}^{n}`, and `x_i²` as `{{x}_{i}}^{2}`, with extra braces. It is still LaTeX, delimited the way most Markdown math setups expect. If you are moving a document to a site that renders `$…$`, A is the path that carries the maths. (We did not render the exported file in any particular site generator; check yours with one equation first.)

**Copy as Markdown** writes the characters of the equation in a row with the structure gone: `a/b + Σ x_i² + α` became `ab+i=1nxi2+`. The fraction bar, the sum sign, the sub- and superscript positions and the Greek letter are all missing, and nothing marks where the equation was. In a table cell, β² became `2`. Nothing warns you; the pasted text simply reads wrong.

## 4. LaTeX typed as text comes out escaped

If your equations are LaTeX source sitting in the document as text — `$E = mc^2$` typed into a paragraph — both A and B escape every Markdown-significant character: `\$E \= mc^2\$`, and `\\frac`, `\_0` inside longer expressions.

A Markdown renderer shows that as the literal text `$E = mc^2$`, which is what was in the document. A math renderer that looks for `$…$` (MathJax, KaTeX) does not see an equation, because the dollar signs are escaped. To render these as maths after export you have to un-escape them first — remove the backslash in front of `$`, `=`, `_` and the doubled backslashes in commands. Display maths (`$$…$$`) behaves the same way.

## 5. Images with LaTeX in the alt text

Item 2 is an inline PNG whose alt text holds the LaTeX source. **How it was measured:** the image in the test document was placed by hand, and its alt text was typed into **Image options > Alt text** ("Describe the image") by hand. It was not inserted by any add-on.

Both A and B keep the alt text, with Markdown escapes added (`\\int\_0`), and write the image itself as a reference to a base64 `data:image/png` URI at the end of the file. That makes the file large: with one 256-pixel PNG, the downloaded `.md` was about 480 KB.

A note for readers who use the LaTeXFlow add-on for Google Docs™, since its equations are also images with LaTeX attached. Reading its source code (not a measurement): the add-on writes the LaTeX to the image's alt **title** field (`setAltTitle`), with a prefix such as `AIMATH_FORMULA::v2::inline::` in front of it, and does not write the alt description. The Docs Alt text panel shows only the description field, and the test above filled that field. Whether Download or Copy as Markdown includes the alt **title** was **not measured**, so we do not know whether add-on images come out with their LaTeX.

## 6. Paste from Markdown does not make equations

Column C is the reverse direction: **Edit > Paste from Markdown** with Markdown on the clipboard.

- `$x^2$` and `$$\frac{a}{b}$$` were pasted as literal text. No equation-editor equation was created.
- An image written as `![alt](https://…png)` was fetched and inserted, and the alt text came along — minus the backslashes that Markdown treats as escapes. `\,` became `,`, so the LaTeX in the alt text was no longer the LaTeX that was copied.

So Markdown is not a round trip for equations in Docs: what goes out as `$…$` does not come back as an equation.

## 7. What was not measured

- An image inserted by the LaTeXFlow add-on itself, and whether the alt **title** appears in either export (§5).
- Paste from Markdown for headings, bold, lists, tables and footnotes (only `$…$`, `$$…$$` and an image were pasted).
- Download as Markdown for a document with more than one tab.
- Any interface language other than English, and any account other than the one tested.

## Summary

| You have | Use | What you get |
|---|---|---|
| Equation-editor equations | **File > Download > Markdown (.md)** | LaTeX in `$…$` |
| Equation-editor equations | Edit > Copy as Markdown | Bare characters, Greek letters dropped — avoid |
| LaTeX typed as text | Either | Escaped text — un-escape before a math renderer will see it |
| Images with LaTeX in alt text (description field) | Either | Image as base64 data URI, alt text kept with escapes |
| Markdown with `$…$`, going into Docs | Edit > Paste from Markdown | Literal text, not equations |

---

- How the editor builds the equations that Download keeps → [The Google Docs Equation Editor: Typing It Fast, and the Four Things It Cannot Build](/blog/en/posts/google-docs-equation-editor-typing-and-limits/)
- What the editor stores underneath → [What Google Docs' Equation Editor Actually Stores](/blog/en/posts/google-docs-equation-editor-internals/)
- The other direction, a `.tex` file into Docs → [Bringing a LaTeX File into Google Docs™: What Works Today, Step by Step](/blog/en/posts/latex-file-into-google-docs-what-works-today/)
