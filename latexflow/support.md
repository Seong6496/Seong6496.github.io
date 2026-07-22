---
layout: latexflow-doc
title: Support
permalink: /latexflow/support/
description: Support and contact for the LaTeXFlow Google Docs Add-on and Web app.
---

Need help with **LaTeXFlow** — either the **Google Docs™ Add-on** or the **Web app** at `mathsystem.dev/latexflow/web/`? Here's how to get support.

---

## Report a Bug or Request a Feature

The fastest way to get help is to open an issue on GitHub:

**[Open an Issue on GitHub](https://github.com/Seong6496/google-docs-latex-addon/issues)**

Please include:

- Which product (Add-on or Web app)
- What you were trying to do
- What happened instead
- The LaTeX formula that caused the problem (if applicable)
- **(Add-on)** Your browser and Google Workspace account type
- **(Web app)** Your browser and OS, and whether you used drag-drop or Google Drive import

---

## Contact by Email

For privacy-related requests or issues you'd prefer not to post publicly:

**sung2417@gmail.com**

---

## Frequently Asked Questions

### Add-on (inside Google Docs)

**Q. The equation image looks blurry in my document.**
A. The Add-on inserts a PNG image sized to match standard inline/display text height. If you need a larger image, try scaling it after insertion using Google Docs' image resize handle.

**Q. My LaTeX formula shows an error in the preview.**
A. The preview uses Temml to render your formula. Check your LaTeX syntax — common issues include missing closing braces `}` or unsupported commands.

**Q. The Scan tab didn't find my formulas.**
A. The scanner detects `$...$` (inline) and `$$...$$` (display) delimiters. Make sure your formulas use these delimiters and are not inside special objects like drawings or images.

**Q. How do I turn off data collection in the Add-on?**
A. Go to **Extensions → LaTeXFlow → Data Collection Settings** in Google Docs. You can withdraw consent at any time. See our [Privacy Policy](/latexflow/privacy/) for details.

### Web app (mathsystem.dev/latexflow/web/)

**Q. What Google Drive access does the Web app get?**
A. Only the limited `drive.file` scope — it can see only the files you explicitly pick in the Drive Picker, and it cannot list, search, or read anything else in your Drive. Nothing leaves your browser. See the [Privacy Policy](/latexflow/privacy/#drive-import) for details.

**Q. My `.docx` upload fails or some equations are missed.**
A. The scanner detects `$...$`, `$$...$$`, and optionally bracket `[\...]` equations. Equations split across multiple paragraphs are not currently detected — keep each `$$...$$` on a single paragraph if possible.

**Q. How do I recover the original LaTeX from a rendered image?**
A. Each PNG includes the original LaTeX in its alt-text (`AIMATH_FORMULA::v1::` tag). You can recover the source for any equation from the image's alt-text field in Word or Google Docs.

**Q. How do I turn off data collection in the Web app?**
A. The Web app sends only the equation source and rendered PNG (no other document content) to our collection endpoint. An in-app toggle is on the roadmap; in the meantime, email sung2417@gmail.com and we will arrange an opt-out for your account.

---

## Legal

- [Privacy Policy](/latexflow/privacy/)
- [Terms of Service](/latexflow/terms/)
