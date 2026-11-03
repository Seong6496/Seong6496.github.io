---
title: "How to Write an Equation in LaTeX: The Five Pieces You Need First"
date: 2026-11-25 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/how-to-write-an-equation-in-latex/
categories: [LaTeX, Tutorial]
tags: [latex, equations, beginner, math-mode, fractions, greek-letters, google-docs, tutorial]
math: true
pin: false
description: "How to write an equation in LaTeX, for a first-timer: math mode and its delimiters, superscripts and subscripts with braces, fractions and roots, Greek letters and symbols, sums and integrals with limits. Each piece with the code and what it looks like, the five mistakes beginners make, and a place to try it without installing anything."
---

<!-- Sources: standard LaTeX/amsmath syntax; LaTeXFlow Equation tab behaviour (live preview, Insert into Docs, always display) from the 09-10 post and the v17 sidebar; Scan delimiters per the 09-12 post. -->

To write an equation in LaTeX, put the maths between delimiters — `$…$` inside a sentence, `\[ … \]` on its own line — and write it with a few building blocks: `^` and `_` for superscripts and subscripts, `\frac{}{}` and `\sqrt{}` for fractions and roots, backslash names such as `\alpha` for symbols, and `\sum` or `\int` with limits. Those five pieces cover most of the equations in a typical course or paper.

Each piece below comes with its code and its result. You can try every example as you go, in Google Docs™, without installing LaTeX (section 7).

## 1. Math mode: tell LaTeX where the maths is

Everything mathematical goes into **math mode**. There are two kinds:

| Write | Result | Use for |
|---|---|---|
| `The area is $\pi r^2$.` | The area is $\pi r^2$. | maths inside a sentence (inline) |
| `\[ E = mc^2 \]` | a centred line of its own | an equation on its own line (display) |

$$E = mc^2$$

Inside math mode, letters are set in italics as variables, spaces you type are ignored, and LaTeX does the spacing around `=` and `+` itself. Outside it, the same characters are ordinary text. `$$…$$` and `\(…\)` also exist; which of the four to use, and where each breaks, is in [LaTeX Math Delimiters](/blog/en/posts/latex-math-delimiters-which-to-use/).

To number an equation, use the `equation` environment instead of `\[ … \]`:

```latex
\begin{equation}
  a^2 + b^2 = c^2
\end{equation}
```

## 2. Superscripts and subscripts: ^ and _, with braces

```latex
x^2   \qquad   a_n   \qquad   x^{10}   \qquad   a_{n+1}   \qquad   e^{-x^2}
```

$$x^2 \qquad a_n \qquad x^{10} \qquad a_{n+1} \qquad e^{-x^2}$$

`^` and `_` take **one** character. For anything longer, wrap it in braces: `x^10` gives $x^10$, which is $x^1$ followed by 0; `x^{10}` gives $x^{10}$.

## 3. Fractions and roots

```latex
\frac{a}{b}   \qquad   \frac{x+1}{x-1}   \qquad   \sqrt{2}   \qquad   \sqrt[3]{x}
```

$$\frac{a}{b} \qquad \frac{x+1}{x-1} \qquad \sqrt{2} \qquad \sqrt[3]{x}$$

`\frac` takes two groups in braces, numerator then denominator. They nest: the quadratic formula is

```latex
x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
```

$$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$

## 4. Greek letters and symbols: backslash names

Symbols are written as a backslash and a name:

| Code | Result | Code | Result |
|---|---|---|---|
| `\alpha`, `\beta`, `\pi` | $\alpha, \beta, \pi$ | `\le`, `\ge`, `\ne` | $\le, \ge, \ne$ |
| `\Delta`, `\Omega` | $\Delta, \Omega$ | `\times`, `\cdot`, `\pm` | $\times, \cdot, \pm$ |
| `\infty` | $\infty$ | `\to`, `\Rightarrow` | $\to, \Rightarrow$ |
| `\sin x`, `\log x` | $\sin x, \log x$ | `\in`, `\subset` | $\in, \subset$ |

Capital Greek letters that look like Latin ones (A, B, E, …) have no command; type the Latin letter. Function names such as `\sin` and `\log` keep the name upright, as it should be; plain `sin` would be three italic variables.

## 5. Sums, integrals and limits

Large operators take their limits with `_` and `^`:

```latex
\sum_{k=1}^{n} k   \qquad   \int_0^1 x^2 \, dx   \qquad   \lim_{x \to 0} \frac{\sin x}{x}
```

$$\sum_{k=1}^{n} k \qquad \int_0^1 x^2 \, dx \qquad \lim_{x \to 0} \frac{\sin x}{x}$$

The `\,` is a thin space, the usual way to set off $dx$. Brackets that grow with their content are written with `\left(` and `\right)`:

```latex
\left( \frac{a}{b} \right)^2
```

$$\left( \frac{a}{b} \right)^2$$

## 6. Five mistakes beginners make

1. **Forgetting math mode.** `x^2` outside `$…$` is an error; LaTeX stops with `! Missing $ inserted`.
2. **Leaving out braces.** `x^10` and `\frac12+1` do not mean what they look like; use `x^{10}` and `\frac{1}{2}+1`.
3. **Typing words inside maths.** `$speed = d/t$` sets *speed* as five italic variables. Use `\text{speed}` (from the `amsmath` package).
4. **Unbalanced brackets.** Every `{` needs its `}`, and every `\left` its `\right`.
5. **Expecting `\\` to start a new line.** In a display it does nothing on its own; [equations over several lines](/blog/en/posts/latex-equation-multiple-lines/) need `align*` or `aligned`.

## 7. Try it in Google Docs™

You do not need a LaTeX installation to practise. With the free LaTeXFlow add-on, Google Docs™ shows what your LaTeX produces:

1. Install the add-on and open **Extensions → LatexFlow → Open Equation Panel** ([install walkthrough](/blog/en/posts/convert-latex-in-google-docs/)).
2. On the **Equation** tab, type an equation from this post, for example `x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}`. The live preview shows the result as you type, so a missing brace shows up at once.
3. Place the cursor in the document and press **➕ Insert into Docs**. The equation goes in as a display equation.
4. For several equations in a sentence or a page, type them straight into the document between `$…$` or `$$…$$`, then on the **Scan** tab press **🔍 Scan Document** and **⚡ Convert All**.

<!-- TODO shot: the LaTeXFlow Equation tab with the quadratic formula typed in the box and the live preview rendered below it, a Google Docs™ document beside it with the cursor on an empty line. Live v17. -->
<!-- TODO shot: the same document after Insert into Docs, the formula rendered as a display equation. -->

Each converted equation keeps its LaTeX, so you can select it, press **↩ Revert to LaTeX**, fix it and convert it again.

## 8. FAQ

**How do you write an equation in LaTeX?**
Put it in math mode — `$…$` inline, `\[ … \]` or `equation` on its own line — and build it from `^`, `_`, `\frac`, `\sqrt`, backslash symbol names and operators such as `\sum` and `\int`.

**What is a LaTeX equation?**
An equation written as plain-text LaTeX code, such as `\frac{a}{b}`, that LaTeX (or a renderer such as MathJax) typesets into a formatted formula.

**How do I write math in LaTeX without installing it?**
Use an online editor such as Overleaf, or practise inside Google Docs™ with the LaTeXFlow Equation tab, which previews the LaTeX as you type (section 7).

**How do I number equations in LaTeX?**
Use `\begin{equation} … \end{equation}`. Add `\label{eq:name}` inside it and refer to it with `\eqref{eq:name}`.

## 9. Summary

- Math mode: `$…$` inline, `\[ … \]` or `equation` for a line of its own.
- `^` and `_` with braces; `\frac{}{}` and `\sqrt{}`; `\alpha`-style names; `\sum` and `\int` with limits; `\left( … \right)`.
- Practise with a live preview: [LaTeXFlow for Google Docs™](https://workspace.google.com/marketplace/app/latexflow/59137436133?flow_type=2&utm_source=blog&utm_medium=post&utm_campaign=how-to-write-an-equation-in-latex), **Equation** tab, type, **Insert into Docs**.
