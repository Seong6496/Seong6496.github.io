---
title: "한글 LaTeX, 어느 엔진으로 컴파일하나 — pdfLaTeX·XeLaTeX·LuaLaTeX 실측 비교"
date: 2026-10-16 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, kotex, 한국어, pdflatex, xelatex, lualatex, 컴파일러, 폰트, setmainhangulfont, overleaf]
math: false
pin: false
description: "같은 한글 문서를 pdfLaTeX·XeLaTeX·LuaLaTeX 세 엔진으로 컴파일해 비교합니다 — kotex 만 있으면 세 엔진 모두 한글이 나오고 (pdfLaTeX 는 배포판의 나눔명조, Xe·Lua 는 은바탕), 다른 것은 글꼴을 이름으로 고를 수 있는가 (Xe·Lua 만), 수식 안 한글이 깨지는 모양, 기울임, 컴파일 시간입니다. kotex 만 넣어서는 \"Figure\"·\"October\" 가 영어로 남고 [hangul] 옵션이 이를 바꾼다는 것까지."
---

한글 LaTeX 문서를 시작할 때 처음 고르는 것이 엔진 (컴파일러) 입니다. 흔히 "한글은 XeLaTeX" 라고 하고, 이 블로그도 [kotex 세팅 글](/blog/posts/kotex-korean-setup/)에서 그렇게 안내했습니다. 그런데 받은 템플릿이 pdfLaTeX 기준일 때도 있고, 이 블로그의 최근 레퍼런스 글들 ([수식 글자체](/blog/posts/latex-math-fonts-text-mathrm-mathbf/) · [정리·증명](/blog/posts/latex-theorem-proof-amsthm/) · [siunitx](/blog/posts/latex-siunitx-units-numbers/)) 은 전부 **pdfLaTeX + kotex** 로 한글을 컴파일했습니다.

그래서 같은 원본을 세 엔진으로 직접 돌려 무엇이 같고 무엇이 다른지 정리했습니다. 결과는 전부 MiKTeX 25.12 에서 측정한 것입니다.

| 엔진 | 버전 (MiKTeX 25.12) | kotex 이 부르는 패키지 |
|---|---|---|
| pdfLaTeX | pdfTeX 1.40.28 | `kotexutf` v3.0.0 |
| XeLaTeX | XeTeX 0.999997 | `xetexko` v4.6 |
| LuaLaTeX | LuaHBTeX 1.24.0 | `luatexko` v5.8 |

`\usepackage{kotex}` 한 줄은 엔진을 보고 셋 중 하나를 대신 불러 줍니다 (`kotex` v1.6). 그래서 프리앰블은 같아도 엔진마다 실제로 일하는 패키지가 다릅니다. LaTeX 커널은 2025-11-01.

## 1. kotex 없이 한글을 치면

```latex
\documentclass{article}
\begin{document}
한국어 문장입니다. Korean text.
\end{document}
```

| 엔진 | 결과 |
|---|---|
| pdfLaTeX | **멈춥니다.** `! LaTeX Error: Unicode character 한 (U+D55C) not set up for use with LaTeX.` 가 글자마다 (실측 8개) |
| XeLaTeX | 오류 없이 끝나고 **한글만 빈칸.** 로그에 `Missing character` 8줄 |
| LuaLaTeX | 같음. `Missing character` 24줄 |

pdfLaTeX 는 시끄럽게, Xe·Lua 는 조용히 실패합니다. Xe·Lua 쪽이 더 위험한 이유는 [오류 사전 2편](/blog/posts/latex-document-errors-guide/) 4부에 있습니다 — 컴파일은 "성공" 이라 로그를 열기 전에는 모릅니다. 어느 엔진이든 답은 같습니다. `\usepackage{kotex}`.

## 2. kotex 을 넣으면 — 세 엔진 모두 한글이 나온다

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage{kotex}
\begin{document}
한국어 문장입니다. Korean text.\\
\figurename\ 1, \tablename\ 1, \today\\
수식: $a 여기서 b$ \quad $a \text{ 여기서 } b$\\
\textbf{굵게} \quad \textit{기울임} \quad \textsf{고딕}
\end{document}
```

![같은 원본을 세 엔진으로 컴파일한 결과 — 세 엔진 모두 한글 본문이 나오고, 이름표는 Figure·Table·October 로 영어, 수식 안에 그냥 친 한글은 pdfLaTeX 에서 a0øb 로 깨지고 XeLaTeX 에서 빈칸, LuaLaTeX 에서 ab 로 사라지며, \text 로 감싼 한글은 셋 다 정상. 기울임은 pdfLaTeX 만 기울어진다](/assets/img/posts/2026-10-16/01-three-engines-default.png){: width="720" }

실측 다섯 가지.

1. **한글은 셋 다 나옵니다.** 글꼴 설정 없이도 오류가 없습니다. 기본 글꼴은 엔진마다 다릅니다 — PDF 에 박힌 글꼴을 보면 pdfLaTeX 는 **나눔명조** (`nanummj`, 고딕은 `nanumgt`, 배포판에 든 Type 1 글꼴), XeLaTeX 와 LuaLaTeX 는 **은바탕** (`UnBatang`, 고딕은 `UnDotum`, 역시 배포판에 든 글꼴) 입니다.
2. **이름표와 날짜는 영어로 남습니다.** `\figurename` 은 `Figure`, `\today` 는 `October 7, 2026` — 세 엔진 모두. `kotex` 만으로는 바뀌지 않습니다 (§4).
3. **수식 안에 그냥 친 한글은 세 엔진 모두 실패하고, 실패하는 모양이 다릅니다.** pdfLaTeX 는 `a0øb` 처럼 엉뚱한 글자, XeLaTeX 는 빈칸, LuaLaTeX 는 글자 없이 `ab`. 셋 다 오류가 아니라 `Missing character` 경고입니다. `\text{ 여기서 }` 로 감싸면 셋 다 정상 — [수식 글자체 글](/blog/posts/latex-math-fonts-text-mathrm-mathbf/) §3 의 규칙이 엔진과 무관하다는 뜻입니다.
4. **`\textit` 의 한글은 pdfLaTeX 만 기울어집니다.** pdfLaTeX 는 나눔명조를 기울인 글꼴을 따로 갖고 있고 (`nanummj…-Slant`), Xe·Lua 의 기본 설정에서는 한글이 바로 선 채로 나옵니다. 한글 강조를 기울임으로 할 생각이면 엔진에 따라 결과가 다르다는 것을 알아 두면 됩니다. 한글 강조는 굵게 (`\textbf`) 가 세 엔진에서 같게 나옵니다.
5. **`\textsf` (고딕) 은 셋 다 고딕으로 바뀝니다.** pdfLaTeX 는 나눔고딕, Xe·Lua 는 은돋움.

## 3. 글꼴을 고를 수 있는가 — 여기서 갈린다

엔진 선택이 실제로 결과를 바꾸는 곳은 글꼴입니다.

**XeLaTeX · LuaLaTeX — 시스템 글꼴을 이름으로.** 컴퓨터에 설치된 글꼴을 이름으로 부릅니다. 한글만 따로 정하는 명령도 있습니다.

```latex
\usepackage{kotex}
\setmainhangulfont{NanumGothic}   % 한글 본문 글꼴만
```

실측으로 XeLaTeX·LuaLaTeX 모두 한글은 NanumGothic, 영문은 기본 Latin Modern 으로 나뉘어 들어갑니다. [kotex 세팅 글](/blog/posts/kotex-korean-setup/)의 `\setmainfont{…}` 은 **영문과 한글을 한 글꼴로** 정하는 쪽이고, 실측으로 `\setmainfont{Noto Serif KR}` 하나만 써도 한글까지 그 글꼴로 나옵니다. 한글과 영문을 다른 글꼴로 두고 싶을 때 `\setmainhangulfont` · `\setsanshangulfont` 를 씁니다.

> 글꼴 이름은 **그 컴퓨터에 설치된 글꼴**이어야 합니다. 이 글의 측정은 Windows 에 설치된 NanumGothic 으로 했고, Overleaf 에서 쓸 수 있는 글꼴 목록은 확인하지 않았습니다. 같은 이름이 Overleaf 에서 안 잡히면 오류 사전의 [kotex 글꼴 오류 절](/blog/posts/latex-document-errors-guide/)로.
{: .prompt-info }

**pdfLaTeX — 배포판에 든 글꼴만.** pdfTeX 는 시스템 글꼴을 이름으로 부르는 기능 자체가 없습니다. `\setmainhangulfont` 는 실측으로 `Undefined control sequence` 오류입니다. 한글 글꼴은 배포판이 준비해 둔 것 (MiKTeX 25.12 에서는 나눔명조·나눔고딕) 으로 정해집니다. 받은 템플릿을 그대로 컴파일하는 데는 문제가 없지만, 학교 양식이 "본문은 ○○체" 처럼 특정 글꼴을 요구하면 pdfLaTeX 로는 맞출 수 없습니다.

## 4. 이름표를 한국어로 — [hangul] 옵션

§2 에서 `Figure`·`October` 가 영어로 남았습니다. `kotex` 에 `hangul` 옵션을 주면 바뀝니다.

```latex
\usepackage[hangul]{kotex}
```

![hangul 옵션을 준 결과 — 세 엔진 모두 그림 1, 표 1, 차 례, 2026년 10월 7일 로 바뀌고, XeLaTeX·LuaLaTeX 는 \setmainhangulfont{NanumGothic} 으로 한글 본문이 고딕이 되었으며, pdfLaTeX 는 나눔명조 그대로](/assets/img/posts/2026-10-16/02-hangul-option-font.png){: width="720" }

실측으로 세 엔진 모두 `그림 1`, `표 1`, `차 례`, `2026년 10월 7일` 이 됩니다. (`차 례` 의 사이 띄움도 실측 출력 그대로입니다.) 그림의 Xe·Lua 줄은 §3 의 `\setmainhangulfont{NanumGothic}` 을 함께 준 결과이고, pdfLaTeX 줄은 그 명령 없이 나눔명조 그대로입니다. 이름표를 하나씩 정하고 싶으면 [kotex 세팅 글](/blog/posts/kotex-korean-setup/) §4 의 `\renewcommand{\figurename}{그림}` 이 그대로 통합니다.

## 5. 컴파일 시간

§2 의 원본 (한 쪽) 을 세 번씩 컴파일한 시간입니다.

| 엔진 | 1회 | 2회 | 3회 |
|---|---|---|---|
| pdfLaTeX | 1.1 초 | 1.1 초 | 1.3 초 |
| XeLaTeX | 3.2 초 | 3.6 초 | 3.4 초 |
| LuaLaTeX | 4.3 초 | 4.7 초 | 5.4 초 |

pdfLaTeX 가 세 배쯤 빠릅니다. LuaLaTeX 는 **새 글꼴을 처음 쓸 때 한 번** 글꼴 목록을 만드느라 오래 걸립니다 — 실측으로 `Noto Serif KR` 을 처음 부른 컴파일은 29.5 초, 그다음부터는 위 표 수준이었습니다. 처음 한 번이 느리다고 멈춘 것은 아닙니다.

한 쪽짜리 문서의 숫자라 긴 논문에서는 비율이 달라질 수 있고, Overleaf 의 서버 시간은 재지 않았습니다.

## 6. 그래서 어느 엔진인가

| 상황 | 엔진 |
|---|---|
| 새로 시작하는 한글 논문·보고서 | **XeLaTeX** — 글꼴을 이름으로 고를 수 있다 (§3) |
| 받은 템플릿이 pdfLaTeX 기준 | **pdfLaTeX 그대로** + `\usepackage{kotex}`. 한글은 나온다 (§2). 글꼴 지정이 필요해지면 그때 XeLaTeX |
| 양식이 특정 한글 글꼴을 요구 | XeLaTeX 또는 LuaLaTeX |
| LuaLaTeX 가 꼭 필요한 패키지를 쓴다 | LuaLaTeX. 한글 결과는 XeLaTeX 와 거의 같다 (§2·§3) |

pdfLaTeX 템플릿을 XeLaTeX 로 돌릴 때 걸리는 `\usepackage[utf8]{inputenc}` · `\usepackage[T1]{fontenc}` 두 줄은 실측으로 문제가 되지 않았습니다. `inputenc` 는 Xe·Lua 에서 `inputenc package ignored with utf8 based engines` 경고 한 줄을 남기고 무시되고, `[T1]{fontenc}` 를 함께 둔 원본도 세 엔진 모두 오류 없이 한글이 나왔습니다. Xe·Lua 로 옮겼다면 `inputenc` 줄은 지워도 됩니다.

Overleaf 에서는 왼쪽 위 **Menu** 의 **Compiler** 항목에서 엔진을 고릅니다.

## 정리

| 질문 | 실측 답 (MiKTeX 25.12) |
|---|---|
| pdfLaTeX 로 한글이 되나 | `kotex` 이 있으면 된다. 기본 글꼴 나눔명조 |
| `kotex` 없이 한글을 치면 | pdfLaTeX 는 멈춤, Xe·Lua 는 빈칸 (경고만) |
| 글꼴을 이름으로 고르기 | Xe·Lua 만 (`\setmainfont`, `\setmainhangulfont`) |
| 수식 안 한글 | 세 엔진 모두 `\text{ … }` 필요 |
| 이름표·날짜 한국어 | `\usepackage[hangul]{kotex}` |
| 한글 기울임 | pdfLaTeX 만 기울어진다 |
| 속도 (한 쪽) | pdfLaTeX 약 1 초, XeLaTeX 약 3 초, LuaLaTeX 약 4~5 초 |

"한글은 XeLaTeX 여야 한다" 는 절반만 맞습니다. 한글을 **찍는 것** 은 세 엔진 모두 kotex 하나로 되고, 한글 **글꼴을 고르는 것** 이 XeLaTeX·LuaLaTeX 의 몫입니다.

---

이전 글: [LaTeX 단위와 숫자 — siunitx 로 고치는 다섯 가지](/blog/posts/latex-siunitx-units-numbers/)
함께 보기: [kotex 로 한국어 논문 처음부터 세팅하기](/blog/posts/kotex-korean-setup/) · [LaTeX 오류 메시지 해결 사전 2편](/blog/posts/latex-document-errors-guide/) · [LaTeX 수식 안 글자체 네 가지](/blog/posts/latex-math-fonts-text-mathrm-mathbf/)
