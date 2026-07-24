---
title: "kotex 로 한국어 논문 처음부터 세팅하기 — XeLaTeX·폰트·한영 혼용"
date: 2026-08-09 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, kotex, 한국어, xelatex, setmainfont, 폰트, 한영혼용, 캡션, 논문, overleaf]
math: false
pin: false
description: "LaTeX 로 한국어 논문을 처음 세팅하는 법 — XeLaTeX 컴파일러 선택과 kotex 패키지, setmainfont 로 한글 폰트 지정, 영문 용어 혼용, 그리고 그림·표 이름표를 한국어로 바꾸기까지. 깨끗한 상태에서 시작하는 설정에 집중합니다."
---

한국어 논문을 LaTeX 로 쓸 때, 영문 문서와 다른 점은 대부분 **맨 처음의 설정 한 번**에 몰려 있습니다. 그 설정을 제대로 해 두면 이후로는 한글을 그냥 타이핑하면 되고, 안 해 두면 글자가 깨지거나 아예 안 보입니다. 이 글은 그 처음 세팅을 정리합니다.

전제를 하나 분명히 하겠습니다. 이 글은 **깨끗한 상태에서 새로 시작하는** 경우입니다. 이미 문서를 쓰고 있는데 한글이 □□□ 로 나오거나, `inputenc` 오류가 뜨거나, 어제까지 되던 게 갑자기 깨졌다면 그건 복구 문제라 접근이 다릅니다 — 그 진단과 해결은 [LaTeX 오류 메시지 해결 사전 2편](/blog/posts/latex-document-errors-guide/) 의 4부에 정리해 두었으니 그쪽을 보세요. 여기서는 처음부터 올바로 까는 순서만 다룹니다.

## 1. XeLaTeX + kotex — 두 가지가 함께 필요하다

한국어 출력에는 두 축이 동시에 필요합니다. 하나는 **한글을 다룰 줄 아는 엔진**, 다른 하나는 **한국어 조판 규칙을 아는 패키지** 입니다.

엔진부터. 전통적인 pdfLaTeX 는 시스템 폰트를 직접 다루지 못해 한국어에 적합하지 않습니다. 시스템에 깔린 한글 폰트를 이름으로 불러 쓸 수 있는 **XeLaTeX**(또는 LuaLaTeX)가 한국어의 기본 선택입니다.

Overleaf 에서는 대개 자동으로 잡혀 있지만, 확인하려면 이렇게 합니다.

- 왼쪽 위 **Menu → Compiler → XeLaTeX** 선택

그다음 프리앰블에 `kotex` 패키지를 불러옵니다. 이것이 한국어 조판 규칙 — 줄바꿈, 자간, 조사 처리 — 을 담당합니다.

```latex
\documentclass{article}
\usepackage{kotex}     % XeLaTeX 용 한국어 패키지

\begin{document}
한국어로 논문을 씁니다. 수식도 그대로 쓸 수 있습니다.
\end{document}
```

엔진(XeLaTeX)과 패키지(kotex)는 둘 중 하나만으로는 부족합니다. XeLaTeX 로 컴파일하는데 `kotex` 이 없으면 조판 규칙이 빠지고, `kotex` 은 있는데 컴파일러가 pdfLaTeX 면 폰트를 못 불러 멈춥니다. **둘을 세트로** 기억하면 됩니다.

## 2. 폰트 선택 — setmainfont

XeLaTeX 의 장점은 한글 폰트를 이름으로 골라 쓸 수 있다는 것입니다. 프리앰블에서 지정합니다.

```latex
\usepackage{kotex}

\setmainfont{Noto Serif KR}   % 본문 (명조)
\setsansfont{Noto Sans KR}    % 제목·강조 (고딕)
\setmonofont{D2Coding}        % 코드 (고정폭)
```

- `\setmainfont` — 본문 기본 폰트. 논문 본문은 보통 명조체(serif)
- `\setsansfont` — 고딕체가 필요한 곳(제목 등)
- `\setmonofont` — 코드나 고정폭이 필요한 곳

Overleaf 에는 구글 한글 폰트를 비롯해 여러 폰트가 내장돼 있어, 이름만 정확히 적으면 바로 됩니다. 자주 쓰는 것들입니다.

| 폰트 이름 | 특징 |
|---|---|
| `Noto Serif KR` | 가독성 높은 명조체, 본문용 |
| `Noto Sans KR` | 깔끔한 고딕체 |
| `NanumMyeongjo` | 나눔 명조 |
| `NanumGothic` | 나눔 고딕 |

폰트 이름은 시스템에 등록된 것과 **정확히 일치**해야 합니다. 이름을 잘못 적으면 폰트를 못 찾는다는 오류가 나는데, 이 경우의 대처도 앞서 링크한 오류 사전 4부에 있습니다. 새로 시작하는 단계라면 위 표의 이름을 그대로 복사해 쓰는 편이 안전합니다.

## 3. 한영 혼용 — 영문 용어가 섞여도

한국어 논문에는 전문 용어가 영문으로 섞이는 일이 잦습니다. `kotex` 은 이 혼용을 알아서 처리하므로, 따로 신경 쓸 것이 거의 없습니다.

```latex
\usepackage{kotex}

제안된 방법을 \textit{채널 주의 메커니즘(Channel Attention Mechanism)}이라
명명한다. 이는 SENet~\cite{hu2018squeeze}의 개념을 확장한 것으로...
```

한글과 영문이 한 문장에 섞여도 자간과 줄바꿈이 자연스럽게 잡힙니다. 영문 부분에 다른 폰트를 쓰고 싶다면 `\setmainfont` 와 별개로 영문 폰트를 지정할 수도 있지만, 처음에는 굳이 나누지 않고 한글 폰트 하나로 두어도 무방합니다. 대부분의 한글 폰트가 영문 글리프도 함께 갖고 있기 때문입니다.

## 4. 제목·캡션을 한국어로

한 가지 더 손볼 곳이 있습니다. 기본 `article` 클래스는 자동으로 붙는 이름표 — 그림 캡션의 "Figure", 표의 "Table", 목차의 "Contents" — 를 영어로 답니다. `kotex` 은 대개 이것을 한국어("그림", "표", "차례")로 바꿔 주지만, 클래스나 설정에 따라 영어가 그대로 남는 경우가 있습니다.

확실하게 한국어로 고정하려면 프리앰블에서 직접 이름표를 바꿉니다. 이 방법은 어떤 환경에서도 동작합니다.

```latex
\renewcommand{\figurename}{그림}
\renewcommand{\tablename}{표}
\renewcommand{\contentsname}{차례}
\renewcommand{\refname}{참고문헌}    % article
\renewcommand{\bibname}{참고문헌}    % report·book
```

이렇게 두면 [그림 삽입](/blog/posts/latex-figures-captions/) 에서 만든 `\caption` 이 "그림 1" 로, 표가 "표 1" 로 나옵니다. `\today` 로 넣은 날짜도 XeLaTeX + kotex 환경에서는 한국어 형식으로 표시됩니다. 제목(`\maketitle`)은 한글 제목을 그대로 조판하므로 따로 손댈 것이 없습니다.

## 정리

| 목적 | 설정 |
|---|---|
| 엔진 | Overleaf Menu → Compiler → **XeLaTeX** |
| 한국어 패키지 | `\usepackage{kotex}` (엔진과 세트) |
| 본문 폰트 | `\setmainfont{Noto Serif KR}` |
| 고딕·코드 폰트 | `\setsansfont{}` · `\setmonofont{}` |
| 한영 혼용 | kotex 가 자동 처리 |
| 이름표 한국어화 | `\renewcommand{\figurename}{그림}` 등 |
| 한글이 □ 로 깨질 때 | → 오류 사전 4부 (복구) |

한국어 논문의 설정은 결국 **엔진을 XeLaTeX 로, 패키지를 kotex 로, 폰트를 이름으로** — 이 세 줄로 요약됩니다. 처음 한 번만 프리앰블에 제대로 얹어 두면, 그다음부터는 영문 논문과 똑같이 한글을 타이핑하면 됩니다. 나머지는 [문서 뼈대](/blog/posts/latex-document-skeleton/) 위에 내용을 채우는, 언어와 무관한 작업입니다.
