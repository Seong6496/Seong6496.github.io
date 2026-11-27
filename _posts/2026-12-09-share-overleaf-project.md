---
title: "How to Share an Overleaf Project: Invites, Links and Roles"
date: 2026-12-09 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/share-overleaf-project/
categories: [LaTeX, Tutorial]
tags: [overleaf, latex, collaboration, sharing, co-author, word, docx]
math: false
pin: false
description: "Invite co-authors by email as Viewer, Reviewer or Editor, or share one link; how many collaborators the free plan allows, how to hand over a project, and what to do when a co-author cannot edit or does not use LaTeX."
---

<!-- Sources (all read 2026-11-27): docs.overleaf.com/collaborating/sharing-a-project, /collaborating/reviewing-and-reviewers, /collaborating/request-access, /collaborating/transferring-project-ownership, /getting-started/free-and-premium-plans/premium-features, /getting-started/free-and-premium-plans/plan-limits, /managing-projects-and-files/downloading-a-project, overleaf.com/user/subscription/plans. Not confirmed on any Overleaf page: whether a link opener must sign in (written as a condition, not a fact); no "limit reached" error wording quoted. Converter facts = R260 prelaunch build (12-01): PNG / JPG figures inserted, PDF / EPS placeholders; first 3 pages + report free. No screenshots: no logged-in Overleaf session for our own project. No competitor names, no prices. -->

Overleaf has two ways to let someone into a project: an invitation to their email address, or a link. Both start from the **Share** button at the top right of the editor, and both ask one question: what may this person do?

## 1. Pick a role

Overleaf has three roles today:

| Role | Can do | Cannot do |
|---|---|---|
| **Viewer** | Read the source, download the source and the PDF, copy the project, read comments | Comment, suggest or edit |
| **Reviewer** | Everything a Viewer can, plus write comments and suggest edits (tracked changes) | Edit the source directly, add files, accept or reject changes |
| **Editor** | Everything: edit, add files, accept or reject changes, restore versions | — |

A supervisor who should comment but not touch the text is a **Reviewer**. A co-author who writes sections is an **Editor**. Someone who only needs to read is a **Viewer**.

## 2. Invite someone by email

1. Click **Share** at the top right.
2. Type their email address, choose the role, and click **Invite**.
3. They get an email and accept the invitation from their Overleaf account.

Until they accept, the invitation shows as *Pending invite* under **Manage access**. That is also where you change someone's role, resend an invitation or remove someone.

## 3. Share a link instead

1. Click **Share**.
2. Change **Only invited people** to **Anyone with the link**.
3. Choose the link's role. It is **Viewer** unless you change it.
4. Click **Copy sharing link** and send it.

A few things are different from an invitation:

- Anyone who has the link gets that role, so do not post an edit link anywhere public.
- People who joined through the link do not appear under **Manage access**. To change what they can do, you change the link's role, and everyone who joined through it changes with it.
- The link does not expire. To close it, switch back to **Only invited people**. People who came in through the link lose access; people you invited by email keep theirs.

Older projects may still have the earlier pair of view and edit links. They keep working, and Overleaf offers to replace them with the single link above. The switch is permanent.

## 4. How many co-authors the free plan allows

On the free plan, each project can have **1 collaborator**, an Editor or a Reviewer, and any number of Viewers. The limit is per project, so a different person can edit each of your projects. Paid plans allow more (10, or unlimited, on Overleaf's plans page as of November 2026).

So on the free plan, two co-authors cannot both be Editors (or an Editor and a Reviewer) on the same project. What fits: one Editor, and everyone else a Viewer who sends comments another way.

## 5. Hand the project to someone else

Only the owner can transfer a project, and the new owner must already be a collaborator.

1. Click **Share**.
2. Next to that person, open their role and choose **Make owner**.
3. Confirm with **Change owner**.

The change is immediate. If the new owner is on the free plan, every collaborator becomes a Viewer and the new owner can give edit access to one person again.

## 6. When it does not work

**"My co-author can't edit."** They are most likely a Viewer or a Reviewer. A Reviewer can only comment and suggest; switching to Editing is not open to them. They can use **request access** in the project, which sends you an email and a badge on **Share**, or you can change their role under **Manage access**. If you recently transferred the project or changed plans, everyone may have been moved to Viewer.

**"The invitation never arrived."** Check the address, look in the spam folder, then click **Resend** under **Manage access**.

**"The link takes them to a sign-in page."** Joining a project happens in an Overleaf account. If they would rather not sign in, send them a PDF or a Word file instead (section 7).

**"I can't invite another editor."** On the free plan the project already has its one collaborator. Make the new person a Viewer, or change who holds the collaborator place.

## 7. Share a file instead of the project

Not every reader needs the project.

- **A PDF** — **File → Download → Download as PDF**, or the download icon next to **Recompile**.
- **The source** — **File → Download → Download as source (.zip)**. [Download Your Overleaf Project as One .zip for Word](/blog/en/posts/overleaf-project-zip-for-word/) shows what is in it.

### For a co-author who does not use LaTeX

Some co-authors want to read and mark up the paper in Word. Drop the source `.zip` into the [LaTeX to Word converter](/latexflow/tex-to-docx/?utm_source=blog&utm_medium=post&utm_campaign=share-overleaf-project) and send them the `.docx`. Equations come out as Word equations they can edit, citations and cross-references carry over, and PNG and JPG figures are placed. PDF and EPS figures are placeholders in this version. The report lists everything that did not carry over.

The full report and the first 3 pages are free, so you can check how your paper comes out before you send anything. Their edits come back to you as a Word file; you copy the changes into Overleaf yourself.

## 8. Summary

1. **Share** → email → role → **Invite** for named co-authors.
2. **Anyone with the link** plus a role for a quick share; **Only invited people** to close it.
3. Free plan: one Editor or Reviewer per project, unlimited Viewers.
4. A co-author without LaTeX can get a PDF to read or a Word file to mark up.
