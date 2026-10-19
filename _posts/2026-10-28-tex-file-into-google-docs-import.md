---
title: "You Received a .tex File: Editing It Together in Google Docs™"
date: 2026-10-28 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/tex-file-into-google-docs-import/
categories: [Google Docs, Tutorial]
tags: [latex, google-docs, tex-file, import, bibliography, add-on, equations, collaboration]
math: false
pin: false
description: "A co-author sends a short paper as a .tex file and you want to comment and edit it in Google Docs™. What LaTeXFlow Import does with each part of the file: sections, lists, a table with matrices, a footnote, two citations, a figure and its caption. What arrives as Docs structure, what arrives as marked text, and what you still do by hand."
---

The [earlier post on bringing a LaTeX file into Google Docs™](/blog/en/posts/latex-file-into-google-docs-what-works-today/) ended at its step 4: the structure of the file — headings, lists, tables, footnotes — had to be rebuilt by hand. This post takes the same situation with **Import**, on the **LaTeX file** tab of LaTeXFlow, and goes through one real file part by part. Import needs a license key; the click-by-click setup is in the [Export and Import walkthrough](/blog/en/posts/latexflow-export-import-walkthrough/).

## 1. The file

The test file is a two-page note of the kind a co-author might send: a title and author line, two sections with subsections, a footnote, two `\cite` references with the `.bib` entries inside the file (a `filecontents` block), a bulleted list, a `table` whose first column holds `pmatrix` matrices, a `figure` with `\includegraphics` and a caption, and inline and display equations. The `.bib` sits inside the `.tex` because Import reads one file; it does not follow `\input`, `\include` or a separate `refs.bib`.

Open an empty tab (or an empty document), open LaTeXFlow, go to **LaTeX file**, and press **Choose .tex file** in the Import section. Nothing is written yet. The sidebar first reports what it read:

![The Import section after choosing received_paper.tex: 17 blocks — 3 paragraphs, 4 headings, 2 list items, 1 table; 12 equations (2 display) — written as LaTeX text; 2 bibliography entries — saved to this document's Bibliography on import; Import into: Tab 1 with a Use current tab button; and an expanded list of 3 notes on what changes on the way in](/assets/img/posts/2026-10-28/01-import-pick.png){: width="336" }

The three notes are the parts that cannot come in as they are: the author line becomes a subtitle, the footnote becomes a `[1]` marker with an entry under "Notes", and the figure file is not in the `.tex`, so a placeholder line is written instead. Import writes at the end of the tab named after **Import into:**. If that tab already has content, it asks you to tick **Append anyway** first.

## 2. Right after Import

Press **Import**. The sidebar counts "17 / 17 blocks written" and confirms that the 2 bibliography entries were saved.

![The imported document with the sidebar: the title Eigenvalues of Small Matrices, the subtitle Draft for review, Introduction as a heading with a [1] marker and the text [@strang2016], the characteristic polynomial subsection with a display equation written over three lines as \[, the equation and \], two bullet points with inline LaTeX, and the start of the table; the sidebar shows 17 / 17 blocks written and the bibliography message](/assets/img/posts/2026-10-28/02-imported-top.png){: width="720" }

What came in as Docs structure:

- `\title` became a line in the Docs Title style and `\author` a line in the Subtitle style under it. The sidebar note warns that Export writes `\author` back empty, so the name survives only as a line of text.
- `\section` and `\subsection` became Heading 1 and Heading 2, so they appear in the Docs outline.
- The `itemize` list became a bulleted Docs list.
- The `tabular` became a Docs table with the same rows and columns.

What came in as text:

- **Equations** are LaTeX source between delimiters, inline in `$…$` and display as three lines, `\[`, the equation, `\]`. This is deliberate: the source stays editable until you decide to render it (section 4).
- **Citations** are `[@strang2016]` and `[@noether1918]`, a marker with the citation key. The pick summary does not mention them.

The lower half of the file:

![The table with pmatrix source in the first column of each row, an italic centred line Trace, determinant and eigenvalues under it, a bold line [Image: eigen-ellipse.png — insert here], a plain line Caption: The unit circle mapped by a symmetric matrix., and the section A remark on symmetry with [@noether1918] and a display equation in three lines](/assets/img/posts/2026-10-28/03-imported-middle.png){: width="720" }

- The **table caption** is an italic, centred line right under the table.
- The **figure** is a bold line `[Image: eigen-ellipse.png — insert here]`. Only the file name is kept. The image itself was never inside the `.tex`, so insert it from your own copy and delete the line.
- The **figure caption** is a plain line starting with `Caption:`.

Google Docs™ has no caption object, so both captions are ordinary paragraphs, styled to stand apart from the body text.

The footnote text is at the very end of the document, under a heading **Notes**, as `[1] The proofs follow the order of the lecture notes.` The `[1]` in the Introduction points to it. A Docs add-on cannot create real Docs footnotes, so this is the closest it gets; if you want a real one, use Insert › Footnote and move the text.

## 3. The bibliography

The two `.bib` entries were not written into the page. They were saved to the document's **Bibliography** on the LaTeX file tab, which now shows "2 entries":

![The LaTeX file tab after the import: the Bibliography (.bib) row shows a 2 entries badge, above Convert to LaTeX and a License row marked Licensed](/assets/img/posts/2026-10-28/06-bibliography.png){: width="336" }

This is the Bibliography that Export reads. When the document is exported again, each `[@key]` marker goes back to `\cite{key}` and the entries go back into the file, so keep the markers as they are while you edit. The Bibliography belongs to the whole document, not to one tab. If the document already has a different bibliography, Import does not overwrite it and says so.

## 4. Turning the equations into images

When the text is settled, or whenever you want the reader to see rendered maths, open the **Scan** tab and press **Scan Document**. In this file it found "12 equation(s) — display: 2, inline: 10", the same count the import summary gave. **Convert All** replaced all 12, including the matrices inside the table cells:

![The same document after Convert All with the sidebar showing 12 / 12 converted: rendered inline equations in the Introduction and the bullet points, the characteristic polynomial as an image, and the table with rendered 2 by 2 matrices in the first column](/assets/img/posts/2026-10-28/04-converted-top.png){: width="720" }

![The lower part after conversion: the table with rendered matrices and plus-or-minus i, the italic table caption, the bold image placeholder, the Caption line, the remark section with a rendered inequality, and the Notes heading with the footnote text](/assets/img/posts/2026-10-28/05-converted-middle.png){: width="720" }

One thing to know: the two display equations become images at inline size, aligned left, not centred on their own line as they would be in the PDF. Centre them with the paragraph alignment button if it matters. Scan works on the tab you are in; in a document with several tabs, run it in each one.

From here the document is an ordinary Google Docs™ file: share it, comment, suggest edits. To change an equation after conversion, **Revert to LaTeX** on the Scan tab turns it back into source.

## 5. What else changes on the way in

The file above did not use every case. From the add-on's own rules, the ones you are most likely to meet:

| In the `.tex` | In the document |
|---|---|
| `\ref{key}` | the text `[ref:key]` |
| `\label{…}` | dropped |
| `% comments` | dropped |
| a command Import does not know | the command and its argument, kept as monospace source |
| an environment Import does not know | the whole environment, kept as monospace lines |
| `\tableofcontents` | a bold line telling you to use Insert › Table of contents |
| `\usepackage` lines | not written; Export writes its own preamble |

Each of these appears as a note in the pick summary before you press Import. Two exceptions: packages that Export writes itself (such as `amsmath` or `graphicx`) are skipped without a note, and citations come in as `[@key]` without a note.

## 6. Where it stops

Import gets the text, the structure Docs can hold, and the equations in. It does not bring back what Docs has no place for: real footnotes, captions tied to their figure, cross-references that update, the figure files. The parts that need your hand are marked in the document itself — the bold placeholder lines, `[1]`, `[ref:…]`, `[@…]` — so you can find them by searching for `[`.

- License keys: [LaTeXFlow store](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=tex-file-into-google-docs-import)
- Activation, cancelling and refunds: [Export & Import guide](/latexflow/export/)
