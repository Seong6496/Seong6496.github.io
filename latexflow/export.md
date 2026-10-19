---
layout: latexflow-doc
title: Export & Import
permalink: /latexflow/export/
description: How Export (Google Docs™ → .tex) and Import (.tex → Google Docs™) work in the LaTeXFlow Add-on — what they convert, how to activate a licence key, cancelling and refunds.
---

*The two paid features of the LaTeXFlow Google Docs™ Add-on: **Export** (Google Docs™ → LaTeX) and **Import** (LaTeX → Google Docs™). Everything else in LaTeXFlow — scanning, converting, inserting and reverting equations — stays free.*

Prices and purchase: [LaTeXFlow store](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=guide&utm_campaign=export&utm_content=top)

---

## Export: what it does

Export turns the Google Docs™ document you have open into a `.tex` file, in one step, from the LaTeXFlow sidebar. The conversion runs inside Google Docs™ itself: your manuscript is not uploaded to a server — not ours, not anyone else's. Equations made with the Docs equation editor, equations LaTeXFlow inserted, and LaTeX you typed between `$…$` delimiters all come out as LaTeX. You can download the file, copy it to the clipboard, or open it directly as a new Overleaf project.

---

## Export: what comes out

- **Document structure.** The title, headings (`\section`, `\subsection`, `\subsubsection`), bulleted and numbered lists including nested ones, page breaks, horizontal rules, and a table of contents if your document has one.
- **Text formatting.** Bold, italic, underline, superscript and subscript, monospace text, links (`\href`), footnotes (`\footnote`), and centred or right-aligned paragraphs.
- **Tables.** Written as `tabular` with rules. Cells merged across columns become `\multicolumn`.
- **Equations from the Docs equation editor** (Insert → Equation). They are read from the document's own equation structure and rewritten as LaTeX — fractions, roots, sums, products and integrals with limits, sub- and superscripts, vectors, hats, bars, and bracket groups. Nothing is guessed from pixels; this is not OCR.
- **Equations inserted by LaTeXFlow.** The original LaTeX is stored in each image and is restored exactly as you wrote it.
- **LaTeX you typed as text**, between `$…$`, `$$…$$`, `\(…\)` or `\[…\]`, passes through unchanged.
- **Citations.** Paste your `.bib` file in the sidebar and write `[@key]` in the text; it becomes `\cite{key}`, with the bibliography attached to the `.tex`.
- **A preamble** with the packages the document needs, so the file is meant to compile as it is. The documents in our test suite are compiled under two engines, pdfLaTeX and Tectonic.
- **Nothing is dropped silently.** A character that has no LaTeX equivalent is written as a visible placeholder, `\LFXmissing{XXXX}`, and listed in a warning panel with its paragraph number, so you can fix that one spot. Anything else Export could not convert is reported in the same list.

---

## Export: what it does not do

- **Images are not embedded.** Each image becomes a `figure` placeholder with a caption slot and a warning; you add the image file yourself.
- **Visual styling is not carried over.** Font names, font sizes, colours, highlighting, line spacing, indentation, the shape of list bullets, table borders and column widths, headers and footers — the LaTeX document class decides these.
- **Cells merged across rows** are flagged in the warning list but not written as `\multirow`.
- **Strikethrough** is dropped; the text is kept and a warning is added.
- **Equations inside headings, table cells and footnotes** are written inline (`$…$`), not as display equations.
- **An equation-editor element we do not recognise** is written out as it is and marked "check this" in the warning list, rather than replaced with a guess.
- **No reference lookup.** Export does not search for citations or generate BibTeX. You bring your own `.bib`.
- **No journal templates.**
- **Add-on only.** The Web app has no Export feature.

---

## Import

Import goes the other way: it reads a LaTeX (`.tex`) file and writes it into the Google Docs™ document you have open, from the LaTeXFlow sidebar — headings, lists, tables and equations. Equations arrive as LaTeX text; the free **Scan** feature then turns them into equation images, if you want images.

---

## Passes and subscriptions

Export and Import are opened by a 7-day pass, a monthly subscription or a yearly subscription. Each one opens both features for any number of documents; they differ only in how long.

Prices and purchase: [LaTeXFlow store](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=guide&utm_campaign=export&utm_content=bottom)

- **Every product covers every paid feature of LaTeXFlow:** Export and Import, any number of documents, on one Google account at a time.
- **The 7-day pass** ends 7 days after purchase. It is a one-time payment and does not renew.
- **A subscription renews automatically** each month or each year until you cancel it. You can cancel at any time from the [Lemon Squeezy customer portal](https://teolemma.lemonsqueezy.com/billing), where you sign in with the email address you used at checkout. After you cancel, Export and Import stay open until the end of the period you have already paid for.
- **When a pass or subscription ends, Export and Import lock immediately;** there is no grace period.
- **Only the paid features lock.** The `.tex` files you already exported and the documents you already imported are yours, and every free feature of LaTeXFlow keeps working.

---

## How buying works

1. **Payment.** Payments are processed by [Lemon Squeezy](https://www.lemonsqueezy.com/) as merchant of record. You pay Lemon Squeezy, in US dollars; the checkout may show an estimate in your local currency, and VAT or sales tax may be added depending on your country. Your card statement will show `LEMSQZY*` rather than our name.
2. **Licence key.** Your licence key is in the Lemon Squeezy receipt email, which arrives right after payment. There is no separate email to wait for.
3. **Activation.** In Google Docs™, open the LaTeXFlow sidebar, paste the key into the **License** field, and click **Activate**. One key opens both Export and Import, in every document you open with that Google account. A key is used on one Google account at a time.

If anything goes wrong — no key in the receipt email, a key that will not activate — see the [Support page](/latexflow/support/#export-licence-and-purchases-add-on).

---

## Refunds

If Export or Import does not work for your document, email **mathfolis.support@gmail.com** with your order number and we will refund the purchase:

- **7-day pass:** within **7 days** of purchase, while the pass runs.
- **Monthly or yearly subscription:** within **14 days** of the first payment. Renewal payments are not refunded; cancel before the next renewal instead.

Tell us what went wrong; it helps us fix it for the next person.

Lemon Squeezy, as the payment processor, may also refund a purchase within 60 days of purchase at its own discretion. Refunds go back to the original payment method and can take up to 10 days to appear on your statement.

---

## Legal

- [Terms of Service](/latexflow/terms/) — section 1c covers the paid features, licences and refunds
- [Privacy Policy](/latexflow/privacy/)
- [Support](/latexflow/support/)
