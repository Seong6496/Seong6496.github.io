---
title: "LaTeX 정리·증명 환경 — amsthm \\newtheorem 과 번호 체계, \\qedhere 까지"
date: 2026-10-10 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, amsthm, newtheorem, theorem, proof, qedhere, theoremstyle, 정리, 증명, 번호, kotex]
math: true
pin: false
description: "과제·논문에 '정리 1.2' 와 '증명. □' 를 넣는 법을 실측으로 정리합니다. \\newtheorem{theorem}{Theorem}[section] 한 줄의 문법, 정리·보조정리·따름정리가 한 카운터를 공유하게 하는 법, plain·definition·remark 세 스타일의 차이, proof 환경과 디스플레이 수식으로 끝나는 증명의 \\qedhere, 그리고 한글 제목에서 '증명' 뒤 마침표가 사라지는 이유와 해법."
---

과제나 논문에 "정리 1.2" 를 쓰고 그 아래 "증명." 으로 시작해 □ 로 끝내고 싶습니다. `\textbf{정리 1.}` 이라고 손으로 치면 다음 정리에서 번호를 또 손으로 세야 하고, 정리 앞에 하나를 끼워 넣는 순간 뒤 번호가 전부 틀립니다. 이 일을 대신하는 것이 `amsthm` 이고, 배울 것은 명령 세 개 — `\newtheorem`, `\theoremstyle`, `proof` — 와 번호 체계 하나입니다. 아래 결과는 전부 MiKTeX 25.12 (pdfTeX, LaTeX2e 2025-11-01, `amsmath` + `amsthm` + `kotex`) 로 컴파일해 확인한 것입니다.

## 1. 먼저 — amsthm 없이도 정리는 되지만, 증명은 안 된다

`\newtheorem` 은 LaTeX 자체에 있습니다. 그래서 `amsthm` 없이도 정리 환경을 만들 수 있습니다. 없는 것은 셋입니다 — `proof` 환경, `\theoremstyle`, `\qedhere`. 실측으로 `amsthm` 을 빼고 `\begin{proof}` 를 쓰면 이 오류가 납니다.

```
! LaTeX Error: Environment proof undefined.
```

그러니 시작은 프리앰블 한 줄입니다. `amsmath` **뒤에** 둡니다.

```latex
\usepackage{amsmath, amssymb}
\usepackage{amsthm}
```

## 2. 어느 것을 쓰나 — 판단 표

| 하고 싶은 것 | 프리앰블에 쓰는 것 |
|---|---|
| 번호 붙는 정리 | `\newtheorem{theorem}{Theorem}` |
| 절 번호에 종속 (정리 2.1, 2.2, 3.1 …) | `\newtheorem{theorem}{Theorem}[section]` |
| 보조정리·따름정리가 정리와 **한 번호열** | `\newtheorem{lemma}[theorem]{Lemma}` |
| 번호 없는 정리 | `\newtheorem*{theorem*}{Theorem}` |
| 정의·예제 (본문을 세워서) | `\theoremstyle{definition}` 뒤에 `\newtheorem{definition}{Definition}` |
| 참고·주의 (제목을 기울여서) | `\theoremstyle{remark}` 뒤에 `\newtheorem{remark}{Remark}` |
| 증명 | `\begin{proof} … \end{proof}` — 선언 불필요 |
| 한글 제목 | `\newtheorem{thm}{정리}[section]`, 증명은 `\renewcommand{\proofname}{\mbox{증명}}` (§7) |

## 3. \newtheorem 한 줄의 문법

```latex
\newtheorem{환경이름}{표시이름}
\newtheorem{환경이름}{표시이름}[상위카운터]     % 상위 번호에 종속
\newtheorem{환경이름}[공유카운터]{표시이름}     % 다른 환경과 번호를 공유
```

첫 인자는 코드에서 부를 이름 (`\begin{theorem}`), 둘째는 출력에 찍히는 이름 (`Theorem`). 대괄호는 두 자리인데 **위치가 다르고 의미도 다릅니다.** 표시이름 **뒤의** `[section]` 은 "절 번호 아래에 매긴다", 표시이름 **앞의** `[theorem]` 은 "`theorem` 과 같은 카운터를 쓴다" 입니다. 둘을 한 줄에 다 쓸 수는 없습니다 — 실측으로 `\newtheorem{lemma}[theorem]{Lemma}[section]` 은 `! LaTeX Error: Missing \begin{document}.` 라는 엉뚱한 오류를 냅니다 (뒤의 `[section]` 이 본문 글자로 취급됩니다). 공유하는 쪽은 상위 카운터를 원본에서 물려받으므로 앞의 대괄호 하나면 충분합니다.

본문에서는 선택 인자로 정리 이름을 붙입니다.

```latex
\begin{theorem}[Pythagoras]
  In a right triangle with legs $a$, $b$ and hypotenuse $c$, we have $a^2 + b^2 = c^2$.
\end{theorem}
```

출력은 `Theorem 1 (Pythagoras).` 로 시작합니다 (§5 그림).

## 4. 번호 체계 — 독립 · 절 종속 · 공유

세 가지를 한 문서에서 실측한 결과입니다.

```latex
% A: 독립 카운터
\newtheorem{thmA}{Theorem}
\newtheorem{lemA}{Lemma}
% B: 절 종속 + 보조정리·따름정리가 정리 카운터를 공유
\newtheorem{thmB}{Theorem}[section]
\newtheorem{lemB}[thmB]{Lemma}
\newtheorem{corB}[thmB]{Corollary}
```

![세 절에 걸친 정리 번호 실측 — 1절은 Theorem 1, Lemma 1, Theorem 2 (독립), 2절은 Theorem 2.1, Lemma 2.2, Corollary 2.3 (절 종속·공유), 3절에서 Theorem 3.1 로 초기화되고 본문에서 ref 로 3.1 을 부른다](/assets/img/posts/2026-10-10/02-numbering-schemes.png){: width="720" }
_A 는 정리와 보조정리가 각자 1 부터 세고, B 는 `2.1 → 2.2 → 2.3` 한 줄로 이어지다 다음 절에서 `3.1` 로 돌아간다._

- **독립 (A)**: `Theorem 1`, `Lemma 1`, `Theorem 2`. 정리와 보조정리가 각자 셉니다. "Lemma 1 이 Theorem 1 앞인가 뒤인가" 를 번호로 알 수 없습니다.
- **절 종속 + 공유 (B)**: `Theorem 2.1`, `Lemma 2.2`, `Corollary 2.3`. 한 절 안에서 정리·보조정리·따름정리가 **등장 순서대로 한 번호열** 을 이루고, 다음 절에서 `3.1` 로 초기화됩니다. 수학 논문과 교재 대부분이 이 방식입니다 — 독자가 "Lemma 2.2" 를 찾을 때 2절의 두 번째 결과로 바로 갑니다.
- `\label{thm:main}` 을 환경 안에 두고 `Theorem~\ref{thm:main}` 으로 부르면 `3.1` 이 나옵니다. 그림 마지막 줄. [수식 번호와 `\eqref`](/blog/posts/latex-equation-labels-eqref/) 와 같은 카운터 원리이고, `[section]` 옵션이 `equation` 카운터의 `\numberwithin{equation}{section}` 에 해당합니다.

## 5. 세 가지 스타일 — plain · definition · remark

`\theoremstyle{…}` 을 선언하면 **그 뒤에 오는** `\newtheorem` 들이 그 스타일을 받습니다. 앞에 이미 선언한 환경은 바뀌지 않습니다 (실측 — `\theoremstyle{remark}` 를 나중에 써도 먼저 만든 `theorem` 은 plain 그대로).

```latex
\theoremstyle{plain}        % 굵은 제목, 이탤릭 본문 — 기본값
\newtheorem{theorem}{Theorem}
\theoremstyle{definition}   % 굵은 제목, 정체 본문
\newtheorem{definition}{Definition}
\theoremstyle{remark}       % 이탤릭 제목, 정체 본문
\newtheorem{remark}{Remark}
```

![세 스타일과 증명 실측 — Theorem 1 (Pythagoras) 은 굵은 제목에 이탤릭 본문, Definition 1 은 굵은 제목에 정체 본문, Remark 1 은 이탤릭 제목에 정체 본문, Proof 는 이탤릭 제목으로 시작해 오른쪽 끝 네모로 끝난다](/assets/img/posts/2026-10-10/01-theorem-styles.png){: width="720" }
_plain 은 본문까지 기울고, definition 은 본문이 서고, remark 는 제목이 기운다. 마지막 줄이 `proof` 환경._

관례는 이렇습니다. 정리·보조정리·따름정리·명제 = **plain** (주장이므로 본문을 기울여 강조), 정의·예제·문제 = **definition** (읽는 글이므로 본문을 세움), 참고·주의·표기 = **remark** (제목만 살짝). 세 스타일이 기본으로 들어 있고, 굳이 바꿀 일은 §7 의 한글 본문 정도입니다.

## 6. proof 환경과 \qedhere

`\begin{proof} … \end{proof}` 는 이탤릭 `Proof.` 로 시작하고 오른쪽 끝에 □ 를 놓습니다. 선언이 필요 없고, 번호도 없습니다. 제목을 바꾸려면 선택 인자 — `\begin{proof}[Proof of Theorem 1]`.

문제는 증명이 **디스플레이 수식으로 끝날 때** 입니다. □ 는 "마지막 문단의 끝" 에 붙는데, 디스플레이 수식 뒤에는 빈 문단이 하나 더 생겨 □ 가 **혼자 다음 줄로 떨어집니다.** 그때 수식 안에 `\qedhere` 를 둡니다.

```latex
\begin{proof}
  $L$ 과 $L'$ 이 모두 극한이라 하자. 임의의 $\varepsilon > 0$ 에 대해 충분히 큰 $n$ 에서
  \[
    |L - L'| \le |L - a_n| + |a_n - L'| < 2\varepsilon. \qedhere
  \]
\end{proof}
```

![한글 정의·정리·증명 실측 — 정의 2.1, 정리 2.2 (유일성), 그리고 qedhere 를 쓴 증명은 수식 줄 오른쪽 끝에 네모가 붙고, 쓰지 않은 증명은 네모가 수식 아래 빈 줄로 떨어진다](/assets/img/posts/2026-10-10/03-korean-qedhere.png){: width="720" }
_위 증명은 `\qedhere` 로 □ 가 수식 줄에 붙었고, 아래 증명은 같은 수식인데 □ 가 한 줄 아래로 떨어졌다._

`align` 안에서도 마지막 줄에 `\qedhere` 를 두면 됩니다. 다만 그 줄에 번호가 붙는 환경이면 실측으로 **번호 자리에 □ 가 들어가고 그 줄의 번호는 사라집니다** — 번호가 필요한 줄이면 `align*` 로 바꾸거나 `\qedhere` 를 문장 쪽으로 옮깁니다.

□ 를 ■ 로 바꾸려면 `\renewcommand{\qedsymbol}{$\blacksquare$}` 입니다.

## 7. 한글 제목 — 되는 것과 실측으로 걸리는 것 두 가지

[kotex 문서](/blog/posts/kotex-korean-setup/)라면 표시이름에 한글을 그대로 씁니다.

```latex
\newtheorem{thm}{정리}[section]
\newtheorem{lem}[thm]{보조정리}
\theoremstyle{definition}
\newtheorem{defn}[thm]{정의}
\renewcommand{\proofname}{\mbox{증명}}
```

`정리 2.2 (유일성).` `정의 2.1.` 은 그대로 나옵니다 (§6 그림). 걸리는 것은 둘입니다.

**증명 뒤 마침표가 사라진다.** `\renewcommand{\proofname}{증명}` 이라고만 쓰면 실측으로 `증명 L 과 L′ 이 …` 처럼 **마침표 없이** 시작합니다. `amsthm` 은 제목 마지막 글자 뒤에 마침표를 "필요하면" 붙이는데, 한글 글자 뒤에서는 이미 문장 부호가 있다고 판단해 건너뜁니다. `증명.` 이라고 쓰면 이번엔 `증명..` 이 됩니다. 실측으로 통하는 것은 **`\mbox{증명}`** 으로 감싸는 것 — 상자 뒤에서는 판단이 초기화돼 `증명.` 이 정확히 한 번 나옵니다. 정리 제목 쪽 (`정리 2.2.`) 은 번호가 뒤에 오므로 이 문제가 없습니다.

**plain 스타일의 한글 본문이 기울어진다.** plain 은 본문을 이탤릭으로 조판하고, 한글 글꼴에는 이탤릭이 없어 kotex 가 글자를 억지로 기울입니다 (§6 그림의 정리 본문). 읽기 싫으면 본문 글꼴만 정체로 바꾼 스타일을 하나 만듭니다.

```latex
\newtheoremstyle{kplain}{}{}{\normalfont}{}{\bfseries}{.}{ }{}
\theoremstyle{kplain}
\newtheorem{thm}{정리}[section]
```

실측으로 제목은 굵게, 본문은 세워서 나옵니다. 인자 아홉 개 중 셋째 (`\normalfont`, 본문 글꼴) 와 다섯째 (`\bfseries`, 제목 글꼴) 만 채웠고 나머지는 기본값입니다.

## 8. 자주 하는 실수

- **`\begin{proof}` 에서 `Environment proof undefined`** → `\usepackage{amsthm}` 이 없다 (§1).
- **`\theoremstyle` 을 썼는데 안 바뀐다** → `\newtheorem` 보다 **앞에** 있어야 한다 (§5).
- **`[theorem]` 과 `[section]` 을 한 줄에** → `Missing \begin{document}` 오류. 공유하는 쪽은 앞 대괄호 하나만 (§3).
- **□ 가 수식 아래 빈 줄에 혼자** → 수식 안에 `\qedhere` (§6).
- **`증명` 뒤 마침표 없음** → `\renewcommand{\proofname}{\mbox{증명}}` (§7).
- **Lemma 1 이 Theorem 1 뒤인지 앞인지 모르겠다** → 카운터를 공유시킨다 `\newtheorem{lemma}[theorem]{Lemma}` (§4).
- **정리를 참조했더니 `??`** → `\label` 은 `\begin{theorem}` **안에**, 그리고 두 번 컴파일 ([수식 번호 글](/blog/posts/latex-equation-labels-eqref/)과 같은 규칙).

## 정리

| 하고 싶은 것 | 코드 |
|---|---|
| 정리 (절 번호 아래) | `\newtheorem{theorem}{Theorem}[section]` |
| 보조정리·따름정리를 같은 번호열에 | `\newtheorem{lemma}[theorem]{Lemma}` |
| 번호 없이 | `\newtheorem*{theorem*}{Theorem}` |
| 정의 (본문 세움) | `\theoremstyle{definition}` → `\newtheorem{definition}{Definition}` |
| 참고 (제목 기울임) | `\theoremstyle{remark}` → `\newtheorem{remark}{Remark}` |
| 이름 붙은 정리 | `\begin{theorem}[Pythagoras]` |
| 증명 | `\begin{proof} … \end{proof}` |
| 수식으로 끝나는 증명 | 수식 안 마지막에 `\qedhere` |
| 증명 제목 바꾸기 | `\begin{proof}[Proof of Theorem 1]` / `\renewcommand{\proofname}{\mbox{증명}}` |
| ■ 로 | `\renewcommand{\qedsymbol}{$\blacksquare$}` |
| 한글 본문을 세워서 | `\newtheoremstyle{kplain}{}{}{\normalfont}{}{\bfseries}{.}{ }{}` |

선언은 프리앰블에 한 번, 스타일은 `\newtheorem` 앞에, 카운터는 정리 하나에 몰아 주고, 증명이 수식으로 끝나면 `\qedhere`. 이 넷이면 정리 번호를 손으로 셀 일이 없습니다.

---

이전 글: [LaTeX 수식 안 글자체 네 가지 — 이탤릭이 아닌 것은 전부 이유가 있다](/blog/posts/latex-math-fonts-text-mathrm-mathbf/)
함께 보기: [LaTeX 문서의 뼈대 — 빈 파일에서 논문 구조까지](/blog/posts/latex-document-skeleton/) · [LaTeX 수식 번호와 참조 — label 과 eqref](/blog/posts/latex-equation-labels-eqref/) · [LaTeX 문서 완성도 패키지 — hyperref·geometry·listings](/blog/posts/latex-essential-packages/)
