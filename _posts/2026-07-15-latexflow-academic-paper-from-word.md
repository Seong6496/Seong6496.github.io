---
title: "논문 초안의 수식만 LaTeX 으로 쓰고 싶었다 — Word + LaTeXFlow drag-drop 의 마찰 끝낸 path"
date: 2026-07-15 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, word, academic-paper, 학술-논문, 학회, 수식-번호, alt-text]
math: true
pin: false
description: "학회 deadline 직전, Word 본문은 그대로 두고 수식만 LaTeX 으로 쓰고 싶을 때 — LaTeXFlow Scan 의 .docx drag-drop 한 번으로 58개 수식이 모두 깔끔한 PNG 로 변환된 결과를 학술 논문 초안 시나리오로 시연합니다."
---

학회 submission deadline 까지 며칠, 본문은 거의 다 썼는데 수식 자리가 아직 plain text LaTeX 입니다. Word 의 *수식 삽입* 으로 일일이 옮기자니 한 식당 1~2분, 50개가 넘으면 한나절. 그렇다고 plain text 로 두자니 PDF 로 export 했을 때 백슬래시와 중괄호가 그대로 보여 reviewer 가 어떻게 볼지 신경 쓰입니다.

[LaTeXFlow Scan](/latexflow/web/) 의 **drag-drop 경로** 가 그 중간 path 입니다. 본문은 Word 에서 자연스럽게 쓰고, 수식 자리는 `$...$` 또는 `$$...$$` plain text 그대로 두고, 다 쓴 후 docx 를 한 번만 끌어다 놓으면 모든 수식이 PNG 로 변환된 docx 가 다운로드됩니다. 이 글에서는 실제 *Topological Data Analysis 논문 초안* (~3 페이지, 수식 58개) 으로 시연합니다.

## 1. 문제 — Word 에서 수식 쓰는 3 path 의 마찰

### 1-1. Equation Editor — 시각은 좋지만 시간이 든다

Word 의 *수식 삽입* 버튼은 GUI 수식 편집기를 띄웁니다. 단순한 분수나 적분은 빠른데, 다음 같은 식을 하나하나 마우스로 조립하려면 30초~1분씩 듭니다.

```
$$d_B(D, D') = \inf_{\gamma} \sup_{p \in D} \| p - \gamma(p) \|_\infty$$
```

문제는 양이 많을 때입니다. 논문 한 편에 수식 50~80개가 들어가는 일은 흔하고, 그걸 전부 Equation Editor 로 옮기는 시간은 deadline 직전에 가장 부담되는 cost 입니다.

### 1-2. plain text LaTeX — 빠르지만 시각이 안 깔끔

본인이 LaTeX 사용자라면 그냥 본문에 `$\nabla \cdot \vec{F} = \frac{\partial F_x}{\partial x} + \frac{\partial F_y}{\partial y} + \frac{\partial F_z}{\partial z}$` 식으로 plain text 를 적는 게 가장 빠릅니다. 단 PDF 로 export 하면 백슬래시와 중괄호가 그대로 보여, reviewer 가 *"왜 수식이 코드처럼 보이지?"* 하는 인상을 받기 쉽습니다.

### 1-3. Insert Symbol — 한정된 기호만 가능

`∇`, `∫`, `∂` 같은 단일 기호는 *기호 삽입* 으로 넣을 수 있지만, 분수·합·적분이 결합된 복잡한 수식 (예: `\sum_{i=1}^N \frac{x_i}{\sqrt{\sigma_i^2 + \epsilon}}`) 은 표현할 수 없습니다. 결국 Equation Editor 로 돌아가야 합니다.

→ deadline 직전에 *논문 본문에 손 가는 시간* 보다 *수식 변환에 손 가는 시간* 이 더 길어지는 게 일반 마찰입니다.

## 2. 해결 — LaTeXFlow Scan 의 drag-drop 4 step

### 2-1. 본문은 Word, 수식은 plain text LaTeX

먼저 Word 에서 본문은 자연스럽게 쓰고, 수식 자리만 LaTeX plain text 로 둡니다. inline 은 `$...$`, display 는 `$$...$$`, 수식 번호는 `\tag{N}`.

```
We compute the persistence diagram

$$\text{Dgm}_k(X) = \{(b_i, d_i)\}_{i \in I}. \tag{3}$$

and the bottleneck distance between two diagrams is

$$d_B(D, D') = \inf_{\gamma} \sup_{p \in D} \| p - \gamma(p) \|_\infty. \tag{4}$$
```

이 docx 를 그대로 저장합니다. 이 시점까지는 일반 LaTeX 작성과 다를 게 없습니다.

### 2-2. dropzone 에 docx 끌어다 놓기

[LaTeXFlow Scan](/latexflow/web/) 을 열면 첫 화면에 *"Drop a .docx file here"* dropzone 이 있습니다. Word 에서 저장한 docx 를 그대로 끌어다 놓습니다.

![LaTeXFlow Scan dropzone — docx 끌어다 놓기](/assets/img/posts/2026-07-15/01-drag-drop.png){: width="720" }

브라우저 안에서만 처리되며 (`Nothing leaves your browser`), Google Drive 연동도 별도로 가능합니다.

### 2-3. 수식 탐지 — 58개 자동 추출

도구가 docx 의 본문 단락을 훑어 수식을 자동 탐지하고 *Review* 단계로 진입합니다. 이번 데모 docx (~3 페이지, TDA 논문 초안) 의 결과:

![수식 탐지 결과 — Selected 58 / Skipped 0 / Unresolved 0](/assets/img/posts/2026-07-15/02-detection-58.png){: width="720" }

상단 헤더에 *Selected 58 / Skipped 0 / Unresolved ambiguity 0* 이 보입니다. inline 수식 ~49개 + display 수식 9개 (각각 `\tag{1}` ~ `\tag{9}`), 모두 탐지됐습니다. 본문에 우연히 들어간 `$ 100` 류 false positive 가 있다면 우측 **Skip** 으로 제외할 수 있습니다.

### 2-4. PNG 변환 + Word 자동 열기

상단의 **Render PNG · Export** 버튼을 누르면 한 번에 변환된 docx 가 다운로드되고, OS 가 Word 를 자동으로 띄웁니다.

![Render PNG → Word 자동 열기](/assets/img/posts/2026-07-15/03-render-word-launch.png){: width="720" }

## 3. 결과 — 58개 수식이 모두 PNG 로 들어간 docx

다운로드된 docx 를 Word 에서 열면 본문은 그대로 두고 수식 자리만 PNG 로 깔끔하게 들어가 있습니다. 논문 첫 섹션 *"2.1 Persistent homology"* 자리:

![변환 결과 — 본문 첫 섹션의 수식 자리가 모두 PNG](/assets/img/posts/2026-07-15/04-result-first-section.png){: width="720" }

`X = \{x_1, \ldots, x_n\} \subset \mathbb{R}^d`, `H_k(K_i) \to H_k(K_j)`, `[b_i, d_i]`, `k`-th persistence module 등 inline 자리들이 자연스럽게 본문 흐름과 맞춰 들어갑니다. 본문 단어 사이 spacing 도 깨지지 않습니다.

논문 마지막 자리 (Discussion + References) 도 동일하게 처리됩니다. `\tag{N}` 으로 표시한 수식 번호도 PNG 안에 함께 변환되고, 본문 안 `AUC = \int_0^1 \text{TPR}(\text{FPR}^{-1}(u))\, du` 같은 복잡한 display 수식도 한 줄 안에 깨끗하게 들어갑니다.

![변환 결과 — Discussion + References + AUC 큰 수식까지](/assets/img/posts/2026-07-15/05-result-discussion-refs.png){: width="720" }

논문 한 편 전체의 모든 수식이 한 번의 drag-drop 으로 정리됐습니다.

## 4. alt-text 역변환 — reviewer 응대 path 보존

변환된 docx 의 각 PNG 에는 alt 텍스트에 원본 LaTeX 가 그대로 보존됩니다. 즉:

- 학회 reviewer 가 *"식 (3) 의 첨자가 잘못됐다"* 라고 코멘트하면, 해당 PNG 의 alt 텍스트에서 원본 LaTeX 를 그대로 가져와 수정 가능
- PNG 가 *최종 시각 자료* 와 *원본 LaTeX 자료* 두 역할을 동시에 합니다
- 즉 *plain text 에서 PNG 로* 의 단방향 변환이 아니라, 양방향 흐름이 유지됩니다

이 alt-text 보존 규약은 LaTeXFlow 의 모든 출력에 공통 적용됩니다 (`AIMATH_FORMULA::v1::` tag 형식).

## 5. 학회 deadline 직전의 workflow 권장

| 단계 | 시점 | 작업 |
|---|---|---|
| W-2 | 2주 전 | Word 에서 본문 작성 + 수식은 LaTeX plain text 로 둠 |
| W-1 | 1주 전 | LaTeXFlow Scan drag-drop → PNG 변환된 docx 받음 + 본문 검토 |
| W | 제출 직전 | PDF export → submission |

이 path 로 가면 *수식에 손 가는 시간* 이 *LaTeX 를 쓰는 시간* 으로 축소됩니다. 본인이 *논문 초안 / 학위 논문 / 학회 발표 자료* 를 쓰는 경우 동일하게 적용됩니다.

---

*LaTeX 수식 syntax 가 헷갈리면 — [align 환경 정리](/blog/posts/latex-align-equations/) / [수학 기호 cheatsheet](/blog/posts/latex-command-cheatsheet/) / [그리스 문자 정리](/blog/posts/latex-greek-letters-complete/) 글을 참고하세요.*
