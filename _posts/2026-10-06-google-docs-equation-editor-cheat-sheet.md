---
title: "Google Docs Equation Editor Cheat Sheet: Every Name You Can Type, Its LaTeX Equivalent, and the Ones Docs Rejects"
date: 2026-10-06 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/google-docs-equation-editor-cheat-sheet/
categories: [Google Docs, Reference]
tags: [google-docs, equation-editor, cheat-sheet, latex, shortcuts, symbols, reference]
math: true
pin: false
description: "A lookup table for the Google Docs equation editor (Insert > Symbols > Equation): all 125 palette names you can type as backslash commands — 40 Greek, 32 operations, 21 relations, 12 arrows, 20 structures — with their LaTeX equivalents, the seven Google-only structure names and what they mean in LaTeX, the commands Docs silently rejects (\\neq, \\to, \\left, \\iint, matrices), and how far each claim was verified."
---

This is the table version of [the equation editor post](/blog/en/posts/google-docs-equation-editor-typing-and-limits/). That post explains how the editor behaves; this one is for looking a name up. If you already know that Space converts a backslash name and that the toolbar is the whole vocabulary, skip to the tables.

The editor opens from **Insert → Symbols → Equation** (keyboard: `Alt+I, Y, E`). Inside the box you type `\name` and press **Space**; the name becomes a symbol or a structure. Everything below was measured in Google Docs on the web, English UI, on 2026-09-21 and 2026-09-22, in one account on one machine — see §5 for exactly how far each table was checked.

## 1. Six rules for typing a name

1. **Space converts.** The space itself is consumed; nothing visible is inserted.
2. Any **non-alphanumeric key** also converts the pending name — `\beta+` gives β followed by +.
3. **A digit does not.** `\epsilon2` stays literal. Put a Space between the name and the digit.
4. **Enter, Tab and Shift+Enter do not convert;** they leave the box with the text unconverted.
5. **There is no autocomplete.** Nothing suggests names while you type.
6. **An unknown name is not an error.** It stays on screen as italic text — no beep, no red mark (table C is the list of names this happens to).

That is the whole input model. Slot navigation (Tab into the next slot of the innermost structure, arrows to walk linearly) is in the earlier post's §3 and is not repeated here.

## 2. Table A — the 105 symbol names

Every symbol name on the toolbar is also a LaTeX command with the same meaning, and none of them needs a LaTeX package. So for these five groups the "LaTeX equivalent" column would be the name itself; the tables show the glyph and the verification status instead. Status: **✓** typed as `\name` + Space and seen to convert; **○** typed in the same session but not screenshot-confirmed (treat as untested); nothing in the table failed.

**Greek (40) — all 40 typed, all converted.**

| Name | Glyph | | Name | Glyph | | Name | Glyph |
|---|---|---|---|---|---|---|---|
| `\alpha` | α ✓ | | `\nu` | ν ✓ | | `\varphi` | φ ✓ |
| `\beta` | β ✓ | | `\xi` | ξ ✓ | | `\chi` | χ ✓ |
| `\gamma` | γ ✓ | | `\pi` | π ✓ | | `\psi` | ψ ✓ |
| `\delta` | δ ✓ | | `\varpi` | ϖ ✓ | | `\omega` | ω ✓ |
| `\epsilon` | ϵ ✓ | | `\rho` | ρ ✓ | | `\Gamma` | Γ ✓ |
| `\varepsilon` | ε ✓ | | `\varrho` | ϱ ✓ | | `\Delta` | Δ ✓ |
| `\zeta` | ζ ✓ | | `\sigma` | σ ✓ | | `\Theta` | Θ ✓ |
| `\eta` | η ✓ | | `\varsigma` | ς ✓ | | `\Lambda` | Λ ✓ |
| `\theta` | θ ✓ | | `\tau` | τ ✓ | | `\Xi` | Ξ ✓ |
| `\vartheta` | ϑ ✓ | | `\upsilon` | υ ✓ | | `\Pi` | Π ✓ |
| `\iota` | ι ✓ | | `\phi` | ϕ ✓ | | `\Sigma` | Σ ✓ |
| `\kappa` | κ ✓ | | `\Upsilon` | Υ ✓ | | `\Phi` | Φ ✓ |
| `\lambda` | λ ✓ | | `\Psi` | Ψ ✓ | | `\Omega` | Ω ✓ |
| `\mu` | μ ✓ | | | | | | |

`\epsilon` is the lunate ϵ and `\varepsilon` the ε; `\phi` is ϕ and `\varphi` is φ — the LaTeX convention, not the other way round.

**Miscellaneous operations (32) — 8 confirmed, 24 typed but unconfirmed.**

| Name | Glyph | | Name | Glyph | | Name | Glyph |
|---|---|---|---|---|---|---|---|
| `\times` | × ○ | | `\oslash` | ⊘ ✓ | | `\aleph` | ℵ ✓ |
| `\div` | ÷ ○ | | `\otimes` | ⊗ ○ | | `\Re` | ℜ ✓ |
| `\cdot` | · ○ | | `\odot` | ⊙ ○ | | `\Im` | ℑ ✓ |
| `\pm` | ± ○ | | `\dagger` | † ○ | | `\top` | ⊤ ○ |
| `\mp` | ∓ ✓ | | `\ddagger` | ‡ ✓ | | `\bot` | ⊥ ✓ |
| `\ast` | ∗ ✓ | | `\vee` | ∨ ○ | | `\infty` | ∞ ○ |
| `\star` | ⋆ ○ | | `\wedge` | ∧ ○ | | `\partial` | ∂ ○ |
| `\circ` | ∘ ○ | | `\cap` | ∩ ○ | | `\forall` | ∀ ○ |
| `\bullet` | • ○ | | `\cup` | ∪ ○ | | `\exists` | ∃ ○ |
| `\oplus` | ⊕ ○ | | `\neg` | ¬ ○ | | `\triangle` | △ ○ |
| `\ominus` | ⊖ ○ | | `\diamond` | ⋄ ○ | | | |

**Relations (21) — 9 confirmed, 12 typed but unconfirmed.**

| Name | Glyph | | Name | Glyph | | Name | Glyph |
|---|---|---|---|---|---|---|---|
| `\leq` | ≤ ○ | | `\equiv` | ≡ ○ | | `\subset` | ⊂ ○ |
| `\geq` | ≥ ○ | | `\sim` | ∼ ○ | | `\supset` | ⊃ ○ |
| `\prec` | ≺ ✓ | | `\simeq` | ≃ ✓ | | `\subseteq` | ⊆ ○ |
| `\succ` | ≻ ○ | | `\asymp` | ≍ ✓ | | `\supseteq` | ⊇ ○ |
| `\preceq` | ≼ ✓ | | `\approx` | ≈ ○ | | `\in` | ∈ ○ |
| `\succeq` | ≽ ✓ | | `\ne` | ≠ ✓ | | `\ni` | ∋ ✓ |
| `\ll` | ≪ ✓ | | `\gg` | ≫ ○ | | `\notin` | ∉ ✓ |

`\ne` is the only not-equal name. `\neq`, which LaTeX accepts as a synonym, is rejected by Docs (table C).

**Arrows (12) — 7 confirmed, 5 typed but unconfirmed.** Case matters: `\updownarrow` is ↕ and `\Updownarrow` is ⇕, exactly as in LaTeX.

| Name | Glyph | | Name | Glyph |
|---|---|---|---|---|
| `\leftarrow` | ← ○ | | `\Leftarrow` | ⇐ ✓ |
| `\rightarrow` | → ✓ | | `\Rightarrow` | ⇒ ○ |
| `\leftrightarrow` | ↔ ✓ | | `\Leftrightarrow` | ⇔ ✓ |
| `\uparrow` | ↑ ○ | | `\Uparrow` | ⇑ ○ |
| `\downarrow` | ↓ ○ | | `\Downarrow` | ⇓ ✓ |
| `\updownarrow` | ↕ ✓ | | `\Updownarrow` | ⇕ ✓ |

`\to`, LaTeX's usual short form of `\rightarrow`, is rejected (table C).

## 3. Table B — the 20 structure names, and what they are in LaTeX

The Math operations dropdown is where the names stop being LaTeX. Thirteen of the twenty are LaTeX commands or close to them; seven are Google's own. Each one creates a structure with empty slots (Tab moves to the next slot). The LaTeX column is what the same structure would be written as in LaTeX, with `a`, `b`, `c` standing for the slot contents. Status: **✓** typed as `\name` + Space and confirmed; **T** inserted from the toolbar and confirmed, not typed; **—** not tried by anyone yet.

| Docs name | Builds | LaTeX equivalent | Status |
|---|---|---|---|
| `\frac` | fraction, two slots (caret lands in the numerator) | `\frac{a}{b}` | ✓ |
| `\sqrt` | square root, one slot | `\sqrt{a}` | ✓ |
| `\rootof` | root with an index slot and a radicand slot | `\sqrt[a]{b}` | ✓ |
| `\superscript` | base and raised slot | `{a}^{b}` | — |
| `\subscript` | base and lowered slot | `{a}_{b}` | — |
| `\subsuperscript` | base, lowered and raised slots — **three** slots | `{a}_{b}^{c}` | ✓ |
| `\overline` | bar over one slot | `\overline{a}` | ✓ |
| `\widehat` | hat over one slot | `\widehat{a}` | ✓ |
| `\sumab` | ∑ with lower and upper limit slots, body typed after | `\sum_{a}^{b}` | — |
| `\prodab` | ∏ with limit slots | `\prod_{a}^{b}` | — |
| `\coprodab` | ∐ with limit slots | `\coprod_{a}^{b}` | ✓ |
| `\bigcapab` | ⋂ with limit slots | `\bigcap_{a}^{b}` | T |
| `\bigcupab` | ⋃ with limit slots | `\bigcup_{a}^{b}` | T |
| `\intab` | ∫ with limit slots | `\int_{a}^{b}` | ✓ |
| `\ointab` | ∮ with limit slots | `\oint_{a}^{b}` | — |
| `\limab` | lim with **two** slots underneath and an arrow drawn between them | `\lim_{a \to b}` | ✓ |
| `\rbracelr` | auto-sized ( ) around one slot | `\left( a \right)` | ✓ |
| `\sbracelr` | auto-sized [ ] around one slot | `\left[ a \right]` | T |
| `\bracelr` | auto-sized { } around one slot | `\left\{ a \right\}` | T |
| `\abs` | auto-sized vertical bars around one slot | `\left\| a \right\|` (single bars) | ✓ |

Three things the table cannot show:

- **Typed shorthand is different from the palette name.** Typing `\lim` + Space gives a lim with **one** slot underneath (`\lim_{a}`); the palette's `\limab` gives two with an arrow. Typing `\int`, `\oint` or `\sum` + Space gives the operator with limit slots, the same shape as `\intab`, `\ointab`, `\sumab`. `^` and `_` create a raised or lowered slot immediately, no Space needed.
- **The bracket structures are real auto-sizing brackets** — the ( ) built by `\rbracelr` grows to fit a fraction inside it, exactly like `\left( … \right)` in LaTeX. Typed `(` and `)` are plain characters and stay character-sized.
- **The seven Google-only names** — `\rootof`'s LaTeX cousin exists, but `\subsuperscript`, `\bigcapab`, `\bigcupab`, `\coprodab`, `\rbracelr`, `\sbracelr`, `\bracelr` (and the `-ab` forms generally) mean nothing to LaTeX. If you ever retype a document's equations in LaTeX, those are the names to translate with the column above.

## 4. Table C — names Docs rejects, and what to type instead

These stay on screen as italic text. No error, no underline (three of them get a spell-check squiggle), and the equation looks fine at a glance — which is why they are worth listing.

| You typed | Because in LaTeX it is… | In the Docs editor |
|---|---|---|
| `\neq` | the usual not-equal | type `\ne` |
| `\to` | short for `\rightarrow` | type `\rightarrow` |
| `\left(` `\right)` `\bigl(` | auto-sized brackets | use the toolbar's ( ) [ ] { } \| \| entries, or type `\rbracelr` `\sbracelr` `\bracelr` `\abs` |
| `\{` `\}` | literal braces | `\bracelr` for a brace pair; a typed `{` is a plain character ([why that matters](/blog/en/posts/google-docs-equation-editor-internals/), §9) |
| `\iint` | double integral | two `\int` in a row; there is no single ∬ |
| `\begin{matrix}` `\matrix` `\pmatrix` | matrices | cannot be built — see §6 |
| `\cases` | piecewise function | cannot be built — there is no line break inside a box |
| `\text` `\mathbf` | text and bold inside math | cannot be built — the box has one font |
| `\langle` `\rangle` `\lfloor` | angle brackets, floor | not on the palette; no equivalent found |

The pattern: **if a name is not on the toolbar, Docs does not know it.** The palette is not a subset of what you can type — it is the whole list, plus a handful of function names (§5).

## 5. How far each table was verified

The claim "every palette name is typeable" started as a spot check, so here is the exact state.

- **79 of the 125 names have been tested and every one converted: 75 typed as `\name` + Space, 4 inserted from the toolbar only.** Greek 40/40; miscellaneous 8/32; relations 9/21; arrows 7/12; structures 11/20 typed plus 4 toolbar-only. Exceptions found: none.
- **41 names were typed but not screenshot-confirmed** (the rest of miscellaneous, relations and arrows) — a capture failed partway through the session. They are marked ○ above and count as untested, not as failures.
- **5 structure names have not been tried by anyone** (`\superscript`, `\subscript`, `\prodab`, `\sumab`, `\ointab`) — in practice people type `^`, `_`, `\prod`, `\sum`, `\oint`, and those work.
- Function names are not on any dropdown, yet `\sin`, `\cos` and `\log` + Space convert to upright function names. `\vec`, `\hat`, `\bar` and `\binom` also convert. The full set of names that work without being on the palette has **not** been measured; assume nothing beyond these.
- One account, one machine, English UI, September 2026. No Docs version number is exposed to check against.

What the editor *stores* for these names is a separate question with a separate measurement: the symbol names come back from Apps Script as `EQUATION_SYMBOL` nodes carrying the same code, the twenty structures as `EQUATION_FUNCTION` nodes, and `\sin` as a symbol rather than three letters — [that post](/blog/en/posts/google-docs-equation-editor-internals/) has the trees.

## 6. When the list runs out

Tables A and B are the vocabulary, and table C is its edge. Matrices, piecewise functions, aligned lines, text inside math and anything with `\left` are past the edge, and no name typed into the box will bring them in.

The way around is the same one the earlier post ends on: write those constructs as LaTeX text in the paragraph — `$$\begin{pmatrix} a & b \\ c & d \end{pmatrix}$$` — and let [LaTeXFlow for Google Docs](https://workspace.google.com/marketplace/app/latexflow/59137436133?flow_type=2) render the text into an equation image in place. The image is not a native equation object, but it is a matrix, which the native editor will never be. [Installing it and converting a first equation](/blog/en/posts/convert-latex-in-google-docs/) takes about two minutes.

---

- How the editor behaves while you type, with screenshots → [The Google Docs Equation Editor: Typing It Fast, and the Four Things It Cannot Build](/blog/en/posts/google-docs-equation-editor-typing-and-limits/)
- What each of these names becomes in the document's structure → [What Google Docs' Equation Editor Actually Stores](/blog/en/posts/google-docs-equation-editor-internals/)
