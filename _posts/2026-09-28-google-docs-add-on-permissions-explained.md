---
title: "What a Google Docs Add-on Can and Cannot See: The Permissions, Explained"
date: 2026-09-28 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/google-docs-add-on-permissions-explained/
categories: [Google Docs, Reference]
tags: [google-docs, add-on, oauth, permissions, scopes, privacy, reference]
math: false
pin: false
description: "The install consent screen compresses everything into a few lines. Here is each permission the add-on requests, what it reaches, what it does not reach, why it is needed at all, and how to revoke it later."
---

Installing a Google Docs add-on puts a consent screen in front of you with a handful of checkboxes on it, each written in the compressed language Google uses for permission summaries. It is reasonable to want to know what you are actually agreeing to.

This is the full list for [LaTeXFlow](/blog/en/posts/convert-latex-in-google-docs/), what each permission reaches, and — more usefully — what none of them reach.

**The one-sentence version:** it can read and change the single document it is open in, and it cannot touch any other document or anything else in your Drive. That is not a policy promise; it is a consequence of which permission was requested, and Google enforces it.

## 1. What the consent screen shows, and what it means

The flow is **two pages**, not one.

**Page 1** is the account page — your name, profile picture and email address. This is where the email permission is granted.

**Page 2** is the permission summary: **three checkboxes** and a `Continue` button.

Three plus one is four, which is the whole list. There is no "unverified app" interstitial, because the add-on has been through Google's review and is published; if you ever see that warning on something claiming to be this, check the address.

One thing that confuses people who go looking: Google's own developer console lists **one more permission than the consent screen does** — a "name and profile picture" entry. That is a platform default which cannot be removed, is not in the add-on's manifest, is never used by the code, and does not appear in the consent screen's permission list. The `Name and profile picture` line you see on page 1 is Google's standard account panel, not a request from the add-on.

## 2. The permissions requested

Four, exactly:

| Permission | Plain description |
|---|---|
| `documents.currentonly` | Read and change **only the document the add-on is currently open in** |
| `script.container.ui` | Draw the menu, the sidebar and the settings dialog inside Docs |
| `script.external_request` | Make one outbound server request — sending an opted-in equation to the collection endpoint |
| `userinfo.email` | Read the account email once, to derive an anonymous identifier |

## 3. What each one reaches

**`documents.currentonly` — the document you are in, and no other.**

This is the one that matters, and the `currentonly` part is the whole point. It is not a broader document permission that the add-on politely declines to overuse. It is a narrower permission that **makes access to any other document impossible**. The add-on could not open another file if it tried; Google would refuse.

Within the current document it is used for five things: inserting an image, replacing text with an image, scanning the text, reverting an image back to LaTeX, and wrapping a selection in delimiters.

**`script.container.ui` — drawing the interface.**

The menu, the sidebar panel and the settings dialog. This permission covers displaying things inside the Docs window. It does not carry any ability to read or write document content — that is entirely the previous permission's job.

**`script.external_request` — one request, to one place.**

This allows the add-on's server-side code to make an outbound HTTP call. In this codebase, the call that does so appears **exactly once**, in one function, and its destination is a visible literal in the source. It sends one equation to a collection endpoint, and only when data collection is switched on.

**`userinfo.email` — read once, to make a pseudonym.**

The email address is read at a single point in the code, on the collection path only. It is used to compute a truncated SHA-256 hash of the email plus a salt — a 16-character pseudonymous identifier. The address itself is never transmitted and never stored.

## 4. What it does not reach

Sometimes the more useful list.

| Not accessible | Why |
|---|---|
| Any other Google Docs document | `documents.currentonly` makes it impossible |
| Your Drive, your folders, your file list | no Drive permission is requested at all |
| Gmail, Calendar, Contacts, Photos | no permission for any of them |
| Spreadsheets and Slides | no permission for them |
| Deleting anything | no permission grants deletion |
| Your email address, as data | read to derive a hash; never transmitted or stored |
| Your document's title, ID, or any text outside an equation | deliberately excluded from what is sent |

On that last row: when data collection is on, what leaves the add-on for a converted equation is the LaTeX source, the rendered image, which delimiter kind it was, the anonymous hash, a timestamp, and a marker saying it came from the add-on. Not the document ID, not the document title, and no text from the document other than the equation itself.

## 5. Why each one is needed

A permission list is only meaningful next to what would break without it.

- Remove **document access** and the add-on cannot read your maths or put an image back — it has no function at all.
- Remove **interface display** and there is no menu and no sidebar to press anything in.
- Remove **the external request** and data collection stops. Nothing else changes; conversion is unaffected, because the rendering happens in the sidebar rather than on a server.
- Remove **email access** and the anonymous identifier cannot be derived, so collected samples could not be grouped per user.

A note on that third one, since it is the permission that sounds broadest: it covers **server-side** requests only. The maths rendering libraries the sidebar uses are fetched by your browser as ordinary page resources, the same way any web page loads a script, and are not covered by it.

## 6. Data collection is opt-in here

Worth stating separately, because the two LaTeXFlow products differ and the difference runs the direction people do not expect.

In the **add-on**, collection is **opt-in**. The first time you open the sidebar, a consent overlay covers it with `Decline` and `Agree`. Until you agree, the collection function returns immediately and **no outbound request is made at all** — not a reduced one, none. You can change the answer at any time from **Extensions → LatexFlow → Data Collection Settings**.

In the **web app**, collection is **opt-out**: on by default, with a setting to turn it off.

Same organisation, two different defaults, because the two are different products with different install-time friction. If you care about this, the add-on's answer is the one you give it on first open.

## 7. Revoking access later

Approving once does not lock you in, and you do this on Google's side rather than through the add-on:

1. Go to your [Google Account](https://myaccount.google.com/).
2. **Security** → **Sign in with Google** (or *Your connections to third-party apps & services*).
3. Select the app and press **Remove access**.

Documents you already converted are unaffected — the equations in them are images and stay images. Uninstalling from the Marketplace removes the add-on from your documents; revoking access withdraws the permissions.

## 8. Work and school accounts

Organisation-managed accounts sometimes have add-on installation restricted by an administrator. You will get a message pointing you at your admin rather than a consent screen. There is no way around that from your side — the alternative is the [web app](/latexflow/web/), which needs no installation and no account for the drag-and-drop route.

## 9. FAQ

**Can it see documents I had open earlier?**
No. `currentonly` grants access to the document the add-on is running in, at the time it is running. There is no history and no list of other documents.

**Does it upload my document?**
The document itself is not transmitted. If collection is on, individual equations are — the LaTeX and its rendered image, with an anonymous identifier and nothing that identifies the document. If collection is off, there is no outbound request at all.

**Why does the console show one more permission than the consent screen?**
The "name and profile picture" entry is a Google platform default that cannot be removed from the console. It is not in the manifest, the code never uses it, and it is not on the consent screen's permission list. The mismatch is normal.

**What does the add-on do if I decline data collection?**
Everything except collect data. Scanning, converting and reverting all work identically.

**Is the web app's permission set the same?**
No, it is a different product. The web app needs no account for drag-and-drop; using the Drive import button requests `drive.file`, which grants access to the single file you pick in the picker and nothing else. [That flow has its own post](/blog/en/posts/gdoc-file-wont-open-drive-import/).

## 10. Summary

- Four permissions: the current document only, drawing the interface, one outbound request, and reading the email once.
- `documents.currentonly` is a hard boundary. Other documents are not merely untouched — they are unreachable.
- No Drive access, no other Google service, no deletion, and the email is never transmitted.
- Collection is **opt-in** on the add-on, and the outbound request does not happen at all until you agree.
- The console shows one extra platform-default entry. That is expected.
- Revoke at any time from your Google Account security settings.

If you want to see what all of this is in service of before granting any of it, [the install-to-first-conversion walkthrough](/blog/en/posts/convert-latex-in-google-docs/) covers the whole path. If you have read enough, the add-on is on the [Google Workspace Marketplace](https://workspace.google.com/marketplace/app/latexflow/59137436133?flow_type=2).
