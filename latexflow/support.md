---
layout: latexflow-doc
title: Support
permalink: /latexflow/support/
description: Support and contact for the LaTeXFlow Google Docs Add-on and Web app.
comments: true
comments_category: "Q&A"
comments_category_id: DIC_kwDOHGf2gM4DAHL6
---

Need help with **LaTeXFlow** — either the **Google Docs™ Add-on** or the **Web app** at `mathsystem.dev/latexflow/web/`? Here's how to get support.

---

## Report a Bug or Request a Feature

Post it on the **[message board](#message-board)** at the bottom of this page. It is
the fastest way to reach us, and the answer stays visible for the next person with
the same question. Reading the board needs nothing; posting requires signing in with
a GitHub account.

Please include:

- Which product (Add-on or Web app)
- What you were trying to do
- What happened instead
- The LaTeX formula that caused the problem (if applicable)
- **(Add-on)** Your browser and Google Workspace account type
- **(Web app)** Your browser and OS, and whether you used drag-drop or Google Drive import

For privacy requests, or anything you would rather not post publicly, email
**mathfolis.support@gmail.com**.

---

## Frequently Asked Questions

### Add-on (inside Google Docs)

**Q. The equation image looks blurry in my document.**
A. The Add-on inserts a PNG image sized to match standard inline/display text height. If you need a larger image, try scaling it after insertion using Google Docs' image resize handle.

**Q. My LaTeX formula shows an error in the preview.**
A. The preview uses Temml to render your formula. Check your LaTeX syntax — common issues include missing closing braces `}` or unsupported commands.

**Q. The Scan tab didn't find my formulas.**
A. The scanner detects four delimiters — `$...$` (inline), `$$...$$` (display), `\(...\)` (inline), and `\[...\]` (display). A separate **bracket mode** also finds `[ ... ]`, for display math whose backslashes a chat app stripped; it is **off by default**, so tick *Also detect `[ … ]`* in the panel before scanning if you need it. Make sure your formulas use one of these delimiters and are not inside special objects like drawings or images.

**Q. How do I turn off data collection in the Add-on?**
A. Go to **Extensions → LatexFlow → Data Collection Settings** in Google Docs. You can withdraw consent at any time. See our [Privacy Policy](/latexflow/privacy/) for details.

### Export licence and purchases (Add-on)

**Q. How do I get my licence key?**
A. Buy a licence on the [Export page](/latexflow/export/). The payment is processed by Lemon Squeezy as merchant of record, and their receipt arrives right away. Your licence key comes in a **separate email from us**, sent to the email address you used at checkout, normally within 24 hours. It is not printed on the receipt.

**Q. I have not received my key.**
A. First check the spam folder of the address you used at checkout — the key is sent there, not to a Google account. If 24 hours have passed, email **mathfolis.support@gmail.com** with the order number from your Lemon Squeezy receipt (please do not post order numbers on the public board) and we will resend it.

**Q. What is `LEMSQZY*` on my card statement?**
A. That is the purchase. Lemon Squeezy is the merchant of record for LaTeXFlow, so the charge appears under their name rather than ours. Their explanation is at [lemonsqueezy.com/why-did-lemon-squeeezy-charge-me](https://www.lemonsqueezy.com/why-did-lemon-squeeezy-charge-me).

**Q. How do I request a refund?**
A. The refund policy is on the [Export page](/latexflow/export/#refunds) and in the [Terms of Service](/latexflow/terms/), section 1c. To request one, email **mathfolis.support@gmail.com** with your order number and, if you can, what went wrong. Lemon Squeezy may also refund a purchase within 60 days at its own discretion. A refund can take up to 10 days to show on your statement.

**Q. How do I activate my key, or move it to another Google account?**
A. In Google Docs™, open the LaTeXFlow sidebar, go to the **Export** tab, paste the key and click **Activate**. The key is stored in the Google account you activated it in and works in every document you open with that account. To move it, click **Deactivate** in the Export tab's License row on the old account, then paste and activate it on the new one. The key is personal to you — please do not share it.

### Web app (mathsystem.dev/latexflow/web/)

**Q. What Google Drive access does the Web app get?**
A. Only the limited `drive.file` scope — it can see only the files you explicitly pick in the Drive Picker, and it cannot list, search, or read anything else in your Drive. See the [Privacy Policy](/latexflow/privacy/#drive-import) for details.

**Q. My `.docx` upload fails or some equations are missed.**
A. The scanner detects `$...$`, `$$...$$`, `\(...\)`, and `\[...\]`. A fifth **bracket mode** additionally picks up `[ ... ]` — display math whose backslashes a chat app stripped — and it is **on by default**; untick it if plain brackets get picked up. Equations split across multiple paragraphs are not currently detected — keep each `$$...$$` on a single paragraph if possible.

**Q. The scan found 0 equations. What now?**
A. The result screen first reports what was actually read — `Scanned N paragraphs · 0 equations found` — and then walks you through the fix: the same line shown before and after delimiters are added, plus every delimiter that works. If the file holds Word equation *objects*, it says how many; those are not text, so no delimiter can reach them and that math has to be retyped or pasted back in as LaTeX text. Paragraphs that look like math but carry no delimiter are listed above the guide — open one, wrap the math in `$...$` or `$$...$$`, and the live preview confirms what gets detected. **Try another file** reopens the file picker.

**Q. How do I recover the original LaTeX from a rendered image?**
A. Each PNG includes the original LaTeX in its alt-text (`AIMATH_FORMULA::v1::` tag). You can recover the source for any equation from the image's alt-text field in Word or Google Docs.

**Q. How do I turn off data collection in the Web app?**
A. The Web app sends only the equation source and rendered PNG (no other document content) to our collection endpoint. An in-app toggle is on the roadmap; in the meantime, email mathfolis.support@gmail.com and we will arrange an opt-out for your account.

---

## Legal

- [Privacy Policy](/latexflow/privacy/)
- [Terms of Service](/latexflow/terms/)
- [Export to LaTeX — price, licence and refunds](/latexflow/export/)
