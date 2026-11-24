---
title: "LaTeX Citations in Word: From .bib to a Numbered Reference List"
date: 2026-12-07 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/latex-citations-in-word-bib-reference-list/
categories: [LaTeXFlow, Guide]
tags: [latex, word, docx, tex-to-docx, citations, bibtex, bib, bbl, references]
math: false
pin: false
description: "Why \\cite turns into blanks or raw keys when a LaTeX paper goes to Word, which file actually holds your reference list (.bbl, not .bib), and how to get numbered citations and a numbered reference list in the .docx. Measured on 53 unseen papers: 92.2% of citations came through, against 8.2% for a common free converter."
---

<!-- Sources: R243 held-out table (.tmp/r243_heldout.md, the only public numbers): citations resolved 92.2% (2,056 / 2,230) vs free route 8.2% (183 / 2,230; the R243 free route at default settings, citation processing on where a .bib ships), 53 papers with .aux, 49 of them with citations, per-paper ≥98% 29 / 100% 26; worst-paper causes (acmart citations partly unresolved, \citenum leaks). Live page latexflow/tex-to-docx/index.html (citations and bibliography from .bbl, or a built-in style from .bib: Numeric / Author–year / Alpha; "Add the .bbl from your LaTeX build to keep your exact bibliography style"; first 3 pages + report free; privacy sentence). thebibliography: R262 draft feature list. No competitor names. -->

In LaTeX, a citation is two keystrokes of work: `\cite{smith2020}` in the text and an entry in your `.bib` file. When the paper has to become a Word file, that is often where things fall apart. The citations come out blank, as `[smith2020]`, or as question marks, and the reference list is missing or unnumbered.

The reason is that your Word file needs something LaTeX works out while it compiles, and it is not in the `.tex` or the `.bib`.

## 1. Where the numbers actually come from

A LaTeX build with a bibliography runs in steps:

1. LaTeX reads your `.tex` and writes down which keys you cited (in the `.aux` file).
2. BibTeX or biber reads those keys and your `.bib`, applies the bibliography style, and writes a `.bbl` file: the finished reference list, in order, formatted.
3. LaTeX runs again, reads the `.bbl`, and prints [1], [2], [3] in the text and the list at the end.

So the `.bib` is a database, and the `.bbl` is the result. The numbers, the order and the format of each entry are in the `.bbl`. A conversion that only reads the `.tex` has none of this, which is why citations go missing.

## 2. Give the converter the .bbl

The [LaTeX to Word converter](/latexflow/tex-to-docx/?utm_source=blog&utm_medium=post&utm_campaign=latex-citations-in-word-bib-reference-list) reads your citations from the files you give it:

- **`.tex` + `.bbl`** (recommended). The reference list keeps the exact format your bibliography style produced, and the in-text citations match it.
- **`.tex` + `.bib` only.** The converter formats the list itself, in a style you pick: numeric [1], author–year (Knuth, 1984) or alpha [Knu84].
- **A `thebibliography` list** written in the `.tex` works too.

Where to find the `.bbl`: a build on your own computer writes it next to the PDF; in an online editor, look among the output files of the last compile. An arXiv source download usually includes it.

You get citations in the text and a numbered reference list at the end of the Word document.

## 3. How well it works, measured

We froze the converter and ran it on 53 arXiv papers submitted in September of 2012–2026, none of which we had looked at while building it. Each paper's own LaTeX build (its `.aux` file) was the answer key, and we counted how many in-text citations came through in the Word file.

| Citations that come through | Count | Share |
|---|---|---|
| LaTeXFlow | 2,056 of 2,230 | **92.2%** |
| A common free converter (default settings, with its citation processor where a `.bib` was included) | 183 of 2,230 | 8.2% |

49 of the 53 papers cite something. In 26 of them every citation came through, and in 29 at least 98% did.

The misses are spread over a handful of papers; the largest share came from one paper whose journal class handles citations in its own way, which the converter does not read yet. Those spots are not dropped silently: anything the converter does not recognise stays in the document in dark red, at the place it was, and is listed in the report.

## 4. Step by step

1. Build the paper once in LaTeX so the `.bbl` is up to date.
2. Open the [LaTeX to Word converter](/latexflow/tex-to-docx/?utm_source=blog&utm_medium=post&utm_campaign=latex-citations-in-word-bib-reference-list) and drop the `.tex` and the `.bbl`, or the whole project as a `.zip` or `.tar.gz`.
3. If you only have the `.bib`, choose the reference style.
4. Convert and read the report. Look at the reference list and a few citations in the first pages.

The full report and the first 3 pages of the Word file are free, so you can check how your own bibliography comes through before paying anything.

The conversion runs in your browser. We never share your files or data externally without your consent.

## 5. FAQ

**Can I convert a .bib file to a Word reference list?**
Yes, together with the `.tex` that cites it: the converter formats the cited entries in a numeric, author–year or alpha style. For the exact style your journal template uses, add the `.bbl` from your LaTeX build instead.

**Why do my citations show as question marks or keys after converting?**
The converter had no `.bbl` and could not match the keys, or it only translated the source text. Add the `.bbl` from a fresh build.

**Do equation and section references come through too?**
Yes. Section, equation, theorem, figure and table numbers and every `\ref` / `\eqref` are rebuilt as Word fields; see [How Equation Numbers Survive the Trip From LaTeX to Word](/blog/en/posts/how-equation-numbers-survive-latex-to-word/).

## 6. Summary

1. Your reference list lives in the `.bbl`, which LaTeX's build writes from your `.bib`.
2. Drop the `.tex` and the `.bbl` into the [LaTeX to Word converter](/latexflow/tex-to-docx/?utm_source=blog&utm_medium=post&utm_campaign=latex-citations-in-word-bib-reference-list); with only a `.bib`, pick a style.
3. Read the report and check the list. The report and the first 3 pages are free.
