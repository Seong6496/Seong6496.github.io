---
title: "LaTeX 미분·편미분·절댓값을 짧게 — physics 패키지와 주의할 점"
date: 2026-10-18 09:00:00 +0900
categories: [LaTeX, 수식]
tags: [latex, physics, dv, pdv, abs, norm, braket, 미분, 편미분, 벡터, 물리, siunitx]
math: true
pin: false
description: "\\frac{d}{dx} 와 \\left| \\right| 를 매번 손으로 치는 대신 physics 패키지의 \\dv·\\pdv (미분·편미분, d 는 자동으로 세움), \\dd (적분의 dx), \\abs·\\norm·\\qty (크기를 맞추는 괄호), \\bra·\\ket·\\braket (디랙 표기), \\vb (벡터) 를 쓰는 법을 실측으로 정리합니다. 측정에서 나온 주의점 네 가지 — \\dd x 는 중괄호가 없으면 간격이 빠지고, \\sin\\qty(x) 는 \\sin(x) 보다 넓고, \\vb{\\alpha} 는 굵어지지 않고, siunitx 와 함께 쓰면 \\qty 가 physics 쪽으로 간다는 것까지."
---

물리·공학 수식은 같은 모양을 반복합니다. 미분 $\frac{\mathrm{d}f}{\mathrm{d}x}$, 편미분 $\frac{\partial^2 f}{\partial x \partial y}$, 절댓값 $\left|\frac{a}{b}\right|$, 디랙 표기 $\langle \phi | \psi \rangle$. `physics` 패키지는 이것들을 짧은 명령 하나씩으로 만듭니다.

```latex
\usepackage{physics}
```

이 글은 자주 쓰는 명령과, 실제로 컴파일해서 확인한 **주의할 점 네 가지** 를 정리합니다. 패키지를 쓸지 말지는 각자 판단할 일이고, 여기서는 측정된 동작만 적습니다.

아래 결과는 전부 MiKTeX 25.12 (pdfTeX, LaTeX2e 2025-11-01, `amsmath` + `physics` v1.3) 로 컴파일한 것이고, 그림의 두 표는 Tectonic 0.17 로 한 번 더 컴파일해 같은 결과를 확인했습니다 (차이 하나는 §2 끝에). `physics` v1.3 은 파일 머리에 2012년 12월 갱신으로 적혀 있습니다 — 그 뒤로 바뀌지 않은 패키지입니다.

> 이 블로그의 수식 엔진 (MathJax) 은 `physics` 명령을 모릅니다. 그래서 출력은 **pdfLaTeX 로 컴파일한 PDF 를 잘라 낸 그림** 이고, 본문의 수식 렌더는 같은 모양을 손으로 쓴 것입니다.
{: .prompt-info }

## 1. 미분과 편미분 — \dv, \pdv

![미분 명령 실측 — \dv{f}{x} 는 세운 d 의 df/dx 분수, \frac{df}{dx} 는 이탤릭 d, \dv[2]{f}{x} 는 2계 미분, \dv{x}(x^2+1) 은 연산자 꼴, \pdv 는 편미분과 2계·혼합 편미분, \dv* 는 빗금 꼴 df/dx, \dd{x} 는 적분 앞 간격이 있고 \dd x 는 간격이 없음, \eval 은 세로선과 위아래 첨자, \grad·\div·\curl 은 굵은 나블라, \vb{v} 는 굵은 정체, \vb*{v} 는 굵은 이탤릭, \vb{\alpha} 는 굵어지지 않음, \vu{x} 는 모자 쓴 굵은 x](/assets/img/posts/2026-10-18/01-derivatives-vectors.png){: width="720" }

| 하고 싶은 것 | physics | 손으로 쓰면 |
|---|---|---|
| 미분 | `\dv{f}{x}` | `\frac{\mathrm{d}f}{\mathrm{d}x}` |
| n계 미분 | `\dv[2]{f}{x}` | `\frac{\mathrm{d}^2 f}{\mathrm{d}x^2}` |
| 미분 연산자 | `\dv{x}(x^2+1)` | `\frac{\mathrm{d}}{\mathrm{d}x}\left(x^2+1\right)` |
| 편미분 | `\pdv{f}{x}`, `\pdv[2]{f}{x}` | `\frac{\partial f}{\partial x}` … |
| 혼합 편미분 | `\pdv{f}{x}{y}` | `\frac{\partial^2 f}{\partial x \partial y}` |
| 본문 줄 안의 빗금 꼴 | `\dv*{f}{x}` | `\mathrm{d}f/\mathrm{d}x` |
| 적분의 dx | `\dd{x}` | `\,\mathrm{d}x` |
| 값 대입 | `\eval{x^2}_0^1` | `\left. x^2 \right\vert_0^1` |

실측 네 가지.

- **`\dv` 의 d 는 세워집니다.** `\dv{f}{x}` 와 `\frac{\mathrm{d}f}{\mathrm{d}x}` 는 폭·높이가 같고 (11.50 pt · 9.32 pt), `\frac{df}{dx}` 는 이탤릭 d 라 폭이 다릅니다 (11.10 pt). 미분 d 를 세울지는 [수식 글자체 글](/blog/posts/latex-math-fonts-text-mathrm-mathbf/) §4 에서 말했듯 규정의 문제인데, `physics` 는 기본값이 세우는 쪽입니다.
- **`\dv{x}(x^2+1)` 은 뒤의 괄호까지 맡습니다.** 인자를 둘 대신 하나만 주면 연산자 꼴이 되고, 바로 뒤의 `( … )` 를 크기를 맞춘 괄호로 감쌉니다.
- **`\pdv{f}{x}{y}` 는 혼합 편미분**입니다. 인자 셋이 "f 를 x 와 y 로" 라는 뜻이고, 분자의 2 는 알아서 붙습니다.
- **`\eval{x^2}_0^1`** 은 오른쪽 세로선에 위아래 첨자 — [괄호 크기 글](/blog/posts/latex-brackets-left-right-sizes/)의 `\left. … \right|` 를 한 명령으로 만든 것입니다.

벡터 미분은 `\grad{\phi}` (기울기), `\div{\vb{A}}` (발산), `\curl{\vb{A}}` (회전) 이고, 나블라는 굵게 나옵니다.

## 2. 벡터 — \vb, \vu

`\vb{v}` 는 굵은 정체 **v**, `\vb*{v}` 는 굵은 이탤릭, `\vu{x}` 는 모자를 쓴 단위 벡터입니다. 굵은 정체·이탤릭 관례는 [글자체 글](/blog/posts/latex-math-fonts-text-mathrm-mathbf/) §5 와 같습니다.

> **`\vb{\alpha}` 는 굵어지지 않습니다.** 실측으로 `\vb{\alpha}` 와 그냥 `\alpha` 의 폭이 같고 (6.43 pt), 그림에서도 보통 α 입니다. 오류도 경고도 없습니다. `\mathbf{\alpha}` 가 그리스 소문자에 안 먹는 것과 같은 함정입니다. 그리스 문자 벡터는 `\vb*{\alpha}` — 실측으로 `\boldsymbol{\alpha}` 와 폭이 같은 굵은 α (7.61 pt) 입니다.
{: .prompt-warning }

Tectonic 과의 차이는 `\vu{x}` 하나였습니다 — 모자 모양이 Tectonic 에서는 넓게 나옵니다. 나머지 두 표는 같았습니다.

## 3. 크기를 맞추는 괄호 — \abs, \norm, \qty

![괄호 명령 실측 — \abs{\frac{a}{b}} 는 분수 높이만큼 늘어난 세로선, 그냥 |\frac{a}{b}| 와 \abs* 는 늘어나지 않음, \norm 은 겹세로선, \qty 는 소괄호·대괄호·중괄호를 내용 크기에 맞춤, \sin\qty(x) 는 \sin(x) 보다 sin 과 괄호 사이가 넓음, \bra·\ket·\braket·\ev·\mel 은 디랙 표기, \mqty 는 행렬과 행렬식](/assets/img/posts/2026-10-18/02-brackets-braket.png){: width="720" }

- **`\abs{…}` 는 `\left| … \right|` 와 같습니다.** 실측 폭·높이가 일치합니다 (분수일 때 13.40 pt · 8.50 pt). 내용이 크면 세로선이 따라 늘어납니다. 늘리고 싶지 않으면 별표 판 `\abs*{…}`.
- **`\norm{…}`** 은 겹세로선으로 같은 일을 합니다 (`\left\| … \right\|` 와 폭 일치).
- **`\qty(…)` · `\qty[…]` · `\qty{…}`** 는 소·대·중괄호를 내용 크기에 맞춥니다. 괄호 종류를 `\qty` 뒤의 글자로 고르는 방식입니다.

### 주의 1 — \sin\qty(x) 는 \sin(x) 보다 넓다

`\sin\qty(x)` 는 실측 폭 27.44 pt, `\sin(x)` 는 25.77 pt — 차이 1.67 pt 는 가는 공백 하나 (`\,`) 만큼입니다. 그림에서도 `sin` 과 괄호 사이가 벌어져 있습니다. `\qty(…)` 가 만드는 괄호 묶음을 TeX 가 함수 이름 뒤의 "덩어리" 로 보고 간격을 넣기 때문입니다. 반면 `f\qty(x)` 와 `f(x)` 는 폭이 같았습니다 (19.47 pt). 함수 이름 (`\sin`, `\log`, `\exp` …) 뒤에서 괄호 크기를 맞출 필요가 없으면 그냥 `(x)` 가 `\sin(x)` 의 원래 간격입니다.

### 주의 2 — \dd x 와 \dd{x} 는 다르다

그림 1의 다섯째 줄입니다. `\int_0^1 f(x) \dd{x}` 는 `f(x)` 와 `dx` 사이에 간격이 있고, 중괄호 없이 `\dd x` 라고 쓰면 **간격 없이 붙습니다.** 실측으로 `\int f\dd{x}` 는 `\int f\,\mathrm{d}x` 와 폭이 같고 (27.24 pt), `\int f\dd x` 는 1.67 pt 좁습니다 (25.58 pt). `\dd` 는 항상 중괄호와 함께 씁니다.

## 4. 디랙 표기 — \bra, \ket, \braket

| 명령 | 출력 |
|---|---|
| `\bra{\psi}` | $\langle\psi\vert$ |
| `\ket{\psi}` | $\vert\psi\rangle$ |
| `\braket{\phi}{\psi}` | $\langle\phi\vert\psi\rangle$ |
| `\ev{A}{\psi}` | $\langle\psi\vert A\vert\psi\rangle$ (기댓값) |
| `\mel{\phi}{A}{\psi}` | $\langle\phi\vert A\vert\psi\rangle$ (행렬 요소) |

(오른쪽 열은 MathJax 로 손으로 쓴 같은 모양입니다. pdfLaTeX 출력은 그림 2 의 다섯·여섯째 줄.) `\ev{A}{\psi}` 는 인자 순서가 "연산자, 상태" 인데 출력에서는 상태가 양쪽에 놓인다는 점이 헷갈리기 쉽습니다.

행렬은 `\mqty(a & b \\ c & d)` 가 괄호 행렬, `\mqty|a & b \\ c & d|` 가 행렬식입니다. `amsmath` 의 `pmatrix`·`vmatrix` 와 같은 결과이고, 그쪽은 [행렬 글](/blog/posts/latex-matrix-cases/)에 있습니다.

## 5. siunitx 와 함께 쓸 때 — \qty 는 하나뿐

[siunitx 글](/blog/posts/latex-siunitx-units-numbers/) §6 에서 측정한 것을 이쪽에서 한 번 더 적습니다. `physics` 의 `\qty` 는 이 글의 괄호 명령이고, `siunitx` v3 의 `\qty` 는 숫자와 단위입니다. 둘을 함께 로드하면 실측으로 `siunitx` 가 이렇게 알리고 자기 `\qty` 를 정의하지 않습니다 (로드 순서를 바꿔도 같음).

```text
Package siunitx Warning: Detected the "physics" package:
(siunitx)                omitting definition of \qty.
```

결과적으로 `\qty` 는 `physics` 의 괄호이고, 단위는 `siunitx` 의 다른 이름 `\SI{3}{\metre\per\second}` 로 씁니다 — 함께 로드한 상태에서 실측으로 오류 없이 `3 m s⁻¹`. `\qty{3}{\metre}` 를 쓰면 `Missing $ inserted` 가 줄줄이 납니다.

## 6. 정리

| 하고 싶은 것 | physics | 실측 주의 |
|---|---|---|
| 미분 · 편미분 | `\dv{f}{x}`, `\pdv{f}{x}{y}` | d 는 세워진다 |
| 적분의 dx | `\dd{x}` | **중괄호 필수** — `\dd x` 는 간격 없음 |
| 절댓값 · 노름 | `\abs{…}`, `\norm{…}` | `\left\vert … \right\vert` 와 같다. 늘리지 않으려면 `\abs*` |
| 크기 맞춘 괄호 | `\qty(…)` | 함수 이름 뒤에서는 `\sin(x)` 보다 가는 공백 하나 넓다 |
| 벡터 | `\vb{v}`, `\vb*{v}` | 그리스 문자는 `\vb*{\alpha}` — `\vb{\alpha}` 는 안 굵어진다 |
| 디랙 표기 | `\bra`, `\ket`, `\braket`, `\ev`, `\mel` | — |
| siunitx 와 함께 | 단위는 `\SI{…}{…}` | `\qty` 는 physics 쪽 |

`physics` 는 손으로 치던 것을 짧게 줄여 주고, 대부분은 손으로 친 것과 **폭까지 같은** 결과를 냅니다. 다른 결과가 나오는 곳은 위 표의 오른쪽 열에 적은 네 군데였습니다. 같은 이름의 후속 패키지 `physics2` 도 MiKTeX 25.12 에 들어 있지만, 이 글에서는 측정하지 않았습니다.

---

이전 글: [한글 LaTeX, 어느 엔진으로 컴파일하나 — pdfLaTeX·XeLaTeX·LuaLaTeX 실측 비교](/blog/posts/latex-korean-engine-pdflatex-xelatex-lualatex/)
함께 보기: [LaTeX 단위와 숫자 — siunitx](/blog/posts/latex-siunitx-units-numbers/) · [LaTeX 괄호 크기 — \left·\right 로 안 될 때](/blog/posts/latex-brackets-left-right-sizes/) · [LaTeX 수식 안 글자체 네 가지](/blog/posts/latex-math-fonts-text-mathrm-mathbf/)
