---
title: "Google Docs to Overleaf: What Each Route Loses"
date: 2026-09-03 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/google-docs-to-overleaf-what-each-route-loses/
categories: [Google Docs, Reference]
tags: [overleaf, google-docs, latex, pandoc, docx, conversion]
math: true
pin: false
description: "There is no Download as LaTeX in Google Docs, so every route to Overleaf is a workaround. We exported a real document and ran the free route to see what actually survives. Google's export is clean; the losses happen later, and they happen quietly."
---

You have a finished document in Google Docs. Your co-author, your supervisor, or the journal wants it in Overleaf. The deadline is real.

There is no button for this. Every route is a workaround, and each one charges you something different — time, money, or accuracy. This post is about the third one, because it is the only cost that does not announce itself.

We exported a real document and measured what came out. Numbers below are from that run.

## 1. Why there is no direct route

Two facts set up everything that follows.

**Google Docs will not give you a `.tex` file.** Open *File → Download* and you get Word, OpenDocument, RTF, PDF, plain text, web page, EPUB, and Markdown. LaTeX is not on the list and never has been.

**Pandoc cannot read a Google Doc.** Pandoc is the standard free converter and it handles an enormous number of formats, but it reads *files*. There is no Google Docs reader in it, so it cannot reach into your Drive and pull the document out.

Put those together and the export step is not an inconvenience somebody forgot to remove. It is structural. Every free route runs your document through an intermediate file format first, and that is where things happen to it.

## 2. Route one: download as .docx, then run Pandoc

This is the route people find first, because it is free and it is what search results recommend.

```bash
pandoc -f docx -t latex mypaper.docx -o mypaper.tex
```

### What it costs you before you start

It is a command-line tool. If you are comfortable in a terminal that is nothing; if you are not, it is a genuine barrier at 2 a.m.

More importantly it is a **two-step manual process, and it does not stay done**. Every time a co-author edits the Doc, you download again and convert again. There is no link between the Doc and the `.tex` file. For a document still under revision — which is most documents with a deadline — you pay this cost repeatedly.

### What we measured

We took a real Google Doc containing 25 equations built with the native equation editor, plus 6 equations that had been inserted as images, exported it as `.docx`, and converted it with Pandoc 3.9 using default options.

### Google's export is not the problem

This is worth stating clearly, because it is easy to blame the wrong step.

We unzipped the `.docx` and read `word/document.xml` directly before converting anything. All **25 equations were there**, as OMML — the native equation markup used inside Word files — with their structure intact:

| Structure tag | Count | What it is |
|---|---|---|
| `m:f` | 5 | fractions |
| `m:rad` | 4 | roots |
| `m:nary` | 8 | large operators (sum, integral, product) |
| `m:sSup` | 4 | superscripts |
| `m:sSub` | 2 | subscripts |
| `m:limLow`, `m:acc`, `m:bar`, `m:d` | 1 each | limit, accent, overbar, delimiter |

Symbols came out as Unicode math characters. Google's export did its job.

Remember that `m:rad` count — four roots, present and correct in the exported file. It matters in a moment.

### What survived the conversion

Being fair about this first, because plenty did come through correctly:

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

Every symbol converted properly too — the Unicode-to-LaTeX mapping turned the math characters back into commands like `\leq`, `\geq`, and the full Greek set. Large operators with limits, standalone roots, accents, vectors, absolute value: all fine.

### What broke

Four equations came out wrong.

| What it should be | What Pandoc produced | What was lost |
|---|---|---|
| $x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$ | $x = \frac{- b \pm}{2a}$ | the entire discriminant |
| $\frac{1}{\sigma\sqrt{2\pi}}e^{\cdots}$ | $\frac{1}{\sigma}e^{\cdots}$ | the `\sqrt{2\pi}` factor |
| $\sqrt{\frac{1}{2}}$ | `\(\)` | everything — empty output |
| $\overline{x}$ | $\underline{x}$ | an overbar became an underline |

Look at the first row for a moment. That is the quadratic formula with the discriminant removed and the plus-minus left dangling. It is not a formula that means something slightly different. It is not a formula at all.

### The pattern

Three of the four failures share one shape: **a fraction and a root in contact with each other**. Root inside a numerator, root inside a denominator, fraction inside a root — all three combinations, all three lost the root.

Meanwhile the standalone `\sqrt[n]{x}` survived intact.

And recall that `m:rad` count from the export check: the roots were in the `.docx`. Google handed them over. They went missing during conversion, not before it. If you take one thing from this post, take the habit of checking which step actually dropped something before deciding who to blame.

The fourth failure, the overbar turning into an underline, is a different kind of problem — not a loss but a change of meaning. $\overline{x}$ is a sample mean nearly everywhere it appears in a paper. $\underline{x}$ is not.

### The part that actually matters

There is no error message. There is no warning. **The output compiles cleanly.**

You get a `.tex` file, you paste it into Overleaf, it builds, you see a document. The quadratic formula sitting in it is wrong, and nothing anywhere told you so. You find out when a reader finds out — a co-author, a reviewer, or nobody.

This is the real cost of the free route, and it is not the one people plan for. The failure mode you can handle is the one that stops and says it failed. This one hands you a clean build.

### About that 16 percent

Four out of twenty-five equations is sixteen percent, and we would rather you did not focus on that number.

The failures were **not distributed evenly**. Simple constructs survived; compound ones broke. A document full of standalone integrals would have converted perfectly. A document full of fractions containing roots would have been devastated.

Real papers are made of the second kind. So the percentage you should expect is not sixteen — it is however much of *your* document is built out of nested constructs, which is a different number, and possibly a much worse one.

### If your equations are images

One more case, since it is common. If your equations were inserted as pictures rather than typed in the equation editor, Pandoc gives you this:

```latex
\includegraphics[width=1.08333in,height=0.23611in,
  alt={AIMATH\_FORMULA::v2::inline::x = \textbackslash frac\{-b \textbackslash pm ...}]{media/image2.png}
```

The interesting detail is that the original LaTeX source was right there in the image's alt text, and it survived the export. Pandoc had the answer in hand. But it treats alt text as a caption string, so it escapes every backslash and hands you `\textbackslash frac` — a description of an equation rather than an equation. You get a picture in your Overleaf project, not math you can edit.

### Limits of this measurement

Being explicit, because a measurement you cannot check is just an assertion:

- **One document, one Pandoc version (3.9), default options.** We did not test alternative filters or flags, and some of these may well be fixable with the right invocation.
- **We did not investigate whether these four are known bugs or intended behaviour.** If they are bugs and someone reports them upstream, they get fixed, and this comparison stops being true. Nothing here is a permanent property of Pandoc.
- **We did not test the other export formats.** We ran `.docx` because it is the route people actually take.

If you try this on your own document and get a different result, we would genuinely like to hear it.

## 3. Route two: the other export formats

If `.docx` loses things, the natural next thought is to try a different format out of Docs.

The honest answer is that we did not measure this route, so we will not tell you how it goes. What we can tell you is the shape of it: **none of the export formats is `.tex`**, so every one of them still needs a second conversion step, and every conversion step is a place where something can be dropped. Choosing `.odt` or `.html` instead of `.docx` changes which converter you are trusting; it does not remove the conversion.

Two things are worth knowing before you spend an evening on it. Markdown export produces `$...$` math, which sounds promising, but a Doc built with the native equation editor has no `$` delimiters in it to begin with — that is a separate problem we have written about in [what the equation editor actually stores](/blog/en/posts/google-docs-equation-editor-internals/). And whichever format you pick, you should apply the check in section 6 to the result rather than assuming a different file extension fixed anything.

## 4. Route three: pay someone to do it

Human conversion services exist specifically for this, and they are aimed squarely at researchers facing a submission deadline. Advertised prices run roughly **49 to 299 US dollars per job**, depending on length and turnaround.

Treat those numbers as advertised prices rather than a market rate; some of these companies also publish comparisons of the free tools, which makes them an interested party on the question of how bad the free tools are. That is precisely why this post uses our own measurement instead of quoting theirs.

What this route costs:

- **Money, per document.** Not per month — per job.
- **Turnaround time**, which is exactly the thing in shortest supply when this route becomes attractive.
- **Iteration.** This is the one people underestimate. Your paper is not done. When a co-author revises section 3, the conversion you paid for is stale, and fixing it is another job or another evening. The cost is not the price; it is the price multiplied by how many times your document changes.

For a genuinely final document with a real deadline and no appetite for risk, this route is rational. For a document still in motion, it is a trap.

## 5. Route four: convert inside the document

The last category is tools that read the Google Doc directly, without an intermediate file — add-ons that run inside Docs and produce LaTeX from the document itself.

Structurally this route skips the step where route one lost its roots. There is no `.docx`, so there is no OMML-to-LaTeX conversion to lose anything in; the tool reads the document's own structure. Whether a specific add-on actually does that well is a different question, and **we have not benchmarked any of them**, so we are not going to rank them for you. What we can say is what to ask: does it read the equation objects themselves, and what does it do with an equation it cannot handle — convert it wrong, or tell you?

The costs here are the ones that come with installing anything into a document you care about: what permissions it asks for, whether it works on the whole document or a selection, and what happens to your original.

## 6. How to check your own document

Whatever route you pick, this takes ten minutes and is worth all of them.

1. **Compile the output before you trust it.** A clean build is not evidence of a correct conversion — as section 2 showed, wrong math compiles perfectly well. Compiling only rules out the loud failures.
2. **Read your equations side by side.** Put the original Doc next to the rendered PDF and go equation by equation. This is tedious and it is the only thing that actually works.
3. **Check the compound ones first.** From what we measured, the risk concentrates in fractions and roots that touch each other. If you only have time to check some of your equations, check those.
4. **Look for things that are subtly different, not just missing.** A vanished discriminant is easy to spot once you look. An overbar that became an underline is not, and it changes what the symbol means.
5. **Count.** If your document had 40 equations, make sure the output has 40. An equation that converted to an empty `\(\)` leaves no gap on the page to notice.

## 7. So which route

There is no universally right answer, which is why this post is a loss analysis rather than a recommendation.

| Route | You pay in | Main risk |
|---|---|---|
| Export plus Pandoc | time, repeatedly | silent, uneven loss in compound equations |
| Other export formats | time, plus a second converter | unmeasured — same structural risk |
| Human service | money, per job | staleness the moment the document changes |
| In-document tools | setup and permissions | varies by tool; ask what it does when it fails |

The general shape: the more times your document will change before submission, the worse the one-time-cost routes look. The more complex your equations, the worse the automated-with-an-intermediate-format routes look. If both are true — a paper still in revision, full of nested fractions and roots — you are in the situation this whole problem is hardest for, and the checking step in section 6 stops being optional.

## 8. Why we ran this

We build [LaTeXFlow](/latexflow/), which converts LaTeX you have written in a document into rendered equations. That is the opposite direction from this post, and to be clear about what exists today: we do not currently ship a Docs-to-`.tex` export. We are working on the reverse direction, and before building it we wanted to know whether the free route already solved the problem well enough that there was no point.

The answer surprised us in a specific way. We expected the free route to fail loudly — a crash, a mangled file, an obvious mess. Instead it produced a clean, compiling document with the discriminant missing from the quadratic formula and no indication anything had happened. That is a harder problem than a crash, because a crash tells you to go look.

If you are moving a document to Overleaf this week: run whichever route suits you, then go and read your equations. Especially the ones with a root inside a fraction.
