---
title: "iPad 에서 Google Docs 수식을 LaTeX 로 — 다운로드 PDF 함정 우회하기"
date: 2026-08-15 08:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, google-docs, ipad, docx, 수식, 도구]
math: false
pin: false
description: "iPad Google Drive 앱은 .gdoc 을 PDF 로만 다운로드해 LaTeXFlow 가 읽지 못합니다. 도구 안 Google Drive 가져오기 버튼 (OAuth) 또는 Docs 앱의 Word(.docx) 내보내기 — 두 가지 우회 path 를 스크린샷과 함께 정리합니다."
---

[LaTeXFlow Scan](/latexflow/web/) 은 `.docx` 안의 수식을 LaTeX 코드로 뽑아 주는 도구입니다. 데스크탑에서는 Google Docs 를 *파일 → 다운로드 → Microsoft Word(.docx)* 로 받아 그대로 끌어다 놓으면 끝입니다.

문제는 **iPad** 입니다. iPad 의 *Google Drive 앱* 에서 `.gdoc` 파일을 "다운로드" 하면 **PDF 로만 내려옵니다**. LaTeXFlow 는 `.docx` 만 읽기 때문에, PDF 를 끌어다 놓으면 인식되지 않습니다.

iPad 에서 이 함정을 우회하는 방법은 두 가지입니다 — 도구 안에서 바로 가져오거나 (path A), 별도의 Google Docs 앱을 거치거나 (path C). 본인 환경에 맞는 쪽을 고르면 됩니다.

## 1. 어느 path 를 골라야 하나

| | Path A — 도구 안 Google Drive 가져오기 | Path C — Docs 앱 export |
|---|---|---|
| Google 로그인 | 한 번 (OAuth 동의) | 필요 없음 |
| 별도 앱 설치 | 없음 | **Google Docs** 앱 필요 |
| 파일 접근 범위 | 선택한 파일만 도구에 노출 (`drive.file`) | 내보낸 `.docx` 를 직접 골라 전달 |
| 매 변환 시 단계 | 버튼 한 번 + 파일 선택 | Docs 앱 진입 + 내보내기 + 끌어다 놓기 |

OAuth 동의가 거슬리지 않는다면 **path A** 가 가장 짧습니다. OAuth 를 피하고 싶거나 이미 *Google Docs 앱* 을 쓰고 있다면 **path C** 가 자연스럽습니다.

두 path 모두 `.docx` 파일 자체는 서버로 업로드되지 않고 브라우저 안에서 열립니다. 다만 변환된 **수식의 LaTeX 원문과 렌더 이미지** 는 변환 품질 개선을 위해 익명으로 수집됩니다 ([자세히](/latexflow/privacy/)).

## 2. Path A — 도구 안 Google Drive 가져오기

### 2-1. 도구 열기

iPad 의 Safari (또는 Chrome) 에서 [LaTeXFlow Scan](/latexflow/web/) 을 엽니다.

> _스크린샷 자리: 도구 첫 화면 — 업로드 카드 안에 **Import from Google Drive** 버튼이 보이는 모습_
> `![도구 첫 화면](/assets/img/posts/2026-06-25/01-latexflow-home.png){: width="720" }`

### 2-2. Import from Google Drive → 로그인

**Import from Google Drive** 버튼을 누르면 Google 로그인 창이 뜹니다. 평소 쓰는 Google 계정으로 로그인합니다.

> _스크린샷 자리: Google 계정 선택 화면_
> `![Google 계정 선택](/assets/img/posts/2026-06-25/02-google-signin.png){: width="720" }`

이 도구는 *선택한 파일만* 임시로 읽을 수 있는 권한 `drive.file` 만 요청합니다 — 다른 파일에는 접근할 수 없습니다.

### 2-3. 파일 선택

Google Drive 의 파일 선택 창이 뜹니다. 변환하려는 Google Docs 파일을 골라 **선택** 을 누르면 끝입니다.

> _스크린샷 자리: Picker 에서 .gdoc 파일 선택 모습_
> `![Drive Picker — 파일 선택](/assets/img/posts/2026-06-25/04-picker-select.png){: width="720" }`

도구가 파일을 자동으로 `.docx` 로 변환해 받아 다음 단계 *수식 탐지* 화면으로 넘어갑니다.

## 3. Path C — Docs 앱 export

OAuth 가 부담스럽거나 이미 *Google Docs* 앱이 깔려 있다면 이 path 가 짧습니다. 핵심은 **Google Drive 앱이 아니라 Google Docs 앱** 에서 다운로드해야 한다는 점입니다 — Drive 앱은 PDF 만, Docs 앱은 `.docx` 를 줍니다.

### 3-1. Google Docs 앱 설치 (없다면)

App Store 에서 **Google Docs** 를 설치합니다. (Drive 앱과는 다른 별개 앱입니다.)

> _스크린샷 자리: App Store 의 Google Docs 앱 화면_
> `![App Store — Google Docs](/assets/img/posts/2026-06-25/05-docs-appstore.png){: width="540" }`

### 3-2. Docs 앱에서 파일 열기 → 내보내기

변환할 Google Docs 파일을 Docs 앱에서 엽니다. 우측 상단 **⋯ (더보기)** → **공유 및 내보내기** → **다른 이름으로 저장** 또는 **사본 보내기** → **Word (.docx)** 를 고릅니다.

> _스크린샷 자리: Docs 앱의 ⋯ 메뉴 → 공유 및 내보내기 → Word 선택_
> `![Docs 앱 — Word 로 내보내기](/assets/img/posts/2026-06-25/06-docs-export.png){: width="540" }`

### 3-3. 파일 앱에 저장 → 도구에 끌어다 놓기

내보낸 `.docx` 파일을 *파일 (Files) 앱* 의 원하는 위치 (예: *나의 iPad*) 에 저장합니다.

Safari 에서 [LaTeXFlow Scan](/latexflow/web/) 을 열고, 카드 안 점선 영역에 방금 저장한 `.docx` 파일을 끌어다 놓습니다. (또는 점선 영역을 탭해 파일 선택 창을 열어도 됩니다.)

> _스크린샷 자리: 파일 앱에서 .docx 를 Safari 의 LaTeXFlow 화면으로 끌어다 놓는 모습_
> `![파일 끌어다 놓기](/assets/img/posts/2026-06-25/07-drag-drop.png){: width="720" }`

## 4. 이런 경우엔

**.gdoc 만 보이고 .docx 가 안 보여요.**
Google Docs 앱이 아닌 *Google Drive 앱* 에서 다운로드한 경우입니다. `.gdoc` 은 Drive 의 클라우드 참조 파일로 본문이 비어 있고, 다운로드 시 PDF 로 받아집니다. Path C 의 *Google Docs 앱* 에서 다시 내보내 주세요.

**PDF 가 받아져요.**
같은 원인입니다 — Drive 앱은 Google Docs 를 PDF 로만 export 합니다. Path A (도구 안 Picker) 또는 Path C (Docs 앱) 둘 중 하나가 필요합니다.

**Picker 에서 파일이 안 보여요.**
Picker 는 본인 계정의 Drive 안 파일만 보여 줍니다. 다른 계정으로 공유받은 파일이라면 그 계정으로 로그인하거나, 본인 Drive 에 복사한 뒤 선택해 주세요.

---

데스크탑에서는 한 단계로 끝나는 작업이 iPad 에서는 한 단계 더 들어가야 하는 — 모바일 OS 의 파일 시스템 제약이 만든 작은 함정입니다. 이 가이드가 같은 벽에 부딪힌 분께 닿기를 바랍니다.
