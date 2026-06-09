---
layout: page
title: Privacy Policy — LaTeXFlow
permalink: /latexflow/privacy/
---

*Last updated: April 6, 2026*

This Privacy Policy describes how **LaTeXFlow for Google Docs™** ("the Add-on") collects, uses, and protects your information.

---

## 1. Who We Are

The Add-on is developed and maintained by an individual developer (contact: sung2417@gmail.com). It is a Google Workspace Add-on published on the Google Workspace Marketplace.

---

## 2. Google Workspace Data Access

LaTeXFlow accesses your Google Docs™ document solely to provide its core functionality:

- **Document reading**: The Add-on scans your document body to detect LaTeX expressions enclosed in `$...$` and `$$...$$` delimiters.
- **Document writing**: Detected expressions are replaced in-place with rendered equation images. The Add-on also reads inline image metadata to support reverting images back to editable LaTeX text.
- **Sidebar and dialogs**: The Add-on displays a sidebar panel for LaTeX input and live preview, and a modal dialog for managing data collection consent, within Google Docs™.
- **External rendering libraries**: The Add-on loads Temml and MathJax from jsDelivr CDN to render LaTeX expressions as images within the sidebar. No document content is included in these requests.
- **User identification**: The Add-on reads your Google account email address solely to associate anonymized error logs and optional training data with your session. Your email is never shared with third parties or stored in plain text outside of Google's infrastructure.

Your document content is processed within Google's infrastructure (Apps Script) and is **not transmitted to external servers**. The Add-on never stores or shares the text content of your document.

---

## 3. Information We Collect

### 3a. Optional Training Data (Opt-in Only)

When you **explicitly consent**, the Add-on collects:

| Data | Description |
|---|---|
| LaTeX source code | The formula text you entered or converted |
| Rendered PNG image | The resulting equation image (high-resolution) |
| Display type | Whether the equation is inline or display-mode |
| Anonymized user ID | A hashed identifier — **not** linked to your name or email |
| Timestamp | Date and time of submission |

**This data is used solely for training future OCR/recognition models** that improve the Add-on's ability to automatically detect and convert equations.

**Personally identifiable information (name, email) is never collected. Document text content is never stored or transmitted.**

### 3b. Error Logs

If a conversion error occurs, the Add-on automatically records:
- The LaTeX string that caused the error
- The error message
- A timestamp

This data is stored in a private Google Sheet accessible only to the developer, and is used for debugging purposes only.

---

## 4. How We Store Data

Training data (§3a) is stored in **Google Cloud Storage (GCS)** using a dedicated service account. Access is restricted to the developer only.

Error logs (§3b) are stored in a **private Google Sheets** file.

---

## 5. Your Consent and Control

- On first launch, the Add-on displays a **consent dialog** asking whether you agree to share anonymized training data.
- You may **decline** at any time — the Add-on's core functionality (equation insertion) works fully without consent.
- You may **withdraw or change** your consent at any time via:
  **Extensions → LaTeX Converter → Data Collection Settings**

We do not collect training data unless you have explicitly agreed.

---

## 6. Data Retention

Training data is retained indefinitely for model training purposes.
Error logs are retained for up to 12 months and then deleted.

You may request deletion of your anonymized training data by contacting us at sung2417@gmail.com. Because data is stored anonymously without a direct identifier, we will make reasonable efforts to locate and remove records associated with your submissions.

---

## 7. Third-Party Services

The Add-on uses the following third-party services:

| Service | Purpose |
|---|---|
| Google Cloud Storage | Storage of training data |
| Google Sheets | Error log storage |
| jsDelivr CDN | Loading Temml and MathJax rendering libraries |

These services are governed by their own privacy policies.

---

## 8. Children's Privacy

The Add-on is not directed at children under 13. We do not knowingly collect data from children under 13.

---

## 9. Changes to This Policy

We may update this policy from time to time. The "Last updated" date at the top of this page will reflect any changes. Continued use of the Add-on after changes constitutes acceptance.

---

## 10. Contact

For privacy-related questions or data deletion requests:

**Email:** sung2417@gmail.com
**GitHub Issues:** [github.com/Seong6496/google-docs-latex-addon/issues](https://github.com/Seong6496/google-docs-latex-addon/issues)
