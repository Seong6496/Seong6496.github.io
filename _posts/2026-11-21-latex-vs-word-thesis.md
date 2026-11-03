---
title: "LaTeX vs Word (and Google Docs™) for a Thesis: Draft in One, Submit in the Other"
date: 2026-11-21 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/latex-vs-word-thesis/
categories: [LaTeX, Essay]
tags: [latex, word, google-docs, overleaf, thesis, export, comparison, writing]
math: false
pin: false
description: "LaTeX vs Word for a thesis or paper, compared on what actually decides it: equations, references, numbering, collaboration, layout and the time it takes to learn. Where each one is the better tool, and how to avoid choosing for the whole project: draft in Word or Google Docs™, and move to LaTeX when the template or the journal asks for it."
---

<!-- Sources: Overleaf docs "Importing and exporting files" (docs.overleaf.com, read 2026-11-03): New project > Import > Word document (.docx), converted with Pandoc. LaTeXFlow Export/Import round trip: 10-30 post (text, structure, equations come back; layout does not). Word LaTeX input: 11-17 post / Microsoft Learn. No competitor products named beyond the editors themselves. -->

LaTeX is the better tool when a thesis is heavy on equations, cross-references and citations, or when the department or journal hands you a LaTeX template; Word or Google Docs™ is the better tool when the document is mostly prose, many people comment on it, or nobody involved knows LaTeX. You also do not have to pick one for the whole project: many people draft in Word or Google Docs™ and move to LaTeX at the end.

This post compares the two on the points that decide the choice, then shows the two moves between them that make "draft in one, submit in the other" practical.

## 1. The comparison that matters

| | LaTeX (for example in Overleaf) | Word / Google Docs™ |
|---|---|---|
| **Equations** | Typed as LaTeX; the reference standard for mathematical typesetting | Built-in equation editors. Word also accepts LaTeX input; Docs' editor has no matrices or multi-line equations |
| **Citations** | BibTeX / BibLaTeX from a `.bib` file; style switched with one line | Citation tools or reference-manager plug-ins; style switched in the tool |
| **Numbering and cross-references** | Sections, equations, figures and tables numbered and referenced automatically with `\label` / `\ref` | Possible with captions and cross-reference fields; takes discipline to keep updated |
| **Layout** | Set by the document class or template; consistent, hard to nudge by hand | What you see is what you get; easy to nudge, easy to make inconsistent |
| **Collaboration** | Overleaf has shared editing and comments; co-authors need some LaTeX | Comments and suggestions everyone already knows; no new syntax |
| **Learning time** | Days to be comfortable, longer for custom layouts | Already known |
| **Long documents** | Split into chapter files; compiles the same at 300 pages | Workable, slower and more fragile with many equations and figures |

Neither column wins everywhere. The deciding questions are usually three: does a required template exist only in LaTeX, how many equations are there, and who else edits the text.

## 2. When LaTeX is the right choice

- The university, conference or journal provides a **LaTeX template**, or requires LaTeX source at submission.
- The thesis has **many equations**, numbered and referred to throughout.
- You want the **bibliography** generated from one `.bib` file, in whatever style the committee asks for.
- You are comfortable writing markup, or willing to spend a few days learning it.

## 3. When Word or Google Docs™ is the right choice

- The text is mostly **prose**, with few equations.
- Your **supervisor and co-authors comment** in Word or Google Docs™ and do not use LaTeX.
- The submission format is `.docx`, or there is no required template.
- You need to start writing today, not after learning a new tool.

## 4. Draft in one, submit in the other

The choice is easier when moving between the two is cheap. There are two well-trodden routes, one in each direction of the work.

**Word to LaTeX, with Overleaf.** Overleaf can import a Word file directly: **New project → Import → Word document (.docx)** converts it into a LaTeX project, equations included (Overleaf's documentation, read on 3 November 2026). Expect to tidy tables, figures and citations afterwards.

**Google Docs™ to LaTeX, with Export.** If the draft lives in Google Docs™ — where the comments are — the LaTeXFlow add-on writes the document as a `.tex` file:

1. Write the thesis in Google Docs™ with its headings, lists, tables and equations, either Docs' own equations or LaTeX you converted with the free Scan.
2. Open **Extensions → LatexFlow → Open Equation Panel** and the **Export / Import** tab (Export needs a license key).
3. Press **Convert to LaTeX**, then **Download .tex** or **Open in Overleaf**.
4. Move the text into the department's template, and do the LaTeX-only finishing there: the document class, `\label` and `\ref`, the bibliography style.

In our [round-trip test](/blog/en/posts/google-docs-latex-round-trip/), text, structure and every equation came through the export; fonts, spacing and other layout did not, by design, because the LaTeX template sets them. The full walkthrough with screenshots is [Google Docs™ to LaTeX: Exporting a Document with LaTeXFlow, Step by Step](/blog/en/posts/latexflow-export-import-walkthrough/).

<!-- TODO shot (optional): side by side — the same thesis chapter in Google Docs™ (with a comment thread visible) and the exported .tex compiled in Overleaf with a university-style template. Real documents only. -->

A practical rule: keep **one working copy**. Draft and collect comments in Docs; once you move to LaTeX for submission, make further changes in the `.tex`, not in both.

## 5. FAQ

**Is LaTeX better than Word for a thesis?**
For a thesis with many equations, citations and cross-references, or with a LaTeX template to follow, usually yes. For a mostly-prose thesis edited by people who do not use LaTeX, Word or Google Docs™ is often the faster tool.

**Why do people use LaTeX over Word?**
Mainly for equation typesetting, automatic numbering and cross-references, bibliographies generated from a `.bib` file, and consistent layout from a template.

**Can I write my thesis in Word and convert it to LaTeX later?**
Yes. Overleaf imports `.docx` files into a LaTeX project, and a draft in Google Docs™ can be exported to `.tex` with LaTeXFlow (section 4). Plan for some tidying of tables, figures and citations either way.

**Overleaf or Google Docs™ for writing with co-authors?**
Overleaf when everyone writes LaTeX; Google Docs™ when some co-authors do not. Many groups draft and comment in Docs, then export to LaTeX for the final version.

## 6. Summary

- LaTeX: templates, equations, numbering, bibliographies. Word / Docs: prose, comments, no learning time.
- You can start in one and finish in the other: Overleaf imports `.docx`; LaTeXFlow Export turns a Google Docs™ draft into a `.tex`.
- So write where your co-authors are, and export a `.tex` when the template or the journal needs it. Get the add-on: [LaTeXFlow for Google Docs™](https://workspace.google.com/marketplace/app/latexflow/59137436133?flow_type=2&utm_source=blog&utm_medium=post&utm_campaign=latex-vs-word-thesis); prices are in the [Export & Import guide](/latexflow/export/).
