---
layout: latexflow-doc
title: What's new
permalink: /latexflow/changelog/
description: Release notes for the LaTeXFlow add-on for Google Docs — what changed in each version.
---

Changes to the **LaTeXFlow add-on for Google Docs™**, newest first. How to use the add-on is
in the [Guide](/latexflow/guide/).

---

## Version 17

Released 2026-11-02.

<!-- Checked against gdla-r133 feature/v16.1 72f0c10 (merged into main 36ccebb): R161 0819b15 (items A-G),
     R167 2f4dbef, R169 0d49a97, R170 63b3ae8, R172 f136b82, R173 285b849, R176 099ac36 / 72f0c10.
     Gate R176: arXiv 142/150, 0 I1/I5/I6 regressions. -->

### Scan

- **Google Docs™ equations are left alone.** When an equation Google Docs™ already made sat
  between two `$` signs, Scan could read part of that equation as LaTeX, and
  converting it could replace the Docs equation with an image of a piece of it. Such a match
  now shows "Already a Google Docs™ equation — nothing to convert." and Convert All skips it.
  `$…$` equations next to a Docs equation still convert.
- **Equations with `$`, `%` or currency signs inside.** An equation such as
  `$\text{R$ 1.000}$` is now read as one equation, and an escaped `\$` never ends one.
  A `%`, €, £ or `\pounds` inside an equation no longer stops it from rendering.
- Commands from the `mathtools` package, such as `\xrightleftharpoons`, now render.
- **Cut-off equations say so.** When the LaTeX in the document ends in the middle, for example
  after `\left` or `\sqrt`, the card shows "This equation looks cut off in the document
  text" with what may be missing, instead of a parse error.
- **Convert All stops when Google Docs™ refuses changes.** After two refusals in a row it
  stops and says that Google Docs™ is refusing changes to this document right now. The
  equations it did not convert stay as LaTeX text and can be converted later.
- **Insert into Docs is faster.** Inserting one equation from a card or from the Equation
  tab takes about 0.7 seconds less in our tests. If you allowed the optional data
  collection, it is now sent after the equation is inserted.

### Revert

- **Revert all** is now always the whole tab, and it asks first. The question opens at
  once and fills in the number of equation images when it has counted them.
- **Revert to LaTeX** turns back every equation image in the part you drag over, across
  several lines, list items or table cells. A single clicked image turns back only itself.
  A selection that only touches the start of the next line leaves that line's images as
  they are.
- If some images cannot be turned back, the sidebar says how many were reverted and how
  many failed.

### Export

- A `%` inside an equation is written as `\%`, so the rest of the equation is no longer
  read as a LaTeX comment.
- **Prices next to equations.** A line such as `preço R$ 5 e $x+1$` keeps `$x+1$` as an
  equation and writes the price as text. Before, the whole line became text with a warning.
  A line that could be read in more than one way is still written as text, with the same
  warning.
- A `$` inside the text of an equation image, as in `\text{R$ 1.000}`, is written so that the
  `.tex` compiles.

### How we tested

The same 150 arXiv papers as for Version 15 and 16: 142 compile as exported, as before.
Each change was also checked in a real Google Docs™ document.

---

## Version 16

Released 2026-10-30.

<!-- Checked against gdla-r133 feature/v16 7de97c4 (merged into main 405a8ec). Sources: v16_facts.md (R78-R140),
     R137 P4, R141/R142, R144 real sidebar, R145-R152, R155 (B8), R156, R157; tab names v16_tab_names.md.
     Convert All v15 2.7 s/eq = R120 (live v15, 35 eq); v16 0.7 s/eq = R132 (33 eq ~24 s), small doc unchanged after R150.
     Import 999 blocks ~65 s = R111; v15 0/2 (R108). arXiv 142/150 = R155 gate. Auto-LaTeX named generically (R138 note 1). -->

### The sidebar

- The tabs are now called **Equation**, **Scan** and **Export / Import**. They were Input,
  Scan and LaTeX file. Nothing else about them changed.
- On the Scan tab, **Tag as $…$**, **Revert to LaTeX** and **Revert all** sit in one even row.

### Scan

- **Convert All is faster.** On a short test document an equation takes about 0.7 seconds;
  Version 15 took about 2.7 seconds. The first equation appears after about 4 seconds, and
  the sidebar shows the percentage done.
- The document no longer jumps to each equation while Convert All runs, and new equation
  images no longer show as broken until the page is reloaded.
- While Convert All runs, the sidebar asks you not to edit the document, and the other image
  buttons wait until it has finished.
- **Revert all** turns every equation image back into LaTeX text at once: the selected part,
  or the whole tab when nothing is selected. For the whole tab it asks first and says how
  many images it will change.
- Revert puts back the delimiter you typed. An equation written as `\[ … \]` comes back as
  `\[ … \]`, not as `$$ … $$`.
- Equation images made by other add-ons that keep the LaTeX in the image link are now counted
  by Scan, can be reverted to LaTeX, and are written as LaTeX by Export.
- A numbered equation such as `a=b \tag{2}` now fits the page, with the number right after it.
- `\dag` and `\ddag` render.

### Export

- **Large documents export.** A long document is read in parts, with the percentage shown,
  so a very long document no longer runs out of time. **Stop** pauses it; then
  **Continue from N%** goes on from there and **Start over** begins again.
- **Reference lists written in the document.** A `thebibliography` list, as Import brings
  it in, is exported as a working reference list: the references print and `\cite` resolves.
- A text equation that is a whole `align`, `gather`, `multline` or `equation` environment is
  written without an extra `\[ \]` around it. Before, the `.tex` did not compile.
- Table cells merged down a column are written with `\multirow` in the right columns.
- With the Scan tab's bracket mode on, Export also reads ChatGPT's bare `[ … ]` as a display
  equation.
- With **Selection** chosen, the tab says how to select the part you want.
- **Lists, quotes and centred text keep their structure through editing.** Import now marks
  each block with the list, quote or alignment it belongs to, and Export reads that mark
  instead of guessing from the blocks around it. Common edits — moving a paragraph, deleting
  one, changing its indent, clearing formatting, copying it to another document — leave
  either the original structure or a plain paragraph.
- Ordinary Google Docs™ documents export the same as in Version 15.

### Import

- **Large files import faster and finish.** A `.tex` file of about 1,000 blocks imports in
  about a minute. Version 15 stopped with a Google Docs™ error on the same file.
- The sidebar shows how many blocks are written and the percentage done. A file large enough
  to take a few minutes says so, with a rough number of minutes, as soon as you pick it.
- **Continue import.** If Google Docs™ fails part-way, the sidebar offers **Continue import**,
  which carries on from where it stopped. After **Stop**, the sidebar says "Stopping…" until
  the current step is done.
- Bold, italic, superscript and monospace text in titles, headings and author lines is kept.

### How we tested

We imported and exported again the same 150 arXiv papers as for Version 15: 142 of 150
compile as they are, and no paper that compiled with Version 15 fails with Version 16. We
ran 300,000 generated documents through Import and Export and compared them with Version 15:
none lost structure that Version 15 kept. 40,000 documents of the kind people write directly
in Google Docs™ export exactly as in Version 15.

In real Google Docs™ documents, we imported 10 of the arXiv papers through the sidebar, from
26 to 4,638 blocks, and exported them again: every `.tex` compiles.

---

## Version 15

Released 2026-10-22.

<!-- Checked against gdla-stage6 feature/v15: R67 items 1-11 (.tmp/r67_export_quality.md), R68c e61776d, R68g 5227a73,
     R68k a689f47, R70 52e068d / 4dd1470 / 4efa9ee / 1158388. Apps Script version 15. Numbers: leader's final figures, R73c. -->

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

<!-- Figures: arXiv 142/150 (R73c), 300,000 generated documents (round 2), P1 corpus 20/20 (R72). -->

### How we tested

We tested Version 15 on 150 LaTeX papers from arXiv, in mathematics, physics, computer
science, statistics, economics, quantitative biology and teaching<!-- corpus manifest.csv (R69-B):
     math 40, physics 30, cs 30, stat 10 / econ 5 / q-bio 5, education 10 (math.HO, physics.ed-ph),
     Korean packages 10, book-length or macro-heavy 10; years 2012-2026 -->. Each paper was imported
and then exported again. For 142 of the 150, the exported `.tex` compiles as it is.

We also ran 300,000 generated test documents through Import and Export. The text and
equations were kept in all of them, and every exported file was valid LaTeX. The one thing
not kept is a list starting number typed by hand, which Google Docs™ cannot store.

Finally, we exported 20 documents written in Google Docs™ — worksheets and research notes.
All 20 compile as exported.

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
