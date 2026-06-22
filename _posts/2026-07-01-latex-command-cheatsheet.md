---
title: "LaTeX 명령어 치트시트 — 논문 한 편에 실제로 쓰는 것만"
date: 2026-07-01 09:00:00 +0900
categories: [LaTeX, Reference]
tags: [latex, 치트시트, cheatsheet, reference, 명령어, 입문]
math: true
pin: false
description: "논문 한 편을 LaTeX 로 쓰는 데 실제로 필요한 명령어를 용도별로 정리한 치트시트. 문서 뼈대·텍스트 서식·목록·수식·그림·표·참고문헌·공백 제어까지 한 페이지로 모았습니다. Overleaf 에 띄워두고 복사해 쓰면 됩니다."
---

LaTeX 의 명령어는 끝이 없어 보이지만, **논문 한 편을 끝내는 데 실제로 쓰는 명령어는 60~80 개 정도** 로 좁혀집니다. 이 글은 그 좁은 핵심만 한 페이지에 모은 치트시트입니다. 책의 부록 A 를 블로그 형식으로 옮긴 것이며, Overleaf 옆 탭에 띄워두고 그대로 복사해 써도 무방합니다.

처음 LaTeX 를 잡았을 때 가장 답답한 건 "이게 분명히 있는데 명령어 이름이 뭐였더라" 인 경우입니다. 이 글의 표는 그 순간을 위한 것입니다.

## 1. 문서 뼈대 — 거의 모든 프리앰블의 시작

```latex
\documentclass[12pt, a4paper]{article}    % 기본 — 보고서·과제는 article, 책은 book
\usepackage{kotex}                         % 한국어 — 한국어 문서면 필수
\usepackage{amsmath}                       % 수식 확장 — \eqref, align, \text 등
\usepackage{amssymb}                       % 추가 수학 기호 — \mathbb, \mathcal 등
\usepackage{graphicx}                      % 그림 삽입
\usepackage{hyperref}                      % 클릭 가능한 링크·참조
\usepackage[margin=2.5cm]{geometry}        % 여백 2.5cm

\title{제목}
\author{이름}
\date{\today}                              % 컴파일 날짜 자동

\begin{document}
\maketitle
\tableofcontents                           % 목차 자동 생성

% 본문 시작

\end{document}
```

처음 LaTeX 문서를 시작할 때 이 한 묶음을 복사해 두면 절반은 끝난 셈입니다. `documentclass`, 한국어, 수식, 그림, 링크, 여백 — 이게 거의 모든 학술 문서의 기본 골격입니다.

## 2. 텍스트 서식

| 명령어 | 결과 | 용도 |
|---|---|---|
| `\section{...}` | **1. ...** | 1단계 제목 |
| `\subsection{...}` | **1.1 ...** | 2단계 제목 |
| `\subsubsection{...}` | **1.1.1 ...** | 3단계 제목 |
| `\paragraph{...}` | **...** | 단락 제목 (번호 없음) |
| `\textbf{...}` | **굵게** | 강조 |
| `\textit{...}` | *이탤릭* | 책 제목 등 |
| `\underline{...}` | 밑줄 | 강조 (학술 문서에선 권장 안 함) |
| `\emph{...}` | *강조* | 문맥에 따라 자동 (ital ↔ roman) |
| `\texttt{...}` | `monospace` | 코드·명령어 |
| `\footnote{...}` | ¹각주 | 본문 옆 각주 |

`\emph` 은 `\textit` 와 비슷해 보이지만, **상위 문단이 이미 이탤릭이면 직립체로 뒤집어 강조** 합니다. 그래서 책·논문에서는 `\textit` 보다 `\emph` 이 권장됩니다.

## 3. 목록

```latex
% 순서 없는 목록 (• 항목)
\begin{itemize}
  \item 첫 번째 항목
  \item 두 번째 항목
    \begin{itemize}             % 중첩 가능
      \item 하위 항목
    \end{itemize}
\end{itemize}

% 순서 있는 목록 (1. 항목)
\begin{enumerate}
  \item 첫 번째
  \item 두 번째
\end{enumerate}

% 설명 목록 (용어: 정의)
\begin{description}
  \item[용어 1] 설명 1
  \item[용어 2] 설명 2
\end{description}
```

`enumerate` 의 번호 형식 (1, a, i 등) 을 바꾸려면 `enumitem` 패키지를 추가합니다.

## 4. 수식 — 가장 자주 쓰는 묶음

### 환경

```latex
% 인라인
텍스트 $E = mc^2$ 텍스트

% 디스플레이 (번호 없음)
\[
  F = ma
\]

% 디스플레이 (번호 있음, 참조 가능)
\begin{equation}
  \nabla \cdot \mathbf{E} = \frac{\rho}{\varepsilon_0}
  \label{eq:gauss}
\end{equation}

% 여러 줄 정렬
\begin{align}
  a &= b + c \\
  d &= e + f
\end{align}

% 본문 참조
식~\eqref{eq:gauss} 에서 보듯이...
```

### 자주 쓰는 패턴

| LaTeX | 결과 | 용도 |
|---|---|---|
| `\frac{a}{b}` | $\frac{a}{b}$ | 분수 |
| `\dfrac{a}{b}` | $\dfrac{a}{b}$ | 인라인에서 큰 분수 |
| `x^{n}`, `x_{i}` | $x^n$, $x_i$ | 위·아래첨자 |
| `\sqrt{x}`, `\sqrt[n]{x}` | $\sqrt{x}$, $\sqrt[n]{x}$ | 제곱근·n 제곱근 |
| `\int_{a}^{b} f(x)\,dx` | $\int_a^b f(x)\,dx$ | 적분 |
| `\sum_{i=1}^{n} x_i` | $\sum_{i=1}^n x_i$ | 합 |
| `\prod_{i=1}^{n} x_i` | $\prod_{i=1}^n x_i$ | 곱 |
| `\lim_{x \to \infty}` | $\lim_{x\to\infty}$ | 극한 |
| `\infty`, `\partial`, `\nabla` | $\infty$, $\partial$, $\nabla$ | 무한·편미분·델 |
| `\mathbb{R}`, `\mathcal{F}` | $\mathbb{R}$, $\mathcal{F}$ | 칠판체·필기체 |
| `\mathbf{v}`, `\boldsymbol{\alpha}` | $\mathbf{v}$, $\boldsymbol{\alpha}$ | 벡터 (로마·그리스) |
| `\hat{x}`, `\bar{x}`, `\tilde{x}` | $\hat x$, $\bar x$, $\tilde x$ | 모자·바·물결 |
| `\dot{x}`, `\ddot{x}` | $\dot x$, $\ddot x$ | 시간 미분 |

### 자동 크기 괄호

```latex
\left( \frac{a}{b} \right)
\left[ \frac{a}{b} \right]
\left\{ \frac{a}{b} \right\}
\left| x \right|
\left\langle v \right\rangle
```

수동 크기는 `\big`, `\Big`, `\bigg`, `\Bigg` 4 단계. 같은 식 안에서 일관된 크기를 잡고 싶을 때 유용합니다.

자주 쓰는 행렬:

```latex
\begin{pmatrix} a & b \\ c & d \end{pmatrix}   % 소괄호 (가장 흔함)
\begin{bmatrix} a & b \\ c & d \end{bmatrix}   % 대괄호
\begin{vmatrix} a & b \\ c & d \end{vmatrix}   % 절댓값 = 행렬식
\begin{cases} x+y=1 \\ 2x-y=3 \end{cases}      % 연립방정식
```

## 5. 그림

```latex
\begin{figure}[htbp]                        % h: 현재, t: 상단, b: 하단, p: 별도
  \centering
  \includegraphics[width=0.7\linewidth]{파일이름.png}
  \caption{그림 제목}
  \label{fig:my-plot}
\end{figure}

% 본문 참조
그림~\ref{fig:my-plot} 에서 볼 수 있듯이...
```

`[htbp]` 4 옵션을 다 적어두면 LaTeX 가 가장 적절한 자리를 알아서 잡습니다. 강제로 현재 위치에 박으려면 `float` 패키지 + `[H]` 옵션을 씁니다.

```latex
\usepackage{float}
\begin{figure}[H]   % 무조건 여기에 — 페이지 끝에 강제 박을 때
  ...
\end{figure}
```

## 6. 표

```latex
\begin{table}[htbp]
  \centering
  \caption{표 제목}                          % 표는 caption 이 위에 옵니다
  \label{tab:results}
  \begin{tabular}{|l|c|r|}                  % l: 좌, c: 중, r: 우 정렬
    \hline
    왼쪽 & 가운데 & 오른쪽 \\
    \hline
    A & B & C \\
    D & E & F \\
    \hline
  \end{tabular}
\end{table}
```

### 논문용 깔끔한 표 — booktabs

세로 줄 + 모든 행에 가로 줄을 그은 표는 학술 출판물에선 거의 쓰이지 않습니다. `booktabs` 패키지로 가로 굵은 줄 + 본문 가는 줄 + 끝 굵은 줄의 3 단 구조가 표준입니다.

```latex
\usepackage{booktabs}

\begin{tabular}{lcc}
  \toprule
  항목 & 값 1 & 값 2 \\
  \midrule
  A & 1.23 & 4.56 \\
  B & 7.89 & 0.12 \\
  \bottomrule
\end{tabular}
```

`\toprule`, `\midrule`, `\bottomrule` 세 명령어만 외워두면 됩니다. 깔끔하고 학술지 스타일에 그대로 통합니다.

## 7. 참고문헌 — BibTeX

```latex
% 프리앰블
\usepackage{natbib}

% 본문에서 인용
\cite{smith2023}      % (Smith, 2023) 또는 [1] — 스타일 따라 다름
\citep{smith2023}     % (Smith, 2023) — natbib 괄호 형식
\citet{smith2023}     % Smith (2023) — natbib 본문 흐름

% 본문 끝
\bibliographystyle{plain}     % plain, ieeetr, apalike, ...
\bibliography{references}     % references.bib 사용
```

`.bib` 파일 예:

```bibtex
@article{smith2023,
  author  = {Smith, John},
  title   = {논문 제목},
  journal = {저널 이름},
  year    = {2023},
  volume  = {10},
  pages   = {1--20}
}

@book{knuth1984,
  author    = {Knuth, Donald E.},
  title     = {The TeXbook},
  publisher = {Addison-Wesley},
  year      = {1984}
}
```

페이지 번호의 `1--20` 처럼 **하이픈 두 개** 가 en-dash (–) 로 자동 변환됩니다.

## 8. 공백·줄바꿈·페이지 제어

```latex
% 줄바꿈
\\           % 강제 줄바꿈 (수식 정렬·본문 모두)
\newline     % 새 줄 (단락 X)
\par         % 새 단락

% 수식·텍스트 공백
~            % 줄바꿈 불가 공백 — "그림~\ref{}" 처럼
\,           % 가는 공백 (적분 dx 앞에 권장)
\quad        % 일반 공백 약 1글자
\qquad       % 큰 공백 약 2글자
\hspace{1cm} % 임의 길이 수평 공간
\vspace{1cm} % 수직 공간

% 페이지 제어
\newpage     % 새 페이지
\clearpage   % 그림·표 flush 후 새 페이지
\pagebreak   % 여기에서 페이지 끊기

% 주석
% 한 줄 주석 (컴파일에서 무시됨)
```

`~` 는 의외로 자주 씁니다. "그림 5" 가 줄 끝에서 "그림 / 5" 로 갈라지면 어색하기 때문에, `그림~\ref{fig:my-plot}` 처럼 끊김 없는 공백을 강제합니다.

## 9. 자주 쓰는 환경 한 묶음

| 환경 | 용도 |
|---|---|
| `equation` | 번호 있는 디스플레이 수식 |
| `equation*` | 번호 없는 디스플레이 수식 |
| `align` / `align*` | 정렬된 여러 줄 수식 (번호 / 무번호) |
| `gather` / `gather*` | 중앙 정렬 여러 줄 |
| `cases` | 조건부 수식 (`f(x) = ...`) |
| `itemize` / `enumerate` / `description` | 순서 없는·있는·설명 목록 |
| `figure` / `table` | 떠다니는 그림·표 |
| `quote` / `quotation` | 인용 |
| `verbatim` | 코드처럼 입력 그대로 (이스케이프 없음) |
| `abstract` | 초록 |

`abstract` 환경은 `\maketitle` 다음, 본문 시작 전에 둡니다.

```latex
\begin{abstract}
  본 논문은 ... 을 다룬다. 결과는 ... 임을 보인다.
\end{abstract}
```

## 10. 트러블슈팅 — 자주 마주치는 오류

| 메시지 | 원인 | 해결 |
|---|---|---|
| `Undefined control sequence` | 명령어 오타·패키지 누락 | `\usepackage{...}` 추가 또는 명령어 철자 확인 |
| `Missing $ inserted` | 수식 환경 안 빈 줄, 또는 인라인 `$` 미닫힘 | 빈 줄 제거, `$` 짝 확인 |
| `Missing \right.` | `\left` 짝이 없음 | `\right.` (점) 으로 짝 맞추기 |
| `LaTeX Warning: Reference '...' on page N undefined` | `\label` 누락 또는 오타 | 라벨 추가·확인, 두 번 컴파일 |
| `LaTeX Warning: Citation '...' undefined` | `.bib` 키 오타 또는 미수록 | `.bib` 확인, BibTeX 컴파일 재실행 |
| `Overfull \hbox` | 한 줄 폭 초과 (단어 분할 실패) | 단어를 끊거나 (`\-`) 짧은 표현으로 |

대부분의 LaTeX 편집기 (Overleaf, TeXstudio 등) 가 첫 줄 오류를 가장 분명히 보여 줍니다. 메시지 첫 줄을 보고 위 표에서 비슷한 패턴을 찾는 게 가장 빠른 길입니다.

## 정리

치트시트는 외우는 게 아니라 **익숙해지는 것** 입니다. 처음 LaTeX 문서를 시작할 때마다 이 글을 옆 탭에 띄워두고 필요한 묶음을 복사해 쓰다 보면, 두세 편 안에 손이 알아서 가는 명령어가 늘어납니다.

쓰는 동안 자주 찾아오는 묶음은 따로 메모해 두면 좋습니다. 본인의 작업 패턴 (이공계인가 인문 사회인가, 표를 많이 쓰는가 수식을 많이 쓰는가) 에 따라 자주 쓰는 명령어가 달라지므로, 이 치트시트를 그대로 가져다 쓰는 것보다 자신의 버전을 만들어 가는 게 장기적으로 더 효율적입니다.

다음 글에서는 수식의 핵심 재료 — **그리스 문자 전체 목록** 을 작명 규칙과 이형 (var-form) 까지 한 번에 정리합니다.

---

이전 글: [#7 LaTeX 수식에서 흔히 하는 5가지 실수와 해결법](/blog/posts/latex-equation-5-mistakes/)
다음 글: [#9 LaTeX 그리스 문자 전체 목록 — 소·대문자와 이형 문자까지](/blog/posts/latex-greek-letters-complete/)

> **Google Docs / Word 의 수식을 한 번에 깔끔하게** — [LaTeXFlow Web 바로 가기](https://mathsystem.dev/latexflow/web/) (sign-in 없이 즉시)
{: .prompt-info }
