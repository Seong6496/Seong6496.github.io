---
title: "수업 정리하다 깨진 수식 — Google Docs 안 LaTeX 한 번에 살리기"
date: 2026-07-13 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, google-docs, class-notes, 수업, 강의, 학생, 수식, 라플라시안, 편미분]
math: true
pin: false
description: "Google Docs 에 수업 노트 정리하다 보면 LaTeX 가 plain text 로 박혀서 발표 자료 박을 때 깨지는 경험 — LaTeXFlow Scan 의 *Import from Google Drive* 한 번으로 깔끔한 PNG 수식 박힌 docx 로 변환하는 과정을 학생 강의 노트 시나리오로 시연합니다."
---

수업 듣다가 노트 박은 후, 발표 자료 박을 때 수식 박힌 자리 깨진 경험 박은 적 있나요. Google Docs 에 *"$\nabla \cdot \vec{F}$"* 박아두면 plain text 로 박혀서 화면상 자료 시각 깨끗하지 않고, 동기들한테 공유할 때도 *"이게 뭐야?"* 박힙니다.

[LaTeXFlow Scan](/latexflow/web/) 의 **Import from Google Drive** 버튼이 그 마찰 끝내는 path 입니다. Drive 연동 → 파일 선택 → 4 step → PNG 수식 박힌 docx. 이 글에서는 실제 *벡터 미적분* 수업 노트 docx 로 시연합니다.

## 1. 문제 — Google Docs 안 LaTeX 의 시각

수업 듣다가 노트 박은 화면:

> _스크린샷 자리: Google Docs 의 plain text LaTeX 박은 시각 — `\nabla f`, `\frac{\partial f}{\partial x}` 류 박힘_
> `![Google Docs plain text LaTeX](/assets/img/posts/2026-07-13/01-google-docs-plain-text.png){: width="720" }`

발표 슬라이드 박을 때 이 docx 그대로 가져오면 수식 자리에 *백슬래시 + 중괄호* 박혀있어 보기 안 좋습니다. 발표 직전에 일일이 수식 박을 시간 없는데, 수식이 10개 넘으면 그게 또 시간 박힙니다.

## 2. 해결 — LaTeXFlow Scan 4 step

### 2-1. 도구 열기

[LaTeXFlow Scan](/latexflow/web/) 을 엽니다. 첫 화면에 **Import from Google Drive** 버튼이 박혀있습니다.

> _스크린샷 자리: LaTeXFlow Scan 첫 화면 — Drive 버튼 + drop-zone 박은 시각_
> `![LaTeXFlow Scan 첫 화면](/assets/img/posts/2026-07-13/02-latexflow-home.png){: width="720" }`

### 2-2. Drive 연동 + 파일 선택

**Import from Google Drive** 누르면 Google 계정 로그인 + scope 동의 (`drive.file` — 선택한 파일만 접근, 다른 Drive 파일에는 접근 안 함) 박힙니다. *처음 사용 시* "App isn't verified" 경고가 박힐 수 있는데, *Advanced → Continue* 박으면 됩니다.

> _스크린샷 자리: Drive Picker — 본인 Drive 안 .gdoc 파일 선택 박는 화면_
> `![Drive Picker — 파일 선택](/assets/img/posts/2026-07-13/03-drive-picker.png){: width="720" }`

### 2-3. 수식 탐지 + Review

도구가 docx 변환 + 수식 탐지 박은 후 *Review* 단계로 박힙니다. 수식 하나하나 미리보기 박혀있어서 *이건 수식 아닌데 잘못 박혀있다* 박으면 **Skip** 가능합니다.

> _스크린샷 자리: 수식 탐지 + Review 화면 — 수식 ~12개 박힌 리스트_
> `![수식 탐지 + Review](/assets/img/posts/2026-07-13/04-review.png){: width="720" }`

수업 노트 박은 시점 LaTeX 박은 자리 박혀있는 것 다 탐지 박혀있고, 본문에 우연히 박힌 `$ 100` 류 같이 수식 아닌 자리는 사용자가 직접 Skip 박을 수 있습니다.

### 2-4. PNG 변환 + 내보내기

**Render PNG · Export** 누르면 한 번에 PNG 박힌 docx 다운로드됩니다.

> _스크린샷 자리: PNG 변환 진행 표시 → 다운로드 완료 박은 화면_
> `![PNG 변환 + 다운로드](/assets/img/posts/2026-07-13/05-export.png){: width="720" }`

## 3. 결과 — PNG 수식 박힌 docx

다운로드된 docx 박은 시각:

> _스크린샷 자리: 다운로드된 docx 의 PNG 수식 박힌 시각 — 본문 + 깔끔한 PNG 수식_
> `![다운로드된 docx — PNG 수식 박힘](/assets/img/posts/2026-07-13/06-result.png){: width="720" }`

발표 자료 박을 때 그대로 쓸 수 있고, PDF 박을 때도 시각 깨끗합니다. 각 PNG 의 alt 텍스트에는 원본 LaTeX 박혀있어서 *역변환* 박을 수 있는 자료라 박혀있고, 추후 LaTeXFlow [Google Docs Add-on](https://workspace.google.com/marketplace) 으로 다시 LaTeX 박을 자리 박을 수 있는 path 보존됩니다.

## 4. 본인 docx 박으면

본인 *수업 정리 docx / 강의 노트 / 학과 발표 자료* 박으면 동일 결과입니다. [LaTeXFlow Scan](/latexflow/web/) 박힌 시점 PC / iPad 어디서나 동작합니다 — 단, iPad 의 *Google Drive 앱* 에서 .gdoc 박는 path 박을 때 PDF 박는 함정 있으니 *Import from Google Drive* 버튼 (도구 안) 박을 path 박는 게 안전합니다.

수업 노트 정리 박는 시간 박은 자리 그대로 두고, 발표 자료 박을 때 수식 박는 자리만 도구 한 번 돌리면 깔끔. 학생/대학원생 분께 닿기를 바랍니다.

---

*수식 정확히 박는 path 박은 자료 — [LaTeX 시리즈 #1~#12](/blog/categories/latex/) 박혀있습니다. align 환경 / Greek letters / 수학 기호 cheatsheet 등 정리 박힘.*
