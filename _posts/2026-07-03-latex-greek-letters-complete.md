---
title: "LaTeX 그리스 문자 전체 목록 — 소·대문자와 이형 문자까지"
date: 2026-07-03 09:00:00 +0900
categories: [LaTeX, Reference]
tags: [latex, 그리스문자, alpha, beta, gamma, sigma, varepsilon, varphi, reference]
math: true
pin: false
description: "LaTeX 그리스 문자 24 자모의 소문자·대문자 명령어와 이형 문자 (\\varepsilon, \\vartheta, \\varphi 등) 를 한 번에 정리한 reference. 대문자에 없는 명령어 (A, B 등 영문자와 동일), 이형이 존재하는 7 자모, 자주 쓰는 용도까지."
---

LaTeX 수식에 가장 자주 등장하는 비-영어 글자는 그리스 문자입니다. **24 자모 × 소·대문자 + 7 개의 이형 (var-form)** — 외울 분량이 그리 많지 않은데, "이게 분명 있었는데 명령어가 뭐였더라" 가 매번 발목을 잡습니다.

이 글은 그 24 자모 + 이형 문자를 **한 페이지에 통째로** 정리한 reference 입니다. 영문 알파벳과 모양이 같아 그리스 명령어가 아예 없는 자모, 두 가지 모양이 모두 쓰이는 이형 (variant), 그리고 각 문자가 학술적으로 자주 등장하는 용도까지 함께 짚습니다.

전제: 프리앰블에 `\usepackage{amsmath}` 와 `\usepackage{amssymb}` 가 있어야 일부 이형 명령어가 동작합니다.

## 1. 작명 규칙 — 외우기보다 추측하기

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

대문자 명령어가 **존재하는** 자모는 8 개뿐입니다: `\Gamma`, `\Delta`, `\Theta`, `\Lambda`, `\Xi`, `\Pi`, `\Sigma`, `\Upsilon`, `\Phi`, `\Psi`, `\Omega`. 그 외 (Α, Β, Ε, Ζ, Η, Ι, Κ, Μ, Ν, Ο, Ρ, Τ, Χ) 는 영문자와 모양이 같아 명령어 없음 — 그냥 영문 대문자로 적습니다.

## 2. 그리스 자모 전체 표

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

## 3. 이형 (variant) 문자 — 7 개의 두 얼굴

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

대학원 수학 교재의 99% 가 `\varepsilon` 을 씁니다. 컴파일은 둘 다 되지만, 의도가 수학적 ε 이라면 `\varepsilon` 이 맞습니다.

### \phi vs \varphi

물리·공학에서 각도 φ 는 보통 `\phi` ($\phi$), 수학에서 함수 φ 는 `\varphi` ($\varphi$). 두 분야가 섞인 글에서는 본인이 의도한 모양으로 통일하는 게 중요합니다.

## 4. 자주 쓰는 그리스 문자 12 개 — 학술 등장 빈도

매번 표 전체를 뒤지진 않습니다. 실제 논문 본문에서 가장 자주 보이는 12 개를 추려 두면 80% 의 그리스 문자 사용이 이 안에서 해결됩니다.

| 문자 | 명령어 | 학술 빈출 용도 |
|---|---|---|
| $\alpha$ | `\alpha` | 학습률·유의수준·계수 |
| $\beta$ | `\beta` | 회귀 계수·세제곱 가속 (물리) |
| $\gamma$ | `\gamma` | 감쇠·로런츠 인자 |
| $\delta$ | `\delta` | 변화량·미소·크로네커 델타 |
| $\Delta$ | `\Delta` | 차이·라플라시안 |
| $\varepsilon$ | `\varepsilon` | 극소 수·오차항 |
| $\theta$ | `\theta` | 각도·모수 |
| $\lambda$ | `\lambda` | 파장·고유값·매개변수 |
| $\mu$ | `\mu` | 평균·이동도·뮤 ($\mu$m) |
| $\pi$ | `\pi` | 원주율·확률 분포 표기 |
| $\sigma$ | `\sigma` | 표준편차·응력·시그마 행렬 |
| $\Sigma$ | `\Sigma` | 합·공분산 행렬 |
| $\phi$ / $\varphi$ | `\phi` / `\varphi` | 위상·함수 |
| $\Omega$ | `\Omega` | 옴·표본 공간 |

이 14 개 (실용상 12 개 + 자주 보이는 대문자 2 개) 만 손에 익으면 본문 그리스 문자의 절반 이상이 막힘 없이 흘러갑니다.

## 5. 굵은 그리스 문자 — 벡터 표기

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

`\boldsymbol` 은 `amsmath` 안의 `\boldmath` 후속 명령어로, 그리스·로마 모두 굵게 처리합니다. `bm` 패키지의 `\bm{...}` 도 같은 역할을 하며, 더 견고하다는 평이 있습니다.

```latex
\usepackage{bm}
$\bm{\alpha} \cdot \bm{\beta}$
```

## 6. 칠판체·필기체 — \\mathbb, \\mathcal

그리스 문자와 자주 같이 등장하는 게 칠판체 (blackboard) 와 필기체 (calligraphic) 입니다. 둘 다 영문 대문자 전용입니다.

```latex
% 칠판체 — 수 집합
$\mathbb{R}$    % 실수
$\mathbb{N}$    % 자연수
$\mathbb{Z}$    % 정수
$\mathbb{Q}$    % 유리수
$\mathbb{C}$    % 복소수

% 필기체 — 시그마 대수·이론
$\mathcal{F}$   % 시그마 대수
$\mathcal{L}$   % 라그랑지안·라플라스
$\mathcal{O}$   % 빅 오 표기
$\mathcal{N}$   % 정규 분포
```

`\mathbb` 는 `amssymb`, `\mathcal` 는 표준 LaTeX 만으로도 동작합니다.

## 7. 함정 정리 — 그리스 문자 작성 시 자주 막히는 곳

| 함정 | 원인 | 해결 |
|---|---|---|
| `\Alpha` 가 안 됨 | 영문 A 와 같은 모양은 명령어 없음 | 그냥 `A` 로 적기 |
| `\epsilon` 이 이상하게 생김 | 수학 표준은 이형 (`\varepsilon`) | `\varepsilon` 으로 바꾸기 |
| `\boldmath` 가 안 먹힘 | 일반 `\mathbf` 은 그리스에 안 통함 | `\boldsymbol{...}` 또는 `\bm{...}` |
| `\mathbb` Undefined | `amssymb` 패키지 누락 | 프리앰블에 `\usepackage{amssymb}` |
| 본문에 그리스 문자 직접 적기 (한글 폰트로 ε 입력) | 폰트에 따라 안 보이거나 비표준 | 수식 환경 안에서 `\varepsilon` 등 명령어 사용 |

## 정리

그리스 문자 24 자모 + 7 이형 + 2 굵게 명령어 + 2 글꼴 (칠판체·필기체) 묶음을 한 번에 보고 나면, 본문에서 막힐 일이 거의 없어집니다.

핵심 두 가지만 챙기세요.

1. **대문자가 영문과 같은 모양인 자모는 그냥 영문 대문자로 적는다.** `\Alpha` 같은 건 없습니다.
2. **수학 표준 ε 는 `\varepsilon`, ϵ 는 `\epsilon`.** 두 모양을 구분하면 글이 훨씬 학술적으로 보입니다.

다음 글에서는 그리스 문자 다음으로 수식에 자주 나오는 — **수학 기호 (관계·집합·논리·연산·화살표) 전체 목록** 을 정리합니다.

---

이전 글: [#8 LaTeX 명령어 치트시트 — 논문 한 편에 실제로 쓰는 것만](/blog/posts/latex-command-cheatsheet/)
다음 글: [#10 LaTeX 수학 기호 전체 목록 — 관계·집합·논리·연산·화살표](/blog/posts/latex-math-symbols-complete/)

> **Google Docs / Word 의 수식을 한 번에 깔끔하게** — [LaTeXFlow Web 바로 가기](https://mathsystem.dev/latexflow/web/) (sign-in 없이 즉시)
{: .prompt-info }
