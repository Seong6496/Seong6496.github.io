---
title: "구글 문서로 만든 시험지·학습지, LaTeX 파일로 바꾸는 법"
date: 2026-10-27 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, google-docs, latex, 시험지, 학습지, 단원평가, 객관식, kotex, overleaf]
math: false
pin: false
description: "구글 문서로 만든 단원평가 시험지를 LaTeX(.tex) 파일로 옮겨 봅니다. 객관식 ①②③, 문항 번호, 한글, 수식이 .tex 에서 어떻게 나오는지, 그대로 컴파일한 PDF 는 어떤지, 그리고 2단 배치·답 쓸 공간·머리글·그림처럼 손으로 채울 곳을 몇 줄로 채우는 방법까지 실제 시험지 한 장으로 확인합니다."
---

시험지는 구글 문서로 만드는 경우가 많습니다. 동료 선생님과 같이 고치기 쉽고, 작년 시험지도 거기 있으니까요. 그런데 문제은행으로 모아 두거나, 다른 선생님이 Overleaf 에서 쓰고 있거나, 수식이 더 깔끔한 PDF 가 필요해지면 같은 시험지를 **LaTeX 파일** 로 갖고 싶어집니다.

다시 치지 않고 옮기는 방법을 시험지 한 장으로 따라가 봅니다. 쓰는 도구는 구글 문서 애드온 **LaTeXFlow** 의 **LaTeX file** 탭에 있는 **Convert to LaTeX** 입니다. 이 기능은 라이선스 키가 있어야 열립니다. 애드온 설치는 [설치부터 첫 변환까지](/blog/posts/latexflow-addon-install-first-conversion/) 글에 있습니다.

## 1. 시험지

고1 이차함수 단원평가입니다. 제목, 학년·반·이름 칸 표, 유의 사항, 선택형 8문항(①~⑤), 서답형 3문항, 그래프 그림 1개, 배점표가 있고, 수식은 구글 문서 수식 편집기(삽입 › 수식)로 넣었습니다.

![구글 문서의 단원평가 시험지 첫 쪽: 2026학년도 1학년 2학기 수학 단원평가 (이차함수) 제목, 학년/반/번호와 이름·점수 칸, 유의 사항, 2단으로 배치된 1~6번 문항과 원 숫자 보기 ①~⑤, 오른쪽 단의 포물선과 직선 그래프](/assets/img/posts/2026-10-27/01-exam-in-google-docs.png){: width="500" }

## 2. LaTeX 파일로 내보내기

**확장 프로그램 › LaTeXFlow** 로 사이드바를 열고 **LaTeX file** 탭에서 **Full document** 가 선택된 채로 **Convert to LaTeX** 를 누릅니다. 이 시험지에서는 결과 줄이 이렇게 나왔습니다.

```text
73 native · 0 image · 0 text equations · 2 tables · 1 image · 0 citations
```

수식 편집기로 넣은 수식 73개(native), 표 2개, 그림 1개를 찾았다는 뜻입니다. 그 아래 **Download .tex**, **Copy .tex**, **Open in Overleaf** 버튼이 있습니다.

<!-- TODO image (web pane): LaTeX file tab after Convert to LaTeX on a Korean exam document — result line with "N native", warnings list, Download .tex / Open in Overleaf buttons. File: /assets/img/posts/2026-10-27/04-sidebar-result.png -->

## 3. .tex 파일 안

파일 앞부분입니다.

```latex
\documentclass{article}
\usepackage[T1]{fontenc}
\usepackage{kotex}        % Korean — works under pdfLaTeX and XeLaTeX
\usepackage{amsmath,amssymb}
\usepackage{graphicx}
\DeclareRobustCommand{\LFXcircled}[1]{\textcircled{\ifnum#1<10 \scriptsize\else\tiny\fi #1}}

\begin{document}

\title{2026학년도 1학년 2학기 수학 단원평가 (이차함수)}
\author{}
\date{}
\maketitle

\textbf{\textreferencemark{} 유의 사항} 선택형 1\textasciitilde{}8번은 OMR 카드에, ...

\textbf{1.} 이차함수 $y=2{x}^{2}-8x+5$ 의 그래프의 꼭짓점의 좌표는? \textbf{[3점]}

\LFXcircled{1} $(2,-3)$ \LFXcircled{2} $(2,3)$ \LFXcircled{3} $(-2,-3)$ ...
```

하나씩 보면:

- **한글.** 문서에 한글이 있으면 `kotex` 를 알아서 넣습니다. pdfLaTeX 와 XeLaTeX 어느 쪽으로도 컴파일됩니다.
- **원 숫자 보기 ①~⑤** 는 `\LFXcircled{1}` 로 나오고, 그 정의가 파일 머리에 같이 들어갑니다. 따로 패키지를 찾을 필요가 없습니다. ※ 는 `\textreferencemark` 가 됩니다.
- **문항 번호.** 손으로 친 "1.", "[서답형 1]" 은 친 그대로 글자로 남습니다. LaTeX 가 번호를 다시 매기지 않으니 시험지 번호가 바뀔 일이 없습니다.
- **수식.** 수식 편집기의 수식은 LaTeX 로 다시 씁니다. `{x}^{2}` 처럼 괄호가 조금 많지만 뜻은 같습니다.
- **제목** 은 구글 문서의 제목 스타일에서 `\title` 이 되고, **표** 는 `tabular` 가 됩니다.

## 4. 그대로 컴파일하면

받은 파일을 손대지 않고 pdfLaTeX 로 컴파일한 첫 쪽입니다.

![내보낸 .tex 를 그대로 컴파일한 PDF 첫 쪽: 제목, 학년·반 표, 유의 사항, 한 단으로 이어진 1~8번 문항과 원 숫자 보기, 그림 자리에 Image 1 상자](/assets/img/posts/2026-10-27/02-exported-pdf.png){: width="500" }

글자, 수식, 보기 번호는 모두 나왔습니다. 대신 시험지 모양은 구글 문서와 다릅니다. 2단이 1단이 되었고, 문항 사이의 빈 공간과 머리글·바닥글이 없고, 그림은 `Image 1` 상자입니다. 글꼴·크기·색·줄 간격·단 나누기 같은 **모양** 은 일부러 옮기지 않습니다. LaTeX 에서는 그것을 문서 클래스와 몇 줄의 명령이 정하기 때문입니다. 그 몇 줄이 다음 절입니다.

## 5. 시험지 모양 채우기 — 몇 줄이면 됩니다

**머리글·바닥글.** 머리말(`\begin{document}` 앞)에 넣습니다.

```latex
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhead[R]{1학년 수학 | 2026. 10.}
\fancyfoot[C]{수학 단원평가 \thepage 쪽}
```

첫 쪽에도 보이게 하려면 `\maketitle` 바로 다음 줄에 `\thispagestyle{fancy}` 를 씁니다.

**2단.** 머리말에 `\usepackage{multicol}` 을 넣고, 1번 문항 앞에 `\begin{multicols}{2}`, `\end{document}` 바로 앞에 `\end{multicols}` 를 씁니다. 이때 그림 부분의 `\begin{figure}[h]` … `\end{figure}` 는 `\begin{center}` … `\end{center}` 로 바꿔 주세요. `multicols` 안에서는 `figure` 가 나오지 않습니다.

**답 쓸 공간.** 공간이 필요한 문항 뒤에 `\vspace{3cm}` 처럼 높이를 적습니다. 구글 문서의 빈 줄은 LaTeX 에서 공간이 되지 않기 때문입니다.

**그림.** 그래프 그림 파일을 Overleaf 프로젝트에 올리고 `\fbox{Image 1}` 을 `\includegraphics[width=0.45\linewidth]{graph.png}` 처럼 바꿉니다. 파일 머리의 경고 목록에 그림마다 한 줄씩 적혀 있어서 빠뜨릴 일은 없습니다.

위 네 가지를 넣고 다시 컴파일한 첫 쪽입니다(그림은 아직 상자).

![머리글 1학년 수학 | 2026. 10. 과 바닥글 수학 단원평가 1쪽이 생기고, 문항이 2단으로 배치되고, 1번 문항 아래에 답 쓸 공간이 생긴 PDF 첫 쪽](/assets/img/posts/2026-10-27/03-after-fixes-pdf.png){: width="600" }

**한 가지 더.** 오른쪽 단 맨 아래 서답형 3번의 연립부등식이 `{x²−3x−10≤0x²−4x+3>0` 처럼 한 줄로 붙어 있습니다. 이 시험지는 원래 워드 파일을 구글 문서로 연 것인데, 그때 구글 문서가 연립식을 한 줄로 펴 버렸습니다. 이런 수식은 구글 문서에서 그 수식을 지우고 LaTeX 를 글자로 쳐 두면 됩니다.

```latex
$$\begin{cases} x^2-3x-10\le 0 \\ x^2-4x+3>0 \end{cases}$$
```

`$…$` 나 `$$…$$` 사이에 친 LaTeX 는 내보낼 때 친 그대로 .tex 에 들어가므로 결과가 정확합니다. 구글 문서에서도 수식 모양으로 보이게 하려면 LaTeXFlow 의 **Scan** 탭(무료)에서 **Scan Document** › **Convert All** 을 누르면 됩니다. 수식 그림 안에 LaTeX 가 저장되어 있어서 내보내기는 그대로 정확합니다. 다만 그 수식을 나중에 고칠 때는 수식 편집기가 아니라 LaTeX 로 고칩니다.

## 6. 어디까지 믿을 수 있나

이 시험지는 저희가 버전마다 돌리는 시험 문서 20개 중 하나입니다(시험지·학습지 10개, 논문형 문서 10개). [버전 15](/latexflow/changelog/#version-15) 를 출시 전에 시험했을 때 20개 모두 **내보낸 그대로 컴파일** 되었습니다. 원 숫자 ①~⑤ 와 로마 숫자 Ⅰ~Ⅲ 가 상자로 깨지지 않고 나오는 것도 버전 15 부터입니다.

정리하면, 글자·수식·보기 번호·표는 그대로 옮겨지고, 시험지 모양은 위의 몇 줄로 채웁니다. 한 번 만들어 둔 머리말은 다음 시험지에도 그대로 쓸 수 있습니다.

- 라이선스 키: [LaTeXFlow 스토어](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=google-docs-exam-worksheet-to-latex)
- 무엇이 어떻게 바뀌는지, 활성화·해지·환불: [Export & Import 안내](/latexflow/export/)
