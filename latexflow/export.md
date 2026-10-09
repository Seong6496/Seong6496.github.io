---
layout: latexflow-doc
title: Export & Import
permalink: /latexflow/export/
description: Export a Google Docs™ document to a .tex file, or import a .tex file into Google Docs™ — the paid features of the LaTeXFlow Add-on, coming in the next version. A $1.99 pass for one document in one direction, or a subscription at $4.99 a month or $49 a year for both.
---

<style>
  .lfx-price { font-family: var(--font-display); font-size: 30px; font-weight: 500; margin: 0 0 4px; }
  .lfx-price small { font-family: var(--font-body); font-size: 16px; font-weight: 400; color: var(--text-muted); }
  .lfx-buy {
    display: inline-block; padding: 10px 18px; border-radius: 6px;
    border: 0.5px solid var(--border); background: var(--bg-card);
    color: var(--text-hint) !important; text-decoration: none !important;
    cursor: default; font-size: 15px;
  }
  .lfx-buy-row { display: flex; flex-wrap: wrap; gap: 8px; }
  .lfx-products { width: 100%; border-collapse: collapse; margin: 0 0 16px; }
  .lfx-products th, .lfx-products td { text-align: left; vertical-align: top; padding: 10px 8px; border-bottom: 0.5px solid var(--border); }
  .lfx-products .lfx-price { font-size: 22px; margin: 0; white-space: nowrap; }
  .lfx-products small { font-size: 14px; color: var(--text-muted); }
  .lfx-buy-note { font-size: 14px; color: var(--text-muted); margin-top: 8px; }
</style>

*The two paid features of the LaTeXFlow Google Docs™ Add-on: **Export** (Google Docs™ → LaTeX) and **Import** (LaTeX → Google Docs™). Both are coming in the next version of the Add-on, which is pending Google review. Everything else in LaTeXFlow — scanning, converting, inserting and reverting equations — stays free.*

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

Import goes the other way: it reads a LaTeX (`.tex`) file and writes it into the Google Docs™ document you have open, from the LaTeXFlow sidebar — headings, lists, tables and equations. Equations arrive as LaTeX text; the free **Scan** feature then turns them into equation images, if you want images. Like Export, it is coming in the next version of the Add-on (pending Google review).

---

## Price

There are four products: a pass for each direction, and two subscriptions that cover both. Prices are in US dollars.

<table class="lfx-products">
  <thead>
    <tr><th>Product</th><th>Price</th><th>Covers</th></tr>
  </thead>
  <tbody>
    <tr>
      <td>Export pass</td>
      <td><span class="lfx-price">$1.99</span> <small>once</small></td>
      <td>Export (Google Docs™ → LaTeX) for <strong>one document</strong>; another document needs another pass. <small>Coming in the next version (pending Google review).</small></td>
    </tr>
    <tr>
      <td>Import pass</td>
      <td><span class="lfx-price">$1.99</span> <small>once</small></td>
      <td>Import (LaTeX <code>.tex</code> → Google Docs™) for <strong>one document</strong>; another document needs another pass. <small>Coming in the next version (pending Google review).</small></td>
    </tr>
    <tr>
      <td>Monthly subscription</td>
      <td><span class="lfx-price">$4.99</span> <small>per month</small></td>
      <td>Every paid feature — Export and Import — for any number of documents.</td>
    </tr>
    <tr>
      <td>Annual subscription</td>
      <td><span class="lfx-price">$49</span> <small>per year</small></td>
      <td>Every paid feature — Export and Import — for any number of documents. A year costs about as much as ten months of the monthly subscription.</td>
    </tr>
  </tbody>
</table>

- **Subscriptions cover every paid feature of LaTeXFlow:** Export and Import.
- **A pass covers one direction and one document.** An Export pass does not unlock Import, and an Import pass does not unlock Export. An Export pass is tied to the first document you export with it, at the moment you export.
  <!-- PENDING(addon): which document an Import pass is tied to, and at what moment (the document you import into, at import time?) -->
- **A subscription works while it is active.** When it ends, Export and Import lock immediately; there is no grace period.
- **When a subscription ends, only the paid features lock.** The `.tex` files you already exported and the documents you already imported are yours, and every free feature of LaTeXFlow keeps working.

---

## How buying works

1. **Payment.** Payments are processed by [Lemon Squeezy](https://www.lemonsqueezy.com/) as merchant of record. You pay Lemon Squeezy, in US dollars; the checkout may show an estimate in your local currency, and VAT or sales tax may be added depending on your country. Your card statement will show `LEMSQZY*` rather than our name.
2. **Licence key.** Your licence key is in the Lemon Squeezy receipt email, which arrives right after payment. There is no separate email to wait for.
3. **Activation.** In Google Docs™, open the LaTeXFlow sidebar, go to the **Export** tab, paste the key, and click **Activate**. The key is stored in the Google account you activated it in. A subscription key applies to every document you open with that account; an Export pass key applies to the first document you export with it.
   <!-- PENDING(addon): where an Import pass key is activated (Export tab's License row, or the Import tab) and which document it is tied to -->

If anything goes wrong — no key in the receipt email, a key that will not activate — see the [Support page](/latexflow/support/#export-licence-and-purchases-add-on).

---

## Refunds

<!-- USER DECISION: refund policy -->
If Export or Import does not work for your document, write to us within **14 days** of purchase through the [Support page](/latexflow/support/) and we will refund the purchase. Tell us what went wrong; it helps us fix it for the next person.

Lemon Squeezy, as the payment processor, may also refund a purchase within 60 days of purchase at its own discretion. Refunds go back to the original payment method and can take up to 10 days to appear on your statement.
<!-- /USER DECISION -->

---

## Buy

<!-- Checkout links: replace each #LS_CHECKOUT_* href with its live Lemon Squeezy checkout URL (and drop aria-disabled / onclick) when the next version ships -->
<p class="lfx-buy-row">
  <a class="lfx-buy" href="#LS_CHECKOUT_EXPORT_PASS" aria-disabled="true" onclick="return false;">Export pass — $1.99</a>
  <a class="lfx-buy" href="#LS_CHECKOUT_IMPORT_PASS" aria-disabled="true" onclick="return false;">Import pass — $1.99</a>
  <a class="lfx-buy" href="#LS_CHECKOUT_MONTHLY" aria-disabled="true" onclick="return false;">Monthly — $4.99</a>
  <a class="lfx-buy" href="#LS_CHECKOUT_ANNUAL" aria-disabled="true" onclick="return false;">Annual — $49</a>
</p>
<p class="lfx-buy-note">Checkout opens with the next version of the Add-on, which brings Export and Import and is pending Google review. Until then these buttons are inactive.</p>

---

## Legal

- [Terms of Service](/latexflow/terms/) — section 1c covers the paid features, licences and refunds
- [Privacy Policy](/latexflow/privacy/)
- [Support](/latexflow/support/)
