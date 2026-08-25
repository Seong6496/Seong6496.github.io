---
title: "Google Docs to Overleaf: What Pandoc Loses"
date: 2026-09-03 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/google-docs-to-overleaf-what-pandoc-loses/
categories: [Google Docs, Reference]
tags: [overleaf, google-docs, latex, pandoc, docx, conversion]
math: true
pin: false
description: "The free route from Google Docs to Overleaf is to export .docx and run Pandoc. We measured it on a real document: Google's export is clean, most equations convert, and four came out wrong with no warning at all."
---

You have a finished document in Google Docs and you need it in Overleaf. There is no button for this, so the free route is to download the document as `.docx` and run it through Pandoc.

It mostly works. It does not work completely, and the part that fails does so without saying anything. We exported a real document and measured it.

## The .docx step is not optional

Two facts make this route what it is.

Google Docs will not give you a `.tex` file — *File → Download* offers Word, OpenDocument, RTF, PDF, plain text, web page, EPUB, and Markdown, and that is the whole list. And Pandoc, the standard free converter, reads files rather than cloud documents; there is no Google Docs reader in it.

So the intermediate file is structural, not an oversight. The document has to become something else before Pandoc can touch it, and that is where the interesting things happen.

## Google's export is clean

Worth establishing first, because it is easy to blame the wrong step.

We unzipped the exported `.docx` and read `word/document.xml` directly, before converting anything. All **25 equations were there** as OMML, the native equation markup inside Word files, with their structure intact:

| Structure tag | Count |
|---|---|
| `m:f` (fractions) | 5 |
| `m:rad` (roots) | 4 |
| `m:nary` (sum, integral, product) | 8 |
| `m:sSup` / `m:sSub` | 4 / 2 |
| `m:limLow`, `m:acc`, `m:bar`, `m:d` | 1 each |

Symbols came out as Unicode math characters. Note the four roots — that count matters shortly.

## Most of it converts

Then `pandoc -f docx -t latex`, version 3.9, default options. Plenty came through correctly:

```text
\sum_{9}^{n}x^{2}
\int_{a}^{b}xdx
\prod_{i=1}^{n}a_{i}
\lim_{x \rightarrow 0}f(x)
\oint_{a}^{b}x
\sqrt[n]{x}
\widehat{x}
\overrightarrow{v}
|a|
log_{2}x
```

Every symbol converted too — the Unicode characters became `\leq`, `\geq`, the Greek set, and so on. Large operators with limits, standalone roots, accents, vectors, absolute value: all fine.

## Four did not

| What it should be | What came out | Lost |
|---|---|---|
| $x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$ | $x = \frac{- b \pm}{2a}$ | the whole discriminant |
| $\frac{1}{\sigma\sqrt{2\pi}}e^{\cdots}$ | $\frac{1}{\sigma}e^{\cdots}$ | the `\sqrt{2\pi}` factor |
| $\sqrt{\frac{1}{2}}$ | `\(\)` | everything — empty output |
| $\overline{x}$ | $\underline{x}$ | an overbar became an underline |

Three of the four share a shape: **a fraction and a root touching each other** — root in a numerator, root in a denominator, fraction inside a root. All three combinations, all three lost the root. The standalone `\sqrt[n]{x}` in the list above survived.

And those four `m:rad` tags were in the `.docx`. Google handed the roots over; they went missing during conversion, not before it.

There is one more case worth showing, because it makes the point sharply. If your equations are images rather than typed in the equation editor, Pandoc produces this:

```latex
\includegraphics[width=1.08333in,height=0.23611in,
  alt={AIMATH\_FORMULA::v2::inline::x = \textbackslash frac\{-b \textbackslash pm ...}]{media/image2.png}
```

The original LaTeX source survived the export inside the image's alt text. Pandoc had it in hand, treated it as a caption string, escaped every backslash, and gave back a description of an equation rather than an equation.

## And there is no warning

No error. No warning. **The output compiles cleanly.**

You paste it into Overleaf, it builds, you see a document. The quadratic formula in it has no discriminant, and nothing told you. That is the actual cost of this route: not that it fails, but that it succeeds visibly while being wrong in four places.

Four out of twenty-five is sixteen percent, but the ratio is the least useful part of it. The failures were not spread evenly — simple constructs survived and compound ones broke. How much of your document is at risk depends on how much of it is built from nested fractions and roots, which in a real paper is usually the interesting half.

## What we measured, and what we did not

One document, Pandoc 3.9, default options, measured 2026-08-25. We did not test other filters or flags, other export formats, or the paid routes — human conversion services and add-ons that read the Doc directly both exist, and we have not benchmarked either.

We also did not check whether these four failures are known bugs or intended behaviour. If they are bugs and someone reports them upstream, they get fixed and this post stops being true. Nothing here is a permanent property of Pandoc.

If you run this on your own document and get a different result, we would like to hear it.

## Why we ran it

We build [LaTeXFlow](/latexflow/), which converts LaTeX you have written in a document into rendered equations — the opposite direction from this post. We are working on the reverse, and to be clear about what exists today: we do not currently ship a Docs-to-`.tex` export.

Before building one, we wanted to know whether the free route already handled this well enough that there was no point. The gap it leaves is narrow but it is in the worst place — the complicated equations, converted silently wrong.

If you are moving a document to Overleaf this week, go and read your equations afterwards. Start with the ones that have a root inside a fraction.
