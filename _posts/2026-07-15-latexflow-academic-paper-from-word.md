---
title: "논문 초안의 수식만 LaTeX 으로 쓰고 싶었다 — Word + LaTeXFlow drag-drop 의 마찰 끝낸 path"
date: 2026-07-15 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, word, academic-paper, 학술-논문, 학회, 수식-번호, alt-text]
math: true
pin: false
description: "학회 deadline 직전, Word 본문은 그대로 두고 수식만 LaTeX 으로 쓰고 싶을 때 — LaTeXFlow Scan 의 .docx drag-drop 한 번으로 58개 수식이 모두 깔끔한 PNG 로 변환됩니다. 언제 이 방법이 맞고 언제 LaTeX/Overleaf 로 가야 하는지, 다단 수식·Word 수식 객체 미지원 같은 한계, 그리고 학회 제출 시나리오 FAQ 까지 실제 워크플로로 정리했습니다."
---

학회 submission deadline 까지 며칠, 본문은 거의 다 썼는데 수식 자리가 아직 plain text LaTeX 입니다. Word 의 *수식 삽입* 으로 일일이 옮기자니 한 식당 1~2분, 50개가 넘으면 한나절. 그렇다고 plain text 로 두자니 PDF 로 export 했을 때 백슬래시와 중괄호가 그대로 보여 reviewer 가 어떻게 볼지 신경 쓰입니다.

[LaTeXFlow Scan](/latexflow/web/) 의 **drag-drop 경로** 가 그 중간 path 입니다. 본문은 Word 에서 자연스럽게 쓰고, 수식 자리는 `$...$` 또는 `$$...$$` plain text 그대로 두고, 다 쓴 후 docx 를 한 번만 끌어다 놓으면 모든 수식이 PNG 로 변환된 docx 가 다운로드됩니다. 이 글에서는 실제 *Topological Data Analysis 논문 초안* (~3 페이지, 수식 58개) 으로 시연합니다.

수식이 열 개 안쪽이라면 사실 어느 방법이든 큰 차이가 없습니다. 이 글이 다루는 상황은 *양이 임계점을 넘긴* 경우입니다. 수식 하나를 옮기는 데 1분이 걸린다고 하면 58개는 산술적으로 한 시간이 넘고, 실제로는 편집기를 열고 커서를 옮기고 오타를 확인하는 문맥 전환 비용까지 붙습니다. 게다가 이 작업은 deadline 이 다가올수록, 즉 본문 문장을 다듬는 데 시간을 쓰고 싶은 바로 그 시점에 몰립니다. "수식에 손 가는 시간" 과 "글에 손 가는 시간" 이 정면으로 충돌하는 겁니다.

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

이 docx 를 그대로 저장합니다. 이 시점까지는 일반 LaTeX 작성과 다를 게 없습니다. 한 가지만 기억하면 됩니다 — display 수식은 `$$...$$` 를 **한 단락 안에** 닫아야 합니다. `$$` 를 열고 줄바꿈(엔터)으로 여러 단락에 걸쳐 쓰면 탐지가 되지 않으니, 긴 수식이라도 한 문단 안에서 끝나도록 둡니다. 탐지되는 구분자는 `$...$`, `$$...$$`, `\(...\)`, `\[...\]` 이고, 대괄호 모드(`[...]`)도 기본으로 켜져 있습니다.

### 2-2. dropzone 에 docx 끌어다 놓기

[LaTeXFlow Scan](/latexflow/web/) 을 열면 첫 화면에 *"Drop a .docx file here"* dropzone 이 있습니다. Word 에서 저장한 docx 를 그대로 끌어다 놓습니다.

![LaTeXFlow Scan dropzone — docx 끌어다 놓기](/assets/img/posts/2026-07-15/01-drag-drop.png){: width="720" }

브라우저 안에서만 처리되며 (`Nothing leaves your browser`), 파일이 서버로 업로드되지 않습니다. 초안이 심사 전 원고라 외부로 나가는 게 꺼려지는 상황에서 이 점이 중요합니다. Google Drive 에 초안을 두고 작업하는 분은 drag-drop 대신 *Import from Google Drive* 로 불러올 수도 있습니다(`drive.file` 범위 — 여러분이 고른 파일에만 접근).

### 2-3. 수식 탐지 — 58개 자동 추출

도구가 docx 의 본문 단락을 훑어 수식을 자동 탐지하고 *Review* 단계로 진입합니다. 이번 데모 docx (~3 페이지, TDA 논문 초안) 의 결과:

![수식 탐지 결과 — Selected 58 / Skipped 0 / Unresolved 0](/assets/img/posts/2026-07-15/02-detection-58.png){: width="720" }

상단 헤더에 *Selected 58 / Skipped 0 / Unresolved ambiguity 0* 이 보입니다. inline 수식 ~49개 + display 수식 9개 (각각 `\tag{1}` ~ `\tag{9}`), 모두 탐지됐습니다. 본문에 우연히 들어간 `$ 100` 류 false positive 가 있다면 우측 **Skip** 으로 제외할 수 있습니다.

Review 단계는 58개를 무작정 믿고 넘기라는 게 아니라 *한눈에 걸러내라고* 있는 화면입니다. 각 카드에 원본 LaTeX 와 렌더 미리보기가 나란히 뜨므로, 위에서 아래로 스크롤하며 (a) 수식이 아닌데 잡힌 것은 **Skip**, (b) `$` 하나가 짝을 못 찾은 *Ambiguity* 카드는 열림/닫힘을 지정해 해소합니다. 헤더의 *Unresolved ambiguity* 숫자가 0 이 되면 안심하고 다음 단계로 갑니다. 58개를 일일이 손으로 옮기는 것과, 58개를 훑어보며 예외만 짚는 것은 노동의 성격이 완전히 다릅니다.

### 2-4. PNG 변환 + 내보내기

상단의 **Render PNG · Export** 버튼을 누르면 한 번에 변환된 docx 가 다운로드됩니다. (브라우저·OS 설정에 따라 다운로드 직후 Word 가 바로 열리기도 합니다 — 아래 화면.)

![Render PNG → docx 다운로드 후 Word 에서 열린 모습](/assets/img/posts/2026-07-15/03-render-word-launch.png){: width="720" }

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

이 alt-text 보존 규약은 LaTeXFlow 의 모든 출력에 공통 적용됩니다 (`AIMATH_FORMULA::v1::<latex>` tag 형식). Word 에서 그림을 클릭하고 *대체 텍스트* 를 열면 그 자리에 `AIMATH_FORMULA::v1::` 뒤에 원본 LaTeX 가 들어 있습니다. 수식 파일을 따로 관리하지 않아도 원본이 문서 안에 항상 붙어 다니는 셈이라, 수정 라운드가 여러 번 도는 심사 과정에서 특히 든든합니다.

## 5. 학회 deadline 직전의 workflow 권장

| 단계 | 시점 | 작업 |
|---|---|---|
| W-2 | 2주 전 | Word 에서 본문 작성 + 수식은 LaTeX plain text 로 둠 |
| W-1 | 1주 전 | LaTeXFlow Scan drag-drop → PNG 변환된 docx 받음 + 본문 검토 |
| W | 제출 직전 | PDF export → submission |

이 path 로 가면 *수식에 손 가는 시간* 이 *LaTeX 를 쓰는 시간* 으로 축소됩니다. 본인이 *논문 초안 / 학위 논문 / 학회 발표 자료* 를 쓰는 경우 동일하게 적용됩니다.

한 가지 실무 팁 — 이 변환은 되도록 *마지막에 한 번* 하는 게 좋습니다. PNG 로 바뀐 뒤에는 문서 안에서 수식이 이미지이므로 본문 텍스트처럼 바로 고칠 수 없고, 고치려면 alt-text 에서 LaTeX 를 꺼내 원본 단계에서 다시 변환하는 흐름이 됩니다. 그래서 수식 내용이 아직 흔들리는 초안 초반보다, 본문이 굳고 제출본을 뽑기 직전인 W-1 시점에 변환을 배치하는 편이 왕복을 줄여 줍니다.

## 6. 언제 이 방법이 맞고, 언제 아닌가

이 방법이 **잘 맞는 경우**는 뚜렷합니다.

- 이미 Word(또는 Google Docs) 로 본문을 쓰고 있고, 공저자·지도교수와의 공유·코멘트도 Word 위에서 돈다
- 최종 산출물이 *제출용 docx* 나 *PDF*, 혹은 발표 슬라이드처럼 **시각적으로 깔끔하면 되는 문서**다
- 수식이 많아 하나씩 편집기로 옮기는 게 비현실적이다

반대로 이 방법이 **맞지 않는 경우**도 정직하게 짚겠습니다. LaTeXFlow Scan 은 수식을 **이미지(PNG)** 로 바꿔 넣는 도구이지, 컴파일 가능한 `.tex` 파일을 만들어 주는 도구가 아닙니다. 따라서 다음이라면 처음부터 LaTeX/Overleaf 로 쓰는 편이 맞습니다.

- `\label` / `\eqref` 로 **수식 번호를 자동으로 매기고 상호참조** 하고 싶다 — 본문에서 "식 (12) 에서 보듯" 이 번호가 삽입·삭제에 따라 자동으로 갱신되길 원한다
- `\cite` 와 BibTeX 로 참고문헌을 관리하고, 저널이 요구하는 `.tex` 소스 제출까지 필요하다
- 문서 전체를 LaTeX 조판 규칙으로 통일하려 한다

즉 *Word 로 쓰던 원고를 시각적으로 마무리* 하는 데는 이 방법이 강하지만, *진짜 수식 번호·상호참조가 필요한 조판 파이프라인* 을 대체하지는 않습니다. Word 와 LaTeX 중 어느 쪽으로 시작할지 아직 고민이라면 [LaTeX vs Word/Docs 비교](/blog/posts/latex-vs-word-docs/) 를, LaTeX 를 아예 처음 잡아 본다면 [Overleaf 10분 시작](/blog/posts/latex-overleaf-10min/) 을 먼저 읽어 보시길 권합니다.

## 7. 한계와 주의점

실제로 써 보며 걸린 지점들을 fact 그대로 정리합니다.

- **다단 수식은 탐지되지 않습니다.** display 수식 `$$...$$` 는 한 단락 안에서 열고 닫아야 합니다. 긴 유도 과정을 엔터로 여러 줄에 걸쳐 쓰면 그 블록은 잡히지 않으니, `align` 스타일이 필요한 긴 전개도 한 문단 안에 담아 둡니다.
- **`\(...\)` 구분자의 백슬래시 소실 주의.** Word 에 LaTeX 를 붙여 넣거나 자동 교정이 개입하면 `\(` `\)` 의 백슬래시가 사라져 그냥 괄호로 남는 일이 있습니다. 그러면 수식으로 인식되지 못합니다. 가장 안전한 건 `$...$` / `$$...$$` 를 쓰는 것이고, 변환 전에 구분자가 온전한지 한 번 훑어보면 좋습니다.
- **Word/Docs 의 네이티브 수식 객체는 읽지 못합니다.** 이 도구는 *raw LaTeX 텍스트* 만 봅니다. Word 의 수식 편집기로 만든 수식 객체(내부적으로 OOXML `<m:oMath>`)는 대상이 아닙니다.
- **"docx 로 만들어 줘" 요청의 함정.** 챗봇에게 수식이 든 문서를 "docx 로 뽑아 줘" 라고 시키면, 도구들이 흔히 수식을 Word 네이티브 객체(`<m:oMath>`)로 내보냅니다. 그렇게 나온 docx 는 겉보기엔 수식이 예쁘게 들어 있어도 LaTeXFlow Scan 이 읽지 못합니다. 이 도구에 태우려면 수식을 **plain text LaTeX 로 (`$...$` 형태)** 유지한 docx 를 준비해야 합니다.
- **번호 자동화는 없습니다.** `\tag{3}` 처럼 직접 적어 준 번호는 PNG 안에 그대로 찍히지만, 수식을 하나 추가·삭제해도 번호가 자동으로 밀리거나 당겨지지 않습니다. 번호는 여러분이 관리하는 텍스트라고 생각하시면 됩니다.

## 8. 자주 묻는 질문 (학회 제출 시나리오)

**Q. 원본 LaTeX 는 어디에 남나요? 나중에 수식을 고쳐야 하면요?**
A. 변환된 각 PNG 의 **대체 텍스트(alt-text)** 에 `AIMATH_FORMULA::v1::<latex>` 형식으로 원본 LaTeX 가 그대로 저장됩니다. Word 에서 그림을 우클릭 → 대체 텍스트에서 원본을 꺼내 수정한 뒤 다시 변환하면 되므로, 수식 소스를 별도 파일로 들고 다닐 필요가 없습니다.

**Q. 수식 번호(식 3, 식 4 …)는 자동으로 매겨지나요?**
A. 아닙니다. 이 도구는 수식을 이미지로 바꿔 넣을 뿐, LaTeX 의 `\label`/`\eqref` 같은 자동 번호·상호참조를 만들지 않습니다. 번호가 필요하면 `$$ ... \tag{3}$$` 처럼 직접 `\tag{}` 로 적어 두세요. 그 번호는 PNG 에 함께 찍힙니다. 다만 수식을 추가·삭제해도 번호가 저절로 갱신되지는 않으니, 자동 번호·상호참조가 핵심이라면 LaTeX/Overleaf 쪽이 맞습니다.

**Q. 58개를 한 번에 검수하려니 부담됩니다. 요령이 있나요?**
A. *Review* 화면을 위에서 아래로 한 번 스크롤하며 예외만 처리하는 방식이 빠릅니다. 수식이 아닌데 잡힌 것(예: 가격 표기 `$ 100`)은 **Skip**, `$` 짝이 안 맞는 *Ambiguity* 카드는 열림/닫힘을 지정해 해소합니다. 헤더의 *Skipped* 와 *Unresolved ambiguity* 숫자만 확인하면 전체 상태가 한눈에 들어오므로, 58개를 일일이 손보는 대신 걸리는 몇 개만 짚으면 됩니다.

**Q. 학회 템플릿(정해진 서식) 위에서 써도 되나요?**
A. 됩니다. 이 도구는 본문 서식·스타일은 건드리지 않고 수식 자리의 LaTeX 텍스트만 PNG 로 교체합니다. 다만 최종 산출물은 수식이 이미지로 들어간 **docx/PDF** 이므로, 저널이 수식이 포함된 `.tex` 소스 제출을 요구하는 트랙이라면 이 방법은 맞지 않습니다. 그런 경우는 처음부터 LaTeX 로 쓰는 게 낫습니다.

**Q. 초안이 심사 전 원고인데, 파일이 외부로 나가지 않나요?**
A. 변환은 **브라우저 안에서만** 이뤄지고 파일이 서버로 올라가지 않습니다(`Nothing leaves your browser`). Google Drive 에서 불러오는 경우에도 `drive.file` 범위라 여러분이 직접 고른 파일에만 접근합니다.

---

*LaTeX 수식 syntax 가 헷갈리면 — [align 환경 정리](/blog/posts/latex-align-equations/) / [수학 기호 cheatsheet](/blog/posts/latex-command-cheatsheet/) / [그리스 문자 정리](/blog/posts/latex-greek-letters-complete/) 글을 참고하세요.*
