---
title: "LaTeX 수식 안 글자체 네 가지 — 이탤릭이 아닌 것은 전부 이유가 있다"
date: 2026-10-08 09:00:00 +0900
categories: [LaTeX, 수식]
tags: [latex, text, mathrm, mathbf, boldsymbol, operatorname, 수식글자체, 수식간격, quad, amsmath, 수식]
math: true
pin: false
description: "수식 안에서 단어가 이탤릭으로 붙고, 단위가 변수처럼 기울고, sin 이 세 글자 곱이 되고, 그리스 문자가 굵어지지 않는 네 장면의 답 — \\text (본문 글자, 공백 유지), \\mathrm (수식 글자를 세움), \\mathbf/\\boldsymbol (굵게, 그리스는 후자), \\operatorname (함수 이름) — 을 실측으로 정리합니다. 수식 안에 한글을 그냥 치면 pdfLaTeX 에서 오류 없이 깨지는 이유, 그리고 공백을 쳐도 안 벌어지는 수식 간격 다섯 가지까지."
---

수식을 치다 보면 글자가 이상하게 나오는 장면이 네 가지 있습니다.

1. `$x > 0 여기서$` — 단어를 넣었더니 이탤릭으로 붙거나, 아예 깨진다.
2. `$v = 3 m/s$` — 단위가 변수처럼 기울어 `3m/s` 가 된다.
3. `$sin x$` — `sin` 이 함수가 아니라 세 변수 s, i, n 의 곱처럼 보인다.
4. `$\mathbf{\alpha}$` — 벡터를 굵게 하려는데 그리스 문자는 굵어지지 않는다.

넷의 원인은 하나입니다. **수식 모드는 글자 하나하나를 변수로 취급합니다.** 변수는 이탤릭이고, 변수 사이 공백은 버려지고, 세 글자를 나란히 치면 세 변수의 곱입니다. 그래서 "변수가 아닌 글자" 는 그렇다고 말해 줘야 하고, 말하는 방법이 네 가지입니다. 아래 결과는 전부 MiKTeX 25.12 (pdfTeX, LaTeX2e 2025-11-01, `amsmath` + `kotex` 로드) 로 컴파일해 확인한 것입니다.

## 1. 먼저 — 수식 안 글자는 왜 기울어지나

```latex
$Var X$ \qquad $\operatorname{Var} X$
```

$$Var X \qquad \operatorname{Var} X$$

왼쪽은 `V`·`a`·`r`·`X` 네 변수의 곱으로 조판됩니다 — 실측으로 이탤릭에, 사이 공백은 사라져 `VarX` 로 붙습니다. 오른쪽은 세운 글자 `Var` 뒤에 가는 공백이 들어간 함수 표기입니다. 같은 네 글자인데 TeX 에게 "이건 변수가 아니라 이름이다" 라고 말했는지의 차이입니다.

수식 안 글자체는 이 "무엇이다" 를 고르는 일입니다. 본문 글자인가 (`\text`), 세운 수식 글자인가 (`\mathrm`), 굵은 기호인가 (`\mathbf`·`\boldsymbol`), 함수 이름인가 (`\operatorname`).

## 2. 어느 것을 쓰나 — 판단 표

| 넣고 싶은 것 | 명령 | 이유 |
|---|---|---|
| 단어·문장 ("여기서", "if", "합계") | `\text{…}` | 공백을 지키고, 주변 본문 글꼴을 따라간다. **한글은 반드시 여기** (§3) |
| 단위 (m/s, kg), 미분 d, 상수 e | `\mathrm{…}` | 수식 글자를 세운다. 공백은 버린다 (§4) |
| 벡터·행렬 — 영문 | `\mathbf{v}` | 굵은 정체 (§5) |
| 벡터·행렬 — 그리스 문자 | `\boldsymbol{\alpha}` | `\mathbf` 는 그리스 소문자에 안 먹는다 (§5) |
| 함수 이름 (Var, argmax, 직접 만든 함수) | `\operatorname{…}` / `\DeclareMathOperator` | `\sin` 과 똑같이 동작한다 (§6) |
| 여러 글자짜리 이탤릭 식별자 | `\mathit{…}` | 글자 간격이 단어처럼 (§7) |
| 집합·공간 기호 | `\mathbb{R}` `\mathcal{L}` | `amssymb` (§7) |

## 3. \text — 본문 글자를 수식 안에

`\text{…}` (`amsmath`) 는 중괄호 안을 **본문으로** 조판합니다. 세 가지 성질이 따라옵니다.

**공백을 지킵니다.** 실측으로 `\text{a b c}` 는 `a b c`, `\mathrm{a b c}` 는 `abc`.

**주변 글꼴을 따라갑니다.** 굵은 문단 (`\textbf{…}`) 안의 `$\text{x}$` 는 굵게, 이탤릭 문단 안에서는 이탤릭으로 나옵니다. `\mathrm{x}` 는 어디서든 보통 굵기 정체입니다 (실측). 정리 환경이나 강조 문단 안의 수식에서 이 차이가 드러납니다.

**첨자에서 작아집니다.** `$x_{\text{max}}$` 의 `max` 는 첨자 크기로 줄어듭니다.

```latex
f(x) = x^2 \text{ 여기서 } x > 0
```

$$f(x) = x^2 \text{ 여기서 } x > 0$$

`\text{ 여기서 }` 처럼 **중괄호 안쪽에 공백을 넣는** 것이 요령입니다. `\text{여기서}` 라고 쓰면 앞뒤 수식에 붙습니다.

> **수식 안 한글은 반드시 `\text` 안에.** [kotex 설정 글](/blog/posts/kotex-korean-setup/)대로 한글 문서를 만들어 두고 `$a 여기서 b$` 처럼 수식 안에 한글을 그냥 치면, pdfLaTeX 에서는 **오류 없이 컴파일되고 글자만 깨집니다.** 실측으로 출력은 `a0øb` 같은 엉뚱한 글자가 되고, 로그에 `Missing character: There is no � in font cmr10!` 한 줄만 남습니다. 수식 글꼴에 한글이 없어서인데, 오류가 아니라 경고라 놓치기 쉽습니다. `\text{ 여기서 }` 로 감싸면 본문 글꼴로 넘어가서 정상 출력됩니다 (위 예제).
{: .prompt-warning }

## 4. \mathrm — 수식 글자를 세운다

`\mathrm{…}` 은 안쪽 글자를 **정체 수식 글자** 로 바꿉니다. `\text` 와 두 가지가 다릅니다 — 공백을 버리고, 주변 본문 글꼴을 무시합니다. 그래서 단어에는 맞지 않고, "기울면 안 되는 수식 기호" 에 맞습니다.

```latex
v = 3\,\mathrm{m/s} \qquad \int_0^1 x\,\mathrm{d}x \qquad \mathrm{e}^{x}
```

$$v = 3\,\mathrm{m/s} \qquad \int_0^1 x\,\mathrm{d}x \qquad \mathrm{e}^{x}$$

- **단위**는 세웁니다. `3 m/s` 라고 치면 실측으로 `3m/s` 가 이탤릭으로 붙어 나옵니다 — 공백도 사라지고 `m`·`s` 가 변수가 됩니다. 숫자와 단위 사이엔 가는 공백 `\,` (§8).
- **미분의 d**와 **자연상수 e**를 세우는 것은 규정 (ISO 80000-2) 이지 문법이 아닙니다. 논문·학회가 요구하면 `\mathrm{d}x`, 아니면 `dx` 로 써도 틀린 것이 아닙니다. 한 문서 안에서 통일하는 것이 중요합니다.
- **첨자 라벨**은 취향이 갈립니다. `x_{\mathrm{max}}` 와 `x_{\text{max}}` 는 실측으로 같은 크기·같은 모양이고, 차이는 §3 의 "주변 글꼴을 따라가는가" 뿐입니다.

## 5. \mathbf 과 \boldsymbol — 굵게

```latex
\mathbf{v} \quad \boldsymbol{v} \quad \mathbf{\alpha} \quad \boldsymbol{\alpha} \quad \mathbf{\Sigma} \quad \boldsymbol{\Sigma}
```

$$\mathbf{v} \quad \boldsymbol{v} \quad \boldsymbol{\alpha} \quad \mathbf{\Sigma} \quad \boldsymbol{\Sigma}$$

(위 렌더에서 `\mathbf{\alpha}` 는 뺐습니다. 이 블로그의 수식 엔진 (MathJax) 은 굵은 알파 글꼴을 갖고 있어 굵게 보여 주지만, 아래는 pdfLaTeX 로 컴파일한 결과입니다.)

실측 결과 세 가지.

- `\mathbf{v}` 는 **굵은 정체**, `\boldsymbol{v}` 는 **굵은 이탤릭**. 벡터를 굵은 정체로 쓰는 관례 (물리·공학) 와 굵은 이탤릭으로 쓰는 관례 (수학 일부) 가 둘 다 있어, 분야의 관례를 따릅니다.
- `\mathbf{\alpha}` 는 **오류 없이 그냥 보통 알파** 가 나옵니다. 굵어지지 않은 것을 눈으로 알아채야 합니다. 그리스 소문자는 `\boldsymbol{\alpha}` (`amsmath`).
- 그리스 **대문자** `\mathbf{\Sigma}` 는 굵어집니다 — 대문자 그리스는 원래 정체 글꼴에 있기 때문입니다. 소문자만 예외라는 것이 헷갈리는 지점입니다.

`\boldsymbol` 은 `\mathbf` 가 못 하는 것 — 그리스 소문자, `\nabla` 같은 기호, 이탤릭 유지 — 을 전부 하므로, 하나만 기억하려면 `\boldsymbol` 입니다. 그리스 문자 쪽 세부는 [그리스 문자 완전 레퍼런스](/blog/posts/latex-greek-letters-complete/)의 벡터 절에 있습니다.

## 6. \operatorname — 함수 이름은 \sin 처럼

`\sin x` 를 치면 세 가지가 한꺼번에 일어납니다. 글자가 서고, `x` 앞에 가는 공백이 들어가고, `\sin(x)` 처럼 괄호가 오면 공백이 빠집니다. 직접 만든 함수도 똑같이 동작하게 하는 것이 `\operatorname` 입니다.

```latex
\sin x \quad sin x \quad \mathrm{sin} x \quad \operatorname{sin} x
```

$$\sin x \quad sin x \quad \mathrm{sin} x \quad \operatorname{sin} x$$

실측으로 첫째와 넷째가 같고 (세운 글자 + 가는 공백), 둘째는 이탤릭 `sinx`, 셋째는 세웠지만 공백 없이 `sinx`. **`\mathrm` 은 글자만 세울 뿐 함수 간격은 넣지 않습니다** — `\mathrm{Var} X` 도 `VarX` 로 붙습니다. 이름 뒤에 인자가 붙는 것은 전부 `\operatorname` 입니다.

자주 쓰는 이름은 프리앰블에 한 번 선언합니다.

```latex
\DeclareMathOperator{\Var}{Var}
\DeclareMathOperator*{\argmax}{arg\,max}
```

```latex
\Var X = \sigma^2 \qquad \argmax_{x \in S} f(x)
```

$$\operatorname{Var} X = \sigma^2 \qquad \operatorname*{arg\,max}_{x \in S} f(x)$$

별표 판 (`\DeclareMathOperator*` · `\operatorname*`) 은 디스플레이 수식에서 첨자를 **아래에** 놓습니다 — `\lim`·`\max` 와 같은 자리입니다. 실측으로 별표가 없으면 `argmax_x` 처럼 오른쪽 아래 첨자로 붙습니다. `arg\,max` 의 `\,` 는 두 단어 사이 가는 공백입니다.

[수식 오류 가이드](/blog/posts/latex-math-errors-guide/)의 "함수 이름이 이탤릭" 항목이 이 절의 요약입니다. 참고로 Google Docs 수식 편집기도 `\sin` 을 치고 Space 를 누르면 세운 함수명으로 저장합니다 — [편집기가 무엇을 저장하나](/blog/posts/google-docs-equation-editor-structure/)에 실측이 있습니다.

## 7. 나머지 글자체 — 한 줄씩

| 명령 | 모양 | 쓰는 곳 |
|---|---|---|
| `\mathit{diff}` | 이탤릭, 단어 간격 | 여러 글자짜리 식별자. 실측으로 `diff` 를 그냥 치면 네 변수라 글자가 벌어지고, `\mathit{diff}` 는 `ff` 가 붙어 단어처럼 나온다 |
| `\mathbb{R}` | 겹선 | 실수·정수 집합 (`amssymb`) |
| `\mathcal{L}` | 필기체 | 라플라스 변환, 클래스, 손실 함수 |
| `\mathfrak{g}` | 프락투어 | 리 대수 (`amssymb`) |
| `\mathsf{A}` | 산세리프 | 텐서·범주 표기 일부 |
| `\mathtt{A}` | 고정폭 | 코드·문자열 |

## 8. 수식 간격 — 공백을 쳐도 안 벌어지는 이유와 다섯 가지 명령

글자체와 같은 뿌리의 질문이 하나 더 있습니다. 수식 안에서 스페이스를 아무리 쳐도 벌어지지 않습니다.

```latex
$a b$ \quad $ab$ \quad $a          b$
```

실측으로 셋은 **완전히 같은** `ab` 입니다. 수식 모드는 입력의 공백을 전부 버리고, 기호의 종류 (변수·연산자·관계 기호·괄호) 에 따라 간격을 **스스로** 넣습니다. `a=b+c` 와 `a = b + c` 가 같은 이유이고, 그래서 `=` 나 `+` 주변에는 손대지 않는 것이 맞습니다.

손대야 하는 자리는 TeX 가 모르는 곳 — 미분 `dx` 앞, 단위 앞, 단어 앞뒤, 조건 앞 — 이고, 그때 쓰는 명령이 다섯입니다.

| 명령 | 폭 | 용도 |
|---|---|---|
| `\,` | 3/18 em (가는 공백) | `\int f(x)\,dx`, `3\,\mathrm{kg}`, `arg\,max` |
| `\:` | 4/18 em | 관계 기호 수준의 공백을 손으로 |
| `\;` | 5/18 em | 조건·구분 앞 (`\;\text{또는}\;`) |
| `\quad` | 1 em | 식과 조건 사이 `f(x) = 1 \quad (x > 0)` |
| `\qquad` | 2 em | 두 식을 한 줄에 |
| `\!` | −3/18 em (음수) | 붙여야 할 때 — `\int\!\!\int` |

```latex
\int f(x)dx \quad \int f(x)\,dx \qquad f(x) = 1 \quad (x > 0)
```

$$\int f(x)dx \quad \int f(x)\,dx \qquad f(x) = 1 \quad (x > 0)$$

실측 세 가지.

- `\int f(x)dx` 는 `f(x)` 와 `dx` 가 붙고, `\,` 하나로 읽는 간격이 생깁니다. 가장 자주 빠뜨리는 자리입니다.
- 조건 `(x > 0)` 앞에 `\quad` 가 없으면 `1(x > 0)` 처럼 곱으로 읽힙니다.
- `\int\int` 는 두 적분 기호가 떨어지고, `\int\!\!\int` 는 붙습니다. 다만 `amsmath` 의 `\iint` 가 이 조합을 통째로 대신하므로 이중·삼중 적분은 `\iint`·`\iiint` 입니다.

단어 앞뒤는 §3 대로 `\text{ if }` 처럼 **중괄호 안에** 공백을 넣습니다. `x \text{if} y` 는 실측으로 `xify` 로 붙습니다. `\ ` (백슬래시 공백) 와 `~` 도 수식 안에서 본문 크기의 공백 하나를 넣지만, 폭이 글꼴에 매이므로 위 표의 명령이 예측 가능합니다.

## 9. 자주 하는 실수

- **수식 안에 한글을 그냥** → pdfLaTeX 에서 오류 없이 깨진다 (§3). `\text{ … }`.
- **`\text{여기서}` 에 안쪽 공백 없음** → 앞뒤 수식에 붙는다. `\text{ 여기서 }`.
- **단위를 그냥** `3 m/s` → 이탤릭 `3m/s`. `3\,\mathrm{m/s}`.
- **`\mathrm{Var} X`** → 세워지긴 하지만 `VarX`. 함수 이름은 `\operatorname{Var} X`.
- **`\mathbf{\alpha}`** → 오류 없이 굵어지지 않는다. `\boldsymbol{\alpha}`.
- **`=` 주변에 `\,`** → TeX 가 이미 넣은 간격 위에 더 얹힌다. 관계·연산 기호 주변은 손대지 않는다.
- **`\int f(x) dx`** → `dx` 앞 `\,` 빠짐.

## 정리

| 하고 싶은 것 | 코드 |
|---|---|
| 단어·한글을 수식 안에 | `\text{ 여기서 }` (안쪽 공백 포함) |
| 단위·미분 d·상수 e 를 세워서 | `3\,\mathrm{m/s}` `\mathrm{d}x` `\mathrm{e}^x` |
| 벡터 굵게 (영문) | `\mathbf{v}` (정체) / `\boldsymbol{v}` (이탤릭) |
| 벡터 굵게 (그리스) | `\boldsymbol{\alpha}` |
| 함수 이름 | `\operatorname{Var} X` / 프리앰블 `\DeclareMathOperator{\Var}{Var}` |
| 첨자를 아래에 두는 함수 | `\operatorname*{arg\,max}_{x}` |
| 여러 글자 식별자 | `\mathit{diff}` |
| 가는 공백 · 1 em · 2 em · 음수 | `\,` `\quad` `\qquad` `\!` |

고르는 순서는 이렇습니다. 사람이 읽는 말이면 `\text`, 세워야 하는 수식 기호면 `\mathrm`, 굵게면 `\boldsymbol`, 뒤에 인자가 오는 이름이면 `\operatorname`. 그리고 공백은 스페이스가 아니라 `\,`·`\quad` 로.

---

이전 글: [LaTeX 괄호 크기 — \left·\right 로 안 될 때 쓰는 세 가지](/blog/posts/latex-brackets-left-right-sizes/)
함께 보기: [LaTeX 그리스 문자·수학 기호 완전 레퍼런스](/blog/posts/latex-greek-letters-complete/) · [kotex 로 한국어 논문 처음부터 세팅하기](/blog/posts/kotex-korean-setup/) · [LaTeX 수식 오류·실수 완전 해결 가이드](/blog/posts/latex-math-errors-guide/)
