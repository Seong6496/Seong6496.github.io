---
title: "LaTeX 그리스 문자·수학 기호 빠른 시작 — 작명 규칙과 자주 쓰는 것만"
date: 2026-06-11 10:00:00 +0900
categories: [LaTeX, 수식]
tags: [latex, 그리스문자, 수학기호, alpha, sigma, infty, 수식, 입문]
math: true
pin: false
description: "LaTeX 그리스 문자·수학 기호를 처음 잡는 분을 위한 빠른 시작 — 작명 규칙(소문자 \\alpha, 대문자 \\Alpha 가 없는 이유), 자주 쓰는 12개, 이형 문자 \\varepsilon · \\varphi 의 함정, 관계·집합·논리·화살표 핵심만. 전체 색인이 필요하면 완전 레퍼런스로 이어집니다."
---

수식을 처음 쓰기 시작하면 가장 먼저 막히는 곳이 **그리스 문자와 수학 기호** 입니다. 알파(α), 시그마(σ), 무한대(∞) 같은 글자가 키보드에 없으니 매번 검색하게 되죠. LaTeX 에서는 작명 규칙 하나만 익히면 거의 모든 기호를 외울 필요 없이 바로 적을 수 있습니다.

[이전 글 #2](/blog/posts/latex-fraction-integral/) 에서 분수·제곱·루트·적분의 다섯 패턴을 정리했다면, 이번 글에서는 그 식들 안에 빠짐없이 등장하는 그리스 문자와 자주 쓰는 수학 기호를 작명 규칙 중심으로 정리합니다. 외워야 할 것보다 **추측 가능한 패턴** 이 훨씬 많다는 게 핵심입니다.

## 1. 그리스 문자 — 작명 규칙

LaTeX 그리스 문자는 단순합니다. **영문 이름을 그대로 백슬래시 뒤에 붙이면 끝**.

```latex
$\alpha$  $\beta$  $\gamma$  $\delta$  $\epsilon$
$\theta$  $\lambda$  $\mu$  $\pi$  $\sigma$  $\omega$
```

출력:

$\alpha$, $\beta$, $\gamma$, $\delta$, $\epsilon$, $\theta$, $\lambda$, $\mu$, $\pi$, $\sigma$, $\omega$

대문자는 첫 글자만 대문자로:

```latex
$\Gamma$  $\Delta$  $\Theta$  $\Lambda$  $\Pi$  $\Sigma$  $\Phi$  $\Psi$  $\Omega$
```

출력:

$\Gamma$, $\Delta$, $\Theta$, $\Lambda$, $\Pi$, $\Sigma$, $\Phi$, $\Psi$, $\Omega$

이 규칙만 알면 24개 그리스 글자의 80% 가 해결됩니다. 나머지 20% 는 두 가지 함정에서 옵니다.

### 1.1 자주 쓰는 12개 — 실전 비중

논문이나 강의 노트에서 압도적으로 자주 쓰이는 그리스 문자는 이 12개입니다. 외울 거면 이것부터.

| 명령어 | 기호 | 자주 쓰이는 곳 |
|---|---|---|
| `\alpha` | $\alpha$ | 학습률, 유의 수준, 첫 번째 매개변수 |
| `\beta` | $\beta$ | 회귀 계수, 두 번째 매개변수 |
| `\gamma` | $\gamma$ | 감마 함수, 할인율 |
| `\delta` | $\delta$ | 작은 변화량, 디랙 델타 |
| `\epsilon` | $\epsilon$ | 오차항, 임의의 작은 양수 |
| `\theta` | $\theta$ | 각도, 모수 일반 |
| `\lambda` | $\lambda$ | 고윳값, 정규화 강도, 람다식 |
| `\mu` | $\mu$ | 평균, 측도 |
| `\pi` | $\pi$ | 원주율, 정책 함수 |
| `\rho` | $\rho$ | 상관계수, 밀도 |
| `\sigma` | $\sigma$ | 표준편차, 활성화 함수 |
| `\omega` | $\omega$ | 각속도, 가중치 일반 |

대문자 중에서는 합산의 $\Sigma$, 곱셈의 $\Pi$, 변화량의 $\Delta$ 가 본문에서 가장 자주 보입니다 — 다만 합과 곱은 보통 `\sum`, `\prod` 명령어로 들어가지 직접 $\Sigma$, $\Pi$ 로 쓰는 일은 드뭅니다.

### 1.2 대문자 함정 — Alpha 는 없다

`\Gamma`, `\Delta` 처럼 모든 대문자에 명령어가 있을 거라 기대하면 빌드가 깨집니다. **`\Alpha`, `\Beta`, `\Epsilon`, `\Zeta` 같은 명령어는 존재하지 않습니다.**

이유는 단순합니다. 그리스 대문자 A, B, E, Z 는 **라틴 알파벳과 모양이 똑같아서** LaTeX 가 별도 명령어를 안 만들었습니다. 그냥 영문 대문자로 적으면 됩니다.

```latex
% 틀린 예 — Undefined control sequence 오류
$\Alpha + \Beta = \Gamma$

% 올바른 예 — 라틴 대문자 그대로
$A + B = \Gamma$
```

명령어가 있는 대문자는 라틴과 모양이 다른 9개뿐입니다.

```
\Gamma  \Delta  \Theta  \Lambda  \Xi  \Pi  \Sigma  \Phi  \Psi  \Omega
```

(엄밀히는 `\Upsilon` 까지 10개지만 거의 안 쓰입니다.) 나머지는 전부 영문 대문자로 직접 입력.

### 1.3 이형 문자 — varepsilon 과 varphi

같은 그리스 문자에 두 가지 모양이 있는 글자가 있습니다. 가장 자주 마주치는 함정.

```latex
$\epsilon$       % ϵ — 둥근 모양
$\varepsilon$    % ε — 곡선이 더 풀린 모양
```

출력:

| 명령어 | 기호 |
|---|---|
| `\epsilon` | $\epsilon$ |
| `\varepsilon` | $\varepsilon$ |
| `\phi` | $\phi$ |
| `\varphi` | $\varphi$ |
| `\theta` | $\theta$ |
| `\vartheta` | $\vartheta$ |
| `\rho` | $\rho$ |
| `\varrho` | $\varrho$ |

저자가 어느 모양을 의도했는지 헷갈리는 경우가 많습니다. 일반적 관례:

- **수학 / 통계**: 보통 `\varepsilon` (오차항 ε 으로 익숙한 모양), `\varphi` (황금비 φ)
- **물리 / 공학**: 보통 `\epsilon` (유전율 ϵ), `\phi` (위상각 φ)

소속 분야의 교과서를 확인하고 하나로 통일하세요. 같은 문서에서 ε 과 ϵ 이 혼용되면 독자가 두 변수로 오해합니다.

## 2. 관계와 비교 기호

부등호 두 개, 거의 같음, 정의 — 본문에서 가장 자주 쓰이는 관계 기호들입니다.

```latex
$a \leq b$       % a ≤ b
$a \geq b$       % a ≥ b
$a \neq b$       % a ≠ b
$a \approx b$    % a ≈ b (근사값)
$a \equiv b$     % a ≡ b (항등 / 정의)
$X \sim N(0,1)$  % X ~ N(0,1) (분포)
$y \propto x$    % y ∝ x (비례)
```

출력 묶음: $a \leq b$, $\;a \geq b$, $\;a \neq b$, $\;a \approx b$, $\;a \equiv b$, $\;X \sim N(0,1)$, $\;y \propto x$.

`\equiv` 는 두 가지 뜻으로 쓰입니다. **정의** ("이 식을 이렇게 정의한다") 와 **항등** ("모든 입력에서 같다"). 문맥에서 결정.

조금 더 강한 관계도 알아두면 유용합니다.

```latex
$a \ll b$    % a ≪ b (훨씬 작음)
$a \gg b$    % a ≫ b (훨씬 큼)
$a \simeq b$ % a ≃ b (근사적으로 같음, 차원·단위 무시)
```

## 3. 집합과 논리 기호

집합 관련 기호는 그리스 문자만큼 자주 나옵니다.

```latex
$x \in A$            % x ∈ A (원소)
$x \notin A$         % x ∉ A
$A \subset B$        % A ⊂ B (부분집합)
$A \subseteq B$      % A ⊆ B (부분집합 또는 같음)
$A \cup B$           % A ∪ B (합집합)
$A \cap B$           % A ∩ B (교집합)
$A \setminus B$      % A ∖ B (차집합)
$\emptyset$          % ∅ (공집합)
```

수 체계 — 실수·자연수·정수·복소수 — 는 `\mathbb{}` 안에 영문 대문자.

```latex
$\mathbb{R}$  $\mathbb{N}$  $\mathbb{Z}$  $\mathbb{Q}$  $\mathbb{C}$
```

출력: $\mathbb{R}$, $\mathbb{N}$, $\mathbb{Z}$, $\mathbb{Q}$, $\mathbb{C}$.

`mathbb` 는 "blackboard bold" 의 약자 — 칠판에 굵게 쓴 듯한 두 줄 글씨체입니다. `amssymb` 패키지가 필요하지만 대부분의 LaTeX 배포본은 기본 포함합니다.

논리 기호는 증명·정의·이산수학에서 단골손님.

```latex
$\forall x \in \mathbb{R}$    % ∀x ∈ ℝ (모든)
$\exists x : P(x)$            % ∃x : P(x) (존재)
$\neg P$                       % ¬P (부정)
$P \land Q$                    % P ∧ Q (논리곱, AND)
$P \lor Q$                     % P ∨ Q (논리합, OR)
$P \Rightarrow Q$              % P ⇒ Q (함의)
$P \Leftrightarrow Q$          % P ⇔ Q (동치)
$\therefore$  $\because$       % ∴, ∵ (따라서, 왜냐하면)
```

## 4. 화살표 — 함수 정의와 극한

화살표는 종류가 많아 보이지만 본문에서 자주 쓰이는 건 네 가지입니다.

```latex
$x \to y$              % x → y (사상 / 극한 방향)
$x \mapsto x^2$        % x ↦ x² (함수의 정의)
$P \Rightarrow Q$      % P ⇒ Q (함의)
$P \Leftrightarrow Q$  % P ⇔ Q (동치)
```

`\to` 와 `\rightarrow` 는 같습니다. `\to` 가 더 짧아 보통 이쪽을 씁니다.

`\mapsto` 는 함수의 정의를 한 줄로 적을 때 깔끔합니다.

```latex
\begin{equation}
  f: \mathbb{R} \to \mathbb{R}, \quad x \mapsto x^2 + 1
\end{equation}
```

출력:

$$f: \mathbb{R} \to \mathbb{R}, \quad x \mapsto x^2 + 1 \tag{1}$$

소문자 화살표 ($\to$, $\mapsto$) 와 대문자 화살표 ($\Rightarrow$, $\Leftrightarrow$) 의 의미가 다르다는 점에 주의하세요. 명제 사이의 함의는 반드시 대문자.

## 5. 자주 쓰는 기타 기호

위 네 묶음에 안 들어가지만 본문에서 빈번한 기호들입니다.

```latex
$\infty$              % ∞ (무한대)
$\partial f / \partial x$  % ∂f/∂x (편미분)
$\nabla f$            % ∇f (그래디언트)
$\pm$  $\mp$          % ±, ∓
$\times$  $\div$      % ×, ÷
$\cdot$               % · (점곱)
$\cdots$  $\ldots$    % ⋯ (가운데 점), … (아래쪽 점)
$\hbar$               % ℏ (디랙 상수)
$\circ$               % ∘ (합성)
```

출력 묶음: $\infty$, $\;\partial f / \partial x$, $\;\nabla f$, $\;\pm$, $\;\mp$, $\;\times$, $\;\div$, $\;a \cdot b$, $\;\cdots$, $\;\ldots$, $\;\hbar$, $\;f \circ g$.

`\cdots` 와 `\ldots` 의 차이는 점의 세로 위치입니다. **수식의 중간 (연산자 사이)** 에는 `\cdots`, **나열 (콤마 사이)** 에는 `\ldots`.

```latex
$a_1 + a_2 + \cdots + a_n$    % 합산 — 가운데 점이 자연
$a_1, a_2, \ldots, a_n$        % 나열 — 아래쪽 점이 자연
```

## 카테고리별 핵심 정리

영역별로 가장 많이 쓰는 기호만 모은 한 표.

| 영역 | 핵심 기호 (명령어) |
|---|---|
| 그리스 소문자 | $\alpha$, $\beta$, $\gamma$, $\delta$, $\epsilon$, $\theta$, $\lambda$, $\mu$, $\pi$, $\sigma$, $\omega$ |
| 그리스 대문자 | `\Gamma`, `\Delta`, `\Theta`, `\Lambda`, `\Pi`, `\Sigma`, `\Phi`, `\Psi`, `\Omega` |
| 관계 | `\leq`, `\geq`, `\neq`, `\approx`, `\equiv`, `\sim`, `\propto` |
| 집합 | `\in`, `\notin`, `\subset`, `\cup`, `\cap`, `\emptyset`, `\mathbb{R}` |
| 논리 | `\forall`, `\exists`, `\neg`, `\land`, `\lor`, `\Rightarrow`, `\Leftrightarrow` |
| 화살표 | `\to`, `\mapsto`, `\Rightarrow`, `\Leftrightarrow` |
| 기타 | `\infty`, `\partial`, `\nabla`, `\pm`, `\times`, `\cdot`, `\cdots` |

세 가지 원칙만 챙기면 90% 의 기호 문제가 해결됩니다.

1. **그리스 문자는 영문 이름 그대로** — 소문자 `\alpha`, 대문자는 모양이 다른 9개에만 `\Gamma` 같은 명령어. 나머지는 그냥 라틴 대문자.
2. **이형 문자 (`\varepsilon`, `\varphi`) 는 분야 관례 따라 통일** — 같은 문서에서 두 모양 혼용 금지.
3. **함의 `⇒` 는 대문자 화살표** — `\to` 는 사상·극한, `\Rightarrow` 는 명제 함의. 둘이 다른 뜻.

## 정리

LaTeX 그리스 문자는 단순한 작명 규칙 위에 두 가지 함정 — 대문자 명령어가 모든 글자에 있지는 않다, 같은 문자에 이형 모양이 있다 — 만 비켜 가면 사실상 끝납니다. 수학 기호도 분류별로 자주 쓰는 7~10개씩만 손에 익히면 본문 흐름이 끊기지 않습니다.

이 글은 **자주 쓰는 핵심** 기준이라 분야에 따라 더 세밀한 기호가 필요할 수 있습니다. 그리스 문자 24자 전체 (소·대·이형 포함) 와 수학 기호 전체 표 — 관계·집합·논리·연산·화살표·머리표시까지 — 는 <a href="/blog/posts/latex-greek-letters-complete/" data-proofer-ignore>#9 그리스 문자·수학 기호 완전 레퍼런스</a> 에서 한 페이지로 다룹니다. 이 글로 감을 잡고, 색인이 필요할 때 그 글을 옆 탭에 띄워두면 됩니다.

다음 글에서는 **행렬과 연립방정식** — `pmatrix`·`bmatrix`·`cases` 환경 — 으로 한 줄 수식을 넘어선 구조적 식 표기를 정리합니다.

---

이전 글: [#2 LaTeX 분수·제곱·루트·적분 — 가장 자주 쓰는 5가지](/blog/posts/latex-fraction-integral/)
다음 글: <a href="/blog/posts/latex-matrix-cases/" data-proofer-ignore>#4 LaTeX 행렬과 연립방정식 — pmatrix·bmatrix·cases</a>

> **LaTeX 가 Word 에서 수식 처리 되지 않아, 하나씩 다시 쓰고 계신가요?**
> Docs·Word 파일을 올리면 `$...$` · `$$...$$` · `\(...\)` · `\[...\]` · `[...]` 로 감싼 수식을 골라 이미지로 바꿔 돌려줍니다.
> LaTeX 한 번에 검증하고 한 번에 변환하기! 설치 No! 로그인 No! [내 문서로 확인해 보기](https://mathsystem.dev/latexflow/web/)
{: .prompt-info }
