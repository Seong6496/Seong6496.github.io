---
title: "How to Align Equations in Google Docs™"
date: 2026-12-05 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/align-equations-in-google-docs/
categories: [Google Docs, Guide]
tags: [google-docs, equations, align, aligned, multi-line, latex, add-on]
math: false
pin: false
description: "Lining up the equals signs of a derivation in Google Docs™: what the built-in equation editor can do with Tab, where it stops, and how LaTeX aligned converted by the free LaTeXFlow add-on gives a real multi-line equation. Measured in a real document."
---

<!-- Sources: .tmp/r266_blog_queue.md (measured 2026-11-24, mathfolis.support, live LaTeXFlow from the Marketplace): Docs equation editor lines centred vs split at the equals sign with Tab (shot 01); $$\begin{aligned}…\end{aligned}$$ with and without \tag, Scan Document = Found 3, Convert All 3 / 3, inserted at the left, centred with Ctrl+Shift+E (shot 02). Enter leaves the equation box, one line per equation: 10-02 post (measured). -->

Google Docs™ can show a derivation line by line, but its own equation editor has no way to line up the equals signs: each equation holds one line, and Enter leaves the box instead of starting a new line. There is a workaround with the Tab key that gets close. For a real multi-line equation, write it in LaTeX with `aligned` and convert it with the free LaTeXFlow add-on.

Both were tried in a real document on 24 November 2026.

## 1. What the equation editor does

Insert two equations, one per line, and centre them. Each line is centred on its own width, so the equals signs land wherever they land:

![Top: "Centred, one equation per line": f(x) = (x + 1)² and, under it, = x² + 2x + 1, both centred, with the two equals signs at different positions. Bottom: "The same lines, split at the equals sign with Tab": f(x), then a gap, then = (x + 1)²; on the next line = x² + 2x + 1 starts under the first equals sign](/assets/img/posts/2026-12-05/01-docs-equations-tab.png){: width="680" }

## 2. The Tab workaround

The lower half of the picture above is the workaround. Split each line at the equals sign into two equations and put a Tab between them:

1. On the first line: **Tab**, insert the left side as an equation (`f(x)`), click after it, **Tab**, insert the right side starting with `=` (`= (x+1)^2`).
2. On the next line: **Tab** twice, then the next right side (`= x^2 + 2x + 1`).

The right sides start at the same tab stop, so the equals signs line up.

Where it stops:

- Each piece is a separate equation. Editing one does not move the others, and nothing keeps them together if the text above changes.
- The left sides have to end before the tab stop the right sides start at. For longer left sides, add your own left tab stop further right (click the ruler) and use it on every line.
- There is no bracket or brace spanning the lines, and no single number for the block.

For two or three short lines it is fine. For anything longer, LaTeX is less work.

## 3. With LaTeX: aligned, then Convert All

In LaTeX, `aligned` lines up its rows at the `&` and breaks lines at `\\`. Type it as one display equation:

```
$$\begin{aligned} f(x) &= (x+1)^2 \\ &= x^2 + 2x + 1 \end{aligned}$$
```

Then open the add-on (**Extensions → LatexFlow → Open Equation Panel**), go to the **Scan** tab, press **🔍 Scan Document** and then **⚡ Convert All**. In our document every block converted. Each one goes in on its own line at the left; to centre it, click its line and press `Ctrl+Shift+E`.

![After Convert All and centring: "Expanding the square:" followed by f(x) = (x + 1)² and = x² + 2x + 1 with the equals signs exactly under each other; then "A numbered system:" with a + b = 5 and 2a − b = 4 aligned on their equals signs and one number (2) beside both lines](/assets/img/posts/2026-12-05/02-aligned-converted.png){: width="680" }

A number for the whole block goes after `\end{aligned}`:

```
$$\begin{aligned} a + b &= 5 \\ 2a - b &= 4 \end{aligned} \tag{2}$$
```

The converted block is one image that keeps its LaTeX. To change a line, click it and press **↩ Revert to LaTeX** on the Scan tab, edit, and convert again. Other layouts (`gather*` for centred lines with no alignment, `cases` for piecewise functions, `multline*` for one long formula) work the same way; [LaTeX Equation on Multiple Lines](/blog/en/posts/latex-equation-multiple-lines/) shows which to use when.

## 4. FAQ

**Can I make a multi-line equation in Google Docs™?**
Not with its own equation editor: Enter leaves the equation box. Write the lines in LaTeX with `aligned` and convert them with LaTeXFlow (section 3).

**How do I align equals signs in Google Docs™?**
Without an add-on, split each line at the equals sign into two equations and use Tab so the right sides start at the same tab stop (section 2). With LaTeX, put `&` before each equals sign inside `aligned`.

**How do I centre an equation in Google Docs™?**
Click its line and press `Ctrl+Shift+E`, or Format → Align & indent → Center.

To number equations as well, see [How to Number Equations in Google Docs™](/blog/en/posts/number-equations-in-google-docs/).

## 5. Summary

1. Docs' equation editor holds one line per equation; centred lines do not align.
2. Short derivations: split at the equals sign and use Tab.
3. Real alignment: `$$\begin{aligned} … &= … \\ … \end{aligned}$$`, then **Scan Document** and **Convert All**; centre with `Ctrl+Shift+E`.

Get the add-on: [LaTeXFlow for Google Docs™](https://workspace.google.com/marketplace/app/latexflow/59137436133?flow_type=2&utm_source=blog&utm_medium=post&utm_campaign=align-equations-in-google-docs). Scan and Convert All are free.
