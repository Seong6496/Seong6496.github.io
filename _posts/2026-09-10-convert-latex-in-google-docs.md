---
title: "How to Convert LaTeX in Google Docs: Install to First Equation"
date: 2026-09-10 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/convert-latex-in-google-docs/
categories: [LaTeXFlow, Guide]
tags: [google-docs, latex, add-on, google-workspace-marketplace, equations, tutorial]
math: true
pin: false
description: "You have LaTeX sitting as plain text in a Google Doc and you want it to look like an equation. This walks the whole path once: installing the add-on from the Marketplace, what the first-run consent screen asks for, running a scan, and what the document holds afterwards."
---

You have this in a Google Doc:

```
The area of a circle is $\pi r^2$, and $$\int_0^1 x^2\,dx = \frac{1}{3}$$.
```

and you want it to look like an equation instead of a row of backslashes. Google Docs has no way to do that on its own — its own *Insert → Equation* builds a different kind of object entirely, and it will not read your LaTeX.

This is the whole path, once through: install, consent, scan, convert. About five minutes the first time, and roughly fifteen seconds every time after.

## 1. What you have, and what you want

Two things have to be true before any of this works.

**The maths must be text.** If you typed `\pi r^2` with the keyboard, it is text. If you built it with *Insert → Equation*, it is an object, and nothing below applies to it — see section 8.

**The maths must be wrapped in a delimiter.** Detection keys on delimiters, so a bare `\frac{1}{2}` with nothing around it is not found. Four are read:

| Delimiter | Kind |
|---|---|
| `$…$` | inline |
| `$$…$$` | display |
| `\(…\)` | inline |
| `\[…\]` | display |

There is a fifth, optional one — a bare `[ … ]`, for text pasted out of a chatbot — which is off by default. More on that in section 8.

## 2. Install from the Google Workspace Marketplace

Install [LaTeXFlow from the Google Workspace Marketplace](https://workspace.google.com/marketplace/app/latexflow/59137436133?flow_type=2). It is a Google Docs editor add-on, so it installs against your Google account rather than being downloaded to your machine.

## 3. First run: the consent screen

Google shows its consent flow during installation. It is **two pages**, which surprises people who expect one.

**Page 1** is the account page: your name, your profile picture, and your email address. This is where the email permission is granted.

**Page 2** is the permission summary: **three checkboxes** and a `Continue` button.

There is no "unverified app" interstitial — the add-on has been through Google's review and is published.

Four permissions in total, and it is worth knowing what each is for:

| Permission | What it is for |
|---|---|
| The current document only | Read and change **only the document the add-on is open in** — scan it, insert images, revert them |
| Display the interface | Draw the menu, the sidebar and the settings dialog inside Docs |
| Connect to an external service | One server-side request: sending an opted-in equation to the collection endpoint |
| Your email address | Read once, on the collection path, to derive an anonymous identifier |

The first one is the important one. It is the `currentonly` form of document access, which means access to **any other document is impossible**, not merely unused. There is no permission here for your Drive or your other files.

## 4. Opening the sidebar

In the document: **Extensions → LatexFlow → Open Equation Panel**.

A sidebar opens on the right, titled *LaTeX → Equation*. It has two tabs, **Input** and **Scan**, and opens on Input.

The very first time, a **Data Collection Consent** overlay covers the sidebar. It explains that the LaTeX source and rendered image of an equation are collected anonymously, that your email is read only to derive a pseudonymous ID — a truncated SHA-256 hash that never leaves the add-on — and that the setting can be changed at any time from **LatexFlow → Data Collection Settings**.

Two buttons: `Decline` and `Agree`. Either dismisses the overlay for good, and the choice is remembered.

Worth being precise here, because it is the opposite of what people assume: collection on the add-on is **opt-in**. Decline and no outbound request is made at all — not a reduced one, none. (The web app is the other way round; it is opt-out.)

## 5. Scanning the document

Switch to the **Scan** tab and press **🔍 Scan Document**.

The scan walks the document's paragraphs, list items and table cells, finds every span wrapped in one of the four delimiters, and lists them as cards in document order. The status line reads:

```
Found 7 equation(s) — display: 2, inline: 5
```

Each card shows the LaTeX it found and a badge with the delimiter it was actually found in — `$$…$$`, `\[…\]`, `\(…\)` or `$…$` — numbered so the card order matches the document order.

Two things you can do to a card before converting:

- **Click its LaTeX** to edit it in place. What gets converted is the edited value.
- **Skip** it, if it is not really an equation. `$100` in a sentence about money will be picked up as an opening delimiter; skipping leaves the text alone.

## 6. Converting one equation

Press **➕ Insert into Docs** on a single card and that equation is replaced, in place, by a rendered image.

When you are happy with the whole list, **⚡ Convert All** does the rest. It works back-to-front through the document, so replacing an earlier equation does not shift the positions of the later ones. **⏹ Stop** ends the run after the equation currently being processed.

Progress shows as a count:

```
5 / 7 converted (1 skipped)
```

There is also the **Input** tab, which is the other way round: type LaTeX into the box, watch the live preview, place your cursor in the document, and press **➕ Insert into Docs**. One note on it — the Input tab always inserts in **display** mode, regardless of how you wrote the formula. If you want an inline equation, type it into the document with `$…$` and use the Scan tab instead.

## 7. What is in the document afterwards

A converted equation is now an **image** in the document. That is what makes it render for everyone who opens the file, including people without the add-on.

The original LaTeX is not thrown away — it is stored in the image's alt text. Which is what makes the reverse trip possible: select one or more equation images and press **↩ Revert to LaTeX** on the Scan tab, and they turn back into LaTeX text.

If nothing is selected you get `Select an equation image in the document first.`; if what you selected was not inserted by the add-on, `No LaTeX metadata found. This image was not inserted by this addon.`

One limitation to know about before you convert a large document: the Scan tab does not check whether MathJax actually rendered the formula successfully. A malformed formula can be inserted as a **red error image** without any warning. Look over the converted document rather than assuming an error would have announced itself.

## 8. When it finds nothing

If the scan comes back with:

```
No equations found.
No $$…$$, \[…\], \(…\) or $…$ equations found in document.
```

there are four causes, in the order worth checking.

**① No delimiters at all.** The most common. Your maths is text, but nothing is wrapped.

The fix is on the same Scan tab, above the scan button. Select the formula in the document — or just put the cursor on its line — and press **`Tag as $…$`**. With a selection it wraps what you selected; with only a cursor it wraps **the whole paragraph**. You get `✅ Tagged!`, then press **🔍 Scan Document** again.

Note that this button wraps as inline `$…$` only. For display maths, type the `$$` pair yourself.

**② The equations are native Docs equation objects.** If you built them with *Insert → Equation*, they are not text and the scanner never sees them. **No delimiter will help**, and it is worth being explicit about why you should not try: the paragraph text of a native equation reads back with its structure destroyed. A `\frac{1}{2}` comes back as `12`. Wrap that in `$$` and you get `$$12$$`, which is valid LaTeX, converts without complaint, and leaves you an image reading **12** where a half used to be. No error, and the result looks plausible enough to miss. Retype the maths as LaTeX text instead. [What Docs actually stores for those equations](/blog/en/posts/google-docs-equation-editor-internals/) has the full picture.

**③ An inline `$…$` broken by a line break.** Inline dollar maths has to open and close on one line. The other three delimiters are not affected.

**④ A `$$…$$` split across paragraphs.** One paragraph is one scan unit, so an opening `$$` and a closing `$$` in different paragraphs never pair. Keep display maths in a single paragraph, using `Shift` + `Enter` if you need the line break visually.

And if the maths came out of a chatbot as bare square brackets — `[\frac{1}{2}]` with the backslashes stripped — tick **`Also detect [ … ]`** and scan again. It is off by default in the add-on because a bracket in a document you are writing is more often prose than maths.

## 9. FAQ

**Do the people I share the document with need the add-on?**
No. Converted equations are images and render for everyone.

**Can I change an equation after converting it?**
Select the image, press **↩ Revert to LaTeX** to get the source back, edit it, and convert again.

**Does it work on an iPad?**
Editor add-ons are not available in the iOS Docs app. On an iPad, use the [web app](/latexflow/web/) instead — export the document as `.docx`, or import it from Drive inside the tool.

**Where do I change the data collection setting?**
**Extensions → LatexFlow → Data Collection Settings**, at any time, in either direction.

**Convert failed with a message about re-scanning.**
The document changed between the scan and the conversion, so the recorded positions went stale. Run the scan again.

## 10. Summary

1. Write your maths as **text**, wrapped in `$…$` or `$$…$$`.
2. Install from the Marketplace and clear the two-page consent screen.
3. **Extensions → LatexFlow → Open Equation Panel**, answer the collection overlay.
4. **Scan** tab → **🔍 Scan Document** → review the cards.
5. **➕ Insert into Docs** per card, or **⚡ Convert All**.
6. Nothing found? Check delimiters first, equation objects second.
