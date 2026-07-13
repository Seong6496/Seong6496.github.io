---
title: "강사 · 과외 문제집 만들 때 raw LaTeX 100개 — drag-drop 한 번에 시각적 완성"
date: 2026-07-22 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, docx, math-problem-book, 문제집, 강사, 과외, 문제은행, 수식, 무한급수, 대량처리]
math: true
pin: false
description: "무한급수 판정법처럼 카테고리별로 정리한 수학 문제집 docx 안에 raw LaTeX 가 100개 넘게 들어 있을 때 — LaTeXFlow Scan drag-drop 한 번으로 전부 PNG 수식이 들어간 학생 배포용 docx 로 변환하는 workflow 를 강사 · 과외 · 문제집 제작 시나리오로 시연합니다."
---

강사 · 과외 선생님이 학원 · 학교 · 개인 학생용 문제집을 만들 때, 수식 자리는 그냥 `$\sum_{n=1}^{\infty} \frac{1}{n^{\sqrt{2}}}$` 라고 raw LaTeX 로 빠르게 적는 게 가장 편합니다. 판정법 하나에 5~10문항, 판정법 8개면 문제집 한 편에 수식이 100개를 훌쩍 넘습니다. 문제는 학생에게 배포하기 직전 — raw text 그대로 인쇄물이나 PDF 로 뽑으면 학생 반응이 *"이게 뭐야?"* 로 갑니다.

[LaTeXFlow Scan](/latexflow/web/) 의 **drag-drop 경로** 가 그 끝단을 정리합니다. 문제집은 raw LaTeX 로 자연스럽게 쓰고, 완성된 docx 를 도구에 한 번만 끌어다 놓으면 100개 넘는 수식이 전부 PNG 로 변환된 docx 가 다운로드됩니다. 이 글에서는 실제 *무한급수 판정법 문제집* (판정법 8개, `$` inline 수식 100+ 개) docx 로 시연합니다.

## 1. 문제 — raw LaTeX 문제집의 실제 시각

강사 입장에서 문제집을 만들 때 가장 빠른 경로는 Word 나 아래아한글에 `$...$` plain text 로 수식을 적어 나가는 겁니다. 판정법별로 카테고리를 나누고, 각 카테고리 안에 문제 5~10개씩. 아래는 그렇게 정리한 문제집 docx 의 *p-Series Test* 섹션입니다.

![raw LaTeX 문제집 — p-Series Test 섹션](/assets/img/posts/2026-07-22/01-raw-docx-p-series.png){: width="720" }

카테고리 구조는 깔끔한데, 문제 자리에는 `$\sum_{n=1}^{\infty} \frac{1}{n^{\sqrt{2}}}$` 같은 raw text 가 그대로 노출됩니다. 강사 본인은 익숙하니 상관없지만, 학생 손에 이 상태 그대로 쥐어 주면 수식을 못 읽습니다.

*Ratio & Root Test* 섹션까지 스크롤하면 밀도가 더 높아집니다.

![raw LaTeX 문제집 — Ratio & Root Test 섹션](/assets/img/posts/2026-07-22/02-raw-docx-ratio-root.png){: width="720" }

`$\sum_{n=1}^{\infty} \left(\frac{2n+3}{3n+2}\right)^n$` 같은 식이 한 페이지 안에 여러 줄. 문제집 전체를 세면 100개를 훌쩍 넘고, 이걸 Word 의 *수식 삽입* 으로 하나하나 옮기려면 식당 30초씩 잡아도 50분 이상 걸립니다. 배포 직전에 이 시간을 쓰는 건 부담됩니다.

## 2. 해결 — LaTeXFlow Scan 의 drag-drop 4 step

### 2-1. 도구 열기

[LaTeXFlow Scan](/latexflow/web/) 을 열면 첫 화면에 dropzone 이 있습니다.

![LaTeXFlow Scan 첫 화면 — dropzone](/assets/img/posts/2026-07-22/03-latexflow-dropzone.png){: width="720" }

*"Drop a .docx file here"* 자리에 문제집 docx 를 그대로 끌어다 놓습니다. 브라우저 안에서만 처리되며 (`Nothing leaves your browser`), 학생 명단이 함께 담긴 문제집이라도 파일이 서버로 올라가지 않습니다.

### 2-2. 수식 자동 탐지

drop 하면 도구가 docx 본문을 훑어 `$...$` inline 수식을 전부 자동으로 뽑아 냅니다. *Detected Equations* 리스트에 수식 하나하나 카드로 나열되고, 각 카드에 *rendered preview*, *raw LaTeX*, *본문 context* 가 함께 표시됩니다.

![Detected Equations 리스트](/assets/img/posts/2026-07-22/04-detected-equations-list.png){: width="720" }

카드 오른쪽 상단의 **Edit LaTeX** 로 오타를 수정하거나 **Skip** 으로 false positive (예: 본문에 우연히 들어간 `$100`) 를 제외할 수 있습니다. 100+ 카드가 나열되어도 각각의 preview 로 *이게 내가 의도한 수식인지* 를 빠르게 검토할 수 있습니다.

### 2-3. Render PNG · Export

검토가 끝나면 상단의 **Render PNG · Export** 버튼 한 번.

![Render PNG · Export 클릭](/assets/img/posts/2026-07-22/05-render-png-click.png){: width="720" }

상단 헤더에 *Selected N · Skipped 0 · Unresolved ambiguity 0* 이 보입니다. 이 시점에 도구가 모든 선택된 수식을 MathJax 로 PNG 렌더링하고, 원본 docx 자리에 그대로 삽입한 새 docx 를 만들어 다운로드합니다. 100개 넘는 수식이라도 브라우저 안에서 몇 초 안에 끝납니다.

## 3. 결과 — PNG 수식이 들어간 학생 배포용 docx

다운로드된 docx 를 Word 에서 열면 raw text 자리가 전부 깔끔한 PNG 로 교체돼 있습니다.

![변환 결과 — PNG 수식 typography](/assets/img/posts/2026-07-22/06-word-result-typography.png){: width="720" }

$a^2 + b^2 = c^2$, $e^{i\pi} + 1 = 0$, $\alpha + 1$, $x^{2n} + 1 > 0$, $ax^2 + bx + c = 0$, $\int e^x\, dx = e^x + C$ — 각각 논문 typography 수준으로 렌더링됩니다. 문제집 전체의 100+ 수식이 동일한 품질로 정리되기 때문에, 인쇄물이나 PDF 로 뽑아도 시각이 균일합니다.

각 PNG 의 alt 텍스트에는 원본 LaTeX 가 `AIMATH_FORMULA::v1::` 태그와 함께 보존됩니다. 학생이 *"이 문제 답 어떻게 나와요?"* 라고 물어와서 원본 수식을 다시 꺼내야 할 때, PNG 의 alt 만 열면 원본 LaTeX 를 그대로 복사할 수 있습니다. 인쇄물은 시각적 결과, 원본 docx 는 편집 가능한 asset — 두 역할이 하나의 파일 안에 살아 있습니다.

## 4. 시간 계산 — 왜 문제집 대량 처리에 특히 유리한가

Word 의 *수식 삽입* 편집기로 수식 하나 옮기는 시간을 30초로 잡으면:

| 문제집 크기 | 편집기 수동 변환 | LaTeXFlow drag-drop |
|---|---|---|
| 수식 20개 (1개 판정법) | 10분 | ~10초 |
| 수식 100개 (문제집 한 편) | 50분 | ~30초 |
| 수식 300개 (한 학기 문제은행) | 2시간 30분 | ~1분 |

편집기 조작 시간이 문제집 크기에 선형으로 늘어나는 반면, drag-drop 은 크기와 거의 무관합니다. 강사 · 과외 · 교재 저자처럼 *반복 대량 처리* 가 workflow 인 사용자에게 시간 절약이 큽니다.

## 5. 본인 docx 라면

본인의 *문제집 · 학습지 · 문제은행 docx* 로도 같은 결과를 얻을 수 있습니다.

- **학원 강사**: 매주 만드는 주간 문제집, 학기말 정리 문제집.
- **과외 선생님**: 학생 개인 수준별 맞춤 문제집, 오답 노트.
- **교재 저자 · 학습지 제작자**: 판형 통일이 중요한 상용 교재 · 무료 배포 자료.
- **학교 교사**: 단원 평가지, 수행 평가 문제.

문제집 raw docx 는 강사 편집용 원본으로 보관하고, drag-drop 으로 뽑은 PNG docx 는 학생 배포용으로 분리해 두는 workflow 를 추천합니다. 원본을 나중에 문제 하나 고쳐야 할 때 다시 raw 로 수정한 뒤 drag-drop 한 번이면 다시 시각화된 docx 가 됩니다.

---

*LaTeX 수식 syntax 자체가 헷갈리면 — [무한급수 관련 정리](/blog/posts/latex-align-equations/) / [수학 기호 cheatsheet](/blog/posts/latex-command-cheatsheet/) / [그리스 문자 정리](/blog/posts/latex-greek-letters-complete/) 글이 참고가 됩니다.*
