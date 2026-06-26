---
title: "수업 정리하다 깨진 수식 — Google Docs 안 LaTeX 한 번에 살리기"
date: 2026-07-13 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, google-docs, class-notes, 수업, 강의, 학생, 수식, 라플라시안, 편미분]
math: true
pin: false
description: "Google Docs 에 수업 노트 정리하다 보면 LaTeX 가 plain text 로 남아 발표 자료 만들 때 깨지는 경험 — LaTeXFlow Scan 의 Import from Google Drive 한 번으로 깔끔한 PNG 수식이 들어간 docx 로 변환하는 과정을 학생 강의 노트 시나리오로 시연합니다."
---

수업 듣다가 노트 정리한 후, 발표 자료 만들 때 수식이 깨진 경험 있나요. Google Docs 에 *"$\nabla \cdot \vec{F}$"* 라고 적어두면 plain text 로 남아 화면에서 시각이 깨끗하지 않고, 동기들에게 공유할 때도 *"이게 뭐야?"* 소리를 듣습니다.

[LaTeXFlow Scan](/latexflow/web/) 의 **Import from Google Drive** 버튼이 그 마찰을 끝내는 경로입니다. Drive 연동 → 파일 선택 → 4 step → PNG 수식이 들어간 docx. 이 글에서는 실제 *벡터 미적분* 수업 노트 docx 로 시연합니다.

## 1. 문제 — Google Docs 안 LaTeX 의 시각

수업 듣다가 정리한 화면:

![Google Docs plain text LaTeX](/assets/img/posts/2026-07-13/01-google-docs-plain-text.png){: width="720" }

발표 슬라이드 만들 때 이 docx 그대로 가져오면 수식 자리에 *백슬래시 + 중괄호* 가 남아있어 보기 안 좋습니다. 발표 직전에 일일이 수식 다듬을 시간 없는데, 수식이 10개 넘으면 그것도 시간이 걸립니다.

## 2. 해결 — LaTeXFlow Scan 4 step

### 2-1. 도구 열기

[LaTeXFlow Scan](/latexflow/web/) 을 엽니다. 첫 화면에 **Import from Google Drive** 버튼이 있습니다.

![LaTeXFlow Scan 첫 화면](/assets/img/posts/2026-07-13/02-latexflow-home.png){: width="720" }

### 2-2. Drive 연동 + 파일 선택

**Import from Google Drive** 누르면 Google 계정 로그인 + scope 동의 (`drive.file` — 선택한 파일만 접근, 다른 Drive 파일에는 접근 안 함) 가 진행됩니다. *처음 사용 시* "App isn't verified" 경고가 나올 수 있는데, *Advanced → Continue* 누르면 됩니다.

![Drive Picker — 파일 선택](/assets/img/posts/2026-07-13/03-drive-picker.png){: width="720" }

### 2-3. 수식 탐지 + Review

도구가 docx 변환과 수식 탐지를 마친 후 *Review* 단계로 진입합니다. 수식 하나하나 미리보기가 있어서 *이건 수식 아닌데 잘못 잡혔다* 싶으면 **Skip** 할 수 있습니다.

![수식 탐지 + Review](/assets/img/posts/2026-07-13/04-review.png){: width="720" }

수업 노트 정리 시점에 적어둔 LaTeX 가 전부 자동 탐지되고, 본문에 우연히 들어간 `$ 100` 같은 자리는 사용자가 직접 Skip 할 수 있습니다.

### 2-4. PNG 변환 + 내보내기

**Render PNG · Export** 누르면 한 번에 PNG 가 들어간 docx 가 다운로드됩니다.

![PNG 변환 + 다운로드](/assets/img/posts/2026-07-13/05-export.png){: width="720" }

## 3. 결과 — PNG 수식이 들어간 docx

다운로드된 docx 의 시각:

![다운로드된 docx — PNG 수식](/assets/img/posts/2026-07-13/06-result.png){: width="720" }

발표 자료 만들 때 그대로 쓸 수 있고, PDF 변환할 때도 시각이 깨끗합니다. 각 PNG 의 alt 텍스트에는 원본 LaTeX 가 보존되어 있어서 *역변환* 가능한 자료라, 추후 LaTeXFlow [Google Docs Add-on](https://workspace.google.com/marketplace) 으로 다시 LaTeX 로 되돌릴 수 있는 경로가 보존됩니다.

## 4. 본인 docx 라면

본인 *수업 정리 docx / 강의 노트 / 학과 발표 자료* 로도 같은 결과를 얻을 수 있습니다. [LaTeXFlow Scan](/latexflow/web/) 은 PC / iPad 어디서나 동작합니다 — 단, iPad 의 *Google Drive 앱* 에서 .gdoc 을 다운로드하는 경로는 PDF 로 빠지는 함정이 있으니 *Import from Google Drive* 버튼 (도구 안) 을 거치는 게 안전합니다.

수업 노트 정리하는 시간은 그대로 두고, 발표 자료 만들 때 수식 자리만 도구 한 번 돌리면 깔끔. 학생 / 대학원생 분께 닿기를 바랍니다.

---

*수식 정확히 다루는 경로 — [LaTeX 시리즈 #1~#12](/blog/categories/latex/) 가 있습니다. align 환경 / Greek letters / 수학 기호 cheatsheet 등 정리되어 있습니다.*
