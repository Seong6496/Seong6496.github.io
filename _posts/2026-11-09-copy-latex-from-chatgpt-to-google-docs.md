---
title: "Copy LaTeX from ChatGPT to Google Docs™: What the Paste Does, and What to Fix After"
date: 2026-11-09 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/copy-latex-from-chatgpt-to-google-docs/
categories: [LaTeXFlow, Guide]
tags: [chatgpt, gemini, latex, google-docs, paste, bracket-mode, scan, add-on]
math: false
pin: false
description: "Paste an AI answer with maths into Google Docs™ and some equations may become Docs equations on their own, while others stay as LaTeX text. A measured paste of ChatGPT- and Gemini-style answers: which shapes Docs converted, which it left, how the free LaTeXFlow add-on finds the rest, and the one way of copying that cannot be repaired."
---

When you copy LaTeX from ChatGPT or Gemini into Google Docs™, Docs may turn some of it into equations by itself, and whatever it leaves as LaTeX text, the free LaTeXFlow add-on converts in one scan. Copy with the answer's own copy button, not by selecting the rendered maths with the mouse: a selection of rendered maths does not carry the LaTeX, and nothing can rebuild it afterwards.

The rest of this post is what we measured on 28 October 2026, so you know what to expect after the paste.

## 1. The test

Four short answers in the shapes chatbots produce, seven equations in total:

- **ChatGPT style:** two inline `\(…\)` and one display `\[…\]` (the quadratic formula).
- **Brackets with the backslashes gone:** two display equations as bare `[ … ]`. This is the shape ChatGPT maths often takes after the backslashes are lost somewhere on the way; the [four shapes post](/blog/en/posts/chatgpt-bracket-math-to-latex/) covers where it comes from.
- **Gemini style:** one inline `$…$` and one display `$$…$$`.
- **The same maths rendered**, as it looks in the chat window, selected with the mouse.

Each was pasted into an empty Google Docs™ document twice: with a normal paste (`Ctrl+V`) and with paste without formatting (`Ctrl+Shift+V`). The account was a regular Google account with the LaTeXFlow add-on installed from the Marketplace.

## 2. What Docs did on paste

![A Google Docs page after pasting: the quadratic formula, the discriminant and the Pythagorean equations appear as Docs equations, while two lines starting with a bare square bracket, such as [ \int_0^1 x^2\,dx = \frac{1}{3} ], are still LaTeX text](/assets/img/posts/2026-11-09/01-paste-in-docs.png){: width="720" }

| Shape | After the paste, in this account |
|---|---|
| `\(…\)`, `\[…\]` | Docs equations |
| `$…$`, `$$…$$` | Docs equations |
| bare `[ … ]` | LaTeX text, unchanged |
| rendered maths, selected with the mouse | broken text, no LaTeX left |

Both kinds of paste gave the same result. Five of the seven equations became Docs equations without any add-on, including the fraction and square root in the quadratic formula.

This automatic conversion is Google's, and **it does not behave the same in every account**. On another account we tested earlier, a short `$\pi r^2$` was converted while a longer `$$x = \frac{-b \pm \sqrt{b^2-4ac}}{2a}$$` stayed as text. So after a paste, expect a mix: some equations already done, some still LaTeX.

## 3. Converting what is left

Whatever is still LaTeX text, the add-on finds and converts.

1. Open the panel: **Extensions → LatexFlow → Open Equation Panel**. First time? The [install walkthrough](/blog/en/posts/convert-latex-in-google-docs/) goes through it.
2. On the **Scan** tab, tick **Also detect [ … ]**. This picks up the bare-bracket shape, and it is off by default in the add-on.
3. Press **Scan Document**.

![The document with two bare-bracket lines still as text, and the LaTeXFlow Scan tab beside it: Also detect [ … ] ticked, Found 2 equation(s) — display: 2, inline: 0, Native equations (Docs equation editor): 5, and two cards previewing the two integrals with Insert into Docs and Skip buttons](/assets/img/posts/2026-11-09/02-scan-found.png){: width="720" }

The scan reported **Found 2** — the two bracket equations Docs had left — and, on a separate line, **Native equations: 5** for the ones Docs had already converted. Nothing was missing: 2 + 5 = 7.

4. Press **Convert All**.

![After Convert All: the two integrals are now rendered equations in the document, and the sidebar shows 2 / 2 converted with both cards marked Done](/assets/img/posts/2026-11-09/03-converted.png){: width="720" }

Both bracket lines became rendered equations: **2 / 2 converted**. The document now shows every equation as an equation, whichever route it took.

## 4. The copy that cannot be repaired

Selecting the rendered maths in the chat window with the mouse and copying it gives Docs the characters on screen, not the LaTeX behind them. In our test the result was one symbol per line, parts of the same formula repeated, and no LaTeX anywhere:

![A Google Docs page after pasting rendered maths: the discriminant formula broken into single characters on separate lines — Δ, =, b, 2, −, 4, a, c — then repeated as Δ=b, 2, −4ac](/assets/img/posts/2026-11-09/04-rendered-copy-broken.png){: width="720" }

Scan found nothing to convert, because there was nothing left to read. The fix is at the copy step: use the copy button under the answer, which copies the text with its LaTeX, or ask for the answer in LaTeX to begin with ([how to ask for maths you can paste](/blog/en/posts/ask-chatgpt-for-latex-math/)).

## 5. FAQ

**Why did some equations convert on their own and others not?**
Google Docs™ converts some pasted LaTeX into its own equations by itself, and the range differs between accounts. Bare `[ … ]` was never converted in our test. Whatever stays as LaTeX text is what the add-on's Scan is for.

**Do I need the add-on if Docs already converted everything?**
Not for the display. If every equation came across, the document is done. The scan line **Native equations: N** tells you how many Docs converted.

**Can I paste into Google Docs™ and keep the LaTeX as text?**
Not reliably: whether Docs converts on paste depends on the account. Typing LaTeX, rather than pasting it, keeps it as text.

**What about Word?**
The same answer pasted into Word arrives in one of four shapes; the [ChatGPT LaTeX to Word post](/blog/en/posts/chatgpt-bracket-math-to-latex/) covers each one.

## 6. Summary

1. Copy the answer with its copy button, not by selecting the rendered maths.
2. Paste into Google Docs™. Some equations may become Docs equations on the spot.
3. Open LatexFlow, tick **Also detect [ … ]**, and press **Scan Document**.
4. Press **Convert All**. Every equation that stayed as LaTeX is now rendered too.
