---
layout: page
title: Privacy Policy — LaTeXFlow
permalink: /latexflow/privacy/
---

*Last updated: 2026-06-23*

> 📋 **Site-wide privacy** (cookies, advertising, third-party services on the blog and tool pages): [mathsystem.dev/privacy/](/privacy/). This page covers **only the LaTeXFlow tool itself** (Add-on permissions, Web app data processing).

This Privacy Policy describes how **LaTeXFlow** — both the **Google Docs™ Add-on** ("the Add-on") and the **Web app at mathsystem.dev** ("the Web app") — collects, uses, and protects your information. Where a section differs between the two products, the distinction is called out explicitly.

---

## 1. Who We Are

LaTeXFlow is developed and maintained by an individual developer (contact: sung2417@gmail.com). The Add-on is published on the Google Workspace Marketplace; the Web app is hosted at `mathsystem.dev/latexflow/web/`. The same developer is the data controller for both products.

---

## 2. Google Workspace Data Access (Add-on)

The Add-on accesses your Google Docs™ document solely to provide its core functionality:

- **Document reading**: The Add-on scans your document body to detect LaTeX expressions enclosed in `$...$` and `$$...$$` delimiters.
- **Document writing**: Detected expressions are replaced in-place with rendered equation images. The Add-on also reads inline image metadata to support reverting images back to editable LaTeX text.
- **Sidebar and dialogs**: The Add-on displays a sidebar panel for LaTeX input and live preview, and a modal dialog for managing data collection consent, within Google Docs™.
- **External rendering libraries**: The Add-on loads Temml and MathJax from jsDelivr CDN to render LaTeX expressions as images within the sidebar. No document content is included in these requests.
- **User identification**: The Add-on reads your Google account email address solely to associate anonymized error logs and optional training data with your session. Your email is never shared with third parties or stored in plain text outside of Google's infrastructure.

Your document content is processed within Google's infrastructure (Apps Script) and is **not transmitted to external servers**. The Add-on never stores or shares the text content of your document.

---

## 2b. Web App Data Access

The Web app runs **entirely in your browser**. The `.docx` file you upload is parsed and converted client-side using JSZip and MathJax loaded from jsDelivr CDN; the **document body text is never transmitted to our servers**.

When you convert equations, the LaTeX source for each equation and its rendered PNG image are sent to our collection endpoint (a Google Cloud Function named `collect-web-pair`) for inclusion in a training dataset. The non-equation contents of your document — paragraphs, tables, images, file name, author metadata — are never transmitted. See §3a for the exact fields collected.

External rendering: MathJax is loaded from jsDelivr CDN. The `.docx` content itself is processed locally in your browser.

---

## 3. Information We Collect

### 3a. Training Data

The collection mechanism differs between the two products:

| Product | Mechanism | Legal basis |
|---|---|---|
| **Add-on** | Explicit opt-in via consent dialog (Google Workspace Marketplace policy) | Your consent (PIPA Art.15 / GDPR Art.6(1)(a)) |
| **Web app** | Automatic anonymized collection — no consent dialog | **GDPR Art.6(1)(f) legitimate interests** and **PIPA Art.28-2 pseudonymized-data exception for scientific research** |

For the legal basis of the Web app's automatic collection, see §5b for the rationale and your opt-out options.

Fields collected:

| Data | Add-on | Web app |
|---|---|---|
| LaTeX source code | ✅ | ✅ |
| Rendered PNG image | ✅ | ✅ |
| Display type / delimiter | inline / display | `$`, `$$`, `\(`, `\[`, `[]` |
| Timestamp (server) | ✅ | ✅ |
| Anonymized user ID | hashed identifier (per Google account) | 16-hex random UUID stored in browser localStorage |
| Email address | ✅ (Google account email) | ❌ — never collected |
| `source` field | implicit (Add-on dataset) | `"web"` (explicit in sidecar JSON) |

**This data is used solely for training future OCR/recognition models** that improve LaTeXFlow's ability to automatically detect and convert equations.

**Personally identifiable information (name, IP address, document content) is never collected by the Web app. The Add-on collects your Google account email only to allow you to manage your consent and request deletion.**

### 3b. Error Logs

If a conversion error occurs in the Add-on, it automatically records:
- The LaTeX string that caused the error
- The error message
- A timestamp

This data is stored in a private Google Sheet accessible only to the developer, and is used for debugging purposes only. The Web app does not transmit error logs.

---

## 4. How We Store Data

Training data (§3a) from both products is stored in **Google Cloud Storage (GCS)**, in a single bucket owned by the developer's GCP project. Access is restricted to the developer's service account.

Object layout:

| Product | Object key | Metadata location |
|---|---|---|
| Add-on | `eq_{timestamp}.png` | Row in a private Google Sheet (with email column) |
| Web app | `latex-pairs/{uuid}.png` + `latex-pairs/{uuid}.json` | Sidecar JSON next to the PNG; includes a server-generated timestamp, the source delimiter, and the anonymous UUID. The sidecar key prefix is `latex-pairs/` and matches the Add-on bucket — no shared key collisions. |

Error logs (§3b) are stored in a **private Google Sheets** file.

---

## 5. Your Consent and Control

### 5a. Add-on — Consent Dialog

- On first launch, the Add-on displays a **consent dialog** asking whether you agree to share anonymized training data.
- You may **decline** at any time — the Add-on's core functionality (equation insertion) works fully without consent.
- You may **withdraw or change** your consent at any time via:
  **Extensions → LaTeX Converter → Data Collection Settings**

We do not collect Add-on training data unless you have explicitly agreed.

### 5b. Web App — How to Opt Out

The Web app does **not** display a consent dialog because the data is **fully pseudonymized** — no email, name, IP address, or document content is collected. The only client-side identifier is a **16-hex random UUID** stored in your browser's localStorage under the key `latexflow_anon_hash`. This UUID is generated locally with `crypto.getRandomValues` and is **not derived from any identifying information**; it is used only to group submissions from the same browser for statistical analysis (e.g., to detect duplicate equations from the same session). It is **not linked to your identity** and is cleared whenever you clear site data.

This automatic processing relies on the lawful bases summarized in §3a. Under GDPR Art.21 you have the **right to object** at any time; under PIPA Art.37 you have an equivalent right to **stop processing**. Both can be exercised without contacting us, as follows.

**To opt out at any time**, open your browser DevTools (press F12), go to the **Console** tab, and run:

```js
localStorage.setItem('latexflow_collect_optout', '1')
```

The opt-out is enforced immediately by the Web app and persists until you clear site data. While the opt-out is set, no further submissions are sent. You may also simply avoid using the Web app if you prefer not to contribute.

To request deletion of previously submitted Web app records, email `sung2417@gmail.com` together with the value of `latexflow_anon_hash` from your browser (read it from the Console using `localStorage.getItem('latexflow_anon_hash')`). Without that identifier we cannot locate your submissions, because no email, name, or IP address is stored alongside them.

---

## 6. Data Retention

Training data — from both the Add-on and the Web app — is retained while it remains useful for model training. Records that have been unused for more than 12 months are reviewed quarterly and deleted if they are no longer needed.

Error logs are retained for up to 12 months and then deleted.

You may request deletion of your anonymized training data by contacting us at sung2417@gmail.com. For the Web app, please include the `latexflow_anon_hash` value as described in §5b.

---

## 7. Third-Party Services

LaTeXFlow uses the following third-party services:

| Service | Purpose |
|---|---|
| Google Cloud Storage | Storage of training data (both products) |
| Google Cloud Functions | Collection endpoint for Web app (`collect-web-pair`) |
| Google Sheets | Error log storage (Add-on); training metadata (Add-on) |
| jsDelivr CDN | Loading Temml and MathJax rendering libraries (both products) |

These services are governed by their own privacy policies.

---

## 8. Children's Privacy

LaTeXFlow is not directed at children under 13. We do not knowingly collect data from children under 13.

---

## 9. Changes to This Policy

We may update this policy from time to time. The "Last updated" date at the top of this page will reflect any changes. Continued use of the Add-on or the Web app after changes constitutes acceptance.

---

## 10. Contact

For privacy-related questions or data deletion requests:

**Email:** sung2417@gmail.com
**GitHub Issues:** [github.com/Seong6496/google-docs-latex-addon/issues](https://github.com/Seong6496/google-docs-latex-addon/issues)
