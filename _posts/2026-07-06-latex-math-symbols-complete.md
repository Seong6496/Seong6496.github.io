---
title: "LaTeX 수학 기호 전체 목록 — 관계·집합·논리·연산·화살표"
date: 2026-07-06 09:00:00 +0900
categories: [LaTeX, Reference]
tags: [latex, 수학기호, 관계, 집합, 논리, 화살표, mathbb, reference]
math: true
pin: false
description: "LaTeX 수학 기호를 용도별로 한 번에 정리한 reference — 관계 (=, ≠, ≤, ≈), 집합 (∈, ⊂, ∪, ℝ), 논리 (∀, ∃, ⇒, ⇔), 연산 (×, ±, ⊕, ∘), 화살표 (→, ⇒, ↦) 까지. 수식 작업 중 막힐 때 옆 탭에 띄워두는 빠른 색인."
---

LaTeX 수식의 절반은 그리스 문자고 나머지 절반은 **수학 기호** — 관계 (=, ≤, ≈), 집합 (∈, ⊂), 논리 (∀, ⇒), 연산 (×, ±, ⊕), 화살표 (→, ↦) 입니다. 이 기호들은 외우기 어렵지 않지만, "분명 있었는데 명령어가 뭐였더라" 의 빈도가 가장 높은 영역이기도 합니다.

이 글은 책의 부록 B 후반부 (B.2~B.7) 를 한 페이지 reference 로 옮긴 것입니다. [#9 그리스 문자 전체 목록](/blog/posts/latex-greek-letters-complete/) 과 함께 옆 탭에 띄워두고 수식 작업 시 색인용으로 쓰면 됩니다.

전제: 프리앰블에 `\usepackage{amsmath}` + `\usepackage{amssymb}` 가 있어야 일부 기호가 동작합니다.

## 1. 관계 기호 — 등호·부등호·근사

| 명령어 | 기호 | 의미 |
|---|---|---|
| `=` | $=$ | 같음 |
| `\neq` | $\neq$ | 다름 |
| `<` | $<$ | 작음 |
| `>` | $>$ | 큼 |
| `\leq` (`\le`) | $\leq$ | 작거나 같음 |
| `\geq` (`\ge`) | $\geq$ | 크거나 같음 |
| `\ll` | $\ll$ | 훨씬 작음 |
| `\gg` | $\gg$ | 훨씬 큼 |
| `\approx` | $\approx$ | 근사 (≈) |
| `\sim` | $\sim$ | 비슷·분포 |
| `\simeq` | $\simeq$ | 근사적 같음 |
| `\equiv` | $\equiv$ | 항등·합동 |
| `\propto` | $\propto$ | 비례 |
| `\cong` | $\cong$ | 합동·이성형 |
| `\asymp` | $\asymp$ | 점근적 같음 |
| `\prec` / `\succ` | $\prec$ / $\succ$ | 순서 (선후) |
| `\preceq` / `\succeq` | $\preceq$ / $\succeq$ | 순서 (선후 이하) |

`\le` 와 `\leq` 는 같습니다 (마찬가지로 `\ge` = `\geq`). 짧은 쪽이 손에 편하면 그 쪽으로 통일하면 됩니다.

부정 관계는 거의 모든 기호 앞에 `\not` 을 붙일 수 있습니다.

```latex
$a \not= b$        % = ≠ (\neq 와 같음)
$x \not\in A$      % ∉
$P \not\Rightarrow Q$
```

특히 `\not\in` 보다 **`\notin`** 이 더 깔끔합니다.

## 2. 집합 기호

| 명령어 | 기호 | 의미 |
|---|---|---|
| `\in` | $\in$ | 원소 |
| `\notin` | $\notin$ | 원소 아님 |
| `\ni` | $\ni$ | 원소를 가짐 (역방향) |
| `\subset` | $\subset$ | 진부분집합 |
| `\subseteq` | $\subseteq$ | 부분집합 또는 같음 |
| `\supset` | $\supset$ | 진상위집합 |
| `\supseteq` | $\supseteq$ | 상위집합 또는 같음 |
| `\cup` | $\cup$ | 합집합 |
| `\cap` | $\cap$ | 교집합 |
| `\setminus` | $\setminus$ | 차집합 (A∖B) |
| `\emptyset` (`\varnothing`) | $\emptyset$ ($\varnothing$) | 공집합 |
| `\bigcup_{i}` | $\bigcup_i$ | 큰 합집합 (디스플레이) |
| `\bigcap_{i}` | $\bigcap_i$ | 큰 교집합 |

**`\emptyset` vs `\varnothing`** — 표준은 `\emptyset` 이고 모양은 $\emptyset$ 인데, 학술 출판물에서는 가운데가 더 뚜렷한 $\varnothing$ (`\varnothing`, `amssymb`) 을 선호하기도 합니다.

### 수 체계 — 칠판체 (\\mathbb)

```latex
\mathbb{R}    % 실수
\mathbb{N}    % 자연수
\mathbb{Z}    % 정수
\mathbb{Q}    % 유리수
\mathbb{C}    % 복소수
\mathbb{F}    % 일반 체 (field)
\mathbb{H}    % 사원수 (quaternions)
```

출력: $\mathbb{R}$, $\mathbb{N}$, $\mathbb{Z}$, $\mathbb{Q}$, $\mathbb{C}$.

음이 아닌 정수는 관례적으로 $\mathbb{Z}_{\geq 0}$ 또는 $\mathbb{N}_0$ 으로 적습니다 (분야 따라).

```latex
$\mathbb{Z}_{\geq 0}$
$\mathbb{N}_0$
```

## 3. 논리 기호

| 명령어 | 기호 | 의미 |
|---|---|---|
| `\forall` | $\forall$ | 모든 |
| `\exists` | $\exists$ | 존재 |
| `\nexists` | $\nexists$ | 존재하지 않음 (amssymb) |
| `\neg` (`\lnot`) | $\neg$ | 부정 |
| `\land` (`\wedge`) | $\land$ | AND (논리곱) |
| `\lor` (`\vee`) | $\lor$ | OR (논리합) |
| `\Rightarrow` (`\implies`) | $\Rightarrow$ | 함의 (→) |
| `\Leftrightarrow` (`\iff`) | $\Leftrightarrow$ | 동치 (⇔) |
| `\therefore` | $\therefore$ | 따라서 (∴) |
| `\because` | $\because$ | 왜냐하면 (∵) |
| `\top` | $\top$ | True / 최대 원소 |
| `\bot` | $\bot$ | False / 최소 원소 |

`\implies` 와 `\iff` 는 `amsmath` 가 제공합니다. `\Rightarrow` 와 같은 기호지만 **양옆 공백이 더 넓어** 본문 문장에 자연스럽게 들어갑니다.

```latex
% 둘 다 같은 기호. 공백만 다름.
$A \Rightarrow B$       % 좁은 공백
$A \implies B$          % 본문 호흡에 어울리는 공백
```

수학 글쓰기 관례상 정리 진술에는 `\implies` / `\iff`, 식 변형에는 `\Rightarrow` / `\Leftrightarrow` 가 자연스럽습니다.

## 4. 연산 기호

| 명령어 | 기호 | 의미 |
|---|---|---|
| `+` | $+$ | 더하기 |
| `-` | $-$ | 빼기 |
| `\pm` | $\pm$ | 플러스 마이너스 (±) |
| `\mp` | $\mp$ | 마이너스 플러스 (∓) |
| `\times` | $\times$ | 곱 (×) — 벡터곱 등 |
| `\div` | $\div$ | 나눗셈 (÷) |
| `\cdot` | $\cdot$ | 가운데 점 (·) — 스칼라 곱 |
| `\ast` | $\ast$ | 별표 (∗) — 합성·켤레 |
| `\star` | $\star$ | 큰 별 (⋆) |
| `\circ` | $\circ$ | 합성 (∘) — `f \circ g` |
| `\bullet` | $\bullet$ | 굵은 점 (•) |
| `\oplus` | $\oplus$ | 직합 (⊕) |
| `\ominus` | $\ominus$ | (⊖) |
| `\otimes` | $\otimes$ | 텐서곱 (⊗) |
| `\odot` | $\odot$ | (⊙) — Hadamard 곱 등 |
| `\sqrt{}` | $\sqrt{\;\;}$ | 제곱근 |
| `\sqrt[n]{}` | $\sqrt[n]{\;\;}$ | n 제곱근 |
| `\partial` | $\partial$ | 편미분 (∂) |
| `\nabla` | $\nabla$ | 그래디언트 (∇) |
| `\infty` | $\infty$ | 무한 (∞) |

`\cdot` 와 `\times` 의 구분이 헷갈리기 쉽습니다.

- $a \cdot b$ — 스칼라 곱, 또는 스칼라끼리의 곱셈을 명시적으로 보일 때
- $\mathbf{a} \times \mathbf{b}$ — **벡터의 외적**
- $A \times B$ — 집합의 곱 (데카르트 곱)

**일반 곱셈에서 점 안 찍기** 가 가장 깔끔합니다 — `ab` 그대로. 점이 필요한 건 변수가 모호하거나 큰 묶음을 분리할 때입니다.

### 큰 연산자 — 합·곱·합집합

```latex
\sum_{i=1}^{n} x_i        % 합
\prod_{i=1}^{n} x_i       % 곱
\int_a^b f(x) \, dx        % 적분
\iint_D f \, dA            % 이중 적분
\iiint_V f \, dV           % 삼중 적분
\oint_C f \, ds            % 선적분
\bigcup_{i=1}^n A_i        % 큰 합집합
\bigcap_{i=1}^n A_i        % 큰 교집합
\bigoplus_{i} V_i          % 큰 직합
\bigotimes_{i} V_i         % 큰 텐서곱
```

위·아래 첨자가 디스플레이 모드에서는 위·아래로, 인라인에서는 옆에 작게 붙습니다. 인라인에서도 위·아래로 보고 싶으면 `\limits` 를 씁니다.

```latex
% 인라인에서 위·아래로 강제
$\sum\limits_{i=1}^n x_i$

% 디스플레이에서 옆에 작게 강제
$$\sum\nolimits_{i=1}^n x_i$$
```

## 5. 화살표

| 명령어 | 기호 | 의미 |
|---|---|---|
| `\to` (`\rightarrow`) | $\to$ | 짧은 오른쪽 (→) |
| `\gets` (`\leftarrow`) | $\gets$ | 짧은 왼쪽 (←) |
| `\uparrow` / `\downarrow` | $\uparrow$ / $\downarrow$ | 위·아래 |
| `\leftrightarrow` | $\leftrightarrow$ | 양방향 |
| `\Rightarrow` | $\Rightarrow$ | 굵은 오른쪽 (⇒) |
| `\Leftarrow` | $\Leftarrow$ | 굵은 왼쪽 (⇐) |
| `\Leftrightarrow` | $\Leftrightarrow$ | 굵은 양방향 (⇔) |
| `\Uparrow` / `\Downarrow` | $\Uparrow$ / $\Downarrow$ | 굵은 위·아래 |
| `\mapsto` | $\mapsto$ | 사상 (↦) — `f: x \mapsto x^2` |
| `\longmapsto` | $\longmapsto$ | 긴 사상 (⟼) |
| `\longrightarrow` | $\longrightarrow$ | 긴 오른쪽 |
| `\Longrightarrow` | $\Longrightarrow$ | 긴 굵은 오른쪽 |
| `\hookrightarrow` | $\hookrightarrow$ | 매장 (↪) |
| `\twoheadrightarrow` | $\twoheadrightarrow$ | 전사 (↠, amssymb) |
| `\rightharpoonup` / `\rightharpoondown` | $\rightharpoonup$ / $\rightharpoondown$ | 평형 (한쪽) |
| `\rightleftharpoons` | $\rightleftharpoons$ | 평형 (양쪽) |

### \\to vs \\rightarrow vs \\mapsto

- `\to` = `\rightarrow` — 같은 짧은 오른쪽 화살표 ($\to$)
- `\mapsto` = "보낸다" 의 의미가 있는 사상 화살표 ($\mapsto$)

함수 정의에서 `\mapsto` 와 `\to` 의 구분은 학술적으로 의미가 있습니다.

```latex
$f: \mathbb{R} \to \mathbb{R}$       % 함수의 정의역·치역 표기
$f: x \mapsto x^2$                   % 입력 → 출력 매핑 규칙
```

`\to` 는 "타입" 이고 `\mapsto` 는 "값" 입니다. `f: \mathbb{R} \mapsto \mathbb{R}` 이라고 적지 않습니다 — 실수 전체가 다른 실수 전체로 보내지는 게 아니라, 각 점이 점으로 보내지는 것이기 때문입니다.

## 6. 머리 표시 — 모자·바·벡터

| 명령어 | 결과 |
|---|---|
| `\hat{x}` | $\hat{x}$ — 모자 |
| `\widehat{abc}` | $\widehat{abc}$ — 넓은 모자 |
| `\bar{x}` | $\bar{x}$ — 짧은 바 (평균) |
| `\overline{abc}` | $\overline{abc}$ — 긴 바 (켤레·집합 보집합) |
| `\tilde{x}` | $\tilde{x}$ — 짧은 물결 |
| `\widetilde{abc}` | $\widetilde{abc}$ — 넓은 물결 |
| `\vec{v}` | $\vec{v}$ — 화살표 |
| `\overrightarrow{AB}` | $\overrightarrow{AB}$ — 긴 벡터 (점에서 점) |
| `\dot{x}` | $\dot{x}$ — 시간 미분 (1차) |
| `\ddot{x}` | $\ddot{x}$ — 시간 미분 (2차) |

`\hat{x}` 와 `\widehat{x}` 의 모양 차이는 미세하지만 한 글자에는 `\hat`, 여러 글자에는 `\widehat` 이 자연스럽습니다.

```latex
$\hat{\beta}$                       % 한 글자 — 모자가 변수에 딱 맞음
$\widehat{\boldsymbol{\beta}}$      % 여러 토큰 — 넓은 모자
```

## 7. 자주 쓰는 묶음 — Top 30

매번 표 전체를 뒤지진 않습니다. 실제로 본문에 가장 자주 등장하는 30 개만 손에 익히면 80% 의 수식 작업이 막힘 없이 진행됩니다.

| 영역 | 명령어 |
|---|---|
| 관계 | `\leq`, `\geq`, `\neq`, `\approx`, `\sim`, `\equiv` |
| 집합 | `\in`, `\notin`, `\subset`, `\cup`, `\cap`, `\emptyset` |
| 수 체계 | `\mathbb{R}`, `\mathbb{N}`, `\mathbb{Z}`, `\mathbb{C}` |
| 논리 | `\forall`, `\exists`, `\Rightarrow`, `\Leftrightarrow` |
| 연산 | `\pm`, `\times`, `\cdot`, `\otimes`, `\circ`, `\partial`, `\nabla` |
| 큰 연산 | `\sum`, `\prod`, `\int`, `\bigcup` |
| 화살표 | `\to`, `\mapsto`, `\Rightarrow` |
| 머리 | `\hat`, `\bar`, `\vec`, `\dot` |

## 8. 함정 정리 — 자주 막히는 곳

| 함정 | 원인 | 해결 |
|---|---|---|
| `\mathbb`, `\mathcal` Undefined | `amssymb` 패키지 누락 | 프리앰블에 `\usepackage{amssymb}` |
| `\nexists`, `\varnothing` Undefined | 같은 이유 | 같은 해결 |
| `\Rightarrow` 와 `\implies` 차이 안 보임 | 같은 기호, 공백만 다름 | 본문 흐름에서는 `\implies`, 식 변형에서는 `\Rightarrow` |
| `f: A \mapsto B` 가 어색함 | `\mapsto` 는 점-대-점, `\to` 는 집합-대-집합 | 함수의 정의역·치역에는 `\to` 만 |
| `\bar` 가 너무 짧음 (여러 글자 위) | `\bar` 는 한 글자용 | 여러 글자에는 `\overline{}` |
| 점곱과 외적이 같은 `\cdot` 으로 적힘 | 의미가 섞임 | 외적은 `\times`, 점곱은 `\cdot` 으로 명확히 |

## 정리

수학 기호는 외우는 게 아니라 **반복적으로 찾아 쓰며 손에 익히는 것** 입니다. 처음에는 이 글의 표를 옆 탭에 띄워두고 색인용으로 쓰다가, 자주 쓰는 30 개 정도가 손에 붙으면 나머지는 그때그때 찾으면 됩니다.

이 글이 reference 트랙의 마지막 묶음입니다. [그리스 문자](/blog/posts/latex-greek-letters-complete/) + 수학 기호 (이 글) + [치트시트](/blog/posts/latex-command-cheatsheet/) 세 글이 곁에 있으면, LaTeX 본문 작업의 99% 가 한 페이지 안에서 해결됩니다.

다음 글 (#11) 부터는 책 1·2장의 내용을 바탕으로 **Word/Docs 로 논문 쓰다 막힌 분께 — LaTeX 가 다른 이유** 라는 essay 형식으로 넘어갑니다. 이 시리즈의 "왜" 를 다루는 글입니다.

---

이전 글: [#9 LaTeX 그리스 문자 전체 목록 — 소·대문자와 이형 문자까지](/blog/posts/latex-greek-letters-complete/)
다음 글: [#11 Word·Google Docs 로 논문 쓰다 막힌 분께 — LaTeX 가 다른 이유](/blog/posts/latex-vs-word-docs/)

> **Google Docs / Word 의 수식을 한 번에 깔끔하게** — [LaTeXFlow Web 바로 가기](https://mathsystem.dev/latexflow/web/) (sign-in 없이 즉시)
{: .prompt-info }
