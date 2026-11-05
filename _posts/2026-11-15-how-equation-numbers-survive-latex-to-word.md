---
title: "How Equation Numbers Survive the Trip From LaTeX to Word"
date: 2026-11-15 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/how-equation-numbers-survive-latex-to-word/
categories: [LaTeXFlow, Guide]
tags: [latex, word, docx, tex-to-docx, equations, cross-references, word-fields, web-app]
math: false
pin: false
description: "Word has no idea what equation (2.4) is. To turn a LaTeX paper into a Word document whose numbers and references still work, the converter has to rebuild what LaTeX computes as Word fields. How we build it, how we score it against LaTeX's own answer key on 144 arXiv papers, and where the number stands now."
---

<!-- R225 (2026-11-05). Launch sequence post 2 of 4 (plan: addon repo docs/marketing_docs/tex2docx_launch_sequence_2026-11-05.md). Numbers: addon repo .tmp/r210_p1_phase1.md (R209 baseline 79.7%, R210 92.1%, G2 Word check (field count from .tmp/r222_p1_phase2.md final run), free-route row) and .tmp/r222/progress.md; section 3 log is generated from addon .tmp/r225/log.json by .tmp/r225/build.py (R227). Rules: no competitor or product names, no price, no limitation list, no release date. -->

In [the last post](/blog/en/posts/latex-to-word-document-coming/) we showed one passage of a paper converted to Word two ways: once by the usual free route, where "(1.1)" turned into "([expansion])" and the citations vanished, and once by the converter we are building, where every number was where the PDF puts it.

The fair question is: does that hold up beyond one hand-picked page? This post is the answer, in two parts — how the numbers are built, and how we check them.

**[Get notified when it's ready →](/latexflow/web/?utm_source=blog&utm_medium=post&utm_campaign=tex2docx_waitlist#tex2docx-notify)**

## 1. Word does not know what "equation (2.4)" is

In LaTeX, you never type a number. You write `\label{eq:energy}` under an equation and `\eqref{eq:energy}` in the text, and when the paper compiles, LaTeX counts: this is the fourth equation of section 2, so it is (2.4), and every reference to it prints "(2.4)". The same counting gives you Theorem 3.1, Figure 5 and Section 4.2.

A `.docx` file has nothing like that. Word has no built-in notion of an equation number at all. So a converter has two choices:

- **Type the numbers in as text.** It looks right on the first screen. Then your co-author adds an equation in section 1, and every number after it is wrong, with nothing to tell anyone.
- **Rebuild LaTeX's counting out of Word's own machinery.** That is what we do.

Word does have the parts. A *SEQ field* is a counter: each one shows the next number in its sequence, and it can restart when a new section begins. A *bookmark* gives a spot in the document a name. A *REF field* prints whatever is inside a named bookmark. Put together:

- each equation number becomes the section's SEQ field, a dot, and the equation's SEQ field, wrapped in a bookmark named after the LaTeX label;
- each `\eqref` becomes a REF field that points at that bookmark;
- theorems, figures, tables and headings get their own sequences, counted the way your document class counts them.

Press Alt+F9 in Word and you see the fields instead of the numbers:

![Theorem 1.1 and equation (1.2) of an arXiv paper in Microsoft Word with field codes shown: the theorem heading reads "Theorem" followed by a SEQ H1 field, a dot and a SEQ T_thm field, and the equation number at the right margin is a SEQ H1 field, a dot and a SEQ Equation field, both in brackets](/assets/img/posts/2026-11-15-equation-numbers-latex-to-word/01-field-codes-theorem-equation.png){: width="720" }
_Field codes in our output (Alt+F9). "Theorem 1.1" is the section counter plus a theorem counter; "(1.2)" is the section counter plus the equation counter. Alt+F9 again shows the numbers._

The result behaves like a Word document that was numbered in Word from the start. Move a section, update the fields (select all, F9), and the numbers and every reference to them follow.

The hard part is not writing the fields. It is getting the *counting* right, because LaTeX's counting depends on the document class, the packages and the preamble. Some papers number equations within sections, some straight through; some theorems share a counter with lemmas, some don't; an appendix switches sections to letters. If the converter counts differently from LaTeX even once, a number is wrong. So we needed a way to check it, paper by paper.

## 2. How we score ourselves: LaTeX grades the test

When LaTeX compiles a paper, it writes a small side file, the `.aux`, with one line per label: this label got number 2.4, that one got Theorem 3.1. That file is the answer key, and it comes from LaTeX itself, not from us.

So the test goes like this:

1. **Take 144 arXiv papers that compile** — mathematics, physics, computer science, statistics and other fields, each with its own class and preamble.
2. **Compile each one with pdflatex** and keep its `.aux`.
3. **Convert each `.tex` to `.docx`**, without looking at the `.aux`. The converter has to do the counting itself.
4. **Compare every number one by one**: each label, each printed reference, each theorem, each caption, each citation, against the `.aux`. About 9,500 labels in all.
5. **Open every output in Microsoft Word.** In our last full check, all 150 documents we converted opened without a repair prompt, and when Word updated all 59,382 fields, not one equation number or reference changed. What you see when you open the file is what Word itself computes.

The usual free route goes through the same answer key, measured the same way. On it, the free route matched none of the labelled equation numbers, and printed 18% of the references right, all of them as plain text.

## 3. Where it stands: the log

When we started measuring, 79.7% of the labels came out with LaTeX's number. Since then, every change to the converter has been re-measured on all 144 papers. Here is the log, one line per change, newest last.

<!-- log:start - generated by addon repo .tmp/r225/build.py from .tmp/r225/log.json; edit log.json, not this block -->
| Date | What was fixed | Labels matching LaTeX |
|---|---|---|
| Nov 4 | First round, seven changes: counters that authors define themselves, lists with their own labels, numbered rows in multi-line equations, the way some journal classes number tables and sub-headings, footnotes, appendices and parts | 79.7% → 92.1% |
| Nov 5 | A multi-line equation whose last row is empty still gets its number, and a label on an unnumbered row now names the row that carries the number | 93.3% |
| Nov 5 | Labels hidden inside an author's own shorthand commands, label names with spaces in them, theorems in some journal classes, algorithm numbers set by package options, and thesis-style figure numbers | 94.1% |
| Nov 5 | Equations grouped as 2a, 2b, 2c, and counters changed or an appendix started in the middle of a paragraph | 94.7% |
| Nov 5 | Pseudo-code blocks with numbered lines: each line gets its number, and a reference to a line points at it | 95.3% |
| Nov 5 | Section numbering depth changed in the middle of a paper, and a figure made of sub-figures with no caption of its own still takes its number | 96.1% |
| Nov 5 | Pseudo-code written in the other common style gets numbered lines too, counted the way LaTeX counts them | 96.3% |
| Nov 5 | Theorems that share a counter through a chain of other theorems, an appendix written as its own block, and author commands that hide part of the text | 96.5% |
| Nov 5 | A reference right after a theorem or a figure group points at the right one again, lists numbered like (i), (ii) or with text around the number, and a label name used twice resolves the way LaTeX resolves it | 97.2% |
| Nov 5 | A figure or table with an empty caption still takes its number, and a list that changes its own numbering style before the first item keeps it | 97.4% |
| Nov 5 | Figure-like blocks that an author defines with their own name keep that name and their own numbers, and text the author switched off in the source is skipped the way LaTeX skips it | 97.7% |
| Nov 5 | Sub-figure captions written in two more ways, label names built from an author's command, theorems restated later in the paper, and appendix numbering in two journal classes | 98.1% |

![Line chart of the share of labels whose number matches LaTeX's own on 144 arXiv papers. It starts at 79.7%, climbs through 7 changes to 92.1% at the end of the first round on November 4, then through 11 more changes to 98.1% on November 5.](/assets/img/posts/2026-11-15-equation-numbers-latex-to-word/02-progress.png){: width="720" }
_The same log as a chart. Each dot is one change, re-measured on all 144 papers. Latest (November 5): 98.1% of about 9,500 labels match LaTeX's `.aux`._
<!-- log:end -->

The first round was the common machinery. Everything after it is the long tail: constructs that only some papers use, each worth anywhere from a dozen to about a hundred labels across the 144 papers. None of them has needed anything Word can't hold. They need the counting to be read more carefully, one construct at a time.

One thing to keep in mind about these numbers: they are development numbers, measured on the papers we work with. Before the converter goes live we will run it on papers it has never seen, and that is the number we will stand behind.

## 4. What comes next

The number keeps moving; the work on the long tail is going on as you read this. The next post shows the page itself: upload a `.tex`, read the report of anything that needs a look, and see the first pages of your Word document before you download it. That is coming later this month.

If you want to know when you can try it, leave your email and we will let you know.

**[Get notified when it's ready →](/latexflow/web/?utm_source=blog&utm_medium=post&utm_campaign=tex2docx_waitlist#tex2docx-notify)**
