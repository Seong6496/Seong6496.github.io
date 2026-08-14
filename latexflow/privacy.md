---
layout: latexflow-doc
title: Privacy Policy
permalink: /latexflow/privacy/
description: How LaTeXFlow (Google Docs™ Add-on and Web app) handles your data.
---

*Last updated: 2026-08-14*

> 📋 **Site-wide privacy** (cookies, advertising, third-party services on the blog and tool pages): [mathsystem.dev/blog/privacy/](/blog/privacy/). This page covers **only the LaTeXFlow tool itself** (Add-on permissions, Web app data processing).

This Privacy Policy describes how **LaTeXFlow** — both the **Google Docs™ Add-on** ("the Add-on") and the **Web app at mathsystem.dev** ("the Web app") — collects, uses, and protects your information.

**Every section and every claim below is labelled `[Add-on]`, `[Web app]`, or `[Both]`.** The two products are documented on one page because they share one collection endpoint, one storage bucket, one region, and one service account; the labels tell you which product any given statement applies to.

---

## The Add-on at a Glance `[Add-on]` {#addon-glance}

Everything a Google Docs™ Add-on user — or a reviewer — needs, in one table. Each row links to the section that expands it.

| | |
|---|---|
| **OAuth scopes** — four, and no others | `.../auth/documents.currentonly` — read and edit **only the document the Add-on is currently open in**; no access to your Drive or to any other file.<br>`.../auth/script.container.ui` — display the sidebar and the consent dialog inside Google Docs™.<br>`.../auth/script.external_request` — load the rendering libraries, and send opted-in training data to our collection endpoint.<br>`.../auth/userinfo.email` — derive the pseudonymous identifier below. The raw email is never transmitted. |
| **What is collected** | Only if you opt in, and only per equation you convert: that **one equation's LaTeX source**, its **rendered PNG**, the **delimiter type**, a **16-hex pseudonym**, a **server timestamp**, and the **`source` label `"addon"`**. Nothing else. See §3a. |
| **What is never collected** | Your Google account email address · the document identifier · your document's body, its other text, tables, images, file name, or metadata. See §4a. |
| **Consent model** | **Explicit opt-in.** Nothing is collected unless you agree in the consent dialog. Collection is gated on a stored preference that **defaults to unset — taking no action means nothing is collected.** You may withdraw at any time (§5a). |
| **Does declining cost you anything?** | **No. Every feature works fully without consenting.** Conversion, insertion, and reverting an image back to editable LaTeX all work identically — reverting reads the LaTeX from the image's own alt text inside your document, never from collected data. |
| **Where it is stored** | Google Cloud Storage in the developer's own project, **`asia-northeast3` (Seoul, Republic of Korea)** only. No cross-border transfer. See §4. |
| **Who receives it** | **No third party.** Not sold, not shared, not transferred, not disclosed — for any purpose, including advertising. Google Cloud is the only infrastructure processor. See §4a. |
| **How it is protected** | HTTPS/TLS in transit · Google-managed encryption at rest · write-only service account · public access prevention · pseudonymization · the collection endpoint never logs your LaTeX. See §4b. |
| **One thing to know about failures** | If a conversion fails, the Add-on writes a diagnostic line to its own Apps Script execution log, and that line **can include the LaTeX that failed**. Nothing is transmitted or stored by us. See §3b. |
| **Deleting your data** | Email `sung2417@gmail.com` from the Google account you used with the Add-on. See §6. |

---

## 1. Who We Are `[Both]`

LaTeXFlow is developed and maintained by an individual developer (contact: sung2417@gmail.com). The Add-on is published on the Google Workspace Marketplace; the Web app is hosted at `mathsystem.dev/latexflow/web/`. The same developer is the data controller for both products.

---

## 2. Google Workspace Data Access `[Add-on]`

The Add-on accesses your Google Docs™ document solely to provide its core functionality:

- **Document reading**: The Add-on scans your document body to detect LaTeX expressions enclosed in `$...$` and `$$...$$` delimiters.
- **Document writing**: Detected expressions are replaced in-place with rendered equation images. The Add-on also reads inline image metadata to support reverting images back to editable LaTeX text.
- **Sidebar and dialogs**: The Add-on displays a sidebar panel for LaTeX input and live preview, and a modal dialog for managing data collection consent, within Google Docs™.
- **External rendering libraries**: The Add-on loads Temml and MathJax from jsDelivr CDN to render LaTeX expressions as images within the sidebar. No document content is included in these requests.
- **User identification**: The Add-on reads your Google account email address only to derive a pseudonymous identifier for optional training data. The email is hashed **inside the Add-on** — `SHA-256(email + salt)`, truncated to 16 hexadecimal characters — and **your raw email address never leaves the script**. It is not transmitted, not stored, and not shared. See §4b.

**OAuth scopes requested by the Add-on** — four, and no others. Each is listed with its justification in [The Add-on at a Glance](#addon-glance) above; that table is the authoritative list.

Your document is opened and edited within Google's infrastructure (Apps Script). **The body of your document is never transmitted to any external server**, and the Add-on never stores or shares your document text. The single exception is the opted-in training data described in §3a: for each equation you convert, the LaTeX source **of that one equation** and its rendered image are transmitted to our collection endpoint (§4), and only if you have given consent (§5a). The surrounding document text, the document identifier, and your account email are never included.

---

## 2b. Web App Data Access `[Web app]`

The Web app runs **entirely in your browser**. The `.docx` file you upload is parsed and converted client-side using JSZip and MathJax loaded from jsDelivr CDN; the **document body text is never transmitted to our servers**.

When you convert equations, the LaTeX source for each equation and its rendered PNG image are sent to our collection endpoint (a Google Cloud Function named `collect-web-pair`, running in our own Google Cloud project in the `asia-northeast3` / Seoul region) for inclusion in a training dataset. The non-equation contents of your document — paragraphs, tables, images, file name, author metadata — are never transmitted. See §3a for the exact fields collected.

External rendering: MathJax is loaded from jsDelivr CDN. The `.docx` content itself is processed locally in your browser.

---

## 2c. Web App — Google Drive Import (Optional) `[Web app]` {#drive-import}

The Web app provides an optional **"Import from Google Drive"** button alongside the standard drag-and-drop input. This path is for users (notably on iPad) whose Google Drive app only exports `.gdoc` as PDF. The button is dormant until you click it — if you only use drag-and-drop, **no Google Drive access ever occurs** and this section does not apply.

- **OAuth scope** — `https://www.googleapis.com/auth/drive.file` only. This is a **narrowly-scoped** permission: the app can read **only the file you explicitly pick** through Google's Drive Picker dialog. It cannot list, search, or read any other file in your Drive.
- **Sign-in flow** — Google handles the sign-in and consent screen. You can cancel at any point.
- **File handling** — Once you select a Google Docs™ document (or `.docx` / `.odt` / `.rtf`), Google exports it as `.docx` and sends it directly to your browser. The file then enters the same client-side pipeline described in §2b. **File content never transits our servers.**
- **Access token** — The OAuth access token returned by Google is held in browser memory only, scoped to the current page. Closing the tab or refreshing discards it. We do not store, log, or transmit the token.
- **Credentials embedded in the page** — The Web app embeds an OAuth Client ID and a Google API Key. Both are **spec-public identifiers**: the OAuth Client ID is public by design under the OAuth 2.0 specification, and the API Key is restricted by HTTP referrer to `mathsystem.dev` (and `localhost` for development). No `client_secret` is used (the Web app uses PKCE / implicit flows).
- **Revoking access** — You can revoke the Web app's Drive access at any time at [myaccount.google.com/permissions](https://myaccount.google.com/permissions).

For the underlying Google services and their policies, see [Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy) and [Google's Privacy Policy](https://policies.google.com/privacy).

---

## 3. Information We Collect `[Both]`

### 3a. Training Data `[Both]`

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
| `source` label | `"addon"` (explicit in sidecar JSON) | `"web"` (explicit in sidecar JSON) |
| Email address | ❌ — **no longer collected** | ❌ — never collected |
| Document identifier | ❌ — never collected | ❌ — never collected |
| Document body / non-equation content | ❌ — never collected | ❌ — never collected |

**This data is used solely for training future OCR/recognition models** that improve LaTeXFlow's ability to automatically detect and convert equations.

**`[Both]` Our collection endpoint does not collect your name, your IP address, or your document content** — the fields listed in the table above are the whole of what is collected, from either product. **`[Add-on]` The Add-on no longer collects your Google account email**; it transmits only the pseudonymous identifier described above (§4b).

### 3b. Failure Diagnostics `[Add-on]`

**We do not collect error logs.** When a conversion fails, the Add-on writes a single diagnostic line to the **Apps Script execution log** for that run. Nothing is transmitted to us, stored by us, or written to any database, spreadsheet, or file.

Two things you should know about that line:

- **It can include the LaTeX string that failed**, along with the error message and the name of the function that raised it. It contains no other document content.
- It is written to Google's own Apps Script execution logging inside the developer's Google Cloud project, and is **retained under Google's default logging behaviour. We do not set a retention period for it**, and we make no retention commitment about it.

**`[Web app]`** The Web app does not transmit error logs.

---

## 4. How We Store Data `[Both]`

Training data (§3a) from both products is stored in **Google Cloud Storage**, in a single bucket — `latex-web-training-data` — owned by the developer's own Google Cloud project (`docsaddon-489707`), in the **`asia-northeast3` (Seoul, Republic of Korea)** region.

Neither product writes to that bucket directly, and **the Add-on holds no service-account key**. Each product makes a single outbound request to our collection endpoint — the Cloud Function `collect-web-pair`, in the same project and the same region — and the function performs the write. **Both products use that same one function**; there is no second endpoint.

The collection endpoint enforces per-field size caps, writes objects with `Cache-Control: private, no-store`, and never logs the LaTeX or the full pseudonymous identifier. See §4b for the full list of protections.

Object layout — **both products** now write the same pair:

| Product | Object key | Metadata location |
|---|---|---|
| Add-on | `latex-pairs/{uuid}.png` | `latex-pairs/{uuid}.json` — sidecar next to the PNG |
| Web app | `latex-pairs/{uuid}.png` | `latex-pairs/{uuid}.json` — sidecar next to the PNG; includes a server-generated timestamp, the source delimiter, and the anonymous UUID |

**No LaTeXFlow data is stored outside `asia-northeast3`.**

---

## 4a. Sharing, Transfer, and Disclosure of Google User Data `[Both]`

**We do not sell your data, and we do not share, transfer, or disclose Google user data to any third party — for any purpose, including advertising.**

- **No third-party recipients.** No Google user data obtained through the Add-on or the Web app is shared with, transferred to, or disclosed to any third party, under any arrangement.
- **Processed only inside our own Google Cloud project.** All processing and storage take place within the developer's own Google Cloud project, `docsaddon-489707` — specifically **Google Cloud Functions** (the collection endpoint) and **Google Cloud Storage** (the bucket described in §4).
- **Google Cloud is the only infrastructure processor.** Google Cloud provides the compute and storage this project runs on, and acts in that capacity only. There are no other processors, vendors, or sub-processors.
- **No cross-border transfer.** All storage is in the **`asia-northeast3` (Seoul, Republic of Korea)** region. Data is not transferred to or stored in any other region or country.
- **Who can access it.** The developer identified in §1, and the project's service account. That service account is **write-only** — it holds `roles/storage.objectCreator`, so it can create objects but cannot read stored objects back.

**What is transmitted at all:**

- **`[Add-on]`** — only if you have opted in through the consent dialog (§5a), and only per equation you convert: the **LaTeX source of that single equation**, its **rendered PNG**, the **delimiter type**, a **pseudonymous identifier**, a **server timestamp**, and the **`source` label `"addon"`**. Your **Google account email address is not transmitted**; the **document identifier is not transmitted**; and the **rest of your document is never transmitted** — not its text, tables, images, or metadata.
- **`[Web app]`** — the LaTeX source of each equation and its rendered PNG, plus the delimiter, a browser-local random UUID, a server timestamp, and the `source` label `"web"`. The `.docx` body, file name, and author metadata are never transmitted (§2b).

## 4b. Data Protection Mechanisms `[Both]`

These protections apply to all data described in §3a, including data derived from Google user data. Rows that differ between the products are labelled.

| Mechanism | What is in place |
|---|---|
| **In transit** | `[Both]` All transmissions use **HTTPS/TLS**. |
| **At rest** | `[Both]` Objects are encrypted at rest with **Google-managed encryption**. |
| **Access control** | `[Both]` **Uniform bucket-level access** is enabled. **Public access prevention** is enabled. `allUsers` and `allAuthenticatedUsers` are explicitly restricted — the bucket is **not publicly readable**. The writing service account holds **`roles/storage.objectCreator` only**: write-only, with no ability to read objects back. |
| **Pseudonymization** | `[Add-on]` The identifier is `SHA-256(email + salt)`, truncated to 16 hexadecimal characters. Hashing happens **inside the Add-on** — the **raw email address never leaves the script**. The salt is held in server-side configuration and is **not stored alongside the data**.<br>`[Web app]` The identifier is a random 16-hex UUID generated in your browser and not derived from anything identifying (§5b). |
| **Minimization** | `[Both]` **No document identifier** and **no document body** is collected. The collection endpoint enforces size caps of **4 KiB for the LaTeX** and **256 KiB for the decoded PNG** per record. |
| **Logging** | `[Both]` The collection endpoint **never logs the LaTeX** and **never logs the full pseudonymous identifier** — at most a 4-character prefix of it.<br>`[Add-on]` Separately, failed conversions write a diagnostic line to the Apps Script execution log that **can include the LaTeX that failed** — see §3b. |
| **Caching** | `[Both]` Stored objects are written with `Cache-Control: private, no-store`. |
| **Region** | `[Both]` All storage is in **`asia-northeast3` (Seoul, Republic of Korea)** — see §4a. |
| **Retention** | `[Both]` Training data is retained while it remains useful for model training; records unused for more than 12 months are reviewed quarterly and deleted if no longer needed. See §6. |
| **Deletion on request** | `[Add-on]` Email `sung2417@gmail.com` **from the Google account you used with the Add-on** — we recompute your identifier from that address and delete the matching records. Nothing else is needed.<br>`[Web app]` Email the same address including your `latexflow_anon_hash` value (§5b). |

---

## 5. Your Consent and Control `[Both]`

### 5a. Add-on — Consent Dialog `[Add-on]`

- On first launch, the Add-on displays a **consent dialog** asking whether you agree to share anonymized training data.
- You may **decline** at any time. **Declining costs you nothing** — every feature of the Add-on works fully without consent, including conversion, insertion, and reverting an image back to editable LaTeX. Reverting reads the LaTeX from the image's own alt text inside your document, so it never depends on collected data.
- You may **withdraw or change** your consent at any time via:
  **Extensions → LaTeX Converter → Data Collection Settings**

We do not collect Add-on training data unless you have explicitly agreed. The preference that gates collection **defaults to unset** — if you never open the dialog and never agree, nothing is collected.

### 5b. Web App — How to Opt Out `[Web app]`

The Web app does **not** display a consent dialog because the data is **fully pseudonymized** — no email, name, IP address, or document content is collected. The only client-side identifier is a **16-hex random UUID** stored in your browser's localStorage under the key `latexflow_anon_hash`. This UUID is generated locally with `crypto.getRandomValues` and is **not derived from any identifying information**; it is used only to group submissions from the same browser for statistical analysis (e.g., to detect duplicate equations from the same session). It is **not linked to your identity** and is cleared whenever you clear site data.

This automatic processing relies on the lawful bases summarized in §3a. Under GDPR Art.21 you have the **right to object** at any time; under PIPA Art.37 you have an equivalent right to **stop processing**. Both can be exercised without contacting us, as follows.

**To opt out at any time**, open your browser DevTools (press F12), go to the **Console** tab, and run:

```js
localStorage.setItem('latexflow_collect_optout', '1')
```

The opt-out is enforced immediately by the Web app and persists until you clear site data. While the opt-out is set, no further submissions are sent. You may also simply avoid using the Web app if you prefer not to contribute.

To request deletion of previously submitted Web app records, email `sung2417@gmail.com` together with the value of `latexflow_anon_hash` from your browser (read it from the Console using `localStorage.getItem('latexflow_anon_hash')`). Without that identifier we cannot locate your submissions, because no email, name, or IP address is stored alongside them.

---

## 6. Data Retention and Deletion `[Both]`

**`[Both]`** Training data is retained while it remains useful for model training. Records that have been unused for more than 12 months are reviewed quarterly and deleted if they are no longer needed.

**`[Add-on]`** We do not collect error logs, so there is no error-log retention period to state. The Apps Script execution-log diagnostics described in §3b are retained under Google's default logging behaviour; **we do not set a retention period for them.**

**How to request deletion:**

- **`[Add-on]`** Email `sung2417@gmail.com` **from the Google account you used with the Add-on**. Your identifier is derived from your email address, so we can recompute it from the address you write from and delete the matching records. You do not need to supply anything else.
- **`[Web app]`** Email the same address and include your `latexflow_anon_hash` value, as described in §5b. Without it we cannot locate your submissions, because nothing identifying is stored alongside them.

---

## 7. Third-Party Services `[Both]`

**§4a is the authoritative answer to who receives your data: no third party does.** The services listed here are the infrastructure this project runs on and the CDN your browser loads rendering libraries from. They are not recipients of Google user data for their own purposes.

| Service | Role | Receives Google user data? |
|---|---|---|
| Google Cloud Storage (`asia-northeast3`) | `[Both]` Storage of training data, in our own project (§4) | Only as our infrastructure processor (§4a) |
| Google Cloud Functions (`asia-northeast3`) | `[Both]` Collection endpoint `collect-web-pair`, in our own project — one function serves both products | Only as our infrastructure processor (§4a) |
| jsDelivr CDN | `[Both]` Serves the Temml and MathJax rendering libraries to your browser and to the Add-on sidebar | **No.** Only library files are requested; no document content or user data is included |

**Google Sheets is not used by either product.**

These services are governed by their own privacy policies.

---

## 8. Children's Privacy `[Both]`

LaTeXFlow is not directed at children under 13. We do not knowingly collect data from children under 13.

---

## 9. Changes to This Policy `[Both]`

We may update this policy from time to time. The "Last updated" date at the top of this page will reflect any changes. Continued use of the Add-on or the Web app after changes constitutes acceptance.

---

## 10. Contact `[Both]`

For privacy-related questions or data deletion requests:

**Email:** sung2417@gmail.com
**GitHub Issues:** [github.com/Seong6496/google-docs-latex-addon/issues](https://github.com/Seong6496/google-docs-latex-addon/issues)
