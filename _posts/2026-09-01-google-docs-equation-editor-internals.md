---
title: "What Google Docs' Equation Editor Actually Stores"
date: 2026-09-01 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/google-docs-equation-editor-internals/
categories: [Google Docs, Reference]
tags: [google-docs, equations, latex, apps-script, reference]
math: true
pin: false
description: "We opened up equations built with the Google Docs equation editor and logged the structure Apps Script returns. It is a small tree with LaTeX command names already in it. Here is the full function table, the symbol list, and the things Docs cannot build at all."
---

If you build an equation in Google Docs with *Insert → Equation*, what is actually stored?

Not what it looks like on screen — what a program reading the document gets back. The answer matters if you ever want to move that document somewhere else, because the two obvious ways to read a Doc give completely different answers, and one of them is quietly useless.

We ran a throwaway Apps Script probe over a document of hand-built equations, walked the body recursively, and dumped every element type along with what `getCode()` and `getText()` returned. This post is the log and what we decoded from it. Everything below is measurement rather than documentation: we did not find the codes and argument shapes written down anywhere we could rely on, so we went and looked at what the API actually returns.

## 1. The text layer is a dead end

Start with the failure, because it is the reason the rest of this post exists.

The straightforward way to read a paragraph is to ask for its text. Here is what that returns for two equations:

| What is on screen | What the text layer returns |
|---|---|
| $\frac{1}{2}$ | `12` |
| $\alpha + \beta$ | `" + "` |

Both are unrecoverable, in different ways.

The fraction collapses **without any delimiter**. You get `12`, and there is no way to tell whether the author wrote one-half or the number twelve. It gets worse with real content: $\frac{a+b}{c}$ comes back as `a+bc`. No amount of post-processing recovers the boundary, because the boundary is simply not in the string.

The Greek letters are worse still. They do not appear at all. The text layer returns a space, a plus sign, and a space — the symbols leave no trace whatsoever.

### A trap worth knowing about

This has a practical consequence that will bite anyone using a text-based LaTeX converter on a Doc containing native equations.

Suppose you have a converter that scans for `$...$` and `$$...$$`. You notice your native equations are not being detected, so you do the reasonable thing and wrap one in `$$`. The scanner now finds `$$12$$` and happily converts it — and you get an image of the number **12** sitting where your fraction used to be.

There is no error. The result is a plausible-looking number, so it does not announce itself as wrong. This is the failure mode to actually worry about with document conversion: not the crash, but the silent substitution.

We have **not** verified what happens to the original equation object in that case — whether it survives underneath or is replaced. That is a separate question we have not measured.

## 2. The structure layer

Now the part that works.

Docs does not store an equation as text. It stores it as a small tree, and Apps Script will hand you that tree. The element type is `EQUATION`, and underneath it you find three kinds of node:

- `EQUATION_FUNCTION` — a construct like a fraction or a root, carrying a code
- `EQUATION_SYMBOL` — a single symbol, carrying a code
- `TEXT` — literal characters

plus one separator node, `EQUATION_FUNCTION_ARGUMENT_SEPARATOR`, which we will get to shortly because it is the whole trick.

Here are the real dumps.

### A fraction

```text
EQUATION text="12a+b=2"
  EQUATION_FUNCTION code="\frac" text="12"
    TEXT text="1"
    EQUATION_FUNCTION_ARGUMENT_SEPARATOR
    TEXT text="2"
  TEXT text="a+b=2"
```

Look at the `text` attribute on the outer node: `12a+b=2`. That is the useless string from section 1, and you can now see exactly where it comes from — it is the tree flattened with the structure thrown away. The structure is right there one level down.

### Greek letters

```text
EQUATION text=" + "
  TEXT text=" "
  EQUATION_SYMBOL code="\alpha"
  TEXT text="+"
  EQUATION_SYMBOL code="\beta"
  TEXT text=" "
```

The symbols that were invisible to the text layer are sitting in plain view as `EQUATION_SYMBOL` nodes, and their codes are already LaTeX.

### Roots, superscripts, subscripts

```text
EQUATION_FUNCTION code="\sqrt" text="x"
  TEXT text="x"

EQUATION_FUNCTION code="\superscript" text="x2"
  TEXT text="x"
  EQUATION_FUNCTION_ARGUMENT_SEPARATOR
  TEXT text="2"

EQUATION_FUNCTION code="\subscript" text="x1"
```

### A nested fraction

```text
EQUATION_FUNCTION code="\frac" text="123"
  EQUATION_FUNCTION code="\frac" text="12"
    TEXT text="1"
    EQUATION_FUNCTION_ARGUMENT_SEPARATOR
    TEXT text="2"
  EQUATION_FUNCTION_ARGUMENT_SEPARATOR
  TEXT text="3"
```

Nesting works the way you would hope: a function can be another function's argument. The flattened `text` is `123`, which could be anything; the tree says $\frac{\frac{1}{2}}{3}$ unambiguously.

### Sums and integrals

```text
EQUATION text="x=1nx2"
  EQUATION_FUNCTION code="\sumab" text="x=1n"
    TEXT text="x=1"
    EQUATION_FUNCTION_ARGUMENT_SEPARATOR
    TEXT text="n"
  EQUATION_FUNCTION code="\superscript" text="x2"     ← sibling, not child

EQUATION text="abxdx"
  EQUATION_FUNCTION code="\intab" text="ab"
    TEXT text="a"
    EQUATION_FUNCTION_ARGUMENT_SEPARATOR
    TEXT text="b"
  TEXT text="xdx"                                     ← sibling, not child
```

Those last two dumps carry the one piece of structure that is genuinely surprising, so it gets its own rule below.

## 3. Three rules that decode the whole thing

**Rule 1 — the codes are LaTeX-shaped.** `getCode()` returns `\frac`, `\sqrt`, `\alpha`, `\beta` — not opaque internal identifiers you would have to reverse-engineer a lookup table out of. How much translation you need depends on which kind of node you are looking at: every symbol we tested passes through unchanged, while 9 of the 14 functions need a rewrite. Sections 5 and 6 give both lists in full.

**Rule 2 — the separator marks argument boundaries.** `EQUATION_FUNCTION_ARGUMENT_SEPARATOR` is precisely the information the text layer destroys. A one-argument function like `\sqrt` has no separator among its children. A two-argument function like `\frac` has one. Split the children on separators and you have the arguments.

**Rule 3 — for big operators, the limits are the arguments and the body is a sibling.** This is the one to watch. In the sum dump above, `\sumab` has exactly two children groups — `x=1` and `n` — which are the lower and upper limits. The thing being summed, $x^2$, is **not inside it**. It is the next sibling. Same for the integral: `\intab` holds `a` and `b`, and `xdx` follows as a sibling.

If you assume the summand is a child, you will produce $\sum_{x=1}^{n}$ followed by nothing, and lose the body.

## 4. A hypothesis that turned out to be wrong

Worth showing, because it is the kind of thing you only catch by testing rather than reasoning.

Looking at `\sumab` and `\intab`, the obvious read is that the `ab` suffix means *both limit slots are filled* — implying there should be `\suma`, `\sumb`, and a bare `\sum` for the other combinations. That was our first guess.

We then built sums and integrals with limits deliberately left empty, and logged them:

| Input | Code returned | Children |
|---|---|---|
| Sum, no limits | `\sumab` | separator only |
| Sum, lower limit only | `\sumab` | TEXT, separator |
| Sum, upper limit only | `\sumab` | separator, TEXT |
| Integral, no limits | `\intab` | separator only |

The guess was wrong. **`\sumab` is a fixed name.** There are always two slots; an empty slot simply has no child sitting in it. `\suma` and `\sumb` do not exist.

The rule is simpler than the hypothesis, which is the nice direction for a surprise to go: one name, one shape, and empty slots get omitted from the output.

## 5. The complete function table

Fourteen functions, all confirmed by probe. `A1` and `A2` are the first and second argument groups.

| Docs code | Args | LaTeX | Needs translation |
|---|---|---|---|
| `\frac` | 2 | `\frac{A1}{A2}` | no |
| `\sqrt` | 1 | `\sqrt{A1}` | no |
| `\rootof` | 2 | `\sqrt[A1]{A2}` | yes |
| `\superscript` | 2 | `{A1}^{A2}` | yes |
| `\subscript` | 2 | `{A1}_{A2}` | yes |
| `\sumab` | 2 | `\sum_{A1}^{A2}` | yes |
| `\intab` | 2 | `\int_{A1}^{A2}` | yes |
| `\prodab` | 2 | `\prod_{A1}^{A2}` | yes |
| `\ointab` | 2 | `\oint_{A1}^{A2}` | yes |
| `\limab` | 2 | `\lim_{A1 \to A2}` | yes |
| `\overline` | 1 | `\overline{A1}` | no |
| `\vec` | 1 | `\vec{A1}` | no |
| `\widehat` | 1 | `\widehat{A1}` | no |
| `\abs` | 1 | single vertical bars — see note | yes |

Three notes on this table.

`\limab` is the only genuine special case. Every other two-slot operator maps its arguments to a subscript and a superscript; the limit maps them to `A1 \to A2` in a single subscript, because $\lim_{x \to 0}$ is written as one thing rather than as lower and upper bounds.

For the `\sumab` family, an empty slot means you drop the whole `_{}` or `^{}` group rather than emitting it empty. A sum with no limits should come out as `\sum`, not `\sum_{}^{}`.

Absolute value is the one row a markdown table cannot show cleanly, because its output contains a vertical bar. Written out, it is:

```text
\left|A1\right|
```

Single bars, not double. Double bars are the norm, which is a different construct and not what this function produces.

## 6. Symbols need no table at all

This was the pleasant surprise. We logged **93 symbols** from the palette, and every single `getCode()` value came back as a valid, ordinary LaTeX command. For symbols there is no mapping table to build at all — you print the code.

**Relations, 21:**

```text
\leq \geq \prec \succ \preceq \succeq \ll \gg \equiv \sim \simeq
\asymp \approx \ne \subset \supset \subseteq \supseteq \in \ni \notin
```

**Greek, 40:** the lowercase set from `\alpha` through `\omega`, the uppercase set from `\Gamma` through `\Omega`, and the six variant forms:

```text
\varepsilon \vartheta \varsigma \varpi \varrho \varphi
```

**Operators and miscellaneous, 32:**

```text
\times \div \cdot \pm \mp \ast \star \circ \bullet \oplus \ominus
\oslash \otimes \odot \dagger \ddagger \vee \wedge \cap \cup \aleph
\Re \Im \top \bot \infty \partial \forall \exists \neg \triangle \diamond
```

## 7. Does it reassemble?

Walking the tree and applying the table above, here is what came back out for the eight equations in the first probe:

| Original | Reassembled |
|---|---|
| $\frac{1}{2}a+b=2$ | `\frac{1}{2}a+b=2` |
| $\alpha + \beta$ | `\alpha + \beta` |
| $\sqrt{x}$ | `\sqrt{x}` |
| $x^{2}$, $x_{1}$ | `x^{2}, x_{1}` |
| $\frac{\frac{1}{2}}{3}$ | `\frac{\frac{1}{2}}{3}` |
| $\sum_{x=1}^{n} x^{2}$ | `\sum_{x=1}^{n} x^{2}` |
| $\int_{a}^{b} xdx$ | `\int_{a}^{b} xdx` |

All eight recovered.

Two larger equations were run as integration tests. The quadratic formula came back as:

{% raw %}
```text
x=\frac{-b\pm\sqrt{{b}^{2}-4ac}}{2a}
```
{% endraw %}

The normal distribution density function nests `\frac` inside `\superscript` inside `\frac` inside `\superscript` — four levels — and the nesting survived intact.

## 8. What Google Docs cannot build

This is the part most worth knowing if you are planning around the equation editor, and it is genuinely good news for anyone writing a converter.

We tried to build each of these in the Docs equation editor and could not:

| Construct | Status in the Docs equation editor |
|---|---|
| Matrices | cannot be built |
| Cases / piecewise | cannot be built |
| Double integrals | cannot be built |
| Auto-sized brackets | do not exist — brackets are plain characters |
| Function names such as `\sin` | no such concept — they are plain letters |

If you have been planning to write a matrix in Google Docs and export it, that plan does not work, and it is better to know now than at 2 a.m. before a deadline.

The flip side is that the set of things the editor *can* produce is small and closed. Fourteen functions and ninety-three symbols is the whole surface. A converter that handles all of them handles everything the editor can make — not most of it, all of it.

## 9. Three awkward corners

**Brackets are characters, and braces will break your output.** Typing `(1/2)`, `{1/2}`, or `[1/2]` gives you plain `TEXT` nodes containing those characters. That is fine for parentheses and square brackets, but a raw `{` or `}` reaching a LaTeX compiler is read as grouping and breaks the build. Any reassembler has to escape them as `\{` and `\}`.

**Function names stay as letters — and leaving them alone is the more faithful choice.** Typing `sin x` produces a single `TEXT` node reading `sinx`. There is no function concept in the editor at all; what you typed is what is stored. It is tempting to "helpfully" rewrite that to `\sin`, but consider what the document actually looks like: Docs renders those letters in italic, exactly like any other variable. In LaTeX, `sin` is italic and `\sin` is upright. Leaving it as `sin` matches the original rendering; rewriting it changes the document's appearance based on a guess about intent. That is the same category of error as the silent `12` in section 1 — a plausible result that differs from the source. Better as an explicit opt-in setting than a default.

**Subscripts attach to one character.** Typing $\log_2 x$ splits into three pieces: `lo`, then `\subscript` over `g` and `2`, then `x`. Docs attaches the subscript to the immediately preceding character only. The reassembled source is ugly — `lo{g}_{2}x` — but it renders correctly, which is the part that matters.

## 10. What this measurement does not cover

Being clear about the edges, since the whole point of publishing a measurement is that someone else can check it:

- **One machine, one locale.** Every log here comes from a single environment. We have not checked whether Docs version or interface language changes any of the codes.
- **Reading only.** This probe covered getting equations *out*. Whether Apps Script can *create* a native equation object is a separate question and we did not test it.
- **Equations split across an object boundary.** During the probe we hit a case where a user had put $\sum$ in an equation object and typed the adjacent `x` as ordinary paragraph text. Deciding whether that neighbouring text belongs to the equation requires guessing, and we have chosen not to guess. The text is not lost in that case — it stays in the output as ordinary text — it just falls outside the math.

## 11. Why we measured this

We build [LaTeXFlow](/latexflow/), which converts LaTeX written in a document into rendered equation images. The reverse direction — reading a finished Doc back out as LaTeX source — kept running into native equations, and the published documentation was not detailed enough to tell us whether they were recoverable. So we probed it.

The short answer is that they are recoverable, deterministically, from a table small enough to fit in this post. We had assumed this would need something cleverer.

If you are writing your own converter, the table in section 5 and the symbol lists in section 6 are the whole map. If you find a code we missed — particularly on a non-English Docs interface, which we could not test — we would like to know.
