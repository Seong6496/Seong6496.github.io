---
title: "Stage D dummy — scheduled publishing test"
date: 2026-06-16 09:00:00 +0900
categories: [Meta]
tags: [meta, test]
math: false
pin: false
published: true
description: "Dummy post for verifying future: false + daily cron rebuild. Remove once verification confirms the scheduled-publishing pipeline works."
---

This post exists only to verify that `future: false` + the daily cron rebuild correctly schedules a future-dated post.

- Expected today's local build: post **excluded** from `_site` (date is tomorrow).
- Expected after cron runs at 2026-06-16 09:00 KST: post appears in the live site.

Remove this file after verification.
