---
title: "LaTeX 그림 삽입과 캡션 — \"그림 3을 보면\"이 자동으로 되는 이유"
date: 2026-08-01 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, 그림, figure, includegraphics, caption, label, ref, float, htbp, graphicspath, 논문]
math: false
pin: false
description: "LaTeX 로 그림을 넣고 캡션·번호·참조를 자동으로 관리하는 법을 정리합니다. includegraphics 로 그림 삽입과 크기 조정, figure/table 부동 환경, caption·label·ref 로 '그림 3' 자동 번호, [htbp] 위치 지시자와 그림이 밀리는 문제, graphicspath 경로 지정과 두 그림 나란히 배치까지. 각 도구를 언제 왜 쓰는지 함께 짚습니다."
---

논문을 쓰다 보면 "그림 3 에서 보듯이", "표 2 와 같이" 처럼 본문에서 그림과 표를 수시로 가리킵니다. Word 에서는 중간에 그림을 하나 추가하면 그 뒤의 모든 번호를 손으로 고쳐야 했습니다. LaTeX 는 다릅니다 — 그림에 이름표(`\label`)만 붙여 두면, 번호는 컴파일할 때마다 자동으로 다시 매겨집니다. 이 글은 그 구조를 만드는 법을 정리합니다.

앞선 [표 만들기](/blog/posts/latex-tables-tabular-booktabs/) 글이 표의 격자를 짜는 법이었다면, 이 글은 그렇게 만든 표와 그림에 **번호·캡션·참조**를 붙이는 법입니다. 그 메커니즘은 그림과 표가 완전히 같아서, 두 경우를 함께 다룹니다.

## 1. 그림 넣기 — includegraphics

그림 삽입은 `graphicx` 패키지의 `\includegraphics` 로 합니다.

```latex
\usepackage{graphicx}   % 프리앰블에 추가

\includegraphics{figure.pdf}
```

지원하는 파일 형식은 `.pdf` · `.png` · `.jpg` 입니다. `.eps` 는 pdfLaTeX 에서 직접 넣을 수 없어 변환이 필요합니다(형식이 맞지 않아 그림이 안 들어가는 경우의 진단은 뒤에서 다룹니다).

### 크기 조정

원본 크기 그대로는 페이지를 넘기기 일쑤라, 대개 너비를 지정합니다.

```latex
\includegraphics[width=0.8\linewidth]{figure.pdf}   % 본문 너비의 80%
\includegraphics[width=8cm]{figure.pdf}              % 고정 8cm
\includegraphics[height=5cm]{figure.pdf}             % 높이 기준
\includegraphics[scale=0.5]{figure.pdf}              % 원본의 50%
\includegraphics[width=0.5\linewidth, angle=90]{figure.pdf}  % 90도 회전
```

가장 많이 쓰는 것은 `width=0.8\linewidth` 형태입니다. `\linewidth` 는 **현재 본문의 너비**를 뜻하는데, 이 값을 기준으로 쓰면 2단·3단 편집으로 단 폭이 바뀌어도 그림이 그 폭에 맞춰 따라갑니다. 고정 `cm` 보다 유연해서, 학술지 템플릿처럼 단 구성이 정해진 문서에서 특히 안전합니다.

## 2. figure 환경 — 그림을 "부동체"로 감싼다

`\includegraphics` 만 쓰면 그림이 코드가 놓인 바로 그 자리에 박혀, 페이지 하단에 어중간하게 걸리기도 합니다. 그래서 그림은 보통 `figure` **환경**으로 감쌉니다.

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\linewidth]{experiment_result.pdf}
  \caption{실험 결과: 제안 방법과 베이스라인의 성능 비교}
  \label{fig:result}
\end{figure}
```

`figure` 는 **부동 환경(float)** 입니다. LaTeX 가 페이지 흐름을 보고 그림이 예쁘게 들어갈 자리를 스스로 고르게 맡긴다는 뜻입니다. 안에 들어가는 요소는 셋입니다.

- `\centering` — 그림을 가운데 정렬
- `\caption{}` — 그림 설명. **자동으로 "그림 1." 처럼 번호가 붙습니다**
- `\label{}` — 참조용 이름표. 반드시 `\caption` **뒤에** 써야 합니다

`\label` 을 `\caption` 앞에 쓰면 엉뚱한 번호를 참조하게 됩니다. 번호를 만드는 것은 `\caption` 이고, `\label` 은 "방금 만들어진 그 번호" 를 붙잡는 역할이라, 순서가 뒤바뀌면 안 됩니다.

### 표도 같은 방식 — table 환경

표를 논문에서 "표 2" 로 번호 매기려면, 앞 글에서 만든 `tabular` 를 `table` 환경으로 감쌉니다. 구조가 `figure` 와 똑같습니다.

```latex
\begin{table}[htbp]
  \centering
  \caption{방법별 성능 비교}
  \label{tab:comparison}
  \begin{tabular}{lcr}
    \toprule
    방법 & 정확도 (\%) & F1 점수 \\
    \midrule
    베이스라인 & 78.3 & 0.781 \\
    제안 방법 & 85.7 & 0.854 \\
    \bottomrule
  \end{tabular}
\end{table}
```

한 가지 관례 차이가 있습니다. **표는 캡션을 위에, 그림은 캡션을 아래에** 둡니다. 그래서 `table` 에서는 `\caption` 을 `\begin{tabular}` **앞**에, `figure` 에서는 `\includegraphics` **뒤**에 씁니다. 위 두 예제의 `\caption` 위치가 다른 이유입니다.

## 3. 캡션·레이블·참조 — 번호가 자동으로 따라오는 원리

이름표를 붙였으면, 본문에서 그 이름으로 부릅니다.

```latex
그림 \ref{fig:result}에서 볼 수 있듯이, 제안 방법이 베이스라인보다
7.4\% 높은 정확도를 보였습니다.

표 \ref{tab:comparison}은 세 가지 방법의 성능을 비교합니다.
```

`\ref{fig:result}` 는 그 그림의 번호를 출력합니다. 주의할 점은 `\ref` 가 **"1", "2" 처럼 숫자만** 낸다는 것입니다. "그림 1" 로 보이게 하려면 앞에 "그림 " 을 직접 적습니다(위 예제처럼). 이 이름표–번호 연결 덕분에, 중간에 그림을 추가·삭제해도 번호가 어긋나지 않습니다. 이것이 서두에서 말한 "그림 3 을 보면" 이 자동으로 되는 원리입니다.

"그림 "·"표 " 를 매번 손으로 적는 게 번거롭다면 `cleveref` 패키지가 이를 자동화합니다.

```latex
\usepackage{cleveref}

\cref{fig:result}      % → 그림 1
\cref{tab:comparison}  % → 표 2
```

`\cref` 는 대상이 그림인지 표인지 알아서 "그림"·"표" 접두어까지 붙여 줍니다.

### 수식 참조와는 다른 이야기

여기서 쓴 `\label`·`\ref` 는 **그림과 표**를 가리킵니다. 수식에 번호를 달고 "식 (2)" 로 참조하는 것도 원리는 비슷하지만, 수식 쪽은 `equation` 환경과 `\eqref` 라는 전용 명령을 쓰고 괄호까지 자동으로 붙는 등 세부가 다릅니다. 수식 번호·참조는 [수식 번호 매기기와 eqref](/blog/posts/latex-equation-labels-eqref/) 글에서 따로 다뤘으니, 수식을 참조하려는 경우라면 그쪽을 보세요. 이 글의 도구는 그림·표 전용으로 생각하면 됩니다.

## 4. 위치 지시자 [htbp] — LaTeX 와 타협하기

`figure` 뒤의 `[htbp]` 는 LaTeX 에게 **어디에 놓고 싶은지 선호도**를 알려주는 지시자입니다.

| 지시자 | 의미 |
|---|---|
| `h` | 소스의 현재 위치(here) |
| `t` | 페이지 상단(top) |
| `b` | 페이지 하단(bottom) |
| `p` | 그림 전용 별도 페이지(page) |
| `!` | LaTeX 의 기본 배치 규칙을 완화 |
| `H` | 정확히 현재 위치에 고정 (`float` 패키지 필요) |

`[htbp]` 는 "여기 → 안 되면 상단 → 하단 → 별도 페이지" 순으로 시도하라는 뜻입니다. 지시자는 선호일 뿐 명령이 아니라서, LaTeX 는 빈 공간을 줄이려고 그림을 뒤 페이지로 미루기도 합니다.

**그림이 엉뚱한 페이지로 밀릴 때**의 대처는 세 가지입니다.

```latex
\begin{figure}[!htbp]   % 1. ! 로 배치 규칙 완화
\begin{figure}[H]       % 2. float 패키지의 H 로 현재 위치 고정
\clearpage              % 3. 미배치 그림을 모두 강제 출력하고 새 페이지
```

`H` 는 `\usepackage{float}` 을 불러와야 쓸 수 있습니다.

여기서 한 가지 구분이 중요합니다. 그림이 **다른 자리로 밀리는 것**과 그림이 **아예 나타나지 않는 것**은 원인이 다릅니다. 위치가 문제라면 방금의 지시자로 해결되지만, 그림 자리가 통째로 비거나 컴파일이 멈춘다면 대개 **파일을 못 찾은 경우** — `File not found` — 입니다. 파일명 대소문자나 경로, 그리고 앞서 말한 `.eps` 형식 문제가 원인일 때가 많고, 이 진단과 해결은 [LaTeX 오류 메시지 해결 사전 2편](/blog/posts/latex-document-errors-guide/) 의 3부에 정리해 두었습니다.

## 5. 그림 경로와 나란히 배치

### 그림 파일 경로

그림 파일은 `.tex` 와 같은 폴더에 두거나, 프리앰블에서 경로를 지정합니다.

{% raw %}
```latex
% 프리앰블에서 그림 폴더 경로 지정
\graphicspath{{figures/}{images/}}

% 이후 파일명만으로 참조 — figures/ 와 images/ 를 자동으로 뒤진다
\includegraphics{experiment.pdf}
```
{% endraw %}

`\graphicspath` 의 중괄호가 이중으로 겹친 것은 오타가 아닙니다. 안쪽 중괄호 하나가 폴더 하나를 감싸는 구조라, 여러 폴더를 나열하면 위 예제처럼 바깥 중괄호 안에 폴더별 중괄호가 들어갑니다. 그림이 여러 폴더에 흩어져 있을 때, 매번 경로를 적는 대신 이 선언 하나로 파일명만으로 부를 수 있습니다.

### 두 그림을 나란히

그림 두 개를 좌우로 놓고 각각 "(a)", "(b)" 를 붙이려면 `subcaption` 패키지를 씁니다.

```latex
\usepackage{subcaption}

\begin{figure}[htbp]
  \centering
  \begin{subfigure}[b]{0.48\linewidth}
    \includegraphics[width=\linewidth]{figure_a.pdf}
    \caption{방법 A의 결과}
    \label{fig:method_a}
  \end{subfigure}
  \hfill
  \begin{subfigure}[b]{0.48\linewidth}
    \includegraphics[width=\linewidth]{figure_b.pdf}
    \caption{방법 B의 결과}
    \label{fig:method_b}
  \end{subfigure}
  \caption{두 방법의 비교}
  \label{fig:comparison}
\end{figure}
```

두 `subfigure` 의 폭을 각각 `0.48\linewidth` 로 두고 사이에 `\hfill` 을 넣으면, 둘이 본문 폭을 나눠 나란히 놓입니다. 이때 `\ref{fig:comparison}` 은 전체 그림 번호를, `\ref{fig:method_a}` 는 "(a)" 같은 부속 번호를 참조합니다.

## 정리

| 목적 | 코드 | 비고 |
|---|---|---|
| 그림 삽입 | `\includegraphics[width=0.8\linewidth]{f.pdf}` | `graphicx` 필요 |
| 그림 감싸기 | `\begin{figure}[htbp]...\end{figure}` | 부동 환경 |
| 표 감싸기 | `\begin{table}[htbp]...\end{table}` | 캡션은 표 위 |
| 캡션·번호 | `\caption{설명}` | 번호 자동 |
| 이름표 | `\label{fig:...}` | 반드시 `\caption` 뒤 |
| 본문 참조 | `\ref{fig:...}` / `\cref{...}` | `\ref` 는 숫자만, `\cref` 는 "그림 1" |
| 위치 밀림 | `[!htbp]` / `[H]`(`float`) / `\clearpage` | 선호도 조정 |
| 그림이 안 나옴 | → 오류 사전 3부 | `File not found` (경로·형식) |
| 여러 폴더 | `\graphicspath` | 파일명만으로 참조 |
| 나란히 배치 | `subcaption` + `subfigure` | (a)(b) 부속 번호 |

그림과 표를 다루는 순서는 늘 같습니다 — 부동 환경(`figure`/`table`)으로 감싸고, `\caption` 으로 설명과 번호를 달고, `\label` 로 이름표를 붙인 뒤, 본문에서 `\ref` 로 부릅니다. 이 네 단계가 손에 붙으면, 그림을 아무리 넣고 빼도 번호가 어긋날 걱정이 사라집니다.
