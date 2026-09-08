---
title: "Detected 0 Equations: Recovering a Document With No LaTeX Delimiters"
date: 2026-09-14 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/no-latex-delimiters-recover-document/
categories: [LaTeXFlow, Troubleshooting]
tags: [latex, docx, delimiters, equation-detection, troubleshooting, google-docs]
math: true
pin: false
description: "The file opened, there was no error, and the equation count came back zero. Almost always that means the document contains no LaTeX delimiters at all. How detection actually decides, how the zero-result screen proposes candidate paragraphs, and how to fix one paragraph and re-detect."
---

The file opened. There was no error. And the review screen says **0 equations**.

If the document is full of mathematics, there is almost always one cause: the maths in it is **not wrapped in LaTeX delimiters**. The tool did not fail to read your document — nothing in it was ever defined as an equation to read.

This post is about what to look at on that screen and what to press, in the order the screen actually works. Everything below describes the [web app](/latexflow/web/); the add-on inside Google Docs behaves differently on several of these points, and I will flag where.

## 1. Why zero: detection keys on delimiters

The scanners walk each paragraph's text and accept **only spans wrapped in a delimiter**. Three scanners divide the work.

| Scanner | Delimiters it owns |
|---|---|
| Base scanner | `$…$` (inline) · `$$…$$` (display) |
| Standard LaTeX scanner | `\(…\)` (inline) · `\[…\]` (display) |
| Bracket scanner | `[ … ]` (for chatbot output; on by default in the web app) |

A paragraph that none of the three matches is **plain text**. So this sentence:

```
The area is \frac{1}{2}bh, so x^2 + y^2 = r^2.
```

is unmistakably mathematics to a human, and comes back as zero. Change it to:

```
The area is $\frac{1}{2}bh$, so $$x^2 + y^2 = r^2$$.
```

and both are found — one inline, one display.

> Automatic detection of bare, undelimited LaTeX is **deliberately not implemented.** A detector loose enough to catch `\frac{1}{2}bh` also catches every `a = b`, every `x_1`, and every fragment of code that happens to appear in the document. So instead of detecting, the tool *proposes*. That is section 3.
{: .prompt-info }

## 2. Read the scan line first

When nothing is found, the top of the screen shows a line like this:

```
Scanned 31 paragraphs · 0 equations found
```

Small `.docx` files parse instantly, and a bare "no equations" used to make it look as though the file had never been opened at all. So the count of paragraphs and table cells actually walked is now printed.

Read that number first, because it splits the diagnosis in two:

- **Paragraph count near zero** → the file is nearly empty, or the body text lives in some other structure such as text boxes.
- **Paragraph count normal, equations zero** → this post. Everything was read; there were no delimiters.

Below it comes the heading and the explanation:

```
No equations detected — this is usually fixable
The file opened correctly. Nothing inside it was wrapped in a
math delimiter, so there was nothing to convert.
```

followed by a before/after pair and a list of the five delimiters that can be read.

## 3. Candidate paragraphs

This is the actual way out. The screen does not stop at an explanation — it picks the paragraphs that **look like** mathematics and lists them, with a lead line reporting how many:

```
<n> paragraphs look like math but have no delimiter.
```

### 3-1. How a candidate is chosen

The rule is deliberately simple. Among the paragraphs that no scanner matched, it keeps the ones containing **at least one mathematical sign**:

- `=` (equality)
- `^` (superscript)
- `_` (subscript)
- `\` (a LaTeX command: `\frac`, `\int`, `\sum`, …)

None of the four, not a candidate. Ordinary prose therefore never reaches the list.

Run over a real corpus, that rule behaved like this: of **1,791 paragraphs**, 218 had no delimiter, and 4 of those (1.8%) met the bar — all four genuine equations, no false positives. The rule only misfires on documents that are *about* LaTeX, and on documents containing code or JSON (7 of 573 paragraphs, 1.2%). Neither is a maths document to begin with.

### 3-2. What candidate detection will not catch

Mathematics that uses none of `= ^ _ \` never becomes a candidate. Coordinate pairs like `(2,3)`, intervals like `(3:5)` — roughly 5% of real equation paragraphs.

Widening the rule would catch those, at the cost of more misfires in prose. Missing one costs a single suggestion and nothing else, so the narrow rule stayed.

## 4. Fixing one paragraph

A candidate card holds the paragraph's text and an **Edit text** button. The card reads:

```
Math with no delimiter stays plain text
This paragraph carries math signs (=, ^, _, \) but no delimiter,
so nothing in it was detected. Wrap the math in $…$ for inline
or $$…$$ for display — the live preview shows what gets detected
as you type.
```

**Edit text** drops the paragraph into a text box. Put delimiters around the maths.

Underneath the box is a **live preview**. Stop typing and the same three scanners run over the text you are editing:

```
Detected: 2 equations
```

along with what each one was read as and how it renders. You can confirm the delimiters landed correctly **before** saving.

> Editing replaces the whole paragraph with text. Bold, italics and colour on that paragraph are lost. The same warning sits above the edit box.
{: .prompt-warning }

## 5. What happens when you save

Saving re-runs the three scanners over the edited text. There are exactly three outcomes.

**① Equations were found.** The card leaves the list and the equations join **Detected Equations** below. `Selected` goes up, `Undelimited candidates` goes down. From here it is the normal review-and-export flow.

**② The dollar signs came out odd.** You added a delimiter but missed one side. The card stays, but changes character into an **ambiguity card** with copy to match. The only thing left to do is close the pair.

**③ Still zero.** No delimiter, or one in the wrong place. The card **does not disappear** — you started at zero equations, so zero cannot count as resolved. Your edit is kept and this appears:

```
Saved — still no equations here. Wrap the math in $…$ or $$…$$.
```

## 6. Twenty candidates: fix one and leave

If the document is entirely plain text, a lot of candidates surface. One real 31-paragraph document produced **20**. All twenty were correct — but dumping twenty cards onto one screen is a dead end wearing a different hat.

So the screen behaves like this:

1. It says how many there are, **in one line, first**.
2. It opens **only the first three**.
3. The rest come in behind one button labelled with the remainder, like `Show the other 17`.

And the guidance says:

> Once you have seen the pattern, fixing the rest in your word processor and uploading the file again is often faster than editing each one here.

That is the intended use of this screen. **Do not sit here and make twenty edits.** Fix one, confirm the shape of the thing, then go back to Word or Google Docs, do it in one find-and-replace, and upload again.

Note the three-open behaviour applies when the document detected **zero** equations. If any equation was detected, the candidate group starts collapsed to a single total line, so a screen that is working is not disturbed. Expand it from that line if you want it.

## 7. When delimiters are not the problem

Further down the zero-detect screen there is one more notice. If the document really does contain **equation objects made with the Word equation editor**, they are counted and reported:

```
This document contains 12 Word equation objects.
Those are not text, so no delimiter can reach them.
```

No amount of delimiter-adding fixes this. An equation object is not text — it is a separate structure inside the file, and a delimiter can only be attached to text. That is a different problem with a different route out.

## 8. Detection reads by paragraph

The tool unpacks the `.docx` and turns **each paragraph and each table cell** into an independent chunk before handing it to the scanners. The `Scanned 31 paragraphs` in section 2 is a count of those chunks.

Two consequences are worth knowing.

**① Split formatting does not matter.**

Word stores a single paragraph as several fragments whenever bold, colour or a spell-check mark interrupts it. The tool stitches the fragments back together before scanning, so bold or colour in the middle of an equation has no effect on detection. If the characters look contiguous on screen, they are read as contiguous.

**② Equations that cross a paragraph break are not found.**

This one does bite. Writing a display equation and pressing Enter inside it:

```
$$
x^2 + y^2 = r^2
$$
```

gives you three separate paragraphs. The opening `$$` and the closing `$$` live in different chunks and never pair. All three will appear in the candidate list — they contain `=` and `^` — but detection is zero.

The fix is to keep it in **one paragraph**:

```
$$x^2 + y^2 = r^2$$
```

If you need the line break visually, use a line break (`Shift` + `Enter`) rather than a paragraph break (`Enter`).

Table cells are scanned the same way. An equation found in a table is labelled with its position, like `Table 1 · Row 2 · Col 3`, so you can find it again in the document.

## 9. FAQ

**No candidate list appeared at all.**
Then no paragraph contains `=`, `^`, `_` or `\`. This is common in documents where the maths is written with Unicode symbols (∑, ∫, ½, ≤). Those are characters, not LaTeX commands — wrapping them will not help nearly as much as rewriting them in LaTeX.

**What is the Not math button on a candidate card?**
It marks the paragraph as not being mathematics and removes it from the list. Use it when a code fragment or a sentence like `A = B, provided …` gets proposed. The button in the same position on an ambiguity card reads `Skip` instead — different situation, different wording.

**Does turning bracket mode off increase the number of candidates?**
It can. A `[ … ]` paragraph that the bracket scanner was matching becomes a paragraph no scanner matches, and since it contains `\` it now meets the candidate bar. A detection demotes itself into a suggestion.

**Do my edits change the original file?**
No. The original `.docx` is untouched; edits go only into the **new file you export**. Edit freely.

**Can I export without clearing the candidates?**
Yes. Export opens as soon as at least one equation is selected. Candidates are suggestions rather than detections, so leaving them does not block anything — the counter just shows the remainder, like `Undelimited candidates 7`.

## 10. Summary, in screen order

1. Read the **scan line**. Normal paragraph count with zero equations means a delimiter problem.
2. If there is a **candidate list**, that is the exit. Do not read the explanation and leave.
3. Open one candidate with **Edit text** and wrap the maths in `$…$` or `$$…$$`.
4. Use the **live preview** to confirm the count before saving.
5. With many candidates, learn the pattern from one and fix the rest in the original document.
6. If the equation-object notice is showing, delimiters cannot reach those.

A document written with delimiters from the start never meets this screen. This flow exists for the documents you are handed, so that "it found nothing" comes with a next step attached.

- Unsure which delimiter to use → [the four delimiters, and which is safe where](/blog/en/posts/latex-math-delimiters-which-to-use/)
- Working inside Google Docs rather than a `.docx` → [how to convert LaTeX in Google Docs](/blog/en/posts/convert-latex-in-google-docs/)
