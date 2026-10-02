---
layout: latexflow-doc
title: What's new
permalink: /latexflow/changelog/
description: Release notes for the LaTeXFlow add-on for Google Docs — what changed in each version.
---

Changes to the **LaTeXFlow add-on for Google Docs™**, newest first. How to use the add-on is
in the [Guide](/latexflow/guide/).

---

## Version 10

<!-- DATE: fill on release -->
<!-- verify against Part 6 -->

This update fixes problems when converting equations from the **Scan** tab.

### Fixed

- Converting equations one card at a time in the same paragraph could fail with an error
  like `Index (127) must be less than the content length (104)`, or delete nearby text. Each
  card now checks the text in the document before replacing it.
- If the document was edited, or a different document tab was open, between scanning and
  converting, text could be removed in the wrong place. The card now shows
  **Re-scan needed** and asks you to scan again instead of changing anything.
- If inserting the equation image failed, the LaTeX text could be lost. The text is now put
  back.

### Changed

- Errors now appear inside the panel instead of in pop-up dialogs.
- When the document changed since the scan, **⚡ Convert All** stops and the panel shows a
  **🔍 Re-scan** button.

### Added

- A clearer message when a permission was not granted, explaining how to allow it.
- **Help** and **Report a problem** links at the bottom of the panel and in the
  **Extensions → LatexFlow** menu. They open the [Guide](/latexflow/guide/) and the
  [Support page](/latexflow/support/).

## Version 9

Released 2026-08-25.

This is the baseline for these notes. Version 9 includes:

- **Input** tab — type LaTeX, check the live preview, and insert the equation at the cursor.
- **Scan** tab — find LaTeX written with `$…$`, `$$…$$`, `\(…\)` or `\[…\]` in paragraphs,
  list items and table cells, and convert it one card at a time or with **⚡ Convert All**.
- An optional bracket mode for `[ … ]` (off by default), **Tag as $…$** for formulas without
  delimiters, and **↩ Revert to LaTeX** to turn an equation image back into text.
