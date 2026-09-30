---
title: "Bringing a LaTeX File into Google Docs™: What Works Today, Step by Step"
date: 2026-10-12 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/latex-file-into-google-docs-what-works-today/
categories: [Google Docs, Tutorial]
tags: [latex, google-docs, tex-file, scan, delimiters, add-on, equations, tutorial]
math: true
pin: false
description: "You have a .tex file and the text needs to live in Google Docs™ — for a co-author, for comments, for a class. The path that exists today, end to end: paste the body, scan, convert. What the scanner detects and what it does not (environments need wrapping), and what does not carry over from the file at all."
---

You have a `.tex` file. A co-author who does not use LaTeX needs to comment on it, a course wants the submission as a Google Docs™ document, or a group is drafting in Docs and the maths lives in your file. Docs cannot open `.tex`, so the question is how much of the file survives the move.

This post walks the path that exists today with the free LaTeXFlow add-on, and then says plainly where that path stops. Nothing here is a promise about a feature that does not exist yet.

## 1. Two different problems in one file

A `.tex` file holds two kinds of content, and they move differently.

- **Prose.** Paragraph text is plain text. Copy and paste moves it, and Docs keeps it as text.
- **Maths.** Everything between LaTeX math delimiters — `$x^2$`, `\[ … \]`, and the rest — is also plain text after a paste, but it *looks* like LaTeX rather than like an equation. This is the part LaTeXFlow handles: it finds those spans and turns each one into a rendered equation image.

Everything else in the file — sectioning commands, lists, tables, citations, figures — is a third kind of content, and it is where the path ends. Section 4 is about that.

## 2. The free path, step by step

**Step 1 — copy the body of the file.** Open the `.tex` in any text editor. Select from the line after `\begin{document}` to the line before `\end{document}` and copy. The preamble — `\documentclass`, `\usepackage` lines, macro definitions — has no meaning in Docs; leave it behind.

**Step 2 — paste into a Google Docs™ document.** Paste as plain text (`Ctrl+Shift+V` on Windows, `Cmd+Shift+V` on a Mac) so no stray formatting comes along. You now have a document full of readable text with LaTeX commands sitting in it as characters.

**Step 3 — open LaTeXFlow.** In the document: **Extensions → LatexFlow → Open Equation Panel**. If this is the first run, the add-on shows a two-page consent screen about optional data collection; answer it either way, every feature works the same. The [install walkthrough](/blog/en/posts/convert-latex-in-google-docs/) covers that screen in detail.

**Step 4 — Scan.** Switch to the **Scan** tab and press **🔍 Scan Document**. The sidebar lists every span it recognised as an equation, one card each, with a preview. Look through the cards. A card that is not maths — a price with a stray dollar sign is the usual case — can be skipped.

**Step 5 — Convert All.** Press **⚡ Convert All**. Each detected span is replaced in place by an equation image. The LaTeX source is kept in the image's alt text, so **↩ Revert to LaTeX** on the same tab turns any image back into editable text later.

Two things to be clear about. The result is an image per equation, not a native Docs equation — the objects Docs makes with **Insert → Symbols → Equation** are a different thing and this path does not produce them. And the prose around the equations is exactly what you pasted: plain text, in one font, with the LaTeX commands still visible wherever they were. Steps 3 to 5 changed the maths and nothing else.

## 3. What Scan detects, and what it does not

This is the part worth reading before you paste a long file, because it decides how much editing you do first.

**The scanner detects delimited maths only.** It looks for text wrapped in one of four delimiter pairs — `$…$` and `\(…\)` for inline, `$$…$$` and `\[…\]` for display — plus, when you tick *Also detect `[ … ]`* in the panel, the bare square brackets that chat apps produce when they strip the backslashes from `\[ … \]`. That option is off by default in the add-on. Maths that is not inside one of those pairs is not an equation to the scanner. This is a deliberate boundary rather than a gap waiting to be filled: a detector loose enough to catch bare `\frac{1}{2}` also catches file paths, code, and any sentence that happens to contain a backslash, and it would start flagging documents that were fine.

In a `.tex` file, three consequences follow.

**Environments are not delimiters.** An equation written as

```latex
\begin{equation}
  E = mc^2 \label{eq:energy}
\end{equation}
```

is not detected, because `\begin{equation}` is not one of the four pairs. The same holds for `align`, `align*`, `gather`, and `multline`. To bring it across, wrap the body in display delimiters and drop the label — Docs has no equation numbering for a label to point at:

```latex
\[ E = mc^2 \]
```

**Aligned bodies need aligned.** When the body uses `&` alignment points and `\\` line breaks, put it in an `aligned` block inside the display delimiters. This is the same shape the add-on's own symbol palette inserts, so it is the shape the renderer expects:

```latex
\begin{align*}
  f(x) &= x^2 + 1 \\
  g(x) &= 2x
\end{align*}
```

becomes

```latex
\[
\begin{aligned}
  f(x) &= x^2 + 1 \\
  g(x) &= 2x
\end{aligned}
\]
```

One `\[ … \]` block renders as one image with both lines in it.

**Inline maths cannot span a line break.** Many `.tex` files are hard-wrapped at 80 characters. If an inline `$ … $` pair happens to straddle a wrapped line, the two dollar signs sit on different lines and the pair is not detected — the inline pattern stops at a line end on purpose. Join the line in the text editor before you copy. The three other delimiter pairs are not affected.

If you find a paragraph after the scan that should have been an equation, you do not need to go back to the file: put the cursor on it, press **`Tag as $…$`** on the Scan tab, and scan again. With a selection it wraps the selection; with only a cursor it wraps the whole paragraph.

## 4. What does not carry over

Everything in the file that is structure rather than text or maths arrives as plain text with its command still attached. `\section{Method}` is the six characters of a heading and a command name; `\begin{itemize}` and each `\item` are words in a paragraph; a `tabular` block is rows of `&` and `\\`; `\cite{knuth84}` and the bibliography are a key and a list; `\label` and `\ref` are a name with nothing to resolve it; `\footnote{…}` is the note inline in the sentence; `\includegraphics{fig1.pdf}` is a file name, since the image itself was never in the `.tex`. For each of these you apply the Docs equivalent by hand — heading styles, a bulleted or numbered list, a Docs table, a footnote from the Insert menu, the image file from disk — and delete the command text. On a short document this is a few minutes. On a thesis chapter it is most of an afternoon, and it is the honest description of where this path stops.

## 5. One line to close

We are looking at a proper `.tex` import that keeps the structure — headings, lists, tables, footnotes — so that step 4 is not done by hand; if that matters to you, say so on the [support page](/latexflow/support/) and it helps us decide what to build next.
