---
title: "LaTeX 수식 번호와 참조 — \\label과 \\eqref"
date: 2026-06-26 09:00:00 +0900
categories: [LaTeX, 수식]
tags: [latex, 수식번호, label, eqref, ref, amsmath, 수식]
math: true
pin: false
description: "LaTeX 수식 번호 자동 매기기와 본문 참조 방법 — equation 환경의 자동 번호, \\label 로 식에 이름 붙이기, \\eqref 와 \\ref 의 차이, amsmath 필수 설정, align 안에서 일부 줄만 번호 빼기 (\\notag), \\tag 로 사용자 정의 표식까지 한 번에 정리."
---

논문이나 보고서의 본문에서 "위 식 (3) 에 의하면..." 처럼 식을 끌어다 쓰는 순간, 수동으로 번호를 적기 시작하면 식 한 줄을 새로 끼울 때마다 본문의 모든 번호를 다시 손봐야 합니다. LaTeX 는 이 작업을 통째로 자동화합니다. **수식 번호 자동 매기기 + `\label` 로 이름 붙이기 + `\eqref` 로 본문에서 참조** — 이 세 가지 조합만 손에 익히면, 식 순서가 어떻게 바뀌어도 본문 번호가 알아서 맞아 들어갑니다.

이전 글까지 인라인·디스플레이 두 모드와 다섯 가지 핵심 명령어, 그리스 문자·수학 기호까지 정리했다면, 이번 글은 그 식들을 **본문 흐름과 연결하는 마지막 한 단계** 입니다. 코드와 출력 비교, 함정 사례, 권장 작명 관례까지 한 번에 짚습니다.

## 1. 왜 자동 번호인가 — 수동 번호의 한계

`equation` 환경에 들어간 식은 LaTeX 가 자동으로 (1), (2), (3) 순서대로 번호를 매깁니다. 본문에서 식을 가리킬 때는 그 번호를 직접 적는 게 아니라 **식에 붙인 이름** 으로 참조합니다. 이게 왜 중요한지부터 짚어봅시다.

수동으로 번호를 적으면 두 가지 문제가 거의 매번 터집니다.

1. **식을 한 줄 끼우면 뒤 번호가 모두 밀린다.** 5개 식을 (1)~(5) 라고 본문에 적어 두었는데, (2) 와 (3) 사이에 새 식을 끼우면 본문의 (3)~(5) 가 전부 (4)~(6) 으로 바뀝니다. 찾아서 고치는 데 한 식당 1분, 깜빡 놓치면 본문 흐름이 깨집니다.
2. **다른 사람과 협업할 때 번호가 어긋난다.** 공저자가 식을 추가하면 본문 번호도 같이 맞춰 줘야 하는데, 누가 어디서 손댔는지 추적이 안 됩니다.

LaTeX 의 해법은 단순합니다. **식에 사람이 읽을 수 있는 이름을 붙이고, 본문에서는 그 이름으로 식을 부른다.** 번호는 컴파일러가 알아서 매깁니다.

```latex
\begin{equation}
  F = ma \label{eq:newton}
\end{equation}

뉴턴의 제2법칙 \eqref{eq:newton} 에 따르면, 힘은 질량과 가속도의 곱입니다.
```

출력:

$$F = ma \tag{1}$$

> 뉴턴의 제2법칙 (1) 에 따르면, 힘은 질량과 가속도의 곱입니다.

식 앞뒤로 다른 식이 100개가 추가되어도 본문의 `\eqref{eq:newton}` 는 자동으로 그 시점의 새 번호로 다시 그려집니다. 식 순서를 바꿔도, 다른 장으로 옮겨도 마찬가지입니다.

## 2. equation 환경의 자동 번호

`equation` 환경은 디스플레이 수식을 감싸는 가장 기본적인 환경이며, **자동으로 번호를 매깁니다**.

```latex
\begin{equation}
  E = mc^2
\end{equation}

\begin{equation}
  \int_0^1 x^2 \, dx = \frac{1}{3}
\end{equation}
```

출력:

$$E = mc^2 \tag{1}$$

$$\int_0^1 x^2 \, dx = \frac{1}{3} \tag{2}$$

별표 (`*`) 가 붙은 `equation*` 환경은 같은 모양으로 식을 띄우되 **번호를 매기지 않습니다**.

```latex
\begin{equation*}
  e^{i\pi} + 1 = 0
\end{equation*}
```

출력:

$$e^{i\pi} + 1 = 0$$

본문에서 굳이 부를 일이 없는 식은 `equation*` 로 처리하는 게 깔끔합니다. 모든 식에 번호를 매기면 본문이 산만해지고 정작 중요한 식의 번호가 묻혀버리는 역효과가 납니다. 책의 관례는 **본문에서 한 번이라도 끌어다 쓸 식만 번호** 입니다.

별표가 붙은 환경 (`*` variant) 은 `equation` 외에도 `align*`, `gather*`, `multline*` 처럼 `amsmath` 의 거의 모든 수식 환경에 공통으로 존재합니다. 의미는 동일 — "번호 없음".

## 3. \\label 로 식에 이름 붙이기

자동으로 매겨진 번호를 본문에서 끌어다 쓰려면, 그 식에 **`\label{이름}`** 을 붙입니다.

```latex
\begin{equation}
  F = ma \label{eq:newton}
\end{equation}
```

`\label{eq:newton}` 의 의미는 **"바로 이 식의 번호를 `eq:newton` 이라는 이름으로 기억해 두라"** 입니다. 본문에서 `\eqref{eq:newton}` 라고 적으면, LaTeX 가 그 자리에 식 번호를 다시 그려 줍니다.

### \\label 위치

`\label` 은 식 환경 **안에** 두는 게 안전합니다. `equation` 환경 안의 어디에 두든 같은 식 번호를 가리키므로, 식 끝에 붙이는 게 관례입니다.

```latex
% 권장
\begin{equation}
  F = ma \label{eq:newton}
\end{equation}

% 가능하지만 비권장 — 의도가 흐림
\begin{equation} \label{eq:newton}
  F = ma
\end{equation}
```

`align` 환경처럼 줄마다 번호가 매겨지는 환경에서는 **`\label` 이 같은 줄에 있어야** 그 줄 번호를 가리킵니다. 자세한 내용은 4 절에서 다룹니다.

### 작명 관례 — eq:, fig:, tab: 접두어

`\label` 의 이름은 사람이 읽기 위한 것이므로 자유롭게 정할 수 있습니다. 그러나 학계에서 통용되는 **접두어 관례** 가 있어 따르는 게 협업에 좋습니다.

| 접두어 | 대상 |
|---|---|
| `eq:` | 수식 (equation) |
| `fig:` | 그림 (figure) |
| `tab:` | 표 (table) |
| `sec:` | 절·장 (section) |
| `chap:` | 장 (chapter) |
| `thm:` | 정리 (theorem) |

예: `eq:newton`, `fig:histogram`, `tab:results`, `sec:method`. 접두어 자체는 필수 아니지만, 본문에 `\eqref{newton}` 만 적혀 있으면 그게 식인지 그림인지 헷갈리고, 100 페이지짜리 문서가 되면 검색·관리가 어려워집니다.

이름에는 공백 대신 하이픈이나 콜론·언더스코어를 씁니다. 한국어는 피하고 영문 소문자로 — `\label{eq:뉴턴법칙}` 은 동작하지만 다른 사람·도구가 깨질 위험이 있습니다.

## 4. \\eqref 와 \\ref 의 차이

본문에서 식 번호를 다시 그릴 때 명령어가 두 가지입니다.

```latex
% \ref — 괄호 없이 숫자만
\ref{eq:newton}

% \eqref — 괄호 포함
\eqref{eq:newton}
```

| 명령어 | 출력 | 권장 용도 |
|---|---|---|
| `\ref{eq:newton}` | `1` | 일반 참조 (그림·표·절 번호 등) |
| `\eqref{eq:newton}` | `(1)` | 수식 번호 전용 — 자동으로 괄호 |

수식 번호는 본문에 등장할 때 거의 항상 괄호와 함께 적습니다. `(1) 에 의하면...` 같은 식이죠. **그래서 수식 참조는 `\eqref` 가 정답입니다.** `\ref` 를 쓰고 손으로 괄호를 적으면 `(`\ref{eq:newton}`)` 처럼 어색해집니다.

```latex
% 권장
뉴턴의 제2법칙 \eqref{eq:newton} 에 의하면 ...

% 비권장 — 같은 결과지만 손이 한 번 더 감
뉴턴의 제2법칙 (\ref{eq:newton}) 에 의하면 ...
```

그림·표 참조는 보통 괄호 없이 적으므로 `\ref` 가 자연스럽습니다.

```latex
% 그림 참조 — \ref 가 자연스러움
그림 \ref{fig:histogram} 의 분포에서 보듯이 ...

% \eqref 를 쓰면 어색
그림 \eqref{fig:histogram} 의 분포에서 보듯이 ...  % → 그림 (3) 의 분포...
```

요약: **수식은 `\eqref`, 그 외는 `\ref`**.

## 5. amsmath 패키지 — \\eqref 의 전제

`\eqref` 는 LaTeX 표준 명령어가 아닙니다. **`amsmath` 패키지가 제공합니다.** 프리앰블에 다음 한 줄을 추가해야 합니다.

```latex
\usepackage{amsmath}
```

`amsmath` 가 없으면 `\eqref` 호출 시 `Undefined control sequence` 오류가 납니다.

```
! Undefined control sequence.
l.42 식 \eqref
              {eq:newton} 에 의하면 ...
```

LaTeX 본문을 진지하게 쓸 거라면 `amsmath` 는 거의 무조건 들어갑니다. 이 패키지는 `align`, `gather`, `multline`, `cases`, `\text{}` 같은 환경·명령어도 함께 제공하기 때문에, 수식 글의 사실상 기본 패키지입니다. 책의 6장 이후로 다루는 수식 명령어의 절반 이상이 `amsmath` 의 자산입니다.

## 6. align 안에서 일부 줄만 번호 빼기 — \\nonumber, \\notag

여러 줄짜리 수식을 정렬해서 적을 때 쓰는 `align` 환경은 **줄마다 번호를 매깁니다**.

```latex
\begin{align}
  a^2 + b^2 &= c^2 \label{eq:pyth} \\
  c &= \sqrt{a^2 + b^2}
\end{align}
```

출력:

$$\begin{aligned} a^2 + b^2 &= c^2 \\ c &= \sqrt{a^2 + b^2} \end{aligned}$$
$$ \tag{3, 4}$$

(MathJax 환경에서는 줄별 번호를 정확히 시뮬레이션하기 어려워 묶어 표기했습니다. 실제 LaTeX 컴파일에서는 위 두 줄이 각각 (3) 과 (4) 로 매겨집니다.)

본문에서 끌어다 쓸 식이 위 두 줄 중 첫 줄뿐이라면, 둘째 줄에는 번호가 필요 없습니다. 이때 **`\nonumber` 또는 `\notag`** 를 그 줄에 붙입니다.

```latex
\begin{align}
  a^2 + b^2 &= c^2 \label{eq:pyth} \\
  c &= \sqrt{a^2 + b^2} \notag
\end{align}
```

`\nonumber` 와 `\notag` 는 같은 동작을 합니다. `\notag` 가 `amsmath` 에서 도입된 신형이고 권장 형태이지만, 둘 다 동작합니다.

전체 `align` 의 모든 줄에 번호를 매기지 않으려면 별표 환경 `align*` 을 씁니다.

```latex
% 모든 줄에 번호 없음
\begin{align*}
  a^2 + b^2 &= c^2 \\
  c &= \sqrt{a^2 + b^2}
\end{align*}
```

**선택 규칙**:
- 다 번호 필요 → `align`
- 다 번호 필요 없음 → `align*`
- 일부만 필요 → `align` + 나머지에 `\notag`

## 7. \\tag — 사용자 정의 표식

가끔 식 번호 대신 **(★)** 이나 **(i)** 같은 사용자 정의 표식을 쓰고 싶을 때가 있습니다. 책에서 강조 식을 표시하거나, 동일 식을 다른 맥락에서 다시 보일 때 등입니다. 이때 **`\tag{...}`** 를 씁니다.

```latex
\begin{equation}
  E = mc^2 \tag{$\star$}
\end{equation}
```

출력:

$$E = mc^2 \tag{$\star$}$$

`\tag` 가 붙은 식은 자동 번호 카운터를 **소비하지 않습니다**. 즉 위 식 다음에 나오는 `equation` 의 자동 번호는 (n+1) 이 아니라 (n) 그대로 이어집니다. 표식만 바뀐 식이라고 LaTeX 에게 알려주는 셈입니다.

```latex
\begin{equation}
  a + b = c
\end{equation}                       % (1)

\begin{equation}
  E = mc^2 \tag{$\star$}
\end{equation}                       % (★) — 자동 번호 카운터 소비 안 함

\begin{equation}
  x + y = z
\end{equation}                       % (2) — 그래서 여기는 (3) 이 아니라 (2)
```

같은 식을 다른 장에서 다시 보여줄 때 `\tag` 로 원래 번호를 강제로 가져오면 독자가 헷갈리지 않습니다. 자주 쓰는 패턴은 아니지만, 알아 두면 막힐 때 풀 카드가 됩니다.

## 8. 두 번 컴파일해야 번호가 맞는다

LaTeX 의 `\eqref` 가 작동하는 원리는 **두 단계 컴파일** 입니다.

1. **첫 번째 컴파일** — 본문을 한 번 훑으며 모든 `\label` 의 이름과 그 시점의 번호를 `.aux` 파일에 적어둡니다. 이 시점에 `\eqref` 는 아직 무슨 번호를 그려야 할지 모르므로 임시로 `??` 을 출력합니다.
2. **두 번째 컴파일** — `.aux` 의 라벨 표를 읽어 본문의 모든 `\eqref` 자리에 실제 번호를 채워 넣습니다.

처음 컴파일했을 때 본문에 `??` 이 보이거나 다음 경고가 나오면 **한 번 더 컴파일** 하면 됩니다.

```
LaTeX Warning: Reference `eq:newton' on page 1 undefined on input line 42.
LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.
```

대부분의 LaTeX 편집기 (Overleaf, TeXstudio 등) 는 이 과정을 자동으로 두 번 돌립니다. 그래서 익숙해지면 신경 쓸 일이 거의 없지만, 작동 원리를 알고 있으면 갑자기 (1) 이 (??) 로 나올 때 당황하지 않습니다.

## 9. 자주 하는 실수 5가지

### 실수 1: \\label 빼먹기

```latex
% 라벨이 없어 본문에서 부를 수 없음
\begin{equation}
  F = ma
\end{equation}

% 본문에서 \eqref{eq:newton} → "??" 출력
```

식을 적은 직후 본문에 `\eqref{...}` 가 등장한다면, 식에 `\label{...}` 도 함께 박는 습관을 들이면 안전합니다.

### 실수 2: amsmath 패키지 누락

프리앰블에 `\usepackage{amsmath}` 가 없으면 `\eqref` 가 동작하지 않습니다. `Undefined control sequence` 가 뜨면 가장 먼저 패키지 로드를 의심하세요.

### 실수 3: 라벨 이름 오타

```latex
\begin{equation}
  F = ma \label{eq:newton}
\end{equation}

% 본문 — 'n' 빠짐
... 뉴턴의 제2법칙 \eqref{eq:ewton} ...   % → (??) 출력
```

LaTeX 가 `eq:ewton` 라벨을 못 찾아서 `??` 을 출력합니다. 라벨 이름은 짧고 분명하게 — 그래야 오타 가능성이 줄어듭니다.

### 실수 4: 한 식에 \\label 두 번

`equation` 환경 안에 `\label` 을 두 번 적으면, 두 번째 라벨이 첫 번째를 덮습니다. 의도한 결과가 아니라면 의문의 본문 참조 깨짐이 됩니다. 한 식에는 라벨 하나 — 원칙입니다.

`align` 처럼 줄마다 번호 매기는 환경에서는 줄마다 별도 `\label` 을 붙일 수 있습니다 — 이건 정상입니다.

```latex
\begin{align}
  a^2 + b^2 &= c^2 \label{eq:pyth-1} \\
  c &= \sqrt{a^2 + b^2} \label{eq:pyth-2}
\end{align}
```

### 실수 5: 라벨이 식 환경 밖에 있음

```latex
% 틀린 예 — \label 이 식 환경 밖
\begin{equation}
  F = ma
\end{equation}
\label{eq:newton}     % → 식 번호가 아니라 절 번호 등 직전 카운터 참조
```

`\label` 은 식 환경 안쪽에 둬야 그 식의 번호를 가리킵니다. 환경 밖에 두면 직전에 카운터가 증가한 다른 객체 (절 번호 등) 를 가리킬 수 있어 결과가 묘하게 어긋납니다.

## 정리

| 명령어 | 역할 |
|---|---|
| `equation` | 자동 번호 매기는 디스플레이 식 환경 |
| `equation*` | 번호 없는 디스플레이 식 환경 |
| `\label{eq:name}` | 식에 이름 붙이기 (식 환경 안에 둘 것) |
| `\eqref{eq:name}` | 본문에서 식 번호 참조 — `(1)` 형태 |
| `\ref{eq:name}` | 본문 참조 — `1` 형태 (식 외 객체용) |
| `\nonumber` / `\notag` | `align` 안에서 그 줄만 번호 빼기 |
| `\tag{...}` | 사용자 정의 표식 (자동 번호 카운터 보존) |
| `\usepackage{amsmath}` | `\eqref` · `\notag` · `align` 전제 패키지 |

세 가지 원칙만 챙기면 식 번호 작업이 자동화됩니다.

1. **본문에 끌어다 쓸 식에만 번호** — 나머지는 `equation*` 또는 `align` + `\notag`.
2. **수식 참조는 `\eqref`** — 그림·표·절은 `\ref`.
3. **라벨 접두어 관례 (`eq:`, `fig:`, `tab:`) 를 지키기** — 협업·검색·관리에 큰 차이.

`\label` 과 `\eqref` 의 조합은 LaTeX 가 워드 프로세서보다 본문 구조 작업에서 결정적으로 앞서는 지점입니다. 식을 끼우든 빼든 옮기든, 본문 번호가 알아서 맞아 들어가는 안정감 — 이게 100 페이지짜리 논문을 손수 손보지 않아도 되게 해주는 메커니즘입니다.

다음 글에서는 본문 작업에 가장 자주 쓰는 LaTeX 명령어를 한 페이지에 모아둔 **치트시트** 를 정리합니다. Overleaf 에 띄워두고 그대로 복사해 쓸 수 있는 형식입니다.

---

이전 글: <a href="/blog/posts/latex-align-equations/" data-proofer-ignore>#5 LaTeX `align` 환경으로 수식 정렬하기</a>
다음 글: <a href="/blog/posts/latex-command-cheatsheet/" data-proofer-ignore>#8 LaTeX 명령어 치트시트 — 논문 한 편에 실제로 쓰는 것만</a>

> **LaTeX 가 Word 에서 수식 처리 되지 않아, 하나씩 다시 쓰고 계신가요?**
> Docs·Word 파일을 올리면 `$...$` · `$$...$$` · `\(...\)` · `\[...\]` · `[...]` 로 감싼 수식을 골라 이미지로 바꿔 돌려줍니다.
> 수식이 2개든 200개든, 올리는 건 파일 하나입니다. [내 문서로 확인해 보기](https://mathsystem.dev/latexflow/web/) — 설치도 로그인도 없이.
{: .prompt-info }
