---
title: "LaTeX 문서 완성도 패키지 — hyperref·geometry·listings"
date: 2026-08-03 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, 패키지, hyperref, geometry, listings, minted, 여백, 하이퍼링크, 코드블록, 패키지순서]
math: false
pin: false
description: "초안을 완성된 문서로 바꾸는 세 패키지를 정리합니다. hyperref 로 클릭 가능한 참조·URL 과 프리앰블 맨 마지막에 불러야 하는 이유, geometry 로 여백 조정, listings·minted 로 코드 블록 삽입. 그리고 패키지들을 어떤 순서로 불러야 충돌이 없는지까지."
---

LaTeX 의 기본 기능은 의도적으로 최소한이라, 갓 컴파일한 문서는 참조가 클릭되지 않고 여백은 어중간하며 코드는 그냥 텍스트로 들어갑니다. 이 셋을 메우는 것이 이 글의 세 패키지 — `hyperref` · `geometry` · `listings` 입니다. 초안을 **제출 가능한 문서**로 바꾸는, 마지막 손질에 해당하는 패키지들입니다.

세 가지만 다루는 데는 이유가 있습니다. 수식 패키지 `amsmath` 와 그림 패키지 `graphicx` 도 "자주 쓰는 패키지" 에 늘 함께 꼽히지만, 이 둘은 이미 각각의 자리에서 다뤘습니다 — `align`·`cases` 같은 수식 환경은 [여러 줄 수식 정렬](/blog/posts/latex-align-equations/) 글에서, `\includegraphics` 는 [그림 삽입과 캡션](/blog/posts/latex-figures-captions/) 글에서. 그래서 여기서는 그 둘을 빼고, 아직 다루지 않은 완성도 패키지에 집중합니다.

## 1. hyperref — 참조를 클릭 가능하게

`hyperref` 는 PDF 에 하이퍼링크와 북마크를 더합니다. 이 패키지를 불러오면 본문의 `\ref`·`\cite`·`\eqref` 참조가 전부 **클릭 가능한 링크**가 되어, "그림 3" 을 누르면 그 그림으로 이동합니다. 목차 항목과 PDF 북마크도 자동으로 링크됩니다.

```latex
\usepackage[
  colorlinks=true,    % 링크에 색 (false 면 테두리 박스)
  linkcolor=blue,     % 내부 참조(그림·표·식) 색
  citecolor=green,    % 인용 색
  urlcolor=cyan       % URL 색
]{hyperref}
```

`colorlinks=true` 를 주지 않으면 기본값은 링크 주위에 빨간 테두리 박스라, 화면에서는 괜찮아도 인쇄본에서는 지저분합니다. 대부분 `colorlinks=true` 로 두고 색을 지정합니다.

### 반드시 프리앰블 맨 마지막에

`hyperref` 에는 다른 패키지와 다른 한 가지 규칙이 있습니다. **프리앰블에서 가장 마지막에 불러와야** 합니다.

```latex
\usepackage{amsmath}
\usepackage{graphicx}
\usepackage{booktabs}
% ... 다른 패키지들 ...
\usepackage{hyperref}   % 항상 마지막
```

이유는 `hyperref` 가 다른 많은 패키지의 명령을 **가로채서 링크 기능을 덧입히는** 방식으로 동작하기 때문입니다. 그러려면 다른 패키지가 먼저 자기 명령을 정의해 둔 뒤에 `hyperref` 가 마지막에 그 위에 얹혀야 합니다. 순서가 뒤바뀌어 `hyperref` 를 먼저 불러오면, 나중에 로드된 패키지의 명령에는 링크가 안 걸리거나 상호작용이 깨져 이상한 오류가 납니다. 참조가 클릭되지 않거나 목차 링크가 어긋난다면, 대개 이 순서를 의심하면 됩니다.

### URL 넣기

```latex
Overleaf 는 \url{https://www.overleaf.com} 에서 접속합니다.

% 링크 텍스트를 따로 지정
\href{https://www.overleaf.com}{Overleaf 공식 홈페이지}를 방문하세요.
```

`\url` 은 주소를 그대로 노출하고, `\href` 는 주소 대신 보일 텍스트를 따로 지정합니다.

## 2. geometry — 여백을 내 뜻대로

LaTeX 의 기본 여백은 의외로 넓습니다. 옛 조판 관습을 따른 값이라, 현대 논문 기준으로는 본문 폭이 좁게 느껴질 때가 많습니다. `geometry` 패키지로 조정합니다.

```latex
\usepackage[
  a4paper,
  top=2.5cm,
  bottom=2.5cm,
  left=3cm,
  right=3cm
]{geometry}
```

각 방향을 따로 지정할 수도 있고, 네 방향이 같다면 `margin=2.5cm` 한 줄로 끝낼 수도 있습니다. `a4paper` 를 함께 주는 이유는 [문서 뼈대](/blog/posts/latex-document-skeleton/) 글에서 말한 대로, LaTeX 의 기본 용지가 US Letter 라 한국 규격과 어긋나기 때문입니다.

### 심사용 넓은 여백

투고 심사 단계에서는 오히려 여백을 **더 넓게** 요구하는 학술지가 많습니다. 심사자가 여백에 메모를 적을 공간이 필요해서입니다.

```latex
\usepackage[a4paper, top=3cm, bottom=3cm, left=4cm, right=4cm]{geometry}
```

한 가지 예외가 있습니다. 학술지가 제공하는 **스타일 파일(`.cls`)을 쓸 때는 `geometry` 를 직접 쓰지 않습니다.** 스타일 파일이 이미 그 저널의 규격대로 여백을 정의해 두었기 때문에, 위에 `geometry` 로 여백을 덮어쓰면 투고 규정을 어기게 됩니다.

## 3. listings · minted — 코드 블록 넣기

전산·공학 논문에는 코드를 실어야 할 때가 많습니다. 코드를 그냥 본문에 붙이면 들여쓰기와 문법 색이 사라져 읽기 어려운데, 이를 처리하는 패키지가 둘 있습니다.

### listings — 추가 설치 없이

`listings` 는 별도 설치 없이 바로 쓸 수 있습니다. 색은 `xcolor` 와 함께 씁니다.

```latex
\usepackage{listings}
\usepackage{xcolor}

\lstset{
  language=Python,
  basicstyle=\ttfamily\small,
  keywordstyle=\color{blue},
  commentstyle=\color{gray},
  stringstyle=\color{red},
  numbers=left,
  numberstyle=\tiny,
  frame=single,
  breaklines=true
}
```

`\lstset` 은 코드 블록의 공통 스타일을 한 번에 정의합니다 — 언어, 글꼴, 키워드·주석·문자열 색, 줄 번호, 테두리, 자동 줄바꿈. 이렇게 설정해 두면 이후 모든 코드 블록에 같은 스타일이 적용됩니다. 실제 삽입은 `lstlisting` 환경으로 합니다.

```latex
\begin{lstlisting}[caption={ResNet 블록 구현}, label={lst:resnet}]
class ResBlock(nn.Module):
    def __init__(self, channels):
        super().__init__()
        self.conv1 = nn.Conv2d(channels, channels, 3, padding=1)

    def forward(self, x):
        return self.relu(self.conv1(x) + x)
\end{lstlisting}
```

`caption` 과 `label` 을 주면 그림·표와 똑같이 "목록 1" 로 번호가 붙고 본문에서 `\ref{lst:resnet}` 으로 참조됩니다.

### minted — 더 정교한 문법 강조

더 예쁜 색 강조를 원하면 `minted` 입니다. 파이썬의 `Pygments` 라이브러리를 이용해 `listings` 보다 정교하게 문법을 칠합니다.

```latex
\usepackage{minted}

\begin{minted}[linenos, frame=lines, fontsize=\small]{python}
def channel_attention(x, ratio=16):
    avg = x.mean(dim=(2, 3))
    w = torch.sigmoid(fc2(torch.relu(fc1(avg))))
    return x * w.unsqueeze(-1).unsqueeze(-1)
\end{minted}
```

대신 `minted` 는 `Pygments` 가 설치돼 있어야 하고, 컴파일 시 외부 프로그램 실행을 허용하는 옵션(shell-escape)이 필요합니다. 로컬에서는 이 설정이 번거로울 수 있는데, Overleaf 에서는 별도 설정 없이 바로 됩니다. 추가 설치가 부담스러우면 `listings`, 색 품질이 더 중요하면 `minted` — 이렇게 나누면 됩니다.

## 4. 패키지 로딩 순서

패키지는 불러오는 순서가 충돌을 좌우합니다. 아래가 충돌을 최소화하는 권장 순서입니다.

```latex
\documentclass{article}

% 1. 수식
\usepackage{amsmath}
\usepackage{amssymb}

% 2. 그림·표
\usepackage{graphicx}
\usepackage{booktabs}

% 3. 레이아웃
\usepackage{geometry}

% 4. 코드
\usepackage{listings}

% 5. 한국어 (XeLaTeX 사용 시)
% \usepackage{kotex}

% 6. 항상 마지막
\usepackage{hyperref}
```

큰 원칙은 두 가지입니다. 기능별로 묶어 (수식 → 그림·표 → 레이아웃 → 코드) 두면 읽기 쉽고, **`hyperref` 는 무조건 맨 아래** 입니다. 이 두 가지만 지키면 대부분의 패키지 충돌은 애초에 생기지 않습니다. 여기 목록의 `amsmath`·`graphicx`, 그리고 도형을 코드로 그리는 `tikz` 는 각각 별도 주제라 이 글에서는 자리만 표시해 두었습니다.

## 정리

| 패키지 | 역할 | 핵심 주의 |
|---|---|---|
| `hyperref` | 클릭 가능한 참조·URL·북마크 | **프리앰블 맨 마지막**에 로드 |
| `geometry` | 여백·용지 조정 | 학술지 스타일 파일 쓰면 사용 안 함 |
| `listings` | 코드 블록 (설치 불필요) | `\lstset` 으로 공통 스타일 |
| `minted` | 코드 블록 (정교한 강조) | `Pygments`·shell-escape 필요, Overleaf 는 바로 됨 |
| `\url` / `\href` | URL 삽입 | 주소 노출 / 텍스트 지정 |

이 세 패키지는 문서의 내용을 바꾸지는 않지만, 읽는 사람의 경험을 바꿉니다 — 참조가 클릭되고, 여백이 규격에 맞고, 코드가 코드처럼 보이는. 뼈대를 세우고 표·그림으로 내용을 채운 뒤, 마지막으로 이 완성도 패키지를 얹으면 제출 가능한 문서가 됩니다.
