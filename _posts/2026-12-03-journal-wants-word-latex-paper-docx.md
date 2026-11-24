---
title: "Your Journal Wants Word: Submitting a LaTeX Paper as .docx"
date: 2026-12-03 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/journal-wants-word-latex-paper-docx/
categories: [LaTeXFlow, Guide]
tags: [latex, word, docx, tex-to-docx, journal, submission, equations, citations, cross-references]
math: false
pin: false
description: "Wrote the paper in LaTeX, and the journal asks for a Word file? What a .docx submission needs to keep (equation numbers, references, citations, editable tables), what a quick conversion loses, and how to get a Word file from your .tex that keeps them, with the numbers we measured on 53 unseen papers."
---

<!-- Sources: R243 held-out table (.tmp/r243_heldout.md, the only public numbers: 53 papers with .aux; equation numbers 96.1 vs 0.0, cross-references 93.6 vs 25.5, citations 92.2 vs 8.2, editable equations 97.1 vs 90.1; Word 2016 opened 55/55 without repair; Fields.Update changed 0 numbers; S4 = journal .sty/.cls numbering rules not read). Live page latexflow/tex-to-docx/index.html (options: paper size, live cross-references on/off, reference style; what carries over / what does not yet; privacy sentence; first 3 pages + report free). Prices: tech-status v1.1 / R262 draft (7-day $6.99, monthly $19.99). No competitor names; "a common free converter" = the R243 free route at default settings. -->

You wrote the paper in LaTeX. Then the journal's author guidelines say the manuscript goes in as a Word file, or the editor asks for one at the revision stage, or a co-author in the statistics team wants to comment with tracked changes. This happens a lot in medicine, epidemiology, biostatistics and parts of the social sciences, where Word is the house format and LaTeX is the exception.

You do not have to rewrite the paper. A converter that reads your `.tex` the way LaTeX does can give you a `.docx` that keeps what the editors look at: numbered equations, references to them, citations and a reference list.

## 1. What the Word file has to keep

Author guidelines differ, so read yours first. Most of what goes wrong in a converted manuscript falls into a few places:

- **Equation numbers and references to them.** "As shown in (3)" has to point at equation (3), and still do after an editor's change.
- **Citations and the reference list.** In-text citations in the journal's form, and a numbered list at the end.
- **Tables as tables.** Editable Word tables, not pictures, so the production team can restyle them.
- **Editable equations.** Word equations a copy editor can click into.
- **Figures** are often uploaded as separate files anyway; the manuscript needs the captions and the figure numbers in the text.

## 2. What a quick conversion loses

LaTeX computes the numbers when it compiles: equation (3), Table 2, reference [14]. They are not in your `.tex` file; they are worked out from `\label`, `\ref` and `\cite`. A converter that only translates the source text has nothing to put there, so you get blanks, raw keys such as `[eq:model]`, or numbers that are wrong.

We measured this. On 53 arXiv papers the converter had never seen, scored against each paper's own LaTeX output:

| On 53 unseen papers | LaTeXFlow | A common free converter (default settings) |
|---|---|---|
| Equation numbers that match LaTeX | **96.1%** | 0.0% |
| References (`\ref`, `\eqref`) with the right number | **93.6%** | 25.5% |
| Citations that come through | **92.2%** | 8.2% |
| Equations that are editable Word equations | **97.1%** | 90.1% |

Every one of our files opened in Word without a repair prompt, and updating all fields in Word changed none of the numbers. How the numbers are rebuilt and scored is in [How Equation Numbers Survive the Trip From LaTeX to Word](/blog/en/posts/how-equation-numbers-survive-latex-to-word/).

## 3. Converting the paper

1. Open the [LaTeX to Word converter](/latexflow/tex-to-docx/?utm_source=blog&utm_medium=post&utm_campaign=journal-wants-word-latex-paper-docx).
2. Drop your `.tex` file, together with the `.bbl` from your LaTeX build (or the `.bib`). A whole project works as is: the `.zip` from your online editor or an arXiv source `.tar.gz`. Files pulled in with `\input`, `\include`, `\subfile` and `\import` are read in place.
3. Pick the paper size the journal uses, Letter or A4.
4. Convert, then read the report: what was kept, what changed, and what needs you.

The full report and the first 3 pages of the Word file are free, so you can check your own paper before paying anything. For the whole file there is a 7-day pass ($6.99), which fits one submission or revision round, and a monthly plan ($19.99).

The conversion runs in your browser. We never share your files or data externally without your consent.

## 4. Settings that matter for a journal

**Live cross-references, or plain numbers.** By default, section, equation, table and figure numbers and every `\ref` / `\eqref` are Word fields: add an equation, update fields (F9), and the numbers after it move, as they would in LaTeX. Some production teams ask for a manuscript without fields. Switch **Live Word cross-references** off and the numbers are written as plain text.

**Keep the reference style.** If you add the `.bbl`, the reference list keeps the format your bibliography style produced, so a journal style you already compiled with comes through as it was. With only a `.bib`, you pick a built-in style: numeric [1], author–year (Knuth, 1984) or alpha [Knu84].{% assign cite_post = site.posts | where: "url", "/blog/en/posts/latex-citations-in-word-bib-reference-list/" | first %}{% if cite_post %} How citations are carried over is in [LaTeX Citations in Word](/blog/en/posts/latex-citations-in-word-bib-reference-list/).{% endif %}

**Tables** come through as Word tables, including merged cells (`multirow`, `multicolumn`).

**Figures.** Captions, figure numbers and references to figures carry over. If a figure image cannot be placed, the report lists it and the document marks the spot; for journals that take figures as separate uploads, that is usually what you send anyway.

## 5. What to check before you upload

- **The report.** Anything the converter does not recognise stays in the document in dark red, at the place it was, and is listed in the report. Fix those few spots in Word or in your source.
- **Numbering set by a journal class.** Some class or style files number equations by section (1.1, 1.2). The converter does not read `.sty` and `.cls` files, so it numbers 1, 2, 3. If your template does this, look at the numbers before you submit.
- **TikZ drawings and slides** (`beamer`) are not converted; export TikZ figures as images.

## 6. FAQ

**Can I submit a LaTeX paper to a journal that only accepts Word?**
Yes. Convert the `.tex` to `.docx` with a converter that rebuilds the numbers, check the report, and submit the Word file. Keep the LaTeX source as your master copy.

**Will the equations be editable in Word?**
Yes. Inline and display maths, including `align`, `gather`, `cases` and matrices, become Word equations, and your own `\newcommand` macros are expanded.

**Do the equation numbers update if the editor adds an equation?**
With live cross-references on, yes: they are Word fields, and updating fields renumbers them and every reference to them.

**What if the journal wants no fields in the file?**
Turn **Live Word cross-references** off before converting. The numbers are then plain text.

## 7. Summary

1. Read the journal's author guidelines for what the Word file must contain.
2. Drop your `.tex` with its `.bbl` (or the project archive) into the [LaTeX to Word converter](/latexflow/tex-to-docx/?utm_source=blog&utm_medium=post&utm_campaign=journal-wants-word-latex-paper-docx), set the paper size, and decide between live fields and plain numbers.
3. Read the report, fix the few marked spots, and submit the `.docx`. The report and the first 3 pages are free.
