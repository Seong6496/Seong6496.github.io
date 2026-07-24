---
title: "LaTeX 문서의 뼈대 — 빈 파일에서 논문 구조까지 한 번만 이해하면 끝"
date: 2026-07-28 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, documentclass, 프리앰블, 본문, article, report, book, maketitle, abstract, 논문, 구조]
math: false
pin: false
description: "모든 LaTeX 문서가 공유하는 두 영역 구조 — 프리앰블과 본문 — 을 한 번에 정리합니다. article·report·book 을 언제 고르는지, 제목·저자·초록을 첫 페이지에 올리는 법, 그리고 어디에 무엇을 쓰는지의 경계가 왜 컴파일 오류를 가르는지까지. 빈 파일에서 논문 뼈대까지 복사해 쓸 수 있는 최소 골격을 함께 담았습니다."
---

LaTeX 를 처음 열면 대개 남의 템플릿을 받아 그 위에 글을 씁니다. 컴파일은 되는데, 어느 줄이 설정이고 어느 줄이 내용인지, 왜 어떤 명령은 위쪽에만 있고 어떤 건 아래쪽에만 있는지는 흐릿한 채로 지나갑니다. 그러다 줄 하나를 잘못 옮기면 `Missing \begin{document}` 같은 오류가 나고, 원인을 모른 채 이것저것 되돌려 봅니다.

그런데 이 구조는 **한 번만 이해하면 그다음부터는 다시 볼 일이 없는** 종류의 것입니다. 문서가 논문이든 보고서든 책이든, 모든 LaTeX 파일은 같은 뼈대를 공유하기 때문입니다. 이 글은 그 뼈대를 한 번에 정리합니다. 아직 Overleaf 를 켜 본 적이 없다면 [Overleaf 10분 만에 시작하기](/blog/posts/latex-overleaf-10min/) 로 실행 환경을 먼저 만들고 오는 편이 좋습니다. 여기서는 실행이 아니라 **구조**를 다룹니다.

## 1. 두 영역 — 프리앰블과 본문

모든 LaTeX 문서는 두 부분으로 나뉩니다. 이것 하나가 이 글에서 가장 중요합니다.

```latex
% ── 프리앰블 (Preamble) ──────────────
\documentclass{article}

\usepackage{amsmath}
\usepackage{graphicx}

\title{문서 제목}
\author{저자 이름}
\date{\today}

% ── 본문 (Body) ─────────────────────
\begin{document}

\maketitle

여기에 실제 내용을 씁니다.

\end{document}
```

**프리앰블**은 `\documentclass{}` 부터 `\begin{document}` 직전까지입니다. 문서 **전체에 걸친 설정**을 두는 곳입니다 — 어떤 종류의 문서인지, 어떤 패키지를 불러올지, 제목·저자는 무엇인지. 독자가 보게 될 글자는 여기에 하나도 없습니다.

**본문**은 `\begin{document}` 와 `\end{document}` 사이입니다. **독자가 보게 될 모든 것** — 텍스트·수식·표·그림 — 이 여기에 들어갑니다.

이 구분이 낯설다면 HTML 을 떠올리면 됩니다. `<head>` 에 메타데이터와 스타일을 넣고 `<body>` 에 실제 내용을 넣듯, LaTeX 는 프리앰블에 설정을, 본문에 내용을 둡니다. 역할이 정확히 대응합니다.

### 경계가 왜 중요한가

이 경계는 미관 문제가 아니라 **컴파일러가 실제로 지키는 규칙**입니다. 프리앰블은 선언만 허용되는 구간입니다. 공백과 주석을 뺀 글자가 하나라도 `\begin{document}` 위에 나타나면, 컴파일러는 "본문이 시작됐는데 아직 문서를 열지 않았다" 고 판단하고 멈춥니다. 이것이 `Missing \begin{document}` 오류의 정체입니다 — 제목 메모를 프리앰블에 그냥 적어 뒀거나, `\usepackage` 줄 뒤에 오타 문자가 붙었을 때 나옵니다. 이 오류를 로그에서 확인하고 고치는 자세한 흐름은 [LaTeX 오류 메시지 해결 사전 2편](/blog/posts/latex-document-errors-guide/) 의 1부에 정리해 두었습니다.

거꾸로, 패키지 선언(`\usepackage`)을 본문 안에 쓰면 이것도 오류입니다. 패키지는 문서가 열리기 전에 모두 준비돼 있어야 하기 때문입니다. **설정은 위, 내용은 아래** — 이 한 줄만 지키면 대부분의 구조 오류가 사라집니다.

`%` 로 시작하는 줄은 **주석**이라 컴파일 시 무시됩니다. 설명을 달거나 한 줄을 잠시 꺼 둘 때 씁니다.

## 2. 문서 클래스 — article, report, book 중 무엇을 고를까

프리앰블의 첫 줄은 언제나 `\documentclass{}` 입니다. 이 한 줄이 문서의 전체 레이아웃과, **쓸 수 있는 섹션 명령의 종류**까지 결정합니다. 자주 쓰는 세 가지만 알면 충분합니다.

| 클래스 | 언제 | 최상위 섹션 | 특징 |
|---|---|---|---|
| `article` | 논문·과제·짧은 보고서 | `\section` | 제목·목차가 간결. 대부분의 학술 논문 |
| `report` | 졸업논문·기술 보고서 | `\chapter` | 챕터가 새 페이지에서 시작, 제목·목차가 별도 페이지 |
| `book` | 단행본 | `\part` → `\chapter` | 홀·짝 페이지 레이아웃, Part 단위 지원 |

핵심 갈림길은 **`\chapter` 가 필요한가** 입니다. 문서가 "장(章)" 으로 나뉠 만큼 길면 `report` 나 `book`, 그렇지 않으면 `article` 입니다. `article` 에는 `\chapter` 자체가 없어서, `article` 로 시작해 놓고 `\chapter` 를 쓰면 `Undefined control sequence` 가 납니다. 클래스를 먼저 정하는 이유가 이것입니다 — 클래스가 섹션 명령의 목록을 정하기 때문입니다.

`article` 의 섹션 계층은 `\section` → `\subsection` → `\subsubsection`, `report` 와 `book` 은 그 위에 `\chapter` 가 얹힙니다.

### 옵션 붙이기

클래스 이름 앞의 대괄호에 옵션을 넣습니다.

```latex
\documentclass[12pt, a4paper, twocolumn]{article}
```

- `12pt` — 기본 글자 크기 (기본값 10pt, 11pt 도 가능)
- `a4paper` — A4 용지 (기본값은 US Letter 라, 한국에서 쓰면 거의 항상 지정)
- `twocolumn` — 2단 편집
- `twoside` — 양면 인쇄용 여백

`a4paper` 는 특히 기억해 둘 값입니다. 기본값이 US Letter 라, 지정하지 않으면 국내 규격과 미묘하게 어긋난 여백으로 조판됩니다.

### 학술지에 낼 때

학회나 저널에 투고할 때는 클래스 자체가 그쪽에서 제공하는 스타일 파일로 바뀝니다.

```latex
\documentclass{IEEEtran}              % IEEE 논문
\documentclass{acmart}                % ACM 논문
\documentclass[preprint]{elsarticle}  % Elsevier 논문
```

이때는 여백·글자 크기·저자 표기 형식이 스타일 파일에 이미 정해져 있으므로, `geometry` 로 여백을 직접 건드리는 등의 설정은 오히려 투고 규정을 어기게 됩니다. 스타일 파일을 받았다면 그 규칙을 따르는 게 원칙입니다.

## 3. 패키지 — 필요한 기능만 불러오기

LaTeX 의 기본 기능은 의도적으로 최소한입니다. 필요한 기능은 **패키지**로 그때그때 불러옵니다. 선언은 프리앰블에서 `\usepackage{}` 로 합니다.

```latex
\usepackage{amsmath}       % 고급 수식 환경 (align, cases 등)
\usepackage{graphicx}      % 그림 삽입 (\includegraphics)
\usepackage{hyperref}      % 클릭 가능한 링크·참조
\usepackage[margin=2.5cm]{geometry}   % 여백 2.5cm
\usepackage{kotex}         % 한국어
```

Overleaf 는 수천 개의 패키지를 내장하고 있어, `\usepackage{}` 만 선언하면 자동으로 로드됩니다. 별도 설치가 필요 없습니다. 옵션이 있으면 패키지 이름 앞 대괄호에 넣습니다 — `\usepackage[margin=2.5cm]{geometry}` 처럼.

처음에는 아래 정도를 프리앰블에 두고 시작하면 대부분의 문서를 씁니다.

| 패키지 | 역할 |
|---|---|
| `amsmath` | 수식 환경 확장 (`align`, `cases`) |
| `amssymb` | 수학 기호 추가 (`\mathbb`, `\mathcal`) |
| `graphicx` | 그림 삽입 |
| `hyperref` | 링크·북마크·참조 |
| `geometry` | 여백·용지 크기 조정 |
| `kotex` | 한국어 폰트·줄바꿈 |
| `booktabs` | 학술지 스타일 표 |

패키지 각각을 언제 어떻게 쓰는지는 별도 주제라 여기서는 목록만 둡니다. 어떤 패키지를 어떤 순서로 불러야 하는지 — 특히 `hyperref` 는 왜 대개 맨 마지막에 두는지 — 는 문서 완성도 패키지 글에서 따로 다룹니다.

## 4. 제목·저자·날짜 — 첫 페이지 만들기

논문 첫 페이지의 제목·저자·날짜는 **프리앰블에 선언**하고 **본문에서 출력**합니다. 선언과 출력이 나뉘어 있다는 점이 처음엔 어색한데, 앞의 프리앰블/본문 원칙을 그대로 따른 것입니다 — 정보는 설정이니 위에, 출력 명령은 내용이니 아래에.

```latex
% 프리앰블
\title{딥러닝을 활용한 한국어 텍스트 분류 연구}
\author{홍길동 \and 김철수}
\date{2026년 4월}

\begin{document}
\maketitle
```

- `\and` — 저자가 여럿일 때 구분합니다.
- `\date{\today}` — 컴파일하는 날짜가 자동으로 들어갑니다. 날짜를 비우려면 `\date{}` 로 빈 인자를 줍니다(그냥 생략하면 오늘 날짜가 나옵니다).
- `\maketitle` — 선언해 둔 세 정보를 실제 제목 블록으로 조판합니다. 본문 맨 앞에 한 번 씁니다.

### 소속·이메일 붙이기

기본 `article` 에서 소속을 붙일 때는 `\thanks{}` 를 씁니다. 저자 이름 뒤에 각주처럼 달립니다.

```latex
\author{홍길동\thanks{한국대학교 컴퓨터공학과, \texttt{hong@korea.ac.kr}}
        \and
        김철수\thanks{서울대학교 AI 연구소}}
```

다만 학술지 스타일 파일을 쓸 때는 저자 정보 형식이 그쪽에 이미 정의돼 있어, `\thanks` 대신 전용 명령을 씁니다. IEEE 라면 이런 식입니다.

```latex
\author{
  \IEEEauthorblockN{홍길동}
  \IEEEauthorblockA{컴퓨터공학과\\
  한국대학교\\
  hong@korea.ac.kr}
}
```

이 명령들(`\IEEEauthorblockN` 등)은 `IEEEtran` 클래스가 제공하는 것이라, 다른 클래스에서는 동작하지 않습니다. 저자 표기가 뜻대로 안 나온다면 대개 클래스와 표기 명령이 안 맞은 경우입니다.

### 초록 넣기

초록은 `abstract` 환경으로, `\maketitle` 바로 다음에 씁니다.

```latex
\begin{document}
\maketitle

\begin{abstract}
본 연구는 딥러닝 모델을 활용하여 한국어 텍스트 분류 성능을 향상시키는
방법을 제안합니다. 실험 결과, 제안 방법이 기존 방법 대비 5.3\% 향상된
정확도를 달성함을 확인하였습니다.
\end{abstract}

\section{서론}
```

퍼센트 기호가 `5.3\%` 처럼 백슬래시와 함께 쓰인 데 주의하세요. `%` 는 LaTeX 에서 주석 기호라, 글자로 쓰려면 `\%` 로 이스케이프해야 합니다. 초록 다음에 키워드를 넣는 명령은 스타일 파일마다 다르므로, 투고 규정을 확인하는 편이 안전합니다.

## 5. 전체를 하나로 — 복사해 쓰는 최소 뼈대

지금까지의 조각을 모으면, 한국어 논문 한 편의 출발점으로 그대로 쓸 수 있는 골격이 됩니다.

```latex
\documentclass[12pt, a4paper]{article}

\usepackage{kotex}          % 한국어
\usepackage{amsmath}        % 수식
\usepackage{graphicx}       % 그림
\usepackage[margin=2.5cm]{geometry}   % 여백
\usepackage{hyperref}       % 링크 (관례상 마지막)

\title{연구 제목}
\author{저자 이름\thanks{소속, \texttt{email@example.com}}}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
초록을 여기에 씁니다.
\end{abstract}

\section{서론}
본문을 여기서 시작합니다.

\end{document}
```

이 골격만 있으면 이후 작업은 전부 **본문을 채우는 일** 입니다 — 문단을 쓰고, 표를 넣고, 그림을 걸고, 참고문헌을 붙이는. 뼈대 자체는 다시 손댈 일이 거의 없습니다.

## 정리

| 요소 | 어디에 | 요점 |
|---|---|---|
| 프리앰블 | `\documentclass` ~ `\begin{document}` 직전 | 설정만. 여기에 본문 글자가 있으면 `Missing \begin{document}` |
| 본문 | `\begin{document}` ~ `\end{document}` | 독자가 볼 내용만. 여기에 `\usepackage` 를 쓰면 오류 |
| `\documentclass` | 프리앰블 첫 줄 | `article`(장 없음) / `report`·`book`(`\chapter`) 갈림 |
| 클래스 옵션 | `[12pt, a4paper]` | 한국에서는 `a4paper` 를 거의 항상 지정 |
| `\usepackage` | 프리앰블 | 필요한 기능만. Overleaf 는 자동 로드 |
| `\title`·`\author`·`\date` | 프리앰블에 선언 | 출력은 본문의 `\maketitle` 로 |
| `abstract` | `\maketitle` 다음 | 환경 하나. 키워드 명령은 투고 규정 확인 |

문서의 뼈대는 논문이든 보고서든 같습니다. 클래스를 정하고(무엇을 쓸지), 패키지를 불러오고(무슨 기능이 필요한지), 제목 정보를 선언한 뒤(`\maketitle`), 본문을 채웁니다. 이 순서가 한 번 손에 붙으면, 새 문서를 시작할 때 빈 화면 앞에서 망설이는 일이 없어집니다.
