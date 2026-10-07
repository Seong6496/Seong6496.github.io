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
description: "Google Docs™ has two ways to get Markdown out — File > Download > Markdown (.md) and Edit > Copy as Markdown — and they treat equations differently. Measured on one test document: Download keeps equation-editor equations as real LaTeX in $…$; Copy as Markdown flattens them to bare characters and drops Greek letters; LaTeX typed as text comes out escaped (\\$E \\= mc^2\\$); an image becomes a base64 data URI, with the alt description as the ![alt] text and the alt title as the link title — which is where the LaTeXFlow add-on's LaTeX ends up. Paste from Markdown does not turn $…$ back into equations."
---

You have a Google Docs™ document with equations in it and you want Markdown — for a static site, a notes app, a README, or to hand the text to a tool that reads Markdown. Docs has two built-in ways to get it, and on the same document they do not agree about equations.

This post is one table of what each way produced on a test document, followed by what that means for each kind of equation. Everything here was measured on 2026-10-07 in Chrome, on two test documents that hold each case once: the main one with the Docs interface in English, and a second one on another account, with the interface in Korean, for the add-on image row (2-addon). Nothing below is a claim about documents we did not test.

## 1. The two ways out, and the switch that hides one of them

- **A. File > Download > Markdown (.md)** — always in the File menu, no setting needed. Saves a `.md` file.
- **B. Edit > Copy as Markdown** — not visible until you turn on **Tools > Preferences > General > Enable Markdown**. On the account we tested, that box was unchecked by default. The same switch adds **Edit > Paste from Markdown**, which goes the other way (column C below).

The equations in the test documents were made four ways: with the Docs equation editor (**Insert > Symbols > Equation**), as an inline image whose alt text was typed in by hand, as an image inserted by the LaTeXFlow add-on, and as LaTeX typed as ordinary text between dollar signs.

## 2. The result table

| Item in the document | A. Download as Markdown | B. Copy as Markdown | C. Paste from Markdown |
|---|---|---|---|
| 1. Editor equation (`a/b + Σ_{i=1}^n x_i² + α`) | `$\frac{a}{b}+\sum\limits_{i=1}^{n}{{x}_{i}}^{2}+\alpha$` — real LaTeX in `$…$` | `ab+i=1nxi2+` — flattened to bare characters, no delimiters; **α dropped** | n/a |
| 1b. Editor equation in a table cell (β²) | `${\beta }^{2}$` inside the table row (see below) | `2` — **β dropped**, only `2` left | n/a |
| 2-addon. Image inserted by the LaTeXFlow add-on from `$\int_0^1 x^2\,dx = \frac{1}{3}$` (LaTeX in the alt **title**) | `![][image1]` + at file end `[image1]: <data:image/png;base64,…> "AIMATH_FORMULA::v2::inline::\\int_0^1 x^2\\,dx = \\frac{1}{3}"` — **alt empty**, LaTeX in full as the link title, backslashes doubled | same shape as A | not measured |
| 2. Inline image, alt **description** typed by hand = `\int_0^1 x^2\,dx = \frac{1}{3}` | `![\\int\_0^1 x^2\\,dx = \\frac{1}{3}][image1]` + at file end `[image1]: <data:image/png;base64,…>` — alt text kept (Markdown-escaped), image embedded as base64 data URI | same shape as A | image inserted from `![…](url)`, alt becomes `\int_0^1 x^2,dx = \frac{1}{3}` (**`\,` lost its backslash** — read as a Markdown escape) |
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

A Docs image has two alt-text fields, a **description** and a **title**, and the two exports put them in different places. Both A and B write the image itself as a reference to a base64 `data:image/png` URI at the end of the file, and then:

- the alt **description** becomes the `![…]` text, and
- the alt **title** becomes the link title in quotes on the reference line, `[image1]: <data:…> "title"`.

The two image rows in the table show one field each.

**Row 2 — description, typed by hand.** The image was placed by hand, and its alt text was typed into **Image options > Alt text** ("Describe the image") — the field that panel shows is the description. Both A and B keep it as the `![…]` text, with Markdown escapes added (`\\int\_0`). With one 256-pixel PNG, the downloaded `.md` was about 480 KB.

**Row 2-addon — title, written by the LaTeXFlow add-on for Google Docs™.** Here the installed add-on scanned the paragraph `$\int_0^1 x^2\,dx = \frac{1}{3}$` and converted it to an image. The add-on writes the LaTeX to the image's alt **title**, prefixed with `AIMATH_FORMULA::v2::inline::`, and leaves the description empty. Both A and B produced exactly:

```text
![][image1]
[image1]: <data:image/png;base64,…> "AIMATH_FORMULA::v2::inline::\\int_0^1 x^2\\,dx = \\frac{1}{3}"
```

The LaTeX is all there, including the `\,`, with each backslash doubled as Markdown escaping inside the title string. What that means in practice:

- A Markdown renderer shows the PNG with **no alt text**, because `![]` is empty — a screen reader gets nothing to read either.
- A script can still recover the LaTeX from the title: drop the `AIMATH_FORMULA::v2::inline::` prefix (`display` instead of `inline` for display equations) and halve the backslashes.
- The base64 data in A and B differed, though both decode to the same 89×21 PNG — the two exports encode the image separately.

This row was measured on a different account with the Docs interface in Korean, where the same menus are labelled 파일 > 다운로드 > 마크다운(.md) and 수정 > 마크다운으로 복사.

## 6. Paste from Markdown does not make equations

Column C is the reverse direction: **Edit > Paste from Markdown** with Markdown on the clipboard.

- `$x^2$` and `$$\frac{a}{b}$$` were pasted as literal text. No equation-editor equation was created.
- An image written as `![alt](https://…png)` was fetched and inserted, and the alt text came along — minus the backslashes that Markdown treats as escapes. `\,` became `,`, so the LaTeX in the alt text was no longer the LaTeX that was copied.

So Markdown is not a round trip for equations in Docs: what goes out as `$…$` does not come back as an equation.

## 7. What was not measured

- Paste from Markdown for an image with a link title (row 2-addon, column C), and for headings, bold, lists, tables and footnotes (only `$…$`, `$$…$$` and an image without a title were pasted).
- Download as Markdown for a document with more than one tab.
- Any interface language or account other than the two tested (English for the main document, Korean for row 2-addon).

## Summary

| You have | Use | What you get |
|---|---|---|
| Equation-editor equations | **File > Download > Markdown (.md)** | LaTeX in `$…$` |
| Equation-editor equations | Edit > Copy as Markdown | Bare characters, Greek letters dropped — avoid |
| LaTeX typed as text | Either | Escaped text — un-escape before a math renderer will see it |
| Images with LaTeX in the alt description | Either | Image as base64 data URI, LaTeX as the `![…]` text, escaped |
| Images inserted by the LaTeXFlow add-on | Either | Image as base64 data URI, `![]` empty, LaTeX in the link title with its `AIMATH_FORMULA::v2::…::` prefix |
| Markdown with `$…$`, going into Docs | Edit > Paste from Markdown | Literal text, not equations |

---

- How the editor builds the equations that Download keeps → [The Google Docs Equation Editor: Typing It Fast, and the Four Things It Cannot Build](/blog/en/posts/google-docs-equation-editor-typing-and-limits/)
- What the editor stores underneath → [What Google Docs' Equation Editor Actually Stores](/blog/en/posts/google-docs-equation-editor-internals/)
- The other direction, a `.tex` file into Docs → [Bringing a LaTeX File into Google Docs™: What Works Today, Step by Step](/blog/en/posts/latex-file-into-google-docs-what-works-today/)
