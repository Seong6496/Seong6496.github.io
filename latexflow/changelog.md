---
layout: latexflow-doc
title: What's new
permalink: /latexflow/changelog/
description: Release notes for the LaTeXFlow add-on for Google Docs — what changed in each version.
---

Changes to the **LaTeXFlow add-on for Google Docs™**, newest first. How to use the add-on is
in the [Guide](/latexflow/guide/).

---

## Version 12

Released 2026-10-12.

<!-- Checked against gdla-main 06be66f / 586dae9 (stage6 40e8864, cbfa1b0) and changelog_20261012.md §4-4 -->

### Changed

- On the locked **LaTeX file** tab, **Get a license →** now opens the
  [LaTeXFlow store](https://teolemma.lemonsqueezy.com), where the passes and subscriptions
  are listed.
- A new **How it works →** link opens the [Export guide](/latexflow/export/): activating a
  key, cancelling a subscription and refunds.
- The yearly subscription is now shown as **Yearly**.

---

## Version 11

Released 2026-10-12.

<!-- Checked against gdla-main a08b71b / 404bf5f and changelog_20261012.md §2-§3 -->

This update adds two features that need a license, on a new **LaTeX file** tab. Input,
Scan and Convert stay free.

### Added

- **Export to LaTeX.** Turns the document, or a selection, into a `.tex` file. Press
  **Convert to LaTeX**; the panel shows what was converted and a preview of the file, with
  **Download .tex**, **Copy .tex** and **Open in Overleaf**.
- **Import a LaTeX file.** Brings a `.tex` file into the document — headings, lists, tables
  and equations. Press **Choose .tex file**, check the summary, and press **Import**. The
  content goes into the document tab you were on when you chose the file; **Use current tab**
  switches to the tab you are on now. If that tab already has content, Import asks before
  adding the file at its end. Equations are written as LaTeX text, so you can turn them into
  equations with **Scan** and **Convert All**.
- **License.** Paste a license key and press **Activate**. One key opens both Export and
  Import, for one Google account on any device. **Deactivate** releases the key from this
  account.

### Changed

- If a permission the add-on needs was not granted, it now stops and asks you to open the
  panel again so the permission can be granted: "LaTeXFlow needs all the permissions it asked
  for. Close this panel and open it again from Extensions › LatexFlow › Open Equation Panel to
  grant them."

---

## Version 10

Released 2026-10-02.

<!-- Checked against hotfix 63bdc12 (= Apps Script version 10) and web's live verification Parts 6-7, 2026-10-02 -->

This update fixes problems when converting equations from the **Scan** tab.

### Fixed

- Converting equations one card at a time in the same paragraph could fail with an error
  like `Index (127) must be less than the content length (104)`, or delete nearby text. Each
  card now checks the text in the document before replacing it.
- If the document was edited, or a different document tab was open, between scanning and
  converting, text could be removed in the wrong place. Now nothing is changed: the card
  shows **Re-scan needed** and the panel asks you to scan again. If you switched tabs, the
  message reads "Go back to the tab you scanned and click Re-scan. Or click Re-scan now to
  scan the tab you are viewing."
- If inserting the equation image failed, the LaTeX text could be lost. The text is now left
  in place.

### Changed

- Errors now appear inside the panel instead of in pop-up dialogs.
- When the document changed since the scan, the panel shows a message with a
  **🔍 Re-scan** button, and **⚡ Convert All** stops at that point.

### Added

- A clearer message when a permission was not granted, explaining how to allow it.
- **Help** and **Support** links at the bottom of the panel. They open the
  [Guide](/latexflow/guide/) and the [Support page](/latexflow/support/).
- A **Help** item in the **Extensions → LatexFlow** menu. It opens a small dialog with
  **Guide** and **Support** links.

## Version 9

Released 2026-08-25.

This is the baseline for these notes. Version 9 includes:

- **Input** tab — type LaTeX, check the live preview, and insert the equation at the cursor.
- **Scan** tab — find LaTeX written with `$…$`, `$$…$$`, `\(…\)` or `\[…\]` in paragraphs,
  list items and table cells, and convert it one card at a time or with **⚡ Convert All**.
- An optional bracket mode for `[ … ]` (off by default), **Tag as $…$** for formulas without
  delimiters, and **↩ Revert to LaTeX** to turn an equation image back into text.
