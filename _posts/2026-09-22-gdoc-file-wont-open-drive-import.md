---
title: "Your .gdoc File Will Not Open: Why, and the Drive Import Path Around It"
date: 2026-09-22 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/gdoc-file-wont-open-drive-import/
categories: [LaTeXFlow, Troubleshooting]
tags: [google-drive, google-docs, gdoc, docx, picker, oauth, troubleshooting]
math: false
pin: false
description: "Download a Google Doc and you get a one-kilobyte file no tool will open, because a .gdoc is a pointer rather than a document. What the Import from Google Drive button does, which permission it uses, and which of the formats in the picker are actually readable."
---

You wanted to convert the maths notes you wrote in Google Docs, so you downloaded the file. What arrived looks like this:

```
calculus_notes.gdoc      1 KB
```

The document has dozens of equations in it and the file is one kilobyte. Drag it onto a conversion tool and nothing happens.

The file is not corrupt. **A `.gdoc` was never a document in the first place** — it is a pointer. The way around it is the *Import from Google Drive* button, which fetches the real content from Google instead. Both halves are below.

## 1. A .gdoc is an address, not a document

A Google Docs document lives on Google's servers. The `.gdoc` file on your computer is **a short link fragment pointing at it**. It holds a document ID and an address to open, and that is all — no body text, no equations. That is why it is about a kilobyte.

Double-click it and a browser opens on the original document. You did not open a file; you followed a link.

So a `.docx`-only tool has nothing to work with: it looks inside for the document structure it needs and finds a link. The file input only accepts `.docx`, and the drop zone says as much — *Drop a .docx file here* / *For Google Docs, use the Import from Google Drive button above*.

## 2. What the import button does

Press **Import from Google Drive** at the top of the upload card and three things happen.

**① Google sign-in.** The step that grants access to a file.

**② The file picker.** Google's own file chooser opens. Its title is *"LaTeXFlow — Choose a Google Doc or .docx file"*. Pick the document you want.

**③ Conversion and scan.** If you picked a Google Docs document, the tool asks Google to **export it as `.docx`** and receives the result. If you picked a `.docx`, it downloads it as-is. The button label briefly becomes `Downloading…`, the status line reads `Fetching "<name>"…`, and as soon as it arrives you land on the usual equation detection screen.

Your part is two actions: press the button, pick the file. The download, the format conversion and the re-upload are handled in one go. From the moment the file arrives, this route and the drag-and-drop route are identical.

The fetched file is read in your browser and is not uploaded to us. The **LaTeX source and rendered image of each converted equation** are collected anonymously to improve recognition quality ([details](/latexflow/privacy/)).

## 3. Which permission it uses

Drive import requests exactly one scope: `drive.file`. As the name says, it is **per-file**.

| | Scope |
|---|---|
| What the tool can see | **the one file you picked** in the picker |
| What the tool cannot see | the rest of your Drive, your folder list, any other document |

Browsing folders and scanning your file list happens inside **a window Google puts up**. The tool cannot look into that window; it receives only the single file you pressed select on.

Sign-in is required only for this button. The drag-and-drop route needs no account at all.

## 4. What the consent screen is asking

Google's consent screen appears when you use the button. Two things are worth checking.

**① Which app is it.** The app name and logo are shown at the top. The app has been through Google's review, so there is no *"unverified app"* warning screen. If you do see one, you are on a different site — check the address.

**② What are you allowing.** The request is a single line of per-file access. There is no item for seeing all of Drive and none for deleting files. If the list is longer than that, the screen is not this tool's.

### 4-1. Revoking it later

You can withdraw access at any time, from Google's side rather than through the tool:

1. Go to your [Google Account](https://myaccount.google.com/).
2. Open **Security** → **Sign in with Google** (or *Your connections to third-party apps & services*).
3. Select the app in the list and press **Remove access**.

Revoking has no effect on conversions you already ran or files you already downloaded. And the drag-and-drop route keeps working regardless — it has nothing to do with your account.

### 4-2. Work and school accounts

Organisation-managed accounts sometimes have third-party app connections blocked by an administrator. In that case you get a message telling you to contact your admin instead of a consent screen. If waiting for approval is impractical, save a copy of the document to a personal Drive, or use the export route in section 8.

## 5. What the picker shows versus what is readable

Four formats appear in the picker list.

| Format | In the picker | Readable |
|---|---|---|
| Google Docs document | ✅ | ✅ exported to `.docx` and read |
| `.docx` | ✅ | ✅ read directly |
| `.odt` (OpenDocument) | ✅ | ❌ |
| `.rtf` | ✅ | ❌ |

The last two appear but cannot be read. Pick one and the download completes, then the analysis step fails with an error. Only the `.docx` structure can be opened.

There is a small quirk worth knowing if you hit this. The downloaded file gets `.docx` appended to its name when it does not already end in it, so `notes.odt` becomes `notes.odt.docx` and passes the extension check. The failure therefore does not show up as *"unsupported format"* at the door — it lands later, in the analysis step.

To convert an `.odt` or `.rtf`, take one extra step:

- **Open it as a Google Docs document** in Drive and save. Then pick it in the picker.
- Or open it in Word or LibreOffice and **Save As → Word Document (.docx)**.

Folders are shown in the list too, so a file tucked inside a folder can be reached by opening it.

Spreadsheets and slides are not offered — the picker is limited to document formats.

## 6. When the button is greyed out

The button only becomes active once both of Google's scripts — one for sign-in, one for the picker — have loaded. So it can look grey for a moment right after you open the page.

- **Wait a few seconds.** This is usually all it takes.
- Still grey → **refresh**.
- Still grey after that → an ad blocker or extension may be blocking Google's scripts. Turn it off for this page, or use the drag-and-drop route below.

Pressing the button before it is ready shows `Waiting for Google libraries to load…`, which just means try again shortly.

## 7. Common snags

**Import failed.**
Something went wrong fetching the file: no permission on the document, the document was deleted or moved, or the network dropped. The message includes the status code Google returned, which is what to go on.

**The downloaded file has .docx on the end of its name.**
That is normal. A Google Docs document has no extension, so `.docx` is appended when naming the export. The original file in Drive is unchanged.

**I want to save the result back to Drive.**
Not supported. Results come out as a download. The `drive.file` scope does allow writing to files the tool itself created, but the current flow only reads. Upload the downloaded `.docx` to Drive yourself.

**The picker window opens and closes immediately.**
Almost always a blocked popup. Allow popups for the site from the icon in the address bar and try again.

## 8. Doing it without the button

On a desktop, exporting from inside Docs is a short path too.

1. Open the document in Google Docs.
2. Choose **File → Download → Microsoft Word (.docx)**.
3. Drag the downloaded `.docx` onto the tool's dotted area.

No sign-in, no consent screen. For a single one-off document this can be quicker.

| | Drive import | Export from Docs |
|---|---|---|
| Google sign-in | required | not required (you are already signed in to Docs) |
| Steps per conversion | button → pick file | 3 menu steps → drag and drop |
| With several files | better — one button press each | repeat the export per document |
| Downloaded file clutter | none | accumulates in your downloads folder |

Converting several documents in a row favours the button; converting one favours the export.

## 9. What to check after import

Once the file is in, everything is the same as if you had dragged it. This line appears at the top:

```
Scanned 62 paragraphs · 48 equations found
```

If the equation count is zero, the import did not fail — the problem is in the document. It will be one of two things:

- The maths is not wrapped in LaTeX delimiters → [detected 0 equations](/blog/en/posts/no-latex-delimiters-recover-document/)
- The equations are objects inserted with *Insert → Equation* → [equation objects are not text](/blog/en/posts/word-equation-objects-not-text/)

For documents arriving from Google Docs the second is especially common. An equation built with the Docs equation tool stays an object when exported to `.docx`, and there is nowhere to attach a delimiter.

## 10. FAQ

**Does converting change the original Google Docs document?**
No. The tool only reads the document, and the result comes out as a **new `.docx`** download. The original in Drive is untouched.

**How do I convert several documents in a row?**
After downloading a result, press **Start Over** at the top to return to the first screen, then import the next one.

**What about spreadsheets and slides?**
The picker is restricted to document formats, so they do not appear. Move the content into a Docs document first.

**How is this different from the add-on?**
The Google Docs add-on (*Extensions → LatexFlow → Open Equation Panel*) changes equations **inside the document while it is open**, with no file changing hands. The web app takes a file, converts it and hands back a new `.docx` — which is what you want when the original should stay as it is and the result should be a separate artefact.

## 11. Summary

- A `.gdoc` is a link fragment, not a document, so downloading and dropping it gives a tool nothing to read.
- **Import from Google Drive** handles sign-in, file selection and `.docx` conversion in one press.
- The permission is `drive.file` — only **the one file you pick** is handed over. The drag-and-drop route needs no account at all.
- `.odt` and `.rtf` appear in the picker but are not readable. Open them as a Docs document, or re-save as `.docx`.
- Import succeeded but zero equations means missing delimiters or equation objects, not a failed import.

Most of the confusion starts with Google Docs looking like a file when it is not one. Once that boundary is clear, it gets much easier to see which screen is blocking you and why.
