---
title: "LaTeXFlow Export and Import in Google Docs™: A Walkthrough with Real Screenshots"
date: 2026-10-21 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/latexflow-export-import-walkthrough/
categories: [Google Docs, Tutorial]
tags: [latex, google-docs, tex-file, export, import, overleaf, add-on, equations, tutorial]
math: true
pin: false
description: "One short Google Docs™ document taken through the whole LaTeXFlow loop: write equations as LaTeX, scan and convert them for free, unlock the LaTeX file tab with a license key, export a .tex file, then import that file back into an empty tab opened for it. Every step shown as it appeared on screen."
---

This post follows one small document through every step of LaTeXFlow, from typing LaTeX in Google Docs™ to a downloaded `.tex` file and back again. Scan and Convert are free. Export and Import, on the **LaTeX file** tab, need a license key. Each screenshot below was taken from the add-on as it is published on the Google Workspace Marketplace.

## 1. The document

The test document has a heading, a two-item bulleted list and four equations typed as LaTeX: three inline between `$…$` and one display equation between `$$…$$`.

![A Google Docs page titled Sample report with two bullet points, Introduction and Results, followed by three lines of text containing LaTeX source: the quadratic formula between single dollar signs, Euler's identity between double dollar signs, and the Gaussian integral between single dollar signs](/assets/img/posts/2026-10-21/01-doc.png){: width="720" }

Open the add-on with **Extensions → LatexFlow → Open Equation Panel**.

If the **LatexFlow** entry is not in the Extensions menu of a new document, turn it on for that document: **Extensions → Add-ons → Manage add-ons**, open the menu on **LatexFlow**, and choose **Use in this document**. Reload the page and the entry appears.

## 2. Scan and Convert (free)

On the **Scan** tab, press **Scan Document**. The sidebar reports what it found — here, "Found 4 equation(s) — display: 1, inline: 3" — and lists one card per equation with a rendered preview and its LaTeX source.

![The LaTeXFlow sidebar on the Scan tab, showing Scan Document and Convert All buttons, the message Found 4 equation(s) — display: 1, inline: 3, a 0 / 4 converted counter, and the first two equation cards: the quadratic formula and a not-equal-to-zero condition, each with Insert into Docs and Skip buttons](/assets/img/posts/2026-10-21/02-scan.png){: width="336" }

Press **Convert All**. Each LaTeX span in the document is replaced by a rendered equation, and the counter reads "4 / 4 converted".

![The same document after conversion: the quadratic formula, a not-equal-to-zero condition, Euler's identity and the Gaussian integral now appear as rendered equations in the text, and the sidebar shows 4 / 4 converted](/assets/img/posts/2026-10-21/03-converted.png){: width="720" }

## 3. The LaTeX file tab and the license key

The third tab, **LaTeX file**, holds Export (this document → `.tex`) and Import (a `.tex` file → this document). Without a key both are locked, and the tab shows a key field with an **Activate** button. One license covers both.

![The LaTeX file tab while locked: an Export to LaTeX section with a Paste your license key field and an Activate button, the note No license key yet — paste your key to unlock Export, and an Import a LaTeX file section that says Import uses the same LaTeXFlow license as Export](/assets/img/posts/2026-10-21/04-locked.png){: width="336" }

Short passes and subscriptions are sold on the [LaTeXFlow store](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=latexflow-export-import-walkthrough&utm_content=license). The key arrives with the purchase. Paste it into the field and press **Activate**. The License section then shows **Licensed**, and the Export and Import controls appear.

![The LaTeX file tab after activation: Full document and Selection options, a collapsed Bibliography (.bib) section with no entries, a Convert to LaTeX button, a License section marked Licensed with Activate and Deactivate buttons, and below it an Import section with a Choose .tex file button](/assets/img/posts/2026-10-21/05-activated.png){: width="336" }

How activation works, how to cancel a subscription and how refunds are handled are covered in the [Export guide](/latexflow/export/).

## 4. Export to LaTeX

With **Full document** selected, press **Convert to LaTeX**. The result for this document:

- "Converted — LaTeXFlow_demo.tex"
- "0 native · 4 image · 0 text equations" — the four equations converted in step 2 are counted as image equations
- "Nothing skipped — every equation converted"

Below the summary is a preview of the file, with **Download .tex**, **Copy .tex** and **Open in Overleaf**.

![The sidebar after Convert to LaTeX, showing Converted — LaTeXFlow_demo.tex, 0 native · 4 image · 0 text equations, Nothing skipped — every equation converted, a preview box beginning with the documentclass and usepackage lines, and Download .tex, Copy .tex and Open in Overleaf buttons](/assets/img/posts/2026-10-21/06-export-result.png){: width="336" }

The preview scrolls through to `\end{document}`. Beside the rendered document you can check that the heading became `\section`, the bullets became an `itemize` list, and each equation came back as LaTeX.

![The rendered document on the left and, on the right, the sidebar preview scrolled to the body of the file: section Sample report, an itemize list with Introduction and Results, the quadratic formula in dollar signs, Euler's identity as a display equation, the Gaussian integral, and end document](/assets/img/posts/2026-10-21/07-tex-preview.png){: width="720" }

This is the file **Download .tex** saved, unedited:

```latex
% LaTeXFlow Export — nothing skipped: every equation converted
\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{amsmath,amssymb}
\usepackage{graphicx}

\begin{document}

\section{Sample report}
\begin{itemize}
  \item Introduction
  \item Results
\end{itemize}

The quadratic formula gives $x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$ for any $a \neq 0$.

Euler's identity:
\[
e^{i\pi} + 1 = 0
\]

The Gaussian integral is $\int_{-\infty}^{\infty} e^{-x^2}\,dx = \sqrt{\pi}$.

\end{document}
```

The display equation typed between `$$…$$` is written as `\[ … \]`, and the inline equations stay in `$…$`.

## 5. Import a .tex file

Import goes the other way. In the **Import** section of the same tab, press **Choose .tex file** and pick the file. Before anything is written, the sidebar summarises what it read. For the file above: "4 equations (1 display) — written as LaTeX text". **Import into:** names the document tab the content will go to; **Use current tab** switches it to the tab you are in. Press **Import**.

Import does not create a tab. It writes into the tab that was open when you picked the file, adding to the end. For this walkthrough an empty tab named "Imported" was opened first. If the tab already has content, the sidebar asks you to tick **Append anyway** before anything is written.

![The Import section after choosing demo.tex: a summary of blocks, paragraphs, a heading and list items, the line 4 equations (1 display) — written as LaTeX text, Import into: Imported, a Use current tab button and an Import button](/assets/img/posts/2026-10-21/08-import-pick.png){: width="336" }

The heading and the bulleted list come in as a Docs heading and a Docs list. The equations come in as LaTeX text.

![The imported tab: Sample report as a heading, Introduction and Results as bullet points, and the three equation lines as LaTeX source text, with the sidebar showing 10 / 10 blocks written](/assets/img/posts/2026-10-21/09-import-result.png){: width="720" }

That is by design: Import writes equations as LaTeX text, not as images, so they stay editable. To turn them into rendered equations, open the **Scan** tab in the imported tab and run **Scan Document** and **Convert All** again, as in step 2.

## 6. Where to go next

- Passes and subscriptions: [LaTeXFlow store](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=latexflow-export-import-walkthrough&utm_content=next)
- Activation, cancelling and refunds: [Export guide](/latexflow/export/)
- First-time install and the free features: [install walkthrough](/blog/en/posts/convert-latex-in-google-docs/)
