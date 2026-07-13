---
title: "$ 하나 빠뜨렸는데 컴파일 실패 — LaTeXFlow Ambiguity 카드로 미리 잡기"
date: 2026-07-19 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, docx, latex, 컴파일에러, unclosed-dollar, ambiguity, 수식, 논문, 대학원생]
math: true
pin: false
description: "논문 마감 직전 pdflatex 이 뱉는 'Missing $ inserted' 에러 — `$` 한 짝이 어긋난 자리를 line number 만으로 찾기 힘든 마찰을, LaTeXFlow Scan 의 Ambiguity 카드가 파싱 이전에 시각적으로 잡아주는 path 시연. Edit text 로 문단 안에서 바로 고치고, 라이브 프리뷰로 Save 전에 확인하는 흐름."
---

논문 컴파일 직전, `pdflatex` 이 *"! Missing $ inserted."* 를 뱉으면서 line 137 을 가리킵니다. 그 line 을 열어봐도 `$` 개수는 맞아 보이는데, 실제 어긋난 자리는 그 위 어딘가입니다. 마감이 몇 시간 남지 않은 상황에서 문단을 하나하나 되짚어야 합니다.

원인은 대체로 단순합니다. inline 수식 하나에 닫는 `$` 를 빠뜨렸거나, `$$...$$` display 블록 한쪽이 잘못 지워진 자리입니다. 문제는 컴파일러가 그걸 *"어디서 안 닫혔는지"* 가 아니라 *"어디서 이상해졌는지"* 만 알려준다는 점입니다.

[LaTeXFlow Scan](/latexflow/web/) 의 **Ambiguity 카드** 는 그 자리를 파싱 이전에 잡습니다. docx 를 올리면 `$` 개수가 홀수인 문단에 노란 warning 카드가 붙고, **Edit text** 로 문단 안에서 바로 고치면서 라이브 프리뷰로 확인할 수 있습니다. 이 글에서는 그 흐름을 시연합니다.

## 1. 문제 — unclosed `$` 는 왜 잡기 어려운가

LaTeX 컴파일 에러는 아래처럼 뜹니다.

```
! Missing $ inserted.
<inserted text>
                $
l.137 be positive.
```

line 137 은 *에러가 감지된 자리* 이지 *에러가 시작된 자리* 가 아닙니다. `$` 를 하나 빼먹으면 그 뒤 본문 전체가 수식 모드로 해석되다가 다음 `$` 를 만나서야 균형이 맞고, 그 사이 어딘가에서 처음으로 파서가 튕겨나가는 자리에 에러가 붙습니다. 즉 *진짜 원인 문단* 은 line 137 이 아니라 그보다 훨씬 위에 있을 수 있습니다.

에디터의 syntax highlighting 도 `$` 는 잘 안 잡습니다. `$` 는 여닫이가 같은 문자라서, 하나가 빠지면 뒷부분 전체 색이 뒤집힐 뿐 *어느 짝이 어긋났는지* 는 알려주지 않습니다. 결국 눈으로 `$` 를 세거나, 문단 하나하나에 `$` 를 카운트하는 손이 필요합니다. 수식이 많은 논문일수록 그 시간이 늘어납니다.

## 2. 해결 — LaTeXFlow Ambiguity 카드

### 2-1. 도구 열기

[LaTeXFlow Scan](/latexflow/web/) 을 엽니다. 첫 화면에 dropzone 이 있습니다.

![LaTeXFlow Scan 첫 화면 — dropzone + bracket-mode 체크박스](/assets/img/posts/2026-07-19/01-latexflow-scan-landing.png){: width="720" }

*Nothing leaves your browser* — docx 는 브라우저 안에서만 파싱되며, 서버로 업로드되지 않습니다.

### 2-2. docx 올리면 Ambiguity 카드 자동 감지

docx 를 dropzone 에 끌어다 놓으면 도구가 문단을 훑어 수식을 탐지합니다. 그 과정에서 `$` 개수가 홀수인 문단이 발견되면 노란 **Ambiguity 카드** 로 먼저 표시됩니다.

![Ambiguity 카드 2개 — Odd number of $ + Likely a missed closing $](/assets/img/posts/2026-07-19/02-ambiguity-warning-cards.png){: width="720" }

상단 헤더에 *Selected 5 · Skipped 0 · Unresolved ambiguity 2* 가 보입니다. 즉 5개 수식은 자동 탐지되었고, 2개 문단은 `$` 짝이 안 맞아서 *경계를 확정할 수 없다* 는 상태입니다.

각 카드에는 문단 원문이 그대로 보입니다.

- **문단 3**: `3) Let $\alph + 1 be positive.` — `$` 하나만 있고 뒤가 안 닫힘
- **문단 6**: `6) The formulas $\int e^x\, dx = e^x + C$ and $\lim_{n \to \infty} (1 + 1/n)^n = e$ hold but $a + b = c fails without closure.` — 세 번째 `$` 가 안 닫힘

`pdflatex` 이라면 line number 하나만 던지고 끝이지만, LaTeXFlow 는 *어느 문단에서 짝이 어긋났는지* 를 문단 원문과 함께 보여줍니다.

### 2-3. Edit text 로 문단 안에서 바로 고치기

카드 우측 **Edit text** 를 누르면 textarea 가 열려 문단을 바로 편집할 수 있습니다.

![Edit text 열림 — textarea 안 문단 편집 + 라이브 프리뷰](/assets/img/posts/2026-07-19/03-edit-text-open.png){: width="720" }

textarea 아래 *"Detected: 0 equations · still ambiguous"* 라이브 프리뷰가 붙어있습니다. 편집 중에 `$` 를 하나 추가하면 이 프리뷰가 실시간으로 바뀌어, *어디서 짝이 맞춰지는지* 를 Save 전에 확인할 수 있습니다.

문단 상단에 안내가 있습니다 — *"Editing will remove any formatting (bold, italic, colors) from this entire paragraph. Fix the LaTeX or add the missing `$` delimiter, then Save."* 즉 문단 전체 서식이 plain text 로 flatten 됨을 미리 알려줍니다.

### 2-4. 닫는 `$` 추가 → Save → 카운트 변화

`3) Let $\alph + 1 be positive.` 를 `3) Let $\alph + 1$ be positive.` 로 고치고 Save 를 누르면 헤더 카운트가 바뀝니다.

![Save 후 — Selected 6 · Unresolved 1](/assets/img/posts/2026-07-19/04-selected-6-unresolved-1.png){: width="720" }

*Selected 5 → 6*, *Unresolved 2 → 1*. 문단 3 의 ambig 가 해결되어 새 수식 `$\alph + 1$` 이 Detected Equations 리스트에 편입되었고, 문단 6 만 남았습니다. 남은 문단 6 도 같은 방식으로 세 번째 `$` 를 닫아주면 됩니다.

## 3. 결과 — 모든 ambig 해결 후 Render PNG · Export

두 문단을 다 고치고 나면 헤더가 *Selected 9 · Skipped 0 · Unresolved ambiguity 0* 이 됩니다.

![모든 ambig 해결 완료 — Render PNG · Export 준비](/assets/img/posts/2026-07-19/05-all-clean-render-ready.png){: width="720" }

Ambiguity 카드가 사라지고 Detected Equations 리스트만 남습니다. 상단 우측 **Render PNG · Export** 를 누르면 한 번에 PNG 수식이 들어간 docx 가 다운로드되고, OS 가 Word 를 자동으로 띄웁니다.

이 시점에서는 *`pdflatex` 을 돌리기 전에* 이미 `$` 짝이 맞는 게 확인된 상태입니다. 즉 컴파일 에러의 pain point 를 파싱 이전에 잡은 셈입니다.

## 4. 본인 docx 라면

`.docx` 에 LaTeX plain text 를 섞어 쓰는 workflow 라면 아래 자리에서 도움이 됩니다.

- **학회 submission 직전 최종 점검** — 논문 초안 전체의 `$` 짝을 육안으로 세는 대신 도구 한 번에 확인
- **학위 논문 최종 원고** — 챕터별로 넣은 수식 수백 개 중 어긋난 짝이 어느 문단인지 특정
- **협업 문서** — 여러 사람이 나눠 쓴 docx 를 합쳤을 때 짝이 어긋난 자리 정리

[LaTeXFlow Scan](/latexflow/web/) 은 브라우저 안에서만 동작하며, docx 는 서버로 올라가지 않습니다. PC / Mac / iPad 어디서나 열립니다. Ambiguity 카드가 뜨지 않는다면 이미 짝이 맞는 상태이니, 그대로 Render PNG · Export 로 넘어가면 됩니다.

컴파일 에러 메시지를 되짚는 시간을 줄이고, docx 안에서 눈으로 확인 → 편집 → PNG 로 완결하는 path 를 제안합니다.

---

*수식 정확히 다루는 경로 — [LaTeX 시리즈 #1~#12](/blog/categories/latex/) 가 있습니다. align 환경 / 수학 기호 cheatsheet / 그리스 문자 정리 등이 있어, 어긋난 `$` 를 고치는 시점에 함께 참고하실 수 있습니다.*
