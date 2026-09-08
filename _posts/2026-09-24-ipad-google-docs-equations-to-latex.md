---
title: "How to Get Equations Out of Google Docs on an iPad"
date: 2026-09-24 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/ipad-google-docs-equations-to-latex/
categories: [LaTeXFlow, Guide]
tags: [ipad, ios, google-docs, google-drive, docx, latex, mobile]
math: false
pin: false
description: "On a desktop you download the Doc as Word and drop it in. On an iPad the Drive app hands you a PDF instead, and a PDF has no structure a converter can read. Two routes around it, in the order worth trying."
---

On a desktop this is one step. Open the Google Doc, choose *File → Download → Microsoft Word (.docx)*, drag the file onto the [web app](/latexflow/web/), done.

On an **iPad** it is not, and the reason is a single behaviour of one app: **the Google Drive app on iOS downloads a Google Doc as a PDF.** Only `.docx` can be read, so the PDF is a dead end no matter what you do with it.

There are two ways around it. Either fetch the file from inside the tool, or export it through a different Google app.

## 1. Why the desktop route fails on an iPad

The Drive app treats a Google Doc as something to be viewed, and its download produces a PDF. A PDF has no paragraph structure of the kind a `.docx` has, so there is nothing in it a converter can walk. The file will simply not load.

Note this is the Drive app's behaviour, not the tool's. Nothing on the web side chooses it, and nothing on the web side can undo it — the fix is to not go through that app.

Two other things are worth stating before you pick a route, because they save time:

- Both `.docx` drag-and-drop and the Drive picker work in mobile Safari. There is no desktop-only path here.
- The Google Docs **add-on** is a different product and is not part of either route. Editor add-ons are not available in the iOS Docs app.

## 2. Which route to pick

| | Route A — import from Drive inside the tool | Route B — export from the Docs app |
|---|---|---|
| Google sign-in | once (OAuth consent) | not needed |
| Extra app to install | none | the **Google Docs** app |
| File access granted | only the file you pick (`drive.file`) | you hand over the exported `.docx` yourself |
| Steps per conversion | one button + pick the file | open Docs app + export + drop the file |

If the OAuth consent does not bother you, **Route A** is the shortest. If you would rather avoid OAuth, or you already use the Google Docs app, **Route B** is the natural one.

On both routes the `.docx` is read in your browser and is not uploaded to us. The **LaTeX source and rendered image of each converted equation** are collected anonymously to improve conversion quality ([details](/latexflow/privacy/)).

## 3. Route A: import from Google Drive inside the tool

### 3-1. Opening the tool

Open the [web app](/latexflow/web/) in Safari (or Chrome) on the iPad.

### 3-2. Signing in

Press **Import from Google Drive** and a Google sign-in window appears. Sign in with the account that owns the document.

The tool requests the `drive.file` scope only — temporary read access to *the file you select*, and nothing else in your Drive.

If the button is greyed out for a moment after the page loads, that is Google's scripts still loading. Wait a few seconds, then refresh if it persists.

### 3-3. Choosing the file

Google's file picker opens. Select the Google Docs file you want and press select.

The tool asks Google to export it as `.docx`, receives it, and moves straight on to the equation detection screen. Nothing is downloaded to the iPad and nothing needs managing in the Files app.

## 4. Route B: export from the Docs app

The key point of this route is that you must download from **the Google Docs app, not the Google Drive app**. Drive gives you a PDF; Docs gives you a `.docx`.

### 4-1. Installing the Docs app

Install **Google Docs** from the App Store. It is a separate app from Drive.

### 4-2. Exporting to Word

Open the document in the Docs app. Tap **⋯ (More)** at the top right → **Share & export** → **Save as** or **Send a copy** → **Word (.docx)**.

### 4-3. Saving to Files and dropping it in

Save the exported `.docx` somewhere in the *Files* app — *On My iPad* is fine.

Open the [web app](/latexflow/web/) in Safari and drag the saved `.docx` onto the dotted area on the card. Tapping the dotted area to open a file chooser works just as well, and on a tablet is usually easier than dragging.

## 5. Edge cases

**I only see a .gdoc, never a .docx.**
You downloaded through the *Google Drive* app. A `.gdoc` is a cloud reference with no body in it, and the Drive app's download gives a PDF. Export again from the Google Docs app, as in Route B.

**I keep getting a PDF.**
Same cause. The Drive app only exports a Google Doc as PDF. Use Route A or Route B.

**It imported, but zero equations were found.**
Then the import worked and the document is the problem — either the maths is not wrapped in LaTeX delimiters, or it was inserted with *Insert → Equation* and is an object rather than text. Those are two different fixes: [detected 0 equations](/blog/en/posts/no-latex-delimiters-recover-document/) and [equation objects are not text](/blog/en/posts/word-equation-objects-not-text/).

**I have a PDF and nothing else.**
There is no route from here. A PDF is not a supported input, and converting one back to `.docx` reliably enough to preserve the maths is its own problem. Go back to the original Google Doc if you still have it.

## 6. Summary

- The iPad Drive app exports a Google Doc as PDF, and a PDF cannot be read. That is the whole trap.
- **Route A**: press Import from Google Drive inside the tool, sign in once, pick the file. Shortest, one OAuth consent.
- **Route B**: export as `.docx` from the *Google Docs* app — not the Drive app — save to Files, drop it in. No sign-in.
- A zero equation count after a successful import is a document problem, not an iPad problem.

A job that takes one step on a desktop takes one step more on an iPad, entirely because of how a mobile file system exposes cloud documents. Once you know which app to export from, it stops being a wall.
