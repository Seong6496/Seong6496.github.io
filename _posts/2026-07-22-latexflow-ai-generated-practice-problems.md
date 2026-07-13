---
title: "챗봇에게 '연습 문제 20개 만들어줘' 시킨 답변 — docx 에 붙이면 raw LaTeX 로 박힌다"
date: 2026-07-22 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, chatgpt, claude-ai, gemini, ai-chatbot, docx, 자습, 시험대비, 연습문제, 대량처리, 수식]
math: true
pin: false
description: "AI 챗봇에게 시험 대비 연습 문제 20개 만들어달라고 시키면 답변 안 수식이 raw LaTeX 로 옴. docx 에 정리하려니 raw text 그대로 박히는 pain point — LaTeXFlow Scan drag-drop 한 번으로 시각적으로 완성된 자습 자료로 변환하는 workflow 를 학생 · 독학러 시나리오로 시연합니다."
---

시험 대비하다가 ChatGPT · Claude · Gemini 같은 챗봇에게 *"무한급수 판정법 연습 문제 20개 만들어줘"* 시켜 본 적 있나요. 답변 화면에서는 수식이 예쁘게 렌더링돼 나와서 그대로 복사해 docx 에 붙였는데, 열어 보면 `$\sum_{n=1}^{\infty} \frac{1}{n^{\sqrt{2}}}$` 같은 raw LaTeX 가 그대로 박혀 있습니다. 문항 20개면 수식 100개가 넘고, Word 의 *수식 삽입* 편집기로 하나씩 다시 그리려면 자습할 시간을 다 태워 버립니다.

[LaTeXFlow Scan](/latexflow/web/) 의 **drag-drop 경로** 가 그 마찰을 끊어 냅니다. 챗봇 답변은 그대로 복붙해서 docx 에 담아 두고, 다 담은 후 도구에 한 번만 끌어다 놓으면 100개 넘는 수식이 전부 PNG 로 변환된 docx 가 다운로드됩니다. 이 글에서는 실제 *무한급수 판정법 연습 문제 챗봇 답변* (판정법 8개, `$` inline 수식 100+ 개) docx 로 시연합니다.

> 참고: 챗봇 답변이 `\[…\]` 나 `[…]` 로 박히는 markdown 렌더링 특수 케이스 (Gemini · Perplexity 등) 는 [AI 챗봇이 뱉은 [수식] 박힌 답변, docx 에 깔끔하게 살리기 — bracket-mode 시연](/blog/posts/latexflow-ai-chatbot-bracket-mode/) 에서 다뤘습니다. 이 글은 답변이 typical `$...$` 로 정상적으로 온 대량 케이스입니다.

## 1. 문제 — 챗봇 답변을 docx 에 붙인 실제 시각

챗봇에게 *"무한급수 판정법 유형별로 각 5문제씩, 총 40문제 만들어줘. 수식은 `$...$` LaTeX 로 감싸줘"* 시킨 후 답변을 그대로 docx 에 복붙한 화면입니다.

![챗봇 답변 붙여넣은 docx — p-Series Test 섹션](/assets/img/posts/2026-07-22/01-raw-docx-p-series.png){: width="720" }

챗봇은 유형별로 카테고리를 나눠서 예쁘게 정리해 줬는데, 문제 자리에는 `$\sum_{n=1}^{\infty} \frac{1}{n^{\sqrt{2}}}$` 같은 raw text 가 그대로 박혀 있습니다. 챗봇 프롬프트에 익숙해도 이 상태로는 인쇄해서 카페에서 풀거나 태블릿으로 오프라인 자습하기가 불편합니다.

*Ratio & Root Test* 섹션까지 스크롤하면 밀도가 더 높아집니다.

![챗봇 답변 붙여넣은 docx — Ratio & Root Test 섹션](/assets/img/posts/2026-07-22/02-raw-docx-ratio-root.png){: width="720" }

`$\sum_{n=1}^{\infty} \left(\frac{2n+3}{3n+2}\right)^n$` 같은 식이 한 페이지에 여러 줄. 문항 하나에 수식 2~3개씩 잡히면 40문항 = 100+ 수식. 이걸 Word 편집기로 하나하나 다시 그리려면 식당 30초씩만 잡아도 50분 이상. 자습 시작도 못 하고 시간이 다 갑니다.

## 2. 해결 — LaTeXFlow Scan 의 drag-drop 4 step

### 2-1. 도구 열기

[LaTeXFlow Scan](/latexflow/web/) 을 열면 첫 화면에 dropzone 이 있습니다.

![LaTeXFlow Scan 첫 화면 — dropzone](/assets/img/posts/2026-07-22/03-latexflow-dropzone.png){: width="720" }

*"Drop a .docx file here"* 자리에 챗봇 답변을 담아 둔 docx 를 그대로 끌어다 놓습니다. 브라우저 안에서만 처리되며 (`Nothing leaves your browser`), 챗봇 답변에 개인 학습 진도나 오답 히스토리가 함께 있어도 파일이 서버로 올라가지 않습니다.

### 2-2. 수식 자동 탐지

drop 하면 도구가 docx 본문을 훑어 `$...$` inline 수식을 전부 자동으로 뽑아 냅니다. *Detected Equations* 리스트에 수식 하나하나 카드로 나열되고, 각 카드에 *rendered preview*, *raw LaTeX*, *본문 context* 가 함께 표시됩니다.

![Detected Equations 리스트](/assets/img/posts/2026-07-22/04-detected-equations-list.png){: width="720" }

카드 오른쪽 상단의 **Edit LaTeX** 로 챗봇이 어쩌다 뱉은 오타를 수정하거나 **Skip** 으로 false positive (예: 본문에 우연히 들어간 `$100`) 를 제외할 수 있습니다. 100+ 카드가 나열되어도 각각의 preview 로 *이게 내가 풀 문제 수식이 맞는지* 를 빠르게 검토할 수 있습니다.

### 2-3. Render PNG · Export

검토가 끝나면 상단의 **Render PNG · Export** 버튼 한 번.

![Render PNG · Export 클릭](/assets/img/posts/2026-07-22/05-render-png-click.png){: width="720" }

상단 헤더에 *Selected N · Skipped 0 · Unresolved ambiguity 0* 이 보입니다. 이 시점에 도구가 모든 선택된 수식을 MathJax 로 PNG 렌더링하고, 원본 docx 자리에 그대로 삽입한 새 docx 를 만들어 다운로드합니다. 100개 넘는 수식이라도 브라우저 안에서 몇 초 안에 끝납니다.

## 3. 결과 — PNG 수식이 들어간 자습 자료

다운로드된 docx 를 Word 에서 열면 raw text 자리가 전부 깔끔한 PNG 로 교체돼 있습니다.

![변환 결과 — PNG 수식 typography](/assets/img/posts/2026-07-22/06-word-result-typography.png){: width="720" }

$a^2 + b^2 = c^2$, $e^{i\pi} + 1 = 0$, $\alpha + 1$, $x^{2n} + 1 > 0$, $ax^2 + bx + c = 0$, $\int e^x\, dx = e^x + C$ — 각각 논문 typography 수준으로 렌더링됩니다. 챗봇이 뱉은 100+ 수식 전체가 동일한 품질로 정리되기 때문에, 태블릿으로 보든 인쇄해서 카페에서 풀든 시각이 균일합니다.

각 PNG 의 alt 텍스트에는 원본 LaTeX 가 `AIMATH_FORMULA::v1::` 태그와 함께 보존됩니다. 문제 풀다가 *"이 식 어떻게 나왔지?"* 싶어서 다시 챗봇한테 물어봐야 할 때, PNG 의 alt 만 열면 원본 LaTeX 를 그대로 복사해서 다음 프롬프트에 붙일 수 있습니다. 시각 자료와 편집 가능한 원본이 하나의 파일 안에 살아 있습니다.

## 4. 시간 계산 — 자습 세션 하나 만드는 데 얼마나 걸리나

Word 의 *수식 삽입* 편집기로 수식 하나 옮기는 시간을 30초로 잡으면:

| 챗봇 답변 크기 | 편집기 수동 변환 | LaTeXFlow drag-drop |
|---|---|---|
| 수식 20개 (연습 문제 5~10개) | 10분 | ~10초 |
| 수식 100개 (한 단원 연습 세트) | 50분 | ~30초 |
| 수식 300개 (시험 대비 종합) | 2시간 30분 | ~1분 |

편집기 조작 시간이 문제 개수에 선형으로 늘어나는 반면, drag-drop 은 크기와 거의 무관합니다. 자습·독학처럼 *같은 workflow 를 매주 반복* 하는 사용자에게 누적 시간 절약이 큽니다.

## 5. 본인 시나리오

- **시험 대비 자습** — 수능·학교 시험·대학원 시험·자격증 준비. 챗봇에게 *"이 단원 연습 문제 20개"* 시킨 결과를 docx 로 정리해서 오프라인 학습 자료로.
- **스터디 그룹 공동 문제집** — 팀별로 챗봇 답변을 취합해서 공동 문제집을 만들 때. 각자 다른 유형을 뽑아 오게 시켜도 최종 docx 는 시각이 통일됩니다.
- **오답 노트 · 주간 복습** — 챗봇에게 *"방금 틀린 유형 유사 문제"* 시켜서 개인 오답 노트를 매주 갱신하는 workflow.

### 챗봇 프롬프트 팁

프롬프트에 **"수식은 `$...$` LaTeX 문법으로 감싸줘"** 를 명시하면 답변이 파싱 가능한 상태로 옵니다 → 복붙 후 LaTeXFlow drag-drop 이 자연스러워집니다. 프롬프트 예:

> "무한급수 판정법 연습 문제 20개 만들어줘. 각 문제의 수식은 `$...$` LaTeX 문법으로 감싸줘."

이 한 줄이 자습 workflow 마찰의 대부분을 없앱니다. 챗봇에 따라 markdown 렌더링 관성으로 `\[...\]` 나 `[...]` 로 뱉는 경우도 있는데, 그 케이스는 [bracket-mode 시연 글](/blog/posts/latexflow-ai-chatbot-bracket-mode/) 참고.

#### docx 를 직접 요청할 때의 함정

챗봇에게 *"docx 파일로 만들어줘"* 만 부탁하면 챗봇이 "예쁘게" 만든다고 판단해서 **Word 수식 편집기 객체로 수식을 박아 버립니다**. 이 경우 docx 안 수식은 raw text 가 아니라 OOXML `<m:oMath>` XML 객체 → **LaTeXFlow 가 수식으로 인식하지 못합니다** (변환 대상 = raw `$...$` / `\(...\)` / `\[...\]` 텍스트).

해결은 프롬프트에 **LaTeX 문법 명시**를 함께 넣는 것입니다.

- ❌ "연습 문제 20개 만들어서 docx 로 줘" → OOXML 수식 (변환 불가)
- ✅ "수식을 LaTeX 문법 (`$...$` 또는 `\(...\)`) 으로 써서 docx 로 만들어줘" → raw text (변환 가능)

같은 이유로, 챗봇 답변을 채팅창에서 복사→docx 붙여넣기 하는 경우엔 이미 raw LaTeX 로 옵니다 (위 소개 참조) — docx 직접 다운로드 요청만 이 함정에 걸립니다.

---

*LaTeX 수식 syntax 자체가 헷갈리면 — [무한급수 관련 정리](/blog/posts/latex-align-equations/) / [수학 기호 cheatsheet](/blog/posts/latex-command-cheatsheet/) / [그리스 문자 정리](/blog/posts/latex-greek-letters-complete/) 글이 참고가 됩니다.*
