---
layout: latexflow-doc
title: What's new
permalink: /latexflow/changelog/
description: Release notes for the LaTeXFlow add-on for Google Docs — what changed in each version.
---

Changes to the **LaTeXFlow add-on for Google Docs™**, newest first. How to use the add-on is
in the [Guide](/latexflow/guide/).

---

## Version 15

Released ____.

<!-- DRAFT (corpus, 2026-10-22, branch draft/v15-whatsnew, not pushed). Release date left blank on purpose.
     Checked against gdla-stage6 feature/v15: R67 items 1-11 (.tmp/r67_export_quality.md), R68c e61776d, R68g 5227a73,
     R68k a689f47, R70 52e068d / 4dd1470 / 4efa9ee / 1158388. Re-check against the final release commit before publishing. -->

### Export

- **Documents compile without a bibliography.** If no `.bib` is saved, the exported `.tex`
  no longer points to one, so it compiles as it is. Citations print as `[?]` until you add
  a bibliography.
- **Citations with page numbers** come out as `\cite[p.~5]{key}`, and several keys in one
  bracket become one `\cite`.
- **Numbered equations stay numbered.** An equation followed by a tab and a number such as
  `(1)` becomes a display equation with that number.
- Minimum and maximum with limits, circled numbers (①), Roman numerals (Ⅰ) and
  strikethrough text now come out as they look in the document. Strikethrough inside a
  heading is still dropped, with a warning.
- **No double heading numbers.** If your headings already carry numbers, such as
  "1. Introduction", LaTeX does not add a second one.
- **List numbering continues.** A numbered list that is interrupted by a paragraph carries
  on from where it stopped, as it does in Google Docs™.

### Import

- **Quotes** (`quote`, `quotation`, `verse`) are now indented in Google Docs™ as in the
  PDF, and Export writes them back as quotes.
- **Custom item labels** such as `\item[a)]` are kept, and Export writes them back.
- A list that continues an earlier one, such as `[start=4]`, keeps its numbers.
- `\cite[5]{key}` keeps its page note.
- **Real-world LaTeX imports much better.** User macros (`\newcommand`, `\def` and similar)
  are handled in more cases, and comments or labels inside `align` no longer leave a broken
  equation. When you export again, the packages your equations use (for example
  `mathrsfs`, `bm` or `physics`) are loaded for you.

<!-- NUMBERS (user decision 2026-10-22: the numbers go in; v15 ships after R73 passes).
     Every {{...}} is a placeholder. The leader sends the FINAL figures from R73; fill them in
     before publishing and do not publish with any {{...}} left. Exact numbers only, no rounding
     up, no "almost all". Source of record: docs/technical_guide/compatibility_verification_record.md
     (gdla-main); note the R73 round in a comment next to each figure.
     Last recorded figures, for reference only (do not use): round 2 R70 = 128/150 compile,
     I2 = 100% over 300,000 generated documents (excluding hand-written start=N lists);
     R71 reported 142/150 (in progress on 2026-10-22).
     {{WHERE_CHECKED}}: say how the round-trip was run, e.g. "in Google Docs" only if R73 ran it
     in real Google Docs; otherwise describe the test setup plainly. -->

### Tested on real papers

We tested Version 15 on 150 LaTeX papers from arXiv, in mathematics, physics, computer
science, statistics, economics, quantitative biology and teaching<!-- corpus manifest.csv (R69-B):
     math 40, physics 30, cs 30, stat 10 / econ 5 / q-bio 5, education 10 (math.HO, physics.ed-ph),
     Korean packages 10, book-length or macro-heavy 10; years 2012-2026 -->. Each paper was imported and then
exported again {{WHERE_CHECKED}}. For {{N_COMPILE}} of the 150, the exported `.tex`
compiles as it is<!-- R73: {{N_COMPILE}}/150 -->. {{FAILURE_NOTE}}<!-- e.g. "The other {{150-N}}
     still need some hand editing, mostly {{MAIN_REASON}}." Drop the sentence if N_COMPILE = 150. -->

We also ran {{N_GENERATED}} generated test documents through Import and Export
{{GENERATED_RESULT}}<!-- R73: e.g. "and every word and equation was kept"; state any exclusion
     exactly as recorded (round 2 excluded hand-written start=N lists). -->.

---

## Version 14

Released 2026-10-19.

<!-- Checked against gdla-stage6 feature/v13 e0e79f4 / 0a16154 / 68c98cf / edab52e / 52d1281 / 1e3e1dc. Apps Script version 13 exists unused; this release is 14. -->

### Changed

- **Export keeps paragraphs apart.** The exported `.tex` now has an empty line between
  paragraphs, so each Docs paragraph stays its own paragraph in the PDF. Before, some
  neighbouring paragraphs could run together into one. A line right after a display equation
  still continues that paragraph, as in LaTeX. `.tex` files exported by earlier versions
  still import as before.
- The export summary now reads "1 table", "1 image" and "1 citation" for a single item.
- When Import writes citations as `[@key]` markers, the summary now says so in a note, before
  you press **Import**. Export turns the markers back into `\cite`.
- A saved bibliography is no longer added to an export that has no citations — for example,
  a worksheet tab in the same document as a paper.
- The **Bibliography** badge now shows the entries that are actually saved. If you empty the
  box while entries are saved, the button reads **Clear** and removes them.
- The license end date in the **License** section is now always shown in English, whatever
  language Google Docs™ is set to. The time is still your local time.

---

## Version 12

Released 2026-10-12.

<!-- Checked against gdla-main 06be66f / 586dae9 (stage6 40e8864, cbfa1b0) and changelog_20261012.md §4-4 -->

### Changed

- On the locked **LaTeX file** tab, **Get a license →** now opens the
  [LaTeXFlow store](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=doc&utm_campaign=changelog), where the passes and subscriptions
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
