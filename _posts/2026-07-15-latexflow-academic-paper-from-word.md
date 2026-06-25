---
title: "논문 초안 docx 의 수식만 LaTeX 박으려 했다 — 그 마찰 끝낸 방법"
date: 2026-07-15 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, word, academic-paper, 학술-논문, 학회, IEEE, 수식-번호, alt-text]
math: true
pin: false
description: "본문은 Word 에서 박고 수식만 LaTeX 박으려 했더니 시각 마찰 박힌 학계 연구자/대학원생 — LaTeXFlow Scan 의 .docx drag-drop path 로 한 번에 PNG 수식 박힌 docx 박는 과정 + alt-text 역변환 박을 path 보존 명시. 학술 논문 초안 시나리오로 시연합니다."
---

학회 deadline 박히기 직전, 본문 거의 완성된 Word docx 의 수식 박힌 자리만 LaTeX 으로 박으려 했는데 — *Equation Editor* 박으면 시각 안 맞고, *Insert Symbol* 박으면 복잡한 수식 박을 때 시간 박힘, *LaTeX plain text* 박으면 PDF 박을 때 안 깔끔. 3 path 다 마찰 박혀있어 결국 모든 수식 박는 자리 시간 박는 경험.

[LaTeXFlow Scan](/latexflow/web/) 의 **drag-drop path** 가 그 중간 path 입니다. 본문 그대로 Word 에 박고, 수식 자리만 `$...$` 또는 `$$...$$` plain text 박은 후 docx 끌어다 놓으면 한 번에 PNG 박힌 docx 박힙니다. 그리고 각 PNG 의 alt 텍스트에 원본 LaTeX 보존 박혀있어 **역변환 가능** — 학회 reviewer 가 *"식 (3) 잘못 박혀있다"* 박으면 PNG 박은 자리 LaTeX 돌려박을 path 있습니다. 이 글에서는 *IEEE/학회 논문 초안* 시나리오로 시연합니다.

## 1. 문제 — Word 의 수식 박는 3 path 마찰

### 1-1. Equation Editor — 시각 시간 박힘

Word 의 *수식 삽입* 버튼 박으면 GUI 의 수식 편집기 박힙니다. 단순한 수식은 빠르지만, 복잡한 행렬 / 적분 박을 때 시각 맞춰 박는 cost 큽니다.

> _스크린샷 자리: Word 의 Equation Editor 박은 화면 — 복잡한 수식 박으려 할 때 시각 마찰_
> `![Word Equation Editor — 시각 마찰](/assets/img/posts/2026-07-15/01-word-equation-editor.png){: width="720" }`

### 1-2. LaTeX plain text — 시각 안 깔끔

본인이 LaTeX 박는 사람이면 그냥 `$\nabla \times \vec{E} = -\frac{\partial \vec{B}}{\partial t}$` 같이 plain text 박는 게 빠른데, PDF 박을 때 백슬래시 + 중괄호 박혀 시각 안 깔끔합니다.

> _스크린샷 자리: Word 안 LaTeX plain text 박은 시각 — `\nabla \times \vec{E}` 류 박힘_
> `![Word LaTeX plain text](/assets/img/posts/2026-07-15/02-word-plain-text.png){: width="720" }`

학회 deadline 박히기 직전, 모든 수식 박힌 자리 일일이 Equation Editor 박는 시간 없음.

## 2. 해결 — LaTeXFlow Scan drag-drop

### 2-1. 본문은 Word 에서 박고, 수식만 LaTeX plain text

본문 + 수식 plain text 박힌 docx 박은 후, [LaTeXFlow Scan](/latexflow/web/) 의 dropzone 에 끌어다 놓습니다.

> _스크린샷 자리: LaTeXFlow Scan 의 drop-zone 에 .docx 끌어다 놓는 모습_
> `![drag-drop](/assets/img/posts/2026-07-15/03-drag-drop.png){: width="720" }`

### 2-2. 수식 탐지 — 학술 글의 inline + display + 수식 번호

논문 톤 docx 박은 시점:
- inline `$...$` — 본문 안 한 줄 수식 (변분원리 `$\delta S = 0$` 등)
- display `$$...$$` — 별 줄 박힌 수식 (Euler-Lagrange `$$\frac{d}{dt}\frac{\partial L}{\partial \dot{q}} - \frac{\partial L}{\partial q} = 0$$` 등)
- 수식 번호 — `\tag{1}` `\tag{2}` 박힌 자리

도구가 본문 단락 / 표 셀 / 인용 단락 박은 자리 다 훑어서 수식 박힌 자리 추출 박습니다.

> _스크린샷 자리: 수식 탐지 결과 — 수식 ~12~15개 박힌 리스트_
> `![수식 탐지 결과](/assets/img/posts/2026-07-15/04-detection.png){: width="720" }`

### 2-3. PNG 변환 + 내보내기

**Render PNG · Export** 누르면 한 번에 PNG 박힌 docx 다운로드.

> _스크린샷 자리: PNG 변환 진행 표시 → 다운로드 완료_
> `![PNG 변환 + 다운로드](/assets/img/posts/2026-07-15/05-export.png){: width="720" }`

## 3. 결과 — PNG 박힌 docx + alt-text 역변환 path

다운로드된 docx 박은 시각:

> _스크린샷 자리: 다운로드된 docx 의 PNG 수식 박힌 학술 논문 시각_
> `![다운로드된 docx — 학술 논문](/assets/img/posts/2026-07-15/06-result.png){: width="720" }`

각 PNG 의 **alt 텍스트에 원본 LaTeX 박혀있습니다** (`AIMATH_FORMULA::v1::` 박힌 tag). 즉:
- 학회 reviewer 가 *"식 (3) 잘못 박혀있다"* 박으면 PNG 박은 자리 alt 텍스트에서 LaTeX 박은 자료 가져옴
- 다음 라운드 박을 때 추가 [LaTeXFlow Google Docs Add-on](https://workspace.google.com/marketplace) 박은 path 있으면 그 PNG 자리 다시 LaTeX 박을 path 보존
- 즉 PNG 박힌 docx 가 *최종 시각 자료* + *원본 LaTeX 자료* 둘 다 박힌 상태

## 4. 학회 deadline 박힐 때 workflow

- W-2: docx 본문 박는 단계 — Word 에서 본문 + plain text LaTeX 박음
- W-1: LaTeXFlow 한 번 돌려 PNG 박힌 docx 박음 + reviewer 박은 자리 정리
- W: 학회 submission

이 path 박으면 모든 수식 박은 자리 Equation Editor 박는 시간 박지 않고, *수식 박는 시간 = LaTeX 박는 시간* 으로 축소됩니다. 본인 *논문 초안 / 학위 논문 / 학회 발표 자료* 박으면 동일.

---

*LaTeX 수식 박는 path 정확히 박은 자료 — [align 환경](/blog/posts/latex-align-equations/) / [수학 기호 cheatsheet](/blog/posts/latex-command-cheatsheet/) / [그리스 문자 정리](/blog/posts/latex-greek-letters-complete/) 박혀있습니다.*
