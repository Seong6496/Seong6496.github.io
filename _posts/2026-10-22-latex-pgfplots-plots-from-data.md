---
title: "LaTeX 로 그래프 그리기 — pgfplots 로 함수·CSV 데이터 플롯"
date: 2026-10-22 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, pgfplots, 그래프, 플롯, csv, 오차막대, 직선맞춤, 로그축, tikz, 실험보고서, siunitx]
math: false
pin: false
description: "실험 보고서의 그래프를 엑셀 그림 대신 LaTeX 안에서 그리는 pgfplots 를 실측으로 정리합니다 — 함수 플롯과 범례, 삼각함수가 도 단위라 sin(x) 가 거의 직선이 되는 함정 (sin(deg(x))), CSV 파일 플롯과 col sep=comma 를 빼면 나는 오류, 오차 막대, 직선 맞춤 (기울기 9.82 를 직접 계산과 대조), 로그 축, 그리고 compat 한 줄을 빼면 나는 경고까지."
---

실험 보고서에서 그래프는 보통 엑셀이나 파이썬으로 그려 그림 파일로 넣습니다. 그 방법은 [그림 삽입 글](/blog/posts/latex-figures-captions/)에 있습니다. 이 글은 다른 길 — **그래프를 LaTeX 안에서 그리는** `pgfplots` — 입니다. 그래프의 글꼴이 본문과 같아지고, 축 이름에 수식과 단위를 그대로 쓸 수 있고, 데이터 파일이 바뀌면 다시 컴파일만 하면 됩니다.

[TikZ 다이어그램 글](/blog/posts/latex-tikz-diagrams/)이 도형과 화살표를 그렸다면, `pgfplots` 는 그 TikZ 위에서 **축과 데이터** 를 그립니다.

```latex
\usepackage{pgfplots}
\pgfplotsset{compat=1.18}
```

두 번째 줄은 빼먹기 쉽고, 빼면 경고가 납니다 (§5). 아래 그림은 전부 MiKTeX 25.12 (pdfTeX, LaTeX2e 2025-11-01, `pgfplots` **1.18.1**, 한글은 `kotex`) 로 컴파일한 것이고, 같은 원본을 Tectonic 0.17 (`pgfplots` 1.18.1) 로 한 번 더 컴파일해 같은 그림이 나오는 것을 확인했습니다.

## 1. 함수 플롯

```latex
\begin{tikzpicture}
\begin{axis}[
  width=7cm, height=5.5cm,
  xlabel={$x$}, ylabel={$f(x)$},
  domain=-2:2, samples=100,
  legend pos=north west,
  legend cell align=left,
  title={함수 플롯},
]
  \addplot[thick, blue] {x^2};
  \addlegendentry{$x^2$}
  \addplot[thick, red, dashed] {exp(x)};
  \addlegendentry{$e^x$}
\end{axis}
\end{tikzpicture}
```

![pgfplots 실측 — 왼쪽은 x 제곱 (파란 실선) 과 e 의 x 제곱 (빨간 점선) 을 -2 에서 2 까지 그린 그래프와 왼쪽 위 범례, 오른쪽은 0 에서 2π 까지 sin(x) 는 거의 수평인 회색 선이고 sin(deg(x)) 는 한 주기의 파란 사인 곡선](/assets/img/posts/2026-10-22/01-function-plot-degrees.png){: width="720" }

- `axis` 환경이 좌표축 하나입니다. 눈금은 범위에 맞춰 알아서 정해집니다.
- `\addplot {식};` 이 곡선 하나. 식은 `x` 를 변수로 쓰고, `^` · `exp` · `ln` · `sqrt` 같은 계산을 합니다.
- `domain=-2:2` 가 x 범위, `samples=100` 이 계산하는 점의 수입니다. 곡선이 꺾여 보이면 `samples` 를 늘립니다.
- 범례는 `\addlegendentry{…}` 를 각 `\addplot` 바로 뒤에, 위치는 `legend pos` (`north west`, `south east` …) 로.

### 함정 — 삼각함수는 도 단위다

그림 오른쪽입니다. `domain=0:2*pi` 로 `\addplot {sin(x)};` 를 그리면 사인 곡선이 아니라 **거의 수평인 선** 이 나옵니다. `pgfplots` 의 `sin` · `cos` · `tan` 은 각도를 **도 (°)** 로 받기 때문입니다 — x 가 0 에서 6.28 까지 가는 동안 sin 은 0° 에서 6.28° 까지만 갑니다. 라디안으로 그리려면 `sin(deg(x))` 로 감쌉니다 (파란 곡선).

```latex
  domain=0:2*pi, samples=100,
  ...
  \addplot[thick, gray] {sin(x)};       % 도 단위 — 거의 직선
  \addplot[thick, blue] {sin(deg(x))};  % 라디안
```

오류도 경고도 나지 않으니, 그래프 모양을 눈으로 보고 알아채야 하는 종류입니다.

## 2. CSV 데이터 플롯 — 오차 막대와 직선 맞춤

측정값을 담은 CSV 파일 `data.csv` 가 있다고 합시다. 첫 줄은 열 이름입니다.

```text
t,v,dv
0.0,0.10,0.6
0.5,4.80,0.8
1.0,9.95,0.9
1.5,14.60,1.1
2.0,19.70,1.2
2.5,24.40,1.4
3.0,29.60,1.5
```

```latex
\usepackage{kotex}
\usepackage{siunitx}
\usepackage{pgfplots}
\usepackage{pgfplotstable}   % 직선 맞춤에 필요
\pgfplotsset{compat=1.18}
...
\begin{tikzpicture}
\begin{axis}[
  width=9cm, height=6cm,
  xlabel={시간 (\unit{\second})},
  ylabel={속도 (\unit{\metre\per\second})},
  legend pos=north west,
  legend cell align=left,
]
  \addplot+[only marks, mark=*,
    error bars/.cd, y dir=both, y explicit]
    table[x=t, y=v, y error=dv, col sep=comma] {data.csv};
  \addlegendentry{측정값}
  \addplot[thick, red]
    table[x=t, y={create col/linear regression={y=v}}, col sep=comma] {data.csv};
  \addlegendentry{직선 맞춤 ($a = \pgfmathprintnumber{\pgfplotstableregressiona}$)}
\end{axis}
\end{tikzpicture}
```

![CSV 플롯 실측 — 시간 0 에서 3 초까지 일곱 개의 파란 점에 위아래 오차 막대, 빨간 직선 맞춤, 범례에 측정값과 직선 맞춤 a = 9.82, 축 이름은 시간 (s) 와 속도 (m s⁻¹)](/assets/img/posts/2026-10-22/02-csv-error-bars-fit.png){: width="720" }

- **`table[x=t, y=v] {data.csv}`** — 열 이름으로 x·y 를 고릅니다. 파일 이름은 `.tex` 와 같은 폴더 기준입니다.
- **`only marks`** — 선 없이 점만.
- **오차 막대** — `error bars/.cd, y dir=both, y explicit` 와 `y error=dv` 가 짝입니다. `dv` 열의 값만큼 위아래로 막대를 그립니다.
- **직선 맞춤** — `create col/linear regression={y=v}` 가 최소제곱 직선을 계산해 그리고, 기울기는 `\pgfplotstableregressiona` 에 남습니다. 실측으로 범례에 `a = 9.82` 가 찍혔고, 같은 일곱 점을 직접 계산한 기울기는 9.8179 — 반올림해 같습니다. `pgfplotstable` 패키지가 필요합니다.
- **축 이름에 단위** — `\unit{\metre\per\second}` 가 그대로 `m s⁻¹` 로 나옵니다. [siunitx 글](/blog/posts/latex-siunitx-units-numbers/)의 설정이 그래프에도 그대로 적용된다는 뜻입니다. 축 이름의 한글은 `kotex` 로 본문과 같은 글꼴입니다.

> **`col sep=comma` 를 빼면 멈춥니다.** `pgfplots` 는 기본으로 **공백** 을 열 구분자로 봅니다. 쉼표 CSV 를 그냥 읽게 하면 실측으로 `Package pgfplots Error: Sorry, could not retrieve column 't' from table …` 가 납니다 — 한 줄 전체가 열 하나로 읽혀서 `t` 라는 열이 없다는 뜻입니다. 엑셀에서 내보낸 CSV 는 쉼표이니 `col sep=comma` 를 붙입니다.
{: .prompt-warning }

데이터를 파일로 따로 두기 싫으면 `.tex` 안에 `\begin{filecontents*}[overwrite]{data.csv} … \end{filecontents*}` 로 넣어 두는 방법도 있습니다 (`\documentclass` 바로 뒤). 이 글의 그림이 그렇게 컴파일되었습니다.

## 3. 로그 축

```latex
\begin{loglogaxis}[
  width=7cm, height=5.5cm,
  xlabel={$x$}, ylabel={$y$},
  domain=1:100, samples=50,
  grid=major,
]
  \addplot[thick, blue] {x^2};
  \addplot[thick, red] {x^3};
\end{loglogaxis}
```

![로그 축 실측 — 왼쪽 보통 축에서는 x 세제곱이 10의 6제곱까지 올라가 x 제곱은 바닥에 붙어 보이고 축 위에 ·10⁶ 배율이 붙음, 오른쪽 loglogaxis 에서는 두 곡선이 기울기 2 와 3 의 직선으로 나란히 보이고 눈금은 10⁰ 부터 10⁶](/assets/img/posts/2026-10-22/03-log-axis.png){: width="720" }

- 보통 축 (왼쪽) 에서는 `x^3` 이 100만까지 올라가 `x^2` 는 바닥에 붙습니다. 눈금이 커지면 `pgfplots` 가 축 위에 `·10⁶` 같은 배율을 따로 붙입니다.
- `loglogaxis` (오른쪽) 는 두 축이 모두 로그라 거듭제곱 함수가 직선이 되고, 기울기가 지수입니다.
- 한쪽만 로그는 `semilogyaxis` (y 만) · `semilogxaxis` (x 만). 환경 이름만 바꾸면 됩니다.

## 4. 크기를 본문에 맞추기

`width=7cm, height=5.5cm` 대신 `width=\linewidth` 로 두면 본문 폭에 맞춥니다. 그래프를 `figure` 환경에 넣어 캡션과 번호를 다는 것은 이미지 파일과 같습니다 — `\includegraphics` 자리에 `tikzpicture` 를 넣으면 됩니다 ([그림 삽입 글](/blog/posts/latex-figures-captions/)).

## 5. compat 한 줄을 빼면

`\pgfplotsset{compat=1.18}` 없이 컴파일하면 실측으로 이런 경고가 납니다.

```text
Package pgfplots Warning: running in backwards compatibility mode (unsuitable tick labels; missing features). Consider writing \pgfplotsset{compat=1.18} into your preamble.
```

오래된 문서와 같은 모양을 내기 위해 옛 동작으로 돌아가는 것이고, 이 글의 로그 축 그림으로 비교했을 때는 **y 축 이름의 위치** 가 달라졌습니다 (옛 동작에서 축에서 더 멀리). 숫자는 그 판의 `pgfplots` 버전입니다 — 경고문이 알려 주는 숫자를 그대로 쓰면 됩니다.

## 6. 자주 하는 실수

- **`sin(x)` 로 라디안 그래프** → 거의 직선. `sin(deg(x))` (§1).
- **쉼표 CSV 에 `col sep=comma` 없음** → `could not retrieve column` 오류 (§2).
- **`compat` 없음** → 호환 모드 경고, 축 이름 위치가 달라짐 (§5).
- **직선 맞춤에 `pgfplotstable` 없음** → 실측 `Package pgfplotstable Error: Please load \usepackage{pgfplotstable} before using \pgfplotstablecreatecol.` 메시지가 답을 말해 준다.
- **`\addplot … ;` 의 세미콜론 빠짐** → 실측 `Package tikz Error: Giving up on this path. Did you forget a semicolon?` 뒤로 수학 오류가 100개 가까이 이어진다. 첫 오류만 보면 된다 ([TikZ 글](/blog/posts/latex-tikz-diagrams/)과 같은 규칙).

## 정리

| 하고 싶은 것 | 코드 |
|---|---|
| 준비 | `\usepackage{pgfplots}` + `\pgfplotsset{compat=1.18}` |
| 함수 | `\addplot {x^2};` + `domain=-2:2, samples=100` |
| 삼각함수 (라디안) | `\addplot {sin(deg(x))};` |
| CSV | `\addplot table[x=t, y=v, col sep=comma] {data.csv};` |
| 점만 | `\addplot+[only marks]` |
| 오차 막대 | `error bars/.cd, y dir=both, y explicit` + `y error=dv` |
| 직선 맞춤 | `y={create col/linear regression={y=v}}` (`pgfplotstable`) |
| 로그 축 | `loglogaxis` · `semilogyaxis` · `semilogxaxis` |
| 범례 | `\addlegendentry{…}`, `legend pos=north west` |
| 축 이름에 단위 | `ylabel={속도 (\unit{\metre\per\second})}` |

---

이전 글: [LaTeX 미분·편미분·절댓값을 짧게 — physics 패키지와 주의할 점](/blog/posts/latex-physics-package-dv-pdv-abs-braket/)
함께 보기: [LaTeX 로 그림 그리기 — TikZ](/blog/posts/latex-tikz-diagrams/) · [LaTeX 그림 삽입과 캡션](/blog/posts/latex-figures-captions/) · [LaTeX 단위와 숫자 — siunitx](/blog/posts/latex-siunitx-units-numbers/)
