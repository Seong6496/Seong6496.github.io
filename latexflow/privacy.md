---
layout: latexflow-doc
title: Privacy Policy
permalink: /latexflow/privacy/
description: How LaTeXFlow (Google Docs Add-on and Web app) handles your data.
---

*Last updated: 2026-08-13*

> 📋 **Site-wide privacy** (cookies, advertising, third-party services on the blog and tool pages): [mathsystem.dev/blog/privacy/](/blog/privacy/). This page covers **only the LaTeXFlow tool itself** (Add-on permissions, Web app data processing).

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
- **User identification**: The Add-on reads your Google account email address only to derive a pseudonymous identifier for optional training data. The email is hashed **inside the Add-on** — `SHA-256(email + salt)`, truncated to 16 hexadecimal characters — and **your raw email address never leaves the script**. It is not transmitted, not stored, and not shared. See §4b.

**OAuth scopes requested by the Add-on** — four, and no others:

| Scope | Why |
|---|---|
| `.../auth/documents.currentonly` | Read and edit **only the document the Add-on is currently open in**. It gives no access to your Drive or to any other file. |
| `.../auth/script.container.ui` | Display the sidebar and the consent dialog inside Google Docs™. |
| `.../auth/script.external_request` | Load the rendering libraries, and send opted-in training data to our collection endpoint (§4). |
| `.../auth/userinfo.email` | Derive the pseudonymous identifier described above. |

Your document is opened and edited within Google's infrastructure (Apps Script). **The body of your document is never transmitted to any external server**, and the Add-on never stores or shares your document text. The single exception is the opted-in training data described in §3a: for each equation you convert, the LaTeX source **of that one equation** and its rendered image are transmitted to our collection endpoint (§4), and only if you have given consent (§5a). The surrounding document text, the document identifier, and your account email are never included.

---

## 2b. Web App Data Access

The Web app runs **entirely in your browser**. The `.docx` file you upload is parsed and converted client-side using JSZip and MathJax loaded from jsDelivr CDN; the **document body text is never transmitted to our servers**.

When you convert equations, the LaTeX source for each equation and its rendered PNG image are sent to our collection endpoint (a Google Cloud Function named `collect-web-pair`, running in our own Google Cloud project in the `asia-northeast3` / Seoul region) for inclusion in a training dataset. The non-equation contents of your document — paragraphs, tables, images, file name, author metadata — are never transmitted. See §3a for the exact fields collected.

External rendering: MathJax is loaded from jsDelivr CDN. The `.docx` content itself is processed locally in your browser.

---

## 2c. Web App — Google Drive Import (Optional) {#drive-import}

The Web app provides an optional **"Import from Google Drive"** button alongside the standard drag-and-drop input. This path is for users (notably on iPad) whose Google Drive app only exports `.gdoc` as PDF. The button is dormant until you click it — if you only use drag-and-drop, **no Google Drive access ever occurs** and this section does not apply.

- **OAuth scope** — `https://www.googleapis.com/auth/drive.file` only. This is a **narrowly-scoped** permission: the app can read **only the file you explicitly pick** through Google's Drive Picker dialog. It cannot list, search, or read any other file in your Drive.
- **Sign-in flow** — Google handles the sign-in and consent screen. You can cancel at any point.
- **File handling** — Once you select a Google Doc (or `.docx` / `.odt` / `.rtf`), Google exports it as `.docx` and sends it directly to your browser. The file then enters the same client-side pipeline described in §2b. **File content never transits our servers.**
- **Access token** — The OAuth access token returned by Google is held in browser memory only, scoped to the current page. Closing the tab or refreshing discards it. We do not store, log, or transmit the token.
- **Credentials embedded in the page** — The Web app embeds an OAuth Client ID and a Google API Key. Both are **spec-public identifiers**: the OAuth Client ID is public by design under the OAuth 2.0 specification, and the API Key is restricted by HTTP referrer to `mathsystem.dev` (and `localhost` for development). No `client_secret` is used (the Web app uses PKCE / implicit flows).
- **Revoking access** — You can revoke the Web app's Drive access at any time at [myaccount.google.com/permissions](https://myaccount.google.com/permissions).

For the underlying Google services and their policies, see [Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy) and [Google's Privacy Policy](https://policies.google.com/privacy).

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
| LaTeX source code (one equation per record) | ✅ | ✅ |
| Rendered PNG image | ✅ | ✅ |
| Display type / delimiter | inline / display | `$`, `$$`, `\(`, `\[`, `[]` |
| Timestamp (server) | ✅ | ✅ |
| Pseudonymous ID | 16-hex `SHA-256(email + salt)`, computed inside the Add-on | 16-hex random UUID stored in browser localStorage |
| `source` label | ✅ explicit in sidecar JSON | `"web"` (explicit in sidecar JSON) |
| Email address | ❌ — **no longer collected** | ❌ — never collected |
| Document identifier | ❌ — never collected | ❌ — never collected |
| Document body / non-equation content | ❌ — never collected | ❌ — never collected |

<!-- NEEDS CONFIRMATION: the exact literal value of the Add-on's `source` label (the Web app uses "web"). The text above deliberately makes no claim about the literal string. -->

**This data is used solely for training future OCR/recognition models** that improve LaTeXFlow's ability to automatically detect and convert equations.

**Personally identifiable information (name, IP address, document content) is never collected by the Web app. The Add-on no longer collects your Google account email** — it transmits only the pseudonymous identifier described above (§4b).

### 3b. Error Logs

> ⚠️ **NEEDS CONFIRMATION — this section is pending revision and must be resolved before this document is published.**
> Earlier versions of this policy stated that Add-on conversion errors are recorded to a private Google Sheet. **That path no longer exists**: the Add-on no longer writes to Google Sheets, and it now makes exactly one outbound request — to the collection endpoint described in §4. Whether error logging is retained at all, and if so what it records and where it is stored, is to be confirmed and written here before publication. Nothing is asserted in the meantime.

The Web app does not transmit error logs.

---

## 4. How We Store Data

Training data (§3a) from both products is stored in **Google Cloud Storage**, in a single bucket — `latex-web-training-data` — owned by the developer's own Google Cloud project (`docsaddon-489707`), in the **`asia-northeast3` (Seoul, Republic of Korea)** region.

Neither product writes to that bucket directly, and **the Add-on holds no service-account key**. Each product makes a single outbound request to a Cloud Function in the same project and the same region, and the function performs the write. For the Web app that endpoint is `collect-web-pair`.

<!-- NEEDS CONFIRMATION: whether the Add-on posts to the same `collect-web-pair` function or to a separate Cloud Function in the same project. The text above deliberately does not name the Add-on's endpoint. -->

The collection endpoint enforces per-field size caps, writes objects with `Cache-Control: private, no-store`, and never logs the LaTeX or the full pseudonymous identifier. See §4b for the full list of protections.

Object layout — **both products** now write the same pair:

| Product | Object key | Metadata location |
|---|---|---|
| Add-on | `latex-pairs/{uuid}.png` | `latex-pairs/{uuid}.json` — sidecar next to the PNG |
| Web app | `latex-pairs/{uuid}.png` | `latex-pairs/{uuid}.json` — sidecar next to the PNG; includes a server-generated timestamp, the source delimiter, and the anonymous UUID |

The Add-on's earlier storage path — a Google Sheet row containing the account email, and PNG objects in a US multi-region bucket — **no longer exists**. The 224 images collected by earlier versions of the Add-on have been migrated into the Seoul bucket and de-identified, and the previous US bucket has been deleted. No LaTeXFlow data is stored outside `asia-northeast3`.

---

## 4a. Sharing, Transfer, and Disclosure of Google User Data

**We do not sell your data, and we do not share, transfer, or disclose Google user data to any third party — for any purpose, including advertising.**

- **No third-party recipients.** No Google user data obtained through the Add-on or the Web app is shared with, transferred to, or disclosed to any third party, under any arrangement.
- **Processed only inside our own Google Cloud project.** All processing and storage take place within the developer's own Google Cloud project, `docsaddon-489707` — specifically **Google Cloud Functions** (the collection endpoint) and **Google Cloud Storage** (the bucket described in §4).
- **Google Cloud is the only infrastructure processor.** Google Cloud provides the compute and storage this project runs on, and acts in that capacity only. There are no other processors, vendors, or sub-processors.
- **No cross-border transfer.** All storage is in the **`asia-northeast3` (Seoul, Republic of Korea)** region. Data is not transferred to or stored in any other region or country.
- **Who can access it.** The developer identified in §1, and the project's service account. That service account is **write-only** — it holds `roles/storage.objectCreator`, so it can create objects but cannot read stored objects back.

**What is transmitted at all:**

- **Add-on** — only if you have opted in through the consent dialog (§5a), and only per equation you convert: the **LaTeX source of that single equation**, its **rendered PNG**, the **delimiter type**, a **pseudonymous identifier**, a **server timestamp**, and a **`source` label**. Your **Google account email address is not transmitted**; the **document identifier is not transmitted**; and the **rest of your document is never transmitted** — not its text, tables, images, or metadata.
- **Web app** — the LaTeX source of each equation and its rendered PNG, plus the delimiter, a browser-local random UUID, a server timestamp, and the `source` label `"web"`. The `.docx` body, file name, and author metadata are never transmitted (§2b).

## 4b. Data Protection Mechanisms

These protections apply to all data described in §3a, including data derived from Google user data.

| Mechanism | What is in place |
|---|---|
| **In transit** | All transmissions use **HTTPS/TLS**. |
| **At rest** | Objects are encrypted at rest with **Google-managed encryption**. |
| **Access control** | **Uniform bucket-level access** is enabled. **Public access prevention** is enabled. `allUsers` and `allAuthenticatedUsers` are explicitly restricted — the bucket is **not publicly readable**. The writing service account holds **`roles/storage.objectCreator` only**: write-only, with no ability to read objects back. |
| **Pseudonymization** | The Add-on identifier is `SHA-256(email + salt)`, truncated to 16 hexadecimal characters. Hashing happens **inside the Add-on** — the **raw email address never leaves the script**. The salt is held in server-side configuration and is **not stored alongside the data**. |
| **Minimization** | **No document identifier** and **no document body** is collected. The collection endpoint enforces size caps of **4 KiB for the LaTeX** and **256 KiB for the decoded PNG** per record. |
| **Logging** | The collection endpoint **never logs the LaTeX** and **never logs the full pseudonymous identifier** — at most a 4-character prefix of it. |
| **Caching** | Stored objects are written with `Cache-Control: private, no-store`. |
| **Region** | All storage is in **`asia-northeast3` (Seoul, Republic of Korea)** — see §4a. |
| **Retention** | Training data is retained while it remains useful for model training; records unused for more than 12 months are reviewed quarterly and deleted if no longer needed. See §6. |
| **Deletion on request** | Email `sung2417@gmail.com`. **Web app:** include your `latexflow_anon_hash` value (§5b). **Add-on:** ⚠️ **NEEDS CONFIRMATION** — the request route for Add-on records is under revision now that the account email is no longer stored, and must be written here before publication. |

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

Error log retention: ⚠️ **NEEDS CONFIRMATION** — see §3b.

You may request deletion of your pseudonymized training data by contacting us at sung2417@gmail.com. For the Web app, please include the `latexflow_anon_hash` value as described in §5b. For the Add-on, the request route is ⚠️ **NEEDS CONFIRMATION** — see §4b.

---

## 7. Third-Party Services

**§4a is the authoritative answer to who receives your data: no third party does.** The services listed here are the infrastructure this project runs on and the CDN your browser loads rendering libraries from. They are not recipients of Google user data for their own purposes.

| Service | Role | Receives Google user data? |
|---|---|---|
| Google Cloud Storage (`asia-northeast3`) | Storage of training data, in our own project (§4) | Only as our infrastructure processor (§4a) |
| Google Cloud Functions (`asia-northeast3`) | Collection endpoint, in our own project — `collect-web-pair` for the Web app | Only as our infrastructure processor (§4a) |
| Google Sheets | **No longer used** for training metadata. Error-log storage is ⚠️ **NEEDS CONFIRMATION** — see §3b | — |
| jsDelivr CDN | Serves the Temml and MathJax rendering libraries to your browser and to the Add-on sidebar | **No.** Only library files are requested; no document content or user data is included |

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
