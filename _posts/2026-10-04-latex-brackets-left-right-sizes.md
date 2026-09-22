---
title: "LaTeX 괄호 크기 — \\left·\\right 로 안 될 때 쓰는 세 가지"
date: 2026-10-04 09:00:00 +0900
categories: [LaTeX, 수식]
tags: [latex, 괄호, left, right, bigl, bigr, vphantom, 절댓값, 줄바꿈, amsmath, 수식]
math: true
pin: false
description: "\\left( … \\right) 는 안쪽 높이를 재서 괄호를 키우는 도구이고, 그래서 안 되는 장면이 네 가지 있습니다 — 극한까지 재서 너무 커질 때, 한쪽만 필요할 때, 줄바꿈을 넘어야 할 때, 문장 속에서. 수동 크기 \\bigl~\\Biggr, 보이지 않는 짝 \\left. \\right., 줄 사이 높이를 맞추는 \\vphantom 을 실측 결과와 함께 정리합니다. 절댓값 |x| 의 빼기 앞 공백이 생기는 이유도."
---

`\left( … \right)` 까지는 압니다. 안쪽 분수에 맞춰 괄호가 커지고, 그걸로 대부분은 해결됩니다. 그런데 어느 날 네 장면 중 하나를 만납니다.

1. 합 기호 위아래 극한까지 괄호가 덮어서 **너무 크다.**
2. 미분 결과에 `|` 를 세우고 `x=0` 을 달고 싶은데 **왼쪽 짝이 없다.**
3. [긴 수식을 줄바꿈](/blog/posts/latex-long-equation-line-break/)했더니 `\left(` 와 `\right)` 가 다른 줄에 가서 **컴파일 오류**가 난다.
4. 절댓값 `|-x|` 를 썼는데 빼기 앞뒤로 **이상한 공백**이 생긴다.

네 장면의 답은 도구 세 가지입니다 — 수동 크기 `\bigl`~`\Biggr`, 보이지 않는 짝 `\left.`·`\right.`, 줄 사이 높이를 맞추는 `\vphantom`. 그리고 네 번째 장면은 괄호의 **이름**을 바꾸면 끝납니다. 아래 결과는 전부 MiKTeX 25.12 (LaTeX2e 2025-11-01, `amsmath` 로드) 로 컴파일해 확인한 것입니다.

## 1. 먼저 — \left 는 무엇을 재는가

`\left(` 는 짝인 `\right)` 까지의 **내용 전체의 높이** 를 재서 그 높이에 맞는 괄호를 고릅니다. 분수를 감싸면 분수 높이만큼 커지는 것이 이 규칙이고, 문제는 "내용 전체"에 위첨자·아래첨자·극한까지 들어간다는 점입니다.

```latex
\left( \sum_{i=1}^{n} a_i \right)^2
\qquad
\Bigl( \sum_{i=1}^{n} a_i \Bigr)^2
```

$$\left( \sum_{i=1}^{n} a_i \right)^2 \qquad \Bigl( \sum_{i=1}^{n} a_i \Bigr)^2$$

실측으로 왼쪽은 괄호가 `i=1` 부터 `n` 까지 전부 덮어 `\biggl(` 과 같은 높이가 되고, 오른쪽 `\Bigl(` 은 합 기호 본체만 감쌉니다. 인쇄된 수학책이 쓰는 쪽은 대개 오른쪽입니다. `\left` 가 틀린 것이 아니라 **재는 기준이 다를 뿐** 이고, 그래서 손으로 크기를 고르는 도구가 따로 있습니다.

> **Google Docs 수식 편집기의 툴바 괄호** ( ) [ ] { } | | 는 정확히 이 `\left( … \right)` 에 해당하는 자동 크기 구조입니다. 편집기가 무엇을 저장하는지는 [Google Docs 수식 편집기는 무엇을 저장하나](/blog/posts/google-docs-equation-editor-structure/)에 있습니다.
{: .prompt-info }

## 2. 어느 것을 쓰나 — 판단 표

| 상황 | 도구 | 비고 |
|---|---|---|
| 분수·근호 하나를 감싼다 | `\left( … \right)` | 기본. 대부분 이걸로 끝 |
| 극한 달린 합·적분을 감싼다 | `\Bigl( … \Bigr)` 또는 `\biggl( … \biggr)` | `\left` 는 극한까지 재서 커진다 (§1) |
| 괄호가 세 겹 이상 | `\biggl( \Bigl[ \bigl\{ … \bigr\} \Bigr] \biggr)` | `\left` 는 안쪽 내용이 작으면 세 겹이 전부 같은 크기 |
| 한쪽만 필요 (평가 막대, 왼쪽 중괄호) | `\left. … \right\|`, `\left\{ … \right.` | 점 `.` 이 보이지 않는 짝 (§4) |
| 줄바꿈을 넘어야 한다 | `\right.` + `\left.` + `\vphantom`, 또는 수동 크기 | `\left`·`\right` 는 같은 줄에 있어야 한다 (§5) |
| 문장 속 `$…$` 안 | `\bigl( \tfrac{a}{b} \bigr)` | `\left` 도 되지만 `\tfrac` 과 수동 크기가 줄을 덜 밀어낸다 |
| 절댓값·노름 | `\lvert … \rvert`, `\lVert … \rVert` | `\|` 는 여는지 닫는지 몰라 간격이 틀어진다 (§6) |
| 조건이 있는 집합, 조건부 확률의 세로줄 | `\left\{ … \middle\| … \right\}` | 가운데 구분자도 같은 높이로 (§4) |

## 3. 수동 크기 — \bigl 부터 \Biggl 까지, 그리고 l·r 을 붙이는 이유

크기는 네 단계입니다. 작은 것부터 `\big`, `\Big`, `\bigg`, `\Bigg`.

```latex
( \big( \Big( \bigg( \Bigg(
```

$$( \big( \Big( \bigg( \Bigg( \qquad \Bigg) \bigg) \Big) \big) )$$

실제로 쓸 때는 여는 쪽에 `l`, 닫는 쪽에 `r` 을 붙입니다 — `\bigl(` 와 `\bigr)`. 붙이지 않은 `\big(` 도 컴파일은 되지만 간격이 달라집니다. 실측:

```latex
\big( -x \big) \qquad \bigl( -x \bigr)
```

$$\big( -x \big) \qquad \bigl( -x \bigr)$$

왼쪽은 괄호와 `-` 사이에 공백이 들어가 `( − x)` 처럼 보이고, 오른쪽은 `(−x)` 로 붙습니다. `l` 이 없는 `\big(` 는 TeX 에게 "괄호"가 아니라 "그냥 기호" 라서, 뒤의 `-` 를 (부호가 아니라) 두 항 사이의 빼기로 보고 양쪽에 간격을 넣기 때문입니다. `\left(` 는 이 문제가 없습니다 — 항상 여는 괄호로 취급됩니다.

수동 크기의 장점은 **짝을 요구하지 않는다** 는 것입니다. `\bigl(` 하나만 있어도 오류가 아니고, 여는 쪽과 닫는 쪽 크기를 다르게 줘도 됩니다. 이 성질이 §5 의 줄바꿈에서 쓸모가 있습니다.

### 3.1 세 겹 괄호는 계단으로

괄호가 겹칠 때 `\left` 를 전부 쓰면, 안쪽 내용이 낮은 한 세 겹이 **모두 같은 크기** 로 나옵니다. 어느 괄호가 어느 것과 짝인지 눈으로 구분이 안 됩니다.

```latex
\biggl( \Bigl[ \bigl\{ x + y \bigr\} \Bigr] \biggr)
\qquad
\left( \left[ \left\{ x + y \right\} \right] \right)
```

$$\biggl( \Bigl[ \bigl\{ x + y \bigr\} \Bigr] \biggr) \qquad \left( \left[ \left\{ x + y \right\} \right] \right)$$

왼쪽처럼 바깥으로 갈수록 한 단계씩 키우는 것이 관례입니다. `amsmath` 를 로드하면 `\bigl` 계열이 글꼴 크기에 따라 함께 늘어나므로 각주·캡션 안에서도 비율이 유지됩니다.

## 4. 보이지 않는 짝 — \left. 과 \right.

`\left` 와 `\right` 는 반드시 짝이어야 하지만, 한쪽을 **점 `.`** 으로 두면 그 자리에 아무것도 그리지 않습니다. 한쪽 괄호만 필요한 장면이 전부 이걸로 해결됩니다.

**평가 막대.** 미분 결과에 세로줄을 세우고 아래에 조건을 답니다.

```latex
\left. \frac{df}{dx} \right|_{x=0}
```

$$\left. \frac{df}{dx} \right|_{x=0}$$

같은 것을 수동 크기로는 `\frac{df}{dx} \bigg|_{x=0}` 로 씁니다 — 짝이 필요 없으니 여는 쪽을 아예 안 씁니다. 실측으로 두 결과는 같습니다.

**왼쪽 중괄호 하나.** 경우를 나누는 식의 왼쪽 중괄호입니다.

```latex
|x| = \left\{ \begin{array}{ll} x & (x \ge 0) \\ -x & (x < 0) \end{array} \right.
```

$$|x| = \left\{ \begin{array}{ll} x & (x \ge 0) \\ -x & (x < 0) \end{array} \right.$$

다만 이 용도라면 `cases` 환경이 이 조합을 통째로 대신합니다 — [행렬과 연립방정식 글](/blog/posts/latex-matrix-cases/)에서 다뤘습니다. `\left\{ … \right.` 는 `array` 가 아닌 것 (예: 여러 줄 `aligned`) 을 감쌀 때 남겨 두면 됩니다.

**가운데 세로줄.** 조건이 붙는 집합이나 조건부 확률의 세로줄은 `\middle|` 입니다. 바깥 괄호와 같은 높이로 그려집니다.

```latex
\left\{ \, x \in \mathbb{R} \, \middle| \, x > 0 \, \right\}
\qquad
P\left( A \,\middle|\, B \right)
```

$$\left\{ \, x \in \mathbb{R} \, \middle| \, x > 0 \, \right\} \qquad P\left( A \,\middle|\, B \right)$$

`\middle` 은 `\left`·`\right` 사이에서만 쓸 수 있습니다. 앞뒤의 `\,` 는 세로줄이 글자에 붙지 않게 하는 가는 공백입니다.

## 5. 줄을 넘는 괄호 — 09-30 글의 바로 다음 질문

[긴 수식을 `multline`·`split` 으로 끊는 방법](/blog/posts/latex-long-equation-line-break/)을 쓰다 보면 여는 괄호는 첫 줄에, 닫는 괄호는 둘째 줄에 가는 순간이 옵니다. 그대로 두면 오류입니다.

```latex
\begin{multline}
  \left( a + b + c \\
  + d \right)
\end{multline}
```

실측 결과, 두 오류가 연달아 납니다.

```
! Missing \right. inserted.
! Extra \right.
```

이유는 `\\` 가 수식 한 줄을 **닫기** 때문입니다. `\left(` 는 자기 줄 안에서 짝을 찾다가 못 찾아 TeX 가 `\right.` 를 끼워 넣고 (첫 오류), 둘째 줄의 `\right)` 는 짝 없는 고아가 됩니다 (둘째 오류). `split`·`aligned`·`align` 도 같습니다 — **`\left` 와 `\right` 는 같은 줄, 같은 칸 안에 있어야 합니다.**

해법은 둘입니다.

**해법 A — 각 줄을 보이지 않는 짝으로 닫고 연다.** 첫 줄 끝에 `\right.`, 둘째 줄 시작에 `\left.`.

```latex
\begin{equation}
\begin{split}
  F &= \left( \frac{x^2}{2} + \frac{y^2}{2} \right. \\
    &\qquad \left. + \frac{z^2}{2} \right)
\end{split}
\end{equation}
```

$$\begin{split} F &= \left( \frac{x^2}{2} + \frac{y^2}{2} \right. \\ &\qquad \left. + \frac{z^2}{2} \right) \end{split}$$

컴파일되고, 두 줄의 내용 높이가 같아서 여는 괄호와 닫는 괄호도 같은 크기입니다. 그런데 높이가 다르면 — 첫 줄은 분수가 없고 둘째 줄에만 분수가 있으면 — 여는 괄호는 작고 닫는 괄호는 큰 **짝짝이** 가 됩니다 (실측). 각 줄의 `\left` 가 자기 줄만 재기 때문입니다.

그때 `\vphantom` 을 씁니다. `\vphantom{X}` 는 X 만큼의 **높이만 있고 폭은 0인 보이지 않는 상자** 입니다. 낮은 쪽 줄에 높은 쪽 내용을 유령으로 넣어 두면 두 줄의 `\left`·`\right` 가 같은 높이를 잽니다.

```latex
\begin{multline}
  \left( a + b + c + d \vphantom{\frac{1}{2}} \right. \\
  \left. + \frac{1}{2} \right)
\end{multline}
```

$$\begin{multline} \left( a + b + c + d \vphantom{\frac{1}{2}} \right. \\ \left. + \frac{1}{2} \right) \end{multline}$$

**해법 B — 수동 크기.** `\biggl(` 와 `\biggr)` 는 짝을 요구하지 않으므로 (§3) 줄을 넘어도 그냥 됩니다.

```latex
\begin{multline*}
  \biggl( a + b + c + d + \frac{1}{2} \\
  + e + f + \frac{1}{3} \biggr)
\end{multline*}
```

$$\begin{multline*} \biggl( a + b + c + d + \frac{1}{2} \\ + e + f + \frac{1}{3} \biggr) \end{multline*}$$

실측으로 오류 없이 컴파일되고 양쪽이 같은 크기입니다. 줄이 둘뿐이고 크기를 눈으로 고를 수 있으면 B 가 짧고, 줄이 많거나 안쪽 높이가 줄마다 다르면 A + `\vphantom` 이 정확합니다.

## 6. 괄호의 이름 — 부등호와 세로줄을 그대로 치면 생기는 일

괄호처럼 보이는 글자 중 두 개는 괄호가 아닙니다.

**꺾쇠.** `<x, y>` 라고 치면 `<` 와 `>` 는 **부등호** 로 조판됩니다 — 실측으로 `< x >` 처럼 양옆에 관계 기호 간격이 들어갑니다. 꺾쇠 괄호는 `\langle`·`\rangle` 입니다.

**세로줄.** `|` 는 여는 괄호인지 닫는 괄호인지 TeX 가 모릅니다. 그래서 `|-x|` 에서 첫 `|` 뒤의 `-` 를 두 항 사이의 빼기로 보고 간격을 넣습니다 (§3 의 `\big(` 와 같은 이유).

```latex
|-x| \qquad \lvert -x \rvert \qquad \left| -x \right|
```

$$|-x| \qquad \lvert -x \rvert \qquad \left| -x \right|$$

실측으로 첫 번째만 `| − x|` 처럼 벌어지고, `\lvert`·`\rvert` (`amsmath`) 와 `\left|`·`\right|` 는 `|−x|` 로 붙습니다. 노름은 `\lVert`·`\rVert`. 둘 다 `\bigl\lvert` 처럼 수동 크기 앞에 붙일 수 있습니다.

| 원하는 것 | 쓰는 것 | 치면 안 되는 것 |
|---|---|---|
| ⟨x, y⟩ | `\langle x, y \rangle` | `<x, y>` (부등호가 된다) |
| \|x\| | `\lvert x \rvert` | `\|x\|` (여닫이 구분이 없다) |
| ‖v‖ | `\lVert v \rVert` | `\Vert v \Vert` (같은 이유) |
| ⌊x⌋ ⌈x⌉ | `\lfloor x \rfloor` `\lceil x \rceil` | — |
| {x} | `\{ x \}` | `{x}` (묶음 기호라 안 보인다) |

전부 `\left`·`\bigl` 뒤에 붙일 수 있습니다: `\left\lfloor \frac{n}{2} \right\rfloor`, `\Bigl\lceil \frac{n}{2} \Bigr\rceil`.

## 7. 문장 속에서

본문 `$…$` 안에서는 분수가 이미 작게 (`\tfrac` 크기로) 조판되므로, 실측으로 `\left( \frac{a}{b} \right)` 와 `\bigl( \tfrac{a}{b} \bigr)` 는 같은 크기의 괄호가 나옵니다. 어느 쪽이든 되지만 `\bigl` 쪽이 짝 오류에서 자유롭고, `\tfrac` 을 함께 쓰면 무엇이 인라인 크기인지 코드에서 드러납니다.

함수 이름 뒤에서는 차이가 하나 더 있습니다.

```latex
\sin(x) \qquad \sin\left(x\right) \qquad \sin\bigl(x\bigr)
```

$$\sin(x) \qquad \sin\left(x\right) \qquad \sin\bigl(x\bigr)$$

실측으로 가운데만 `sin` 과 `(` 사이가 벌어집니다. `\left … \right` 는 안쪽 전체를 하나의 덩어리로 묶는데, TeX 는 함수 이름과 그런 덩어리 사이에 가는 공백을 넣기 때문입니다. `\sin(x)` 처럼 작은 인자에는 `\left` 를 붙일 이유가 없고, 붙이면 오히려 간격이 달라집니다.

## 8. 자주 하는 실수

- **`\left(` 만 쓰고 `\right` 를 안 쓴다** → `! Missing \right. inserted.` 짝을 채우거나 `\right.` 로 닫습니다.
- **`\left(` 와 `\right)` 가 다른 줄** → §5. `\\` 앞에서 `\right.`, 뒤에서 `\left.`.
- **`\big(` 에 `l`·`r` 을 안 붙인다** → 컴파일은 되지만 `-` 앞에 공백. `\bigl(`·`\bigr)`.
- **모든 괄호에 `\left`** → 세 겹이 같은 크기, 극한 위까지 덮는 괄호, `\sin` 뒤 공백. 내용이 한 줄 높이면 그냥 `( )`, 극한이 있으면 `\Bigl`.
- **`<`·`>`·`|` 를 괄호로** → `\langle`·`\rangle`·`\lvert`·`\rvert`.
- **`\middle` 을 `\left` 없이** → `\middle` 은 `\left … \right` 사이에서만.

## 정리

| 하고 싶은 것 | 코드 |
|---|---|
| 안쪽 높이에 맞춰 자동으로 | `\left( … \right)` |
| 크기를 손으로 (네 단계) | `\bigl( … \bigr)` `\Bigl` `\biggl` `\Biggl` |
| 한쪽만 | `\left. … \right\|` / `\frac{…}{…} \bigg\|_{x=0}` |
| 가운데 세로줄 | `\left\{ … \middle\| … \right\}` |
| 줄을 넘어서 | 줄 끝 `\right.` + 줄 시작 `\left.` (+ 낮은 줄에 `\vphantom{높은 것}`), 또는 `\biggl( … \\ … \biggr)` |
| 절댓값·노름 | `\lvert … \rvert` `\lVert … \rVert` |
| 꺾쇠·바닥·천장 | `\langle \rangle` `\lfloor \rfloor` `\lceil \rceil` |

고르는 순서는 이렇습니다. 분수 하나면 `\left`, 극한이 있거나 세 겹이면 수동 크기, 한쪽만이면 `\left.`, 줄을 넘으면 `\vphantom` 또는 수동 크기. 그리고 `<`·`|` 는 이름을 부릅니다.

---

이전 글: [LaTeX 긴 수식 줄바꿈 — multline·split·aligned 언제 무엇을 쓰나](/blog/posts/latex-long-equation-line-break/)
함께 보기: [LaTeX 분수·제곱·루트·적분 — 가장 자주 쓰는 5가지](/blog/posts/latex-fraction-integral/) · [LaTeX 행렬과 연립방정식 — pmatrix·bmatrix·cases](/blog/posts/latex-matrix-cases/) · [LaTeX 수식 오류·실수 완전 해결 가이드](/blog/posts/latex-math-errors-guide/)
