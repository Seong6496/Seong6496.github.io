---
layout: latexflow-doc
title: Guide
permalink: /latexflow/guide/
description: How to use the LaTeXFlow add-on for Google Docs — install, insert equations, convert LaTeX already in a document, and fix common problems.
---

This guide covers the **LaTeXFlow add-on for Google Docs™**. The add-on turns LaTeX into
equation images inside your document. If something here does not match what you see, or
your problem is not listed, see [Get help](#get-help) at the end. Changes in each version are
listed in [What's new](/latexflow/changelog/).

---

## 1. Install

Install LaTeXFlow from the
[Google Workspace Marketplace](https://workspace.google.com/marketplace/app/latexflow/59137436133).
It is installed to your Google account; nothing is downloaded to your computer.

## 2. First run and permissions

During installation Google shows a consent screen in two pages: first your account, then a
summary of the permissions with checkboxes and a **Continue** button.

**Allow all of the requested permissions.** The add-on needs each of them to show its panel
and to read and change the document you have open. If you untick one, the panel or the scan
will fail later with a permission error (see [Troubleshooting](#7-troubleshooting)).

The document permission is limited to the **current document only** — the one the add-on is
running in. The add-on does not ask for access to your Drive or other files.

## 3. Open the panel

In a document, choose **Extensions → LatexFlow → Open Equation Panel**.

A panel titled **LaTeX → Equation** opens on the right. It has two tabs, **Input** and
**Scan**, and opens on Input.

The first time, a **Data Collection Consent** box covers the panel. It explains what is
collected if you agree (the LaTeX source and the rendered image, with a pseudonymous ID).
Choose **Agree** or **Decline** — the add-on works the same either way, and your choice is
remembered. You can change it later under **Extensions → LatexFlow → Data Collection
Settings**. Details are in the [Privacy Policy](/latexflow/privacy/).

## 4. Type an equation (Input tab)

1. Click in the document where the equation should go.
2. In the **Input** tab, type LaTeX into the box, for example `\frac{d}{dx}\sin x = \cos x`.
   The symbol buttons (Greek, Sym, Frac, …) insert common commands.
3. Check the **Preview**.
4. Click **➕ Insert into Docs**.

The button stays disabled while the preview shows an error, so fix the LaTeX first.

The Input tab always inserts the equation as a **display** (block) equation. For inline
equations, write them in the document as `$…$` and use the Scan tab instead.

## 5. Convert LaTeX already in the document (Scan tab)

If your document already contains LaTeX — for example an answer pasted from a chatbot —
the Scan tab finds it and converts it in place.

1. Open the **Scan** tab and click **🔍 Scan Document**.
2. Each equation found appears as a card, in document order, with a badge showing its
   delimiter. The status line reads like `Found 7 equation(s) — display: 2, inline: 5`.
3. On a card, click the LaTeX to edit it before converting, or click **Skip** if it is not
   an equation (for example a price like `$100`).
4. Convert with **⚡ Convert All**, or one card at a time with that card's
   **➕ Insert into Docs**. **⏹ Stop** halts Convert All after the equation in progress.
   If the document changed since the scan, the panel asks you to scan again — see
   [the document changed since the scan](#the-document-changed-since-the-scan).

The scanner looks at paragraphs, list items and table cells, and recognises four delimiters:

| Written as | Kind |
|---|---|
| `$…$` | inline |
| `\(…\)` | inline |
| `$$…$$` | display |
| `\[…\]` | display |

**Bracket mode.** Chat apps sometimes drop the backslashes from `\[ … \]`, leaving plain
`[ … ]`. Tick **Also detect [ … ] — backslashes stripped by chat apps** before scanning to
find those. It is **off by default** in the add-on, because brackets in ordinary writing are
usually not equations.

**Formula with no delimiters?** Select it (or put the cursor in its line) and click
**Tag as $…$**. With a selection it wraps the selection; with only a cursor it wraps the
whole paragraph. Then scan again. The button wraps as inline `$…$` only — type `$$` yourself
for a display equation.

After converting, look over the document once: a formula with a LaTeX mistake can be
converted into an image that shows a red error message instead of the equation.

## 6. Turn an image back into LaTeX

Converted equations are images, so anyone can see them without the add-on. The original
LaTeX is stored with each image.

To edit one, select one or more equation images in the document and click
**↩ Revert to LaTeX** in the Scan tab. The image is replaced by its LaTeX text; edit it, then
scan and convert again.

- `Select an equation image in the document first.` — nothing was selected.
- `No LaTeX metadata found. This image was not inserted by this addon.` — the image was not
  made by LaTeXFlow, so there is no LaTeX to restore.

## 7. Troubleshooting

### The document changed since the scan

Converting cards one at a time is safe, including several equations in the same paragraph.
If you edit the document or switch to a different document tab after scanning, a card shows
**Re-scan needed** and the panel says the document changed since the scan. Click
**🔍 Re-scan** (or **🔍 Scan Document**), then convert again. Nothing in the document is
changed until you do.

If you are using an older version and text disappeared during a conversion, undo with
**Ctrl+Z** (**⌘+Z** on a Mac). See [What's new](/latexflow/changelog/) for the fix.

### Nothing was found

The status line says `No equations found.` Check, in this order:

1. **No delimiters.** The formula is plain text without `$…$`, `$$…$$`, `\(…\)` or `\[…\]`.
   Use **Tag as $…$** (section 5).
2. **It is a Google Docs equation.** Equations made with *Insert → Equation* are not text, so
   the scanner cannot see them. Do not wrap them in delimiters — their text reads wrongly
   (`\frac{1}{2}` comes out as `12`). Retype them as LaTeX.
3. **An inline `$…$` is broken across lines.** Open and close it on the same line.
4. **A display equation spans paragraphs.** The opening and closing delimiters must be in
   the same paragraph. Use **Shift+Enter** for a line break inside it.

Pasted from a chatbot with bare `[ … ]`? Turn on bracket mode (section 5) and scan again.

### "You do not have permission to call …"

A permission was not granted, usually because a checkbox was unticked on the consent screen.

- Close the panel, open it again from **Extensions → LatexFlow → Open Equation Panel**, and
  allow all requested permissions.
- If you are signed in to **several Google accounts** in the same browser, the add-on can pick
  the wrong one. Open the document in a window where only one account is signed in (for
  example a private window) and try again.

### "Contact your organization administrator"

Your school or work account's administrator has blocked the add-on. Ask them to allow
**LatexFlow** in the Google Workspace Marketplace settings for your organization. We cannot
change this from our side.

### The LatexFlow menu is missing

Right after opening a document, the **Extensions → LatexFlow** menu sometimes does not appear.
This happens when Google limits how many add-on scripts run at once (for example with many
documents open at the same time). Reload the document.

### Other questions

The [Support page FAQ](/latexflow/support/#frequently-asked-questions) answers questions about
image size, preview errors and data collection settings.

## Get help

If your problem is not covered here, report it on the [Support page](/latexflow/support/).
In the add-on, **Report a problem** at the bottom of the panel, or in the
**Extensions → LatexFlow** menu, opens the same page.
Please include what you were trying to do, what happened, and the LaTeX involved.
