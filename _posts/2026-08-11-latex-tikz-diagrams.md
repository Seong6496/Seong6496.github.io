---
title: "LaTeX 로 그림 그리기 — TikZ 로 신경망·순서도 다이어그램 코드로 만들기"
date: 2026-08-11 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, tikz, 다이어그램, 신경망, 순서도, node, draw, foreach, tikzlibrary, 벡터그래픽, 논문]
math: false
pin: false
description: "논문 다이어그램을 이미지 파일로 넣는 대신 코드로 직접 그리는 TikZ 를 정리합니다. 좌표와 상대 배치, 노드, 스타일, 연결선, foreach 반복, 기능을 담은 라이브러리 — 여섯 조각을 각각 설명하고 신경망 구조도와 순서도 두 예제로 조립합니다. 예제를 복사하는 게 아니라 직접 그릴 수 있게."
---

논문에 그림을 넣는 길은 두 갈래입니다. 하나는 이미 만들어진 이미지 파일 — 사진, 스크린샷, 다른 도구로 뽑은 차트 — 을 넣는 것으로, 이건 [그림 삽입과 캡션](/blog/posts/latex-figures-captions/) 에서 `\includegraphics` 로 다뤘습니다. 다른 하나는 **그림 자체를 코드로 그리는 것** 입니다. 신경망 구조도나 알고리즘 순서도처럼 도형과 화살표로 이뤄진 다이어그램은, 그림판에서 그려 캡처하는 대신 LaTeX 안에서 코드로 그리면 벡터라 확대해도 선명하고, 문서 폰트와 일관되며, 나중에 한 줄만 고쳐 수정할 수 있습니다. 그 도구가 TikZ 입니다.

TikZ 를 "패키지 하나" 로 생각하면 막막합니다. 사실 TikZ 는 그 자체로 하나의 **그리기 언어** 라, 명령을 통째로 외우기보다 몇 가지 원리를 이해하는 편이 빠릅니다. 이 글은 그 원리를 여섯 조각으로 나눠 설명하고, 마지막에 신경망 그림 하나로 조립합니다. 목표는 예제를 복사하는 게 아니라, 자기 다이어그램을 직접 그릴 수 있게 되는 것입니다.

준비는 한 줄입니다. 프리앰블([문서 뼈대](/blog/posts/latex-document-skeleton/) 에서 다룬 그 프리앰블)에 패키지를 불러옵니다.

```latex
\usepackage{tikz}
```

그림은 전부 `tikzpicture` 환경 안에 그립니다.

```latex
\begin{tikzpicture}
  % 여기에 그린다
\end{tikzpicture}
```

## 1. 캔버스와 좌표 — 어디에 놓을지

TikZ 는 빈 좌표 평면 위에 요소를 놓습니다. 위치를 정하는 방식은 두 가지입니다.

**절대 좌표** 는 `(x,y)` 로, 원점 `(0,0)` 에서 오른쪽으로 x, 위로 y 만큼(기본 단위 cm) 떨어진 자리입니다.

```latex
\begin{tikzpicture}
  \node (a) at (0,0) {A};
  \node (b) at (2,1) {B};   % 오른쪽 2cm, 위 1cm
\end{tikzpicture}
```

그런데 다이어그램에서는 "B 를 A 오른쪽 2cm 에" 처럼 **다른 요소를 기준으로 한 상대 배치** 가 훨씬 편합니다. 좌표를 일일이 계산하지 않아도 되기 때문입니다.

```latex
\node (a) {A};
\node[right=2cm of a] (b) {B};   % A 의 오른쪽 2cm
\node[below=1cm of a] (c) {C};   % A 의 아래 1cm
```

이 `right=2cm of a` 문법은 `positioning` 라이브러리가 제공합니다(6절에서 다룹니다). 상대 배치가 TikZ 다이어그램의 기본기라, positioning 은 사실상 늘 불러온다고 봐도 됩니다.

## 2. 노드 — 그림의 요소

`\node` 는 도형과 그 안의 내용을 함께 놓는 명령입니다. 대괄호에 모양을, 소괄호에 이름을, 중괄호에 내용을 적습니다.

```latex
\node[circle, draw, minimum size=0.6cm] (i1) {$x_1$};
```

- `[circle, draw, minimum size=0.6cm]` — 원 모양(`circle`), 테두리 그리기(`draw`), 최소 크기 0.6cm
- `(i1)` — 이 노드의 **이름**. 나중에 연결선에서 이 이름으로 부른다
- `{$x_1$}` — 노드 안에 표시할 내용. 수식도 그대로 들어간다

이름 붙이기가 핵심입니다. 노드에 `(i1)` 처럼 이름을 달아 두면, 그 위치를 좌표로 외울 필요 없이 이름만으로 선을 잇거나 다른 노드를 그 옆에 붙일 수 있습니다. 모양은 `circle` 외에 `rectangle`(사각형) 등이 있고, `draw` 를 빼면 테두리 없이 내용만 놓입니다.

## 3. 스타일 — 한 번 정의해 재사용

신경망 노드가 열 개라면, 매번 `[circle, draw, minimum size=0.6cm]` 를 적는 건 번거롭고, 나중에 크기를 바꾸려면 열 군데를 고쳐야 합니다. TikZ 는 스타일을 한 번 정의해 이름표처럼 재사용합니다.

```latex
\begin{tikzpicture}[
  layer/.style={circle, draw, minimum size=0.6cm}
]
  \node[layer] (i1) {$x_1$};
  \node[layer] (i2) {$x_2$};   % 같은 모양을 한 단어로
\end{tikzpicture}
```

`layer/.style={...}` 는 "`layer` 라는 이름의 스타일을 이 모양으로 정의한다" 는 뜻입니다. 이후 `[layer]` 한 단어면 그 모양이 적용됩니다. 크기를 바꾸고 싶으면 `.style` 정의 한 곳만 고치면 전부 따라 바뀝니다. 스타일 정의는 `tikzpicture` 의 대괄호 옵션 안에 둡니다.

## 4. 연결선 — 노드를 잇는다

`\draw` 는 선을 긋습니다. 이름 붙인 두 노드 사이를 잇는 것이 다이어그램에서 가장 흔한 쓰임입니다.

```latex
\draw (i1) -- (h1);        % i1 에서 h1 로 직선
\draw[->] (i1) -- (h1);    % 화살표
```

- `--` 는 두 점을 잇는 직선
- `[->]` 는 끝에 화살표 촉을 붙임. `[<-]` 는 반대 방향, `[<->]` 는 양쪽

노드를 이름으로 잇기 때문에, 노드가 어디로 움직이든 선은 알아서 따라옵니다. 좌표가 아니라 관계로 그리는 셈입니다. 화살표 촉의 모양을 더 다듬고 싶으면 `arrows.meta` 라이브러리를 씁니다(6절).

## 5. 반복 — foreach 로 규모를 감당

입력 노드 둘과 은닉 노드 둘을 완전 연결하면 선이 네 개입니다. 층이 커지면 손으로 다 적기 어렵습니다. `\foreach` 는 이 반복을 대신합니다.

```latex
\foreach \i in {i1, i2}
  \foreach \h in {h1, h2}
    \draw[->] (\i) -- (\h);
```

`\foreach \i in {i1, i2}` 는 `\i` 를 `i1`, `i2` 로 바꿔 가며 안쪽을 반복합니다. 두 반복을 겹치면 `i1-h1`, `i1-h2`, `i2-h1`, `i2-h2` 네 선이 한 번에 그려집니다. 이것이 TikZ 가 규모를 감당하는 방식입니다 — 선을 하나하나 적는 대신, *어느 노드에서 어느 노드로 잇는지 규칙* 을 적습니다. 그래서 노드 이름을 `i1, i2, ...` 처럼 규칙적으로 지어 두면 `\foreach` 와 잘 맞습니다.

## 6. 라이브러리 — 기능은 라이브러리로 온다

TikZ 의 모든 기능이 처음부터 켜져 있지는 않습니다. 상당수는 **라이브러리** 로 나뉘어 있어, 필요한 것을 프리앰블에서 불러옵니다.

```latex
\usetikzlibrary{positioning, arrows.meta}
```

- `positioning` — 1절의 `right=2cm of a`, `below=1cm of a` 같은 상대 배치 문법을 제공합니다. 이 라이브러리가 없으면 그 문법이 오류가 납니다. 다이어그램을 상대 배치로 그리는 이상 사실상 필수입니다.
- `arrows.meta` — 화살표 촉을 세밀하게 다루는 스타일(`-{Stealth}` 같은)을 제공합니다. 기본 `->` 는 이 라이브러리 없이도 되지만, 촉의 모양이나 크기를 바꾸려면 필요합니다.

라이브러리가 왜 필요한지 알면, 남의 예제에서 `\usetikzlibrary{...}` 줄이 왜 있는지 — 어떤 문법을 쓰려고 무엇을 켰는지 — 가 읽힙니다. 낯선 TikZ 코드를 만나도 이 줄을 먼저 보면 그 그림이 무슨 기능에 기대는지 짐작할 수 있습니다.

## 7. 전체 예제 — 신경망 구조도

이제 여섯 조각을 하나로 조립합니다. 입력층 2 · 은닉층 2 · 출력층 1 의 작은 신경망입니다.

```latex
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}

% 본문 안:
\begin{tikzpicture}[
  node distance=1.5cm,
  layer/.style={circle, draw, minimum size=0.6cm}
]
  % 입력층
  \node[layer] (i1) {$x_1$};
  \node[layer, below=0.5cm of i1] (i2) {$x_2$};

  % 은닉층
  \node[layer, right=2cm of i1, yshift=-0.25cm] (h1) {};
  \node[layer, below=0.5cm of h1] (h2) {};

  % 출력층
  \node[layer, right=2cm of h1, yshift=-0.25cm] (o1) {$\hat{y}$};

  % 연결선
  \foreach \i in {i1, i2}
    \foreach \h in {h1, h2}
      \draw[->] (\i) -- (\h);

  \foreach \h in {h1, h2}
    \draw[->] (\h) -- (o1);

  % 레이블
  \node[above=0.3cm of i1] {입력층};
  \node[above=0.3cm of h1] {은닉층};
  \node[above=0.3cm of o1] {출력층};
\end{tikzpicture}
```

읽어 보면 여섯 조각이 그대로 보입니다 — `layer/.style` 로 노드 모양을 정의하고(스타일), `\node ... (i1)` 로 이름 붙인 노드를 놓고(노드), `right=2cm of i1` 로 상대 배치하고(좌표·라이브러리), `\foreach` 로 층 사이를 잇습니다(반복·연결선). `yshift=-0.25cm` 는 은닉층 두 노드를 입력층 두 노드의 가운데 높이에 맞추려고 살짝 내린 것입니다.

TikZ 그림도 결국 하나의 그림이라, [그림 삽입과 캡션](/blog/posts/latex-figures-captions/) 에서 본 `figure` 환경으로 감싸면 번호와 캡션이 똑같이 붙습니다.

```latex
\begin{figure}[htbp]
  \centering
  \begin{tikzpicture}
    % ... 위 신경망 코드 ...
  \end{tikzpicture}
  \caption{2-2-1 신경망 구조}
  \label{fig:nn}
\end{figure}
```

그러면 본문에서 `\ref{fig:nn}` 으로 "그림 1" 처럼 참조됩니다. 코드로 그린 그림과 파일로 넣은 그림이 같은 번호 체계 안에서 자연스럽게 섞입니다.

## 8. 다른 모양 — 순서도

같은 원리로 전혀 다른 그림을 그릴 수 있습니다. 노드 모양만 사각형으로 바꾸고 셋을 세로로 이으면 간단한 순서도가 됩니다.

```latex
\begin{tikzpicture}[
  node distance=1cm,
  box/.style={rectangle, draw, rounded corners, minimum width=2cm, minimum height=0.8cm}
]
  \node[box] (start) {입력};
  \node[box, below=of start] (proc) {처리};
  \node[box, below=of proc] (out) {출력};

  \draw[->] (start) -- (proc);
  \draw[->] (proc) -- (out);
\end{tikzpicture}
```

쓰인 조각은 신경망과 똑같습니다 — `box/.style` 로 모양을 정의하고(스타일), 이름 붙인 노드를 놓고(노드), `below=of ...` 로 상대 배치하고(좌표·라이브러리), `\draw[->]` 로 잇습니다(연결선). 달라진 건 `circle` 이 `rectangle, rounded corners` 로 바뀐 것뿐입니다. 원리를 알면 모양은 부품처럼 갈아 끼웁니다. (`below=of start` 처럼 거리를 생략하면 `node distance` 에 정한 값이 쓰입니다.)

## 정리

| 조각 | 명령 | 요점 |
|---|---|---|
| 캔버스·좌표 | `at (x,y)` / `right=2cm of a` | 절대 좌표 또는 상대 배치 |
| 노드 | `\node[...] (이름) {내용}` | 도형+내용, 이름으로 참조 |
| 스타일 | `layer/.style={...}` | 한 번 정의해 `[layer]` 로 재사용 |
| 연결선 | `\draw[->] (a) -- (b)` | 이름으로 잇기, `->` 화살표 |
| 반복 | `\foreach \x in {..}` | 규칙적 연결을 한 번에 |
| 라이브러리 | `\usetikzlibrary{positioning, arrows.meta}` | positioning=상대배치(필수), arrows.meta=화살표 촉 |

TikZ 는 익히는 데 시간이 조금 듭니다. 다만 넘어야 할 것은 명령 목록이 아니라 이 여섯 조각입니다. 좌표에 노드를 놓고, 스타일로 모양을 묶고, 이름으로 선을 잇고, 반복으로 규모를 감당하고, 라이브러리로 기능을 켜는 것 — 이 원리가 손에 붙으면, 논문에 필요한 다이어그램은 대부분 남의 예제를 고치는 대신 처음부터 직접 그릴 수 있습니다.
