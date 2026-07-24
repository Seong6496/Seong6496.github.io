---
title: "LaTeX 그리스 문자·수학 기호 완전 레퍼런스 — 자모·이형부터 관계·집합·논리·화살표까지"
date: 2026-07-03 09:00:00 +0900
categories: [LaTeX, Reference]
tags: [latex, 그리스문자, 수학기호, alpha, sigma, varepsilon, varphi, mathbb, 관계, 집합, 논리, 화살표, reference]
math: true
pin: false
redirect_from:
  - /blog/posts/latex-math-symbols-complete/
description: "LaTeX 그리스 문자 24 자모(소·대문자·이형)와 수학 기호(관계·집합·논리·연산·화살표·머리표시)를 한 페이지에 정리한 레퍼런스. 명령어 목록에 더해 각 기호를 '언제·어떤 뜻으로' 쓰는지, 한국어(kotex) 문서에서 마주치는 함정까지 함께 짚습니다."
---

수식 작업 중 손이 멈추는 순간의 90% 는 두 가지입니다. **그리스 문자** — 알파(α), 시그마(σ) 처럼 키보드에 없는 글자 — 와 **수학 기호** — 관계(≤, ≈), 집합(∈, ⊂), 논리(∀, ⇒), 화살표(→, ↦) 입니다. "분명 있었는데 명령어가 뭐였더라" 가 매번 발목을 잡죠.

이 글은 그 둘을 **한 페이지에 통째로** 모은 레퍼런스입니다. 단순히 "명령어 = 기호" 를 나열하는 표는 이미 인터넷에 많습니다. 이 글이 다른 점은 세 가지입니다.

- **용도를 함께 적었습니다.** `\lambda` 가 고윳값인지 파장인지, `\to` 와 `\mapsto` 가 어떻게 다른지 — 명령어를 찾은 다음 "이걸 여기 써도 되나" 를 다시 검색하지 않게.
- **한국어(kotex) 문서에서 실제로 걸리는 함정**을 짚습니다. 본문에 ε 을 한글 폰트로 직접 입력했을 때, `\varepsilon` 과 `\epsilon` 을 혼용했을 때 무슨 일이 생기는지.
- **옆 탭에 띄워두고 색인처럼** 쓰도록 영역별로 나눴습니다. 전체를 외우는 표가 아니라, 필요할 때 그 칸만 보는 표입니다.

전제: 프리앰블에 `\usepackage{amsmath}` 와 `\usepackage{amssymb}` 가 있어야 일부 이형·기호 명령어가 동작합니다. 수식을 쓰는 문서라면 이 두 줄은 처음부터 넣어 두는 편이 낫습니다.

---

# 1부 · 그리스 문자

## 1.1 작명 규칙 — 외우기보다 추측하기

그리스 문자 명령어는 **그리스 자모 이름 그대로** 입니다.

```latex
\alpha   → α
\beta    → β
\gamma   → γ
\delta   → δ
```

대문자는 명령어 첫 글자만 대문자로 바꿉니다.

```latex
\Gamma   → Γ
\Delta   → Δ
```

핵심 함정 하나: **대문자가 영문 알파벳과 똑같이 생긴 자모는 LaTeX 명령어가 없습니다.** 예를 들어 알파의 대문자 (Α) 는 영문 `A` 와 같은 모양이므로, `\Alpha` 가 아니라 그냥 `A` 라고 적습니다.

```latex
% 틀린 예 — \Alpha, \Beta 같은 건 없음
$\Alpha + \Beta$    % → Undefined control sequence

% 올바른 예 — 영문 대문자 그대로
$A + B$             % → A + B
```

대문자 명령어가 **존재하는** 자모는 `\Gamma`, `\Delta`, `\Theta`, `\Lambda`, `\Xi`, `\Pi`, `\Sigma`, `\Upsilon`, `\Phi`, `\Psi`, `\Omega` 뿐입니다. 그 외 (Α, Β, Ε, Ζ, Η, Ι, Κ, Μ, Ν, Ο, Ρ, Τ, Χ) 는 영문자와 모양이 같아 명령어 없음 — 그냥 영문 대문자로 적습니다.

## 1.2 그리스 자모 전체 표

| 자모 | 소문자 명령어 | 소문자 | 대문자 명령어 | 대문자 | 이형 |
|---|---|---|---|---|---|
| 알파 | `\alpha` | $\alpha$ | `A` | $A$ | — |
| 베타 | `\beta` | $\beta$ | `B` | $B$ | — |
| 감마 | `\gamma` | $\gamma$ | `\Gamma` | $\Gamma$ | — |
| 델타 | `\delta` | $\delta$ | `\Delta` | $\Delta$ | — |
| 엡실론 | `\epsilon` | $\epsilon$ | `E` | $E$ | `\varepsilon` ($\varepsilon$) |
| 제타 | `\zeta` | $\zeta$ | `Z` | $Z$ | — |
| 에타 | `\eta` | $\eta$ | `H` | $H$ | — |
| 세타 | `\theta` | $\theta$ | `\Theta` | $\Theta$ | `\vartheta` ($\vartheta$) |
| 요타 | `\iota` | $\iota$ | `I` | $I$ | — |
| 카파 | `\kappa` | $\kappa$ | `K` | $K$ | `\varkappa` ($\varkappa$, amssymb) |
| 람다 | `\lambda` | $\lambda$ | `\Lambda` | $\Lambda$ | — |
| 뮤 | `\mu` | $\mu$ | `M` | $M$ | — |
| 뉴 | `\nu` | $\nu$ | `N` | $N$ | — |
| 크사이 | `\xi` | $\xi$ | `\Xi` | $\Xi$ | — |
| 오미크론 | `o` | $o$ | `O` | $O$ | — |
| 파이 | `\pi` | $\pi$ | `\Pi` | $\Pi$ | `\varpi` ($\varpi$) |
| 로 | `\rho` | $\rho$ | `P` | $P$ | `\varrho` ($\varrho$) |
| 시그마 | `\sigma` | $\sigma$ | `\Sigma` | $\Sigma$ | `\varsigma` ($\varsigma$) |
| 타우 | `\tau` | $\tau$ | `T` | $T$ | — |
| 입실론 | `\upsilon` | $\upsilon$ | `\Upsilon` | $\Upsilon$ | — |
| 파이 (φ) | `\phi` | $\phi$ | `\Phi` | $\Phi$ | `\varphi` ($\varphi$) |
| 카이 | `\chi` | $\chi$ | `X` | $X$ | — |
| 프사이 | `\psi` | $\psi$ | `\Psi` | $\Psi$ | — |
| 오메가 | `\omega` | $\omega$ | `\Omega` | $\Omega$ | — |

오미크론 (`o`) 도 영문 소문자 `o` 와 모양이 같아 명령어 없음. 그냥 `o` 입니다.

## 1.3 이형 (variant) 문자 — 7 개의 두 얼굴

같은 자모인데 모양이 두 가지인 경우가 있습니다. LaTeX 에서는 기본형 + `\var` 접두어 형태로 둘 다 지원합니다.

| 자모 | 기본 | 이형 | 학술 관례 |
|---|---|---|---|
| 엡실론 | $\epsilon$ (`\epsilon`) | $\varepsilon$ (`\varepsilon`) | **수학에선 이형이 표준** — `\varepsilon` 권장 |
| 세타 | $\theta$ (`\theta`) | $\vartheta$ (`\vartheta`) | 기본형이 표준 |
| 카파 | $\kappa$ (`\kappa`) | $\varkappa$ (`\varkappa`) | 기본형이 표준 |
| 파이 (소) | $\pi$ (`\pi`) | $\varpi$ (`\varpi`) | 기본형이 표준, 이형은 가끔 |
| 로 | $\rho$ (`\rho`) | $\varrho$ (`\varrho`) | 기본형이 표준 |
| 시그마 | $\sigma$ (`\sigma`) | $\varsigma$ (`\varsigma`) | 이형은 **그리스어 단어 끝 시그마** 에만 사용. 수학에선 거의 안 쓰임 |
| 파이 (φ) | $\phi$ (`\phi`) | $\varphi$ (`\varphi`) | 분야에 따라 다름. 수학에서 `\varphi`, 물리에서 `\phi` 가 흔함 |

### 함정 — \epsilon 과 \varepsilon

가장 자주 마주치는 이형 함정입니다. `\epsilon` 은 컴퓨터 키보드의 ε 처럼 보이지만, **수학 논문의 표준 ε 는 `\varepsilon`** 입니다.

```latex
% 일반적으로 안 쓰임
$\epsilon > 0$         % → ϵ — 모양이 컴퓨터스러움

% 수학 표준
$\varepsilon > 0$      % → ε — 손글씨 모양
```

대학원 수학 교재의 대부분이 `\varepsilon` 을 씁니다. 컴파일은 둘 다 되지만, 의도가 수학적 ε 이라면 `\varepsilon` 이 맞습니다. 물리·공학에서 유전율 ϵ 은 반대로 `\epsilon` 을 쓰는 관례가 있으니, **소속 분야의 교과서를 확인해 하나로 통일**하세요. 같은 문서에서 두 모양이 섞이면 독자가 서로 다른 변수로 오해합니다.

### \phi vs \varphi

물리·공학에서 각도 φ 는 보통 `\phi` ($\phi$), 수학에서 함수 φ 는 `\varphi` ($\varphi$). 두 분야가 섞인 글에서는 본인이 의도한 모양으로 통일하는 게 중요합니다.

## 1.4 자주 쓰는 그리스 문자 — 학술 등장 빈도

매번 표 전체를 뒤지진 않습니다. 실제 논문 본문에서 가장 자주 보이는 것을 추려 두면 그리스 문자 사용의 대부분이 이 안에서 해결됩니다.

| 문자 | 명령어 | 학술 빈출 용도 |
|---|---|---|
| $\alpha$ | `\alpha` | 학습률·유의수준·계수 |
| $\beta$ | `\beta` | 회귀 계수·감쇠 (물리) |
| $\gamma$ | `\gamma` | 감쇠·로런츠 인자·할인율 |
| $\delta$ | `\delta` | 변화량·미소·크로네커 델타 |
| $\Delta$ | `\Delta` | 차이·라플라시안 |
| $\varepsilon$ | `\varepsilon` | 극소 수·오차항 |
| $\theta$ | `\theta` | 각도·모수 |
| $\lambda$ | `\lambda` | 파장·고윳값·정규화 강도 |
| $\mu$ | `\mu` | 평균·이동도·측도 |
| $\pi$ | `\pi` | 원주율·확률 분포·정책 함수 |
| $\rho$ | `\rho` | 상관계수·밀도 |
| $\sigma$ | `\sigma` | 표준편차·응력·활성화 함수 |
| $\Sigma$ | `\Sigma` | 합·공분산 행렬 |
| $\phi$ / $\varphi$ | `\phi` / `\varphi` | 위상·함수·황금비 |
| $\Omega$ | `\Omega` | 옴·표본 공간·각속도 |

이 정도만 손에 익으면 본문 그리스 문자의 절반 이상이 막힘 없이 흘러갑니다. 다만 합과 곱은 보통 $\Sigma$, $\Pi$ 를 직접 쓰지 않고 `\sum`, `\prod` 명령어로 들어갑니다 (아래 2.4 큰 연산자 참고).

## 1.5 굵은 그리스 문자 — 벡터 표기

벡터 변수를 굵게 표시할 때 영문자는 `\mathbf{v}` 로 처리되지만, 그리스 문자는 `\mathbf` 이 안 먹습니다. 이 경우 `\boldsymbol` 을 씁니다.

```latex
% 영문 벡터
$\mathbf{v} = (v_1, v_2, v_3)$

% 그리스 벡터 — \mathbf 안 됨
$\boldsymbol{\alpha} + \boldsymbol{\beta}$

% 그리스 대문자 벡터·행렬
$\boldsymbol{\Sigma}$              % 공분산 행렬
$\boldsymbol{\Lambda}$             % 대각 고유값 행렬
```

`bm` 패키지의 `\bm{...}` 도 같은 역할을 하며, 더 견고하다는 평이 있습니다.

```latex
\usepackage{bm}
$\bm{\alpha} \cdot \bm{\beta}$
```

---

# 2부 · 수학 기호

그리스 문자가 수식의 절반이라면 나머지 절반은 **기호** — 관계·집합·논리·연산·화살표·머리표시 입니다. 외우기 어렵진 않지만 "명령어가 뭐였더라" 의 빈도가 가장 높은 영역입니다.

## 2.1 관계 기호 — 등호·부등호·근사

| 명령어 | 기호 | 의미 |
|---|---|---|
| `=` | $=$ | 같음 |
| `\neq` | $\neq$ | 다름 |
| `<` / `>` | $<$ / $>$ | 작음 / 큼 |
| `\leq` (`\le`) | $\leq$ | 작거나 같음 |
| `\geq` (`\ge`) | $\geq$ | 크거나 같음 |
| `\ll` / `\gg` | $\ll$ / $\gg$ | 훨씬 작음 / 큼 |
| `\approx` | $\approx$ | 근사 (≈) |
| `\sim` | $\sim$ | 비슷·분포 |
| `\simeq` | $\simeq$ | 근사적 같음 |
| `\equiv` | $\equiv$ | 항등·정의·합동 |
| `\propto` | $\propto$ | 비례 |
| `\cong` | $\cong$ | 합동·동형 |
| `\prec` / `\succ` | $\prec$ / $\succ$ | 순서 (선후) |

`\le` 와 `\leq` 는 같습니다 (`\ge` = `\geq`). `\equiv` 는 **정의** ("이 식을 이렇게 정의한다") 와 **항등** ("모든 입력에서 같다") 두 뜻으로 쓰이니 문맥에서 결정합니다. 부정 관계는 대부분 앞에 `\not` 을 붙일 수 있지만, `\not\in` 보다 **`\notin`** 이 더 깔끔합니다.

```latex
$a \not= b$        % ≠ (\neq 와 같음)
$x \notin A$       % ∉ — \not\in 보다 권장
```

## 2.2 집합 기호와 수 체계

| 명령어 | 기호 | 의미 |
|---|---|---|
| `\in` / `\notin` | $\in$ / $\notin$ | 원소 / 원소 아님 |
| `\ni` | $\ni$ | 원소를 가짐 (역방향) |
| `\subset` / `\supset` | $\subset$ / $\supset$ | 진부분집합 / 진상위집합 |
| `\subseteq` / `\supseteq` | $\subseteq$ / $\supseteq$ | 부분집합 이하 / 상위집합 이상 |
| `\cup` / `\cap` | $\cup$ / $\cap$ | 합집합 / 교집합 |
| `\setminus` | $\setminus$ | 차집합 (A∖B) |
| `\emptyset` (`\varnothing`) | $\emptyset$ ($\varnothing$) | 공집합 |
| `\bigcup_{i}` / `\bigcap_{i}` | $\bigcup_i$ / $\bigcap_i$ | 큰 합·교집합 |

수 체계는 `\mathbb{}` 안에 영문 대문자로 적습니다.

```latex
\mathbb{R}    % 실수     \mathbb{Q}    % 유리수
\mathbb{N}    % 자연수   \mathbb{C}    % 복소수
\mathbb{Z}    % 정수     \mathbb{F}    % 일반 체(field)
```

출력: $\mathbb{R}$, $\mathbb{N}$, $\mathbb{Z}$, $\mathbb{Q}$, $\mathbb{C}$. 음이 아닌 정수는 분야에 따라 $\mathbb{Z}_{\geq 0}$ 또는 $\mathbb{N}_0$ 으로 적습니다. **`\emptyset` vs `\varnothing`** — 표준은 `\emptyset`($\emptyset$) 이지만 학술 출판물은 가운데가 뚜렷한 $\varnothing$(`\varnothing`, `amssymb`) 을 선호하기도 합니다.

## 2.3 논리 기호

| 명령어 | 기호 | 의미 |
|---|---|---|
| `\forall` / `\exists` | $\forall$ / $\exists$ | 모든 / 존재 |
| `\nexists` | $\nexists$ | 존재하지 않음 (amssymb) |
| `\neg` (`\lnot`) | $\neg$ | 부정 |
| `\land` (`\wedge`) | $\land$ | AND (논리곱) |
| `\lor` (`\vee`) | $\lor$ | OR (논리합) |
| `\Rightarrow` (`\implies`) | $\Rightarrow$ | 함의 |
| `\Leftrightarrow` (`\iff`) | $\Leftrightarrow$ | 동치 |
| `\therefore` / `\because` | $\therefore$ / $\because$ | 따라서 / 왜냐하면 |
| `\top` / `\bot` | $\top$ / $\bot$ | True·최대 / False·최소 |

`\implies` 와 `\iff` 는 `\Rightarrow`·`\Leftrightarrow` 와 같은 기호지만 **양옆 공백이 더 넓어** 본문 문장에 자연스럽게 들어갑니다. 관례상 정리 진술에는 `\implies` / `\iff`, 식 변형에는 `\Rightarrow` / `\Leftrightarrow` 가 어울립니다.

## 2.4 연산 기호와 큰 연산자

| 명령어 | 기호 | 의미 |
|---|---|---|
| `\pm` / `\mp` | $\pm$ / $\mp$ | 플러스마이너스 / 마이너스플러스 |
| `\times` / `\div` | $\times$ / $\div$ | 곱 / 나눗셈 |
| `\cdot` | $\cdot$ | 가운데 점 — 스칼라 곱 |
| `\ast` / `\star` | $\ast$ / $\star$ | 별표 — 합성·켤레 |
| `\circ` | $\circ$ | 합성 (`f \circ g`) |
| `\oplus` / `\otimes` / `\odot` | $\oplus$ / $\otimes$ / $\odot$ | 직합 / 텐서곱 / Hadamard 곱 |
| `\partial` / `\nabla` | $\partial$ / $\nabla$ | 편미분 / 그래디언트 |
| `\infty` | $\infty$ | 무한 |

`\cdot` 와 `\times` 의 구분이 자주 헷갈립니다. $a \cdot b$ 는 스칼라 곱, $\mathbf{a} \times \mathbf{b}$ 는 **벡터의 외적**, $A \times B$ 는 집합의 데카르트 곱입니다. 일반 곱셈은 점 없이 `ab` 로 붙여 쓰는 게 가장 깔끔하고, 점은 변수가 모호하거나 큰 묶음을 분리할 때만 씁니다.

큰 연산자는 위·아래 첨자로 범위를 붙입니다.

```latex
\sum_{i=1}^{n} x_i        % 합
\prod_{i=1}^{n} x_i       % 곱
\int_a^b f(x) \, dx        % 적분
\iint_D f \, dA            % 이중 적분
\oint_C f \, ds            % 선적분
\bigcup_{i=1}^n A_i        % 큰 합집합
```

디스플레이 모드에서는 첨자가 위·아래로, 인라인에서는 옆에 작게 붙습니다. 인라인에서도 위·아래로 강제하려면 `\sum\limits_{i=1}^n`, 디스플레이에서 옆으로 강제하려면 `\sum\nolimits` 를 씁니다.

## 2.5 화살표

| 명령어 | 기호 | 의미 |
|---|---|---|
| `\to` (`\rightarrow`) | $\to$ | 짧은 오른쪽 |
| `\gets` (`\leftarrow`) | $\gets$ | 짧은 왼쪽 |
| `\leftrightarrow` | $\leftrightarrow$ | 양방향 |
| `\Rightarrow` / `\Leftarrow` | $\Rightarrow$ / $\Leftarrow$ | 굵은 오른쪽 / 왼쪽 |
| `\Leftrightarrow` | $\Leftrightarrow$ | 굵은 양방향 |
| `\mapsto` | $\mapsto$ | 사상 (`f: x \mapsto x^2`) |
| `\longmapsto` | $\longmapsto$ | 긴 사상 |
| `\hookrightarrow` | $\hookrightarrow$ | 매장 (단사) |
| `\twoheadrightarrow` | $\twoheadrightarrow$ | 전사 (amssymb) |
| `\rightleftharpoons` | $\rightleftharpoons$ | 평형 (양쪽) |

### \to vs \mapsto — 타입과 값

함수 정의에서 이 둘의 구분은 학술적으로 의미가 있습니다.

```latex
$f: \mathbb{R} \to \mathbb{R}$       % 정의역·치역 (타입)
$f: x \mapsto x^2$                   % 입력 → 출력 규칙 (값)
```

`\to` 는 "집합에서 집합으로" (타입), `\mapsto` 는 "점에서 점으로" (값) 입니다. `f: \mathbb{R} \mapsto \mathbb{R}` 이라고 적지 않습니다 — 실수 전체가 다른 실수 전체로 보내지는 게 아니라 각 점이 점으로 보내지기 때문입니다.

## 2.6 머리 표시 — 모자·바·벡터

| 명령어 | 결과 | 용도 |
|---|---|---|
| `\hat{x}` / `\widehat{abc}` | $\hat{x}$ / $\widehat{abc}$ | 추정량·단위 벡터 (한 글자 / 여러 글자) |
| `\bar{x}` / `\overline{abc}` | $\bar{x}$ / $\overline{abc}$ | 평균 (짧은 바) / 켤레·보집합 (긴 바) |
| `\tilde{x}` / `\widetilde{abc}` | $\tilde{x}$ / $\widetilde{abc}$ | 근사·변형 |
| `\vec{v}` / `\overrightarrow{AB}` | $\vec{v}$ / $\overrightarrow{AB}$ | 벡터 / 점에서 점 |
| `\dot{x}` / `\ddot{x}` | $\dot{x}$ / $\ddot{x}$ | 시간 1차·2차 미분 |

한 글자에는 `\hat`, 여러 글자에는 `\widehat` 이 자연스럽습니다. 마찬가지로 평균은 `\bar{x}`, 여러 토큰 위 바는 `\overline{...}`.

## 2.7 자주 쓰는 30 개 — 손에 익힐 묶음

전체 표를 매번 뒤지지 않으려면 이 정도만 손에 붙이면 됩니다.

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

---

## 함정 정리 — 그리스·기호 작성 시 자주 막히는 곳

| 함정 | 원인 | 해결 |
|---|---|---|
| `\Alpha` 가 안 됨 | 영문 A 와 같은 모양은 명령어 없음 | 그냥 `A` 로 적기 |
| `\epsilon` 이 이상하게 생김 | 수학 표준은 이형 (`\varepsilon`) | `\varepsilon` 으로 바꾸기 |
| `\mathbb`·`\varnothing`·`\nexists` Undefined | `amssymb` 패키지 누락 | 프리앰블에 `\usepackage{amssymb}` |
| 그리스 벡터에 `\mathbf` 이 안 먹힘 | `\mathbf` 은 로마자 전용 | `\boldsymbol{...}` 또는 `\bm{...}` |
| 본문에 ε 을 한글 폰트로 직접 입력 | 폰트에 따라 안 보이거나 비표준 | 수식 환경 안에서 `\varepsilon` 명령어 사용 |
| `f: A \mapsto B` 가 어색함 | `\mapsto` 는 점-대-점 | 정의역·치역에는 `\to` |
| `\bar` 가 여러 글자 위에서 짧음 | `\bar` 는 한 글자용 | 여러 글자에는 `\overline{}` |

## 정리

그리스 문자는 **작명 규칙 + 두 함정** (대문자 명령어가 다 있지는 않다, 같은 자모에 이형이 있다) 만 비켜 가면 끝입니다. 수학 기호는 영역별로 자주 쓰는 것 몇 개씩만 손에 익히면 본문 흐름이 끊기지 않습니다. 처음에는 이 표를 옆 탭에 띄워두고 색인처럼 쓰다가, 자주 쓰는 30 개가 손에 붙으면 나머지는 그때그때 찾으면 됩니다.

핵심 두 가지만 챙기세요.

1. **대문자가 영문과 같은 모양인 자모는 그냥 영문 대문자로 적는다.** `\Alpha` 같은 건 없습니다.
2. **함의 `⇒` 는 대문자 화살표.** `\to` 는 사상·극한, `\Rightarrow` 는 명제 함의 — 둘이 다른 뜻입니다.

---

이전 글: <a href="/blog/posts/latex-command-cheatsheet/" data-proofer-ignore>#8 LaTeX 명령어 치트시트 — 논문 한 편에 실제로 쓰는 것만</a>
다음 글: <a href="/blog/posts/latex-vs-word-docs/" data-proofer-ignore>#11 Word·Google Docs 로 논문 쓰다 막힌 분께 — LaTeX 가 다른 이유</a>

> **LaTeX 가 Word 에서 수식 처리 되지 않아, 하나씩 다시 쓰고 계신가요?**
> Docs·Word 파일을 올리면 `$...$` · `$$...$$` · `\(...\)` · `\[...\]` · `[...]` 로 감싼 수식을 골라 이미지로 바꿔 돌려줍니다.
> [LaTeXFlow Web 열기](https://mathsystem.dev/latexflow/web/) — 로그인 없이, 드래그 한 번
{: .prompt-info }
