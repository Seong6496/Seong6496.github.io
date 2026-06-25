---
title: "AI 챗봇이 뱉은 [수식] 박힌 답변, docx 에 깔끔하게 살리기 — bracket-mode 시연"
date: 2026-07-17 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, ai-chatbot, chatgpt, gemini, perplexity, bracket-mode, markdown, 수식]
math: true
pin: false
description: "Gemini/Perplexity/ChatGPT 답변의 LaTeX 수식이 markdown 렌더링 때문에 [ ... ] 박힌 plain text 로 복붙되는 함정 — LaTeXFlow Scan 의 bracket-mode 한 번에 PNG 박힌 docx 박는 path 시연. 챗봇 사용자 일반 대응."
---

AI 챗봇한테 *"이 통계 결과 정리해줘"* 박으면 답변에 LaTeX 수식 박혀 나오는데, 그 답변을 docx 에 복붙 박으면 수식이 *"`[E(X) = \sum x_i p_i]`"* 처럼 박혀 옵니다. *"이거 왜 plain text 박혀있지?"* 박은 적 있나요.

원인은 **markdown 렌더링** 입니다. Gemini/Perplexity/ChatGPT 같은 챗봇이 답변 박을 때 LaTeX 박은 자리 `\[ ... \]` 박는데, 화면상 markdown 렌더링 박을 때 백슬래시 박은 자리 사라져서 `[ ... ]` 박힙니다. 복붙 박으면 그 *"백슬래시 박은 자리 사라진 plain text"* 그대로 docx 에 박힙니다.

[LaTeXFlow Scan](/latexflow/web/) 의 **bracket-mode** 가 그 함정 박는 path 입니다. 도구 첫 화면의 체크박스 하나 박으면 `[\frac{...}{...}]` 류 박힌 자리도 LaTeX 박은 자료로 박혀있다고 판단해서 PNG 박은 자료 박혀있는 docx 박힙니다. 이 글에서는 Gemini 답변 시나리오로 시연합니다.

## 1. 문제 — markdown 렌더링 함정

### 1-1. 챗봇 답변에 LaTeX 박힌 자리 — 화면상 시각

Gemini 한테 *"확률 분포의 평균/분산 정리해줘"* 박은 후 박은 답변 화면:

> _스크린샷 자리: Gemini 답변 박은 원본 화면 — LaTeX 수식 markdown 렌더링 박힌 시각_
> `![Gemini 답변 — markdown 렌더링](/assets/img/posts/2026-07-17/01-gemini-response.png){: width="720" }`

화면상 시각: 수식 박힌 자리 깔끔한 LaTeX 렌더링.

### 1-2. 복붙 박으면 — bracket 박힌 plain text

근데 그 답변 복사 박은 후 docx 에 복붙 박으면:

> _스크린샷 자리: docx 에 복붙 박은 시각 — `[E(X) = \sum x_i p_i]` `[Var(X) = E(X^2) - E(X)^2]` 류 박힘_
> `![docx 복붙 결과 — bracket 박힌 plain text](/assets/img/posts/2026-07-17/02-pasted-docx.png){: width="720" }`

원래 챗봇이 박은 자료는 `\[E(X) = \sum x_i p_i\]` 인데 markdown 렌더링 박을 때 백슬래시 박은 자리 사라져서 `[E(X) = \sum x_i p_i]` 박혀있습니다. 표준 LaTeX 의 `$...$` `$$...$$` `\(...\)` `\[...\]` 박은 patterns 박은 도구 박은 자리 이 *백슬래시 빠진 bracket* 매칭 박히지 않습니다.

이게 ChatGPT 외 다양한 챗봇 (Gemini / Perplexity / Claude) 박힌 공통 함정 입니다 — markdown 렌더링 박은 자리 동일한 path 박혀있어 동일 결과 박힙니다.

## 2. 해결 — bracket-mode

### 2-1. 도구 첫 화면 — bracket option 체크박스

[LaTeXFlow Scan](/latexflow/web/) 의 첫 화면 박은 자리에 박힌 체크박스:

> _스크린샷 자리: 도구 첫 화면 — bracket-mode 체크박스 강조 박은 시각_
> `![LaTeXFlow Scan — bracket-mode 체크박스](/assets/img/posts/2026-07-17/03-bracket-mode-option.png){: width="720" }`

기본값으로 ON 박혀있습니다 (*"Also detect bracket [\\...] equations (common in AI chatbot output)"*). 즉 챗봇 답변 docx 박는 사용자는 따로 박을 자리 없이 자동 동작.

### 2-2. 복붙 docx 끌어다 놓음 + 탐지

bracket 박힌 docx 끌어다 놓으면:

> _스크린샷 자리: 수식 탐지 결과 — bracket 박힌 수식 박힌 리스트_
> `![수식 탐지 — bracket 박힌 수식](/assets/img/posts/2026-07-17/04-detection.png){: width="720" }`

`[E(X) = \sum x_i p_i]` 박은 자리 *bracket-mode heuristic* 박혀 자동 탐지. 박은 heuristic = *"bracket 안에 LaTeX 시그니처 (`\` `^` `_` `=` 박힌 자리) 박힌 자리만 수식 박은 자료"*. 본문의 일반 산문 `[참고]` `[1]` `[표 1]` 박힌 자리는 시그니처 0 박혀있어 매칭 안 박힘. 즉 *수식 아닌 박은 산문 bracket* 박은 자리 매칭 박힘 0.

### 2-3. PNG 변환

> _스크린샷 자리: 변환된 docx 의 PNG 수식 박힌 시각_
> `![변환 결과 — PNG 수식](/assets/img/posts/2026-07-17/05-result.png){: width="720" }`

bracket 박힌 자리가 PNG 박힌 자료로 박힘. 본문 그대로 보존.

## 3. 챗봇 일반 대응

bracket-mode 박힌 시점 — Gemini / Perplexity / ChatGPT / Claude 박은 어느 챗봇 답변도 동일 path 박혀있어 동일 결과 박힙니다. 즉 도구의 *bracket-mode = markdown 렌더링 챗봇 답변 일반 대응 path*.

본인이 *"AI 챗봇한테 정리 박은 후 docx 박을 path 박는다"* 면 [LaTeXFlow Scan](/latexflow/web/) 박힌 시점 자동 대응 박힙니다 — bracket-mode 기본값 ON 박혀있고, 챗봇 답변 docx 박은 사용자는 다른 박을 자리 없이 그대로 끌어다 놓으면 됩니다.

---

*수식 정확히 박는 path 박은 자료 — [LaTeX 시리즈 #1~#12](/blog/categories/latex/) 박혀있습니다. align 환경 / 그리스 문자 / 행렬 / cases 정리 박힘.*
