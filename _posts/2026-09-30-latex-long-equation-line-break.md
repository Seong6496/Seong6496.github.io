---
title: "LaTeX 긴 수식 줄바꿈 — multline·split·aligned 언제 무엇을 쓰나"
date: 2026-09-30 09:00:00 +0900
categories: [LaTeX, 수식]
tags: [latex, 줄바꿈, 긴수식, multline, split, aligned, gather, equation, amsmath, 수식]
math: true
pin: false
description: "한 줄에 안 들어가는 LaTeX 수식을 나누는 세 가지 도구 — multline (첫 줄 왼쪽·마지막 줄 오른쪽), equation 안의 split (등호 기준으로 끊고 번호는 하나), aligned (정렬점 여러 개) — 를 언제 무엇을 쓰는지 판단 표와 코드·렌더 비교로 정리합니다. equation 안의 \\\\ 가 왜 아무 일도 안 하는지 실측 결과도 함께."
---

수식이 한 줄에 안 들어갑니다. 전개하다 보니 항이 열 개를 넘었고, 적분 세 겹에 합 세 겹이 붙어 오른쪽 여백을 뚫고 나갑니다. 가장 먼저 해 보는 것은 `equation` 안에 `\\` 를 넣는 일인데 — 아무 일도 일어나지 않습니다. 오류도 없고, 줄도 안 바뀝니다.

[`align` 환경 글](/blog/posts/latex-align-equations/)은 **여러 식**을 등호 기준으로 정렬하는 도구였습니다. 이 글은 그 반대편, **식 하나가 너무 길 때** 어디서 어떻게 끊는지를 다룹니다. 도구는 세 개 — `multline`, `split`, `aligned` — 이고, 어느 것을 고를지는 "끊은 뒤 줄들을 어떻게 놓고 싶은가"와 "번호를 몇 개 붙일 것인가" 두 질문으로 정해집니다.

세 환경 모두 `amsmath` 패키지가 제공합니다. 프리앰블에 이 한 줄이 있어야 합니다.

```latex
\usepackage{amsmath}
```

## 1. 먼저 — equation 안의 두 백슬래시는 무시된다

이 글의 출발점부터 확인합니다. `equation` 안에서 `\\` 를 쓰면 어떻게 되는지.

```latex
\begin{equation}
  (a+b+c)^3 = a^3 + b^3 + c^3 + 3a^2 b + 3a^2 c + 3b^2 a + 3b^2 c + 3c^2 a + 3c^2 b \\
  + 6abc
\end{equation}
```

실측 (MiKTeX 25.12, LaTeX2e 2025-11-01, `amsmath` 로드) 결과는 이렇습니다.

- **컴파일 오류 없음.** 경고도 없습니다.
- **줄이 바뀌지 않습니다.** `\\` 는 조용히 무시되고 식 전체가 한 줄로 조판됩니다.
- 식이 본문 폭보다 길면 로그에 `Overfull \hbox (98.96pt too wide)` 한 줄만 남고, 출력에서는 식이 오른쪽 여백을 넘어가며 번호 (1) 은 다음 줄로 밀려납니다.

`amsmath` 없이 순정 `equation` 으로 컴파일해도 결과는 같습니다 — 무시. 그러니 "오류가 나서 못 쓴다"가 아니라 **"아무 일도 안 일어나니 다른 환경이 필요하다"** 가 정확한 진단입니다. `equation` 은 설계상 한 줄짜리 식을 위한 환경이고, 줄을 끊는 기능 자체가 없습니다.

> **인라인 수식은 사정이 다릅니다.** 문장 속 `$…$` 수식은 TeX 가 `=` 나 `+` 같은 관계·연산 기호 뒤에서 알아서 줄을 끊습니다. 따로 손댈 일이 거의 없습니다. 이 글의 주제는 **디스플레이 수식** 의 줄바꿈입니다.
{: .prompt-info }

## 2. 어느 것을 쓰나 — 판단 표

| 상황 | 환경 | 줄 배치 | 번호 |
|---|---|---|---|
| 긴 식 하나, 등호 없이 항이 계속 이어짐 (긴 합·긴 적분) | `multline` | 첫 줄 왼쪽 · 마지막 줄 오른쪽 · 중간 가운데 | 마지막 줄에 1개 |
| 긴 식 하나, **등호 앞에서** 끊어 유도 과정을 한 식으로 | `equation` + `split` | `&` 자리(등호)로 세로 정렬 | 블록 중앙에 1개 |
| 등호 정렬점이 **두 개 이상** 필요하거나, 문장 속 `$…$` 안에서 | `equation` + `aligned` | `&` 여러 열 정렬 | 블록 중앙에 1개 |
| 짧은 식 여러 개를 정렬 없이 한 줄씩 | `gather` | 각 줄 가운데 | 줄마다 1개 |
| 식 여러 개, 등호 정렬, 줄마다 번호 | `align` | `&` 정렬 | 줄마다 1개 |

마지막 두 줄은 "긴 식 하나"가 아니라 "식 여러 개"의 도구입니다. `align` 은 [이전 글](/blog/posts/latex-align-equations/)에서 다뤘고, `gather` 는 6절에서 짧게 짚습니다.

번호가 기준이 되는 경우가 많습니다. 유도 과정의 **각 줄을 본문에서 따로 부를 일이 있으면** `align`, 결과 하나만 부르면 `split` 또는 `aligned` 입니다.

## 3. multline — 첫 줄 왼쪽, 마지막 줄 오른쪽

등호가 한 번 나오고 그 뒤로 항이 길게 이어지는 식 — 전개식, 긴 합, 여러 겹 적분 — 은 `multline` 이 맞습니다. `\\` 로 끊기만 하면 됩니다. `&` 는 쓰지 않습니다.

```latex
\begin{multline}
  (a+b+c)^3 = a^3 + b^3 + c^3 \\
  + 3a^2 b + 3a^2 c + 3b^2 a + 3b^2 c + 3c^2 a + 3c^2 b \\
  + 6abc
\end{multline}
```

출력:

$$\begin{multline} (a+b+c)^3 = a^3 + b^3 + c^3 \\ + 3a^2 b + 3a^2 c + 3b^2 a + 3b^2 c + 3c^2 a + 3c^2 b \\ + 6abc \end{multline}$$

규칙은 세 줄로 요약됩니다.

- **첫 줄은 왼쪽** 끝에, **마지막 줄은 오른쪽** 끝에 붙습니다. 그 사이 줄은 가운데.
- 수식 번호는 **마지막 줄** 에 붙습니다. `\label` 도 그 번호를 받습니다.
- 왼쪽·오른쪽 끝에서 안쪽으로 조금 들어오는 여백은 `\multlinegap` (기본 10pt) 입니다. `\setlength{\multlinegap}{0pt}` 로 없앨 수 있습니다.

두 줄짜리도 됩니다. 첫 줄 왼쪽, 둘째 줄 오른쪽 — 긴 적분과 그 결과처럼 "좌변 / 우변"이 자연스럽게 갈립니다.

```latex
\begin{multline}
  \int_0^1 \int_0^1 \int_0^1 f(x,y,z)\,dx\,dy\,dz \\
  = \sum_{i=1}^{n} \sum_{j=1}^{n} \sum_{k=1}^{n} w_i w_j w_k\, f(x_i, y_j, z_k)
\end{multline}
```

$$\begin{multline} \int_0^1 \int_0^1 \int_0^1 f(x,y,z)\,dx\,dy\,dz \\ = \sum_{i=1}^{n} \sum_{j=1}^{n} \sum_{k=1}^{n} w_i w_j w_k\, f(x_i, y_j, z_k) \end{multline}$$

### 3.1 중간 줄을 왼쪽·오른쪽으로 — shoveleft, shoveright

중간 줄은 가운데가 기본이지만, 특정 줄만 밀어 붙일 수 있습니다. 줄 내용 전체를 `\shoveleft{…}` 또는 `\shoveright{…}` 로 감쌉니다.

```latex
\begin{multline*}
  f(x) = a_0 + a_1 x + a_2 x^2 \\
  \shoveleft{+ a_3 x^3 + a_4 x^4} \\
  \shoveright{+ a_5 x^5 + a_6 x^6} \\
  + a_7 x^7
\end{multline*}
```

실측: 둘째 줄이 왼쪽 끝, 셋째 줄이 오른쪽 끝에 붙고, 첫 줄과 마지막 줄은 원래 규칙대로입니다. `multline*` 은 번호 없는 판본입니다 — 별표 규칙은 다른 환경과 같습니다.

### 3.2 multline 이 안 맞는 경우

등호가 **여러 번** 나오는 유도 과정에는 `multline` 이 어색합니다. 줄마다 등호 위치가 제각각이라 눈이 등호를 찾아다녀야 합니다. 그때는 다음 절의 `split` 입니다.

## 4. split — 등호 기준으로 끊고 번호는 하나

"유도 과정을 보여 주되, 본문에서는 결과 하나만 참조한다"면 `equation` 안에 `split` 을 넣습니다. `align` 처럼 `&` 로 정렬점을 잡고 `\\` 로 줄을 끊지만, **번호는 블록 전체에 하나** 만 붙습니다.

```latex
\begin{equation}
  \begin{split}
    (a+b)^3 &= (a+b)(a+b)(a+b) \\
            &= (a^2 + 2ab + b^2)(a+b) \\
            &= a^3 + 3a^2 b + 3ab^2 + b^3
  \end{split}
\end{equation}
```

출력:

$$\begin{split} (a+b)^3 &= (a+b)(a+b)(a+b) \\ &= (a^2 + 2ab + b^2)(a+b) \\ &= a^3 + 3a^2 b + 3ab^2 + b^3 \end{split}$$

실측에서 번호는 세 줄의 **세로 중앙** 에 하나만 놓입니다. `align` 이었다면 줄마다 하나씩 세 개가 붙었을 자리입니다.

`split` 에는 제약이 둘 있습니다.

1. **단독으로 못 씁니다.** `equation` (또는 `gather` 등 바깥 수식 환경) 안에서만 동작합니다. 밖에 그냥 쓰면 이 오류가 납니다.

   ```
   ! Package amsmath Error: \begin{split} won't work here.
   ```

2. **정렬점은 한 줄에 하나.** `&` 를 한 줄에 두 개 이상 넣으면 이 오류가 납니다.

   ```
   ! Extra alignment tab has been changed to \cr.
   ```

   두 열 이상 정렬하려면 다음 절의 `aligned` 입니다.

번호를 빼려면 바깥을 `equation*` 로 바꾸거나, `\end{split}` 뒤에 `\notag` 를 둡니다 — 실측으로 둘 다 블록 전체의 번호가 사라집니다. `\label` 은 `equation` 바로 뒤에 두어도, `split` 안의 어느 줄에 두어도 같은 번호 하나를 받습니다 (실측 — `\eqref` 결과 동일).

## 5. aligned — 정렬점 여러 개, 문장 속에서도

`aligned` 는 `align` 의 **내부 환경** 판본입니다. `align` 이 하는 정렬을 그대로 하면서, 자기가 디스플레이를 열지 않고 바깥 환경에 얹힙니다. 그래서 `equation` 안에 들어가 번호를 하나만 받고, `$…$` 안에도 들어갑니다.

`split` 과 다른 점은 **정렬점을 여러 개** 둘 수 있다는 것입니다. `&` 가 홀수 번째는 정렬점, 짝수 번째는 열 구분 — [`align` 의 규칙](/blog/posts/latex-align-equations/)과 같습니다.

```latex
\begin{equation}
  \begin{aligned}
    x &= r\cos\theta, & y &= r\sin\theta \\
    u &= \rho\cos\phi, & v &= \rho\sin\phi
  \end{aligned}
\end{equation}
```

출력:

$$\begin{aligned} x &= r\cos\theta, & y &= r\sin\theta \\ u &= \rho\cos\phi, & v &= \rho\sin\phi \end{aligned}$$

같은 코드를 `split` 으로 바꾸면 4절의 `Extra alignment tab` 오류가 납니다. 반대로 정렬점이 하나뿐이라면 `split` 과 `aligned` 는 출력이 사실상 같습니다 — 어느 쪽을 써도 됩니다. 관례로는 "한 식을 등호에서 끊은 것"은 `split`, "여러 열을 정렬한 것"은 `aligned` 로 나눕니다.

### 5.1 align 을 equation 안에 넣으면 안 되는 이유

`aligned` 대신 `align` 을 `equation` 안에 넣는 실수가 잦습니다. `align` 은 스스로 디스플레이를 여는 환경이라 중첩이 됩니다. 오류 메시지가 답을 직접 알려 줍니다.

```
! Package amsmath Error: Erroneous nesting of equation structures;
(amsmath)                trying to recover with `aligned'.
```

"`aligned` 로 복구해 보겠다"는 말 그대로, 이 자리에는 `aligned` 를 써야 합니다.

### 5.2 문장 속 aligned

```latex
치환하면 $\begin{aligned} a &= b \\ c &= d \end{aligned}$ 가 되고, ...
```

문장 속에 두 줄짜리 블록이 들어갑니다. 자주 쓸 일은 없지만, `split` 은 이 자리에서 동작하지 않고 `aligned` 는 동작한다는 것이 둘의 차이를 가장 잘 보여 줍니다. 위·아래 정렬 기준은 `\begin{aligned}[t]` / `[b]` 로 바꿀 수 있습니다.

## 6. gather·gathered — 정렬 없이 가운데 줄 세우기

끊어야 할 만큼 길지는 않은데 식이 두세 개 연달아 나오고, 등호를 맞출 이유도 없다면 `gather` 입니다. 각 줄이 **가운데 정렬** 되고 줄마다 번호가 붙습니다.

```latex
\begin{gather}
  a = b \\
  c = d + e + f
\end{gather}
```

$$\begin{gather} a = b \\ c = d + e + f \end{gather}$$

번호를 하나만 원하면 `equation` 안에 `gathered` 를 넣습니다 — `align` ↔ `aligned` 와 같은 관계입니다. 실측으로 `equation` + `gathered` 는 두 줄 가운데 정렬에 번호 하나가 블록 중앙에 붙습니다.

## 7. 자주 하는 실수

| 증상 | 원인 | 고치기 |
|---|---|---|
| `\\` 를 넣었는데 줄이 안 바뀜, 오류도 없음 | `equation` 은 줄바꿈 기능이 없음 (1절) | `multline` 또는 `equation` + `split` |
| `\begin{split} won't work here.` | `split` 을 바깥 환경 없이 단독 사용 | `equation` 으로 감싸기 |
| `Extra alignment tab has been changed to \cr.` | `split` 한 줄에 `&` 두 개 | `aligned` 로 교체 |
| `Erroneous nesting of equation structures` | `equation` 안에 `align` | `aligned` 로 교체 |
| `Missing $ inserted` | 수식 환경 안의 **빈 줄** | 빈 줄 제거 — [수식 오류 가이드](/blog/posts/latex-math-errors-guide/) 오류 1 |

빈 줄 문제는 이 글의 네 환경 모두에 해당합니다. 줄을 끊는 것은 `\\` 이지 빈 줄이 아닙니다.

## 8. 번호와 참조

- `multline` 의 `\label` 은 마지막 줄 번호를 받습니다. `\eqref{eq:m}` 으로 부르면 그 번호가 나옵니다 (실측).
- `equation` + `split` / `aligned` / `gathered` 는 번호가 하나이므로 `\label` 도 하나입니다.
- 줄마다 번호가 필요하면 애초에 `align` 또는 `gather` 로 가고, 그중 일부만 빼려면 `\notag` 입니다 — [수식 번호와 참조 글](/blog/posts/latex-equation-labels-eqref/)의 6절에 정리돼 있습니다.

## 정리

| 하고 싶은 것 | 코드 |
|---|---|
| 긴 식 하나를 그냥 끊기 | `\begin{multline} … \\ … \end{multline}` |
| 그중 특정 줄을 왼쪽·오른쪽으로 | `\shoveleft{…}` / `\shoveright{…}` |
| 등호에서 끊고 번호는 하나 | `\begin{equation}\begin{split} … &= … \\ &= … \end{split}\end{equation}` |
| 정렬점 여러 열, 번호 하나 | `\begin{equation}\begin{aligned} … & … & … \end{aligned}\end{equation}` |
| 문장 속 여러 줄 | `$\begin{aligned} … \end{aligned}$` |
| 정렬 없이 가운데, 줄마다 번호 | `\begin{gather} … \end{gather}` |
| 정렬 없이 가운데, 번호 하나 | `\begin{equation}\begin{gathered} … \end{gathered}\end{equation}` |
| 번호 없이 | `multline*` · `equation*` · `gather*` |

고르는 순서는 이렇습니다. 등호가 한 번이면 `multline`, 등호마다 끊고 싶으면 `split`, 정렬점이 둘 이상이거나 문장 속이면 `aligned`. 그리고 어느 쪽이든 `equation` 안의 `\\` 는 아무것도 하지 않는다는 것만 기억하면, 로그에 아무 말이 없는데 식이 여백을 넘어가는 이유는 더 이상 수수께끼가 아닙니다.

`amsmath` 에는 줄을 **자동으로** 끊어 주는 기능이 없습니다. 자동 줄바꿈은 별도 패키지 (`breqn`) 의 영역이고, 이 글의 범위 밖입니다.

---

이전 글: [LaTeX align 환경으로 수식 정렬하기 — 등호 기준 정렬과 번호 제어](/blog/posts/latex-align-equations/)
함께 보기: [LaTeX 수식 번호와 참조 — label 과 eqref](/blog/posts/latex-equation-labels-eqref/) · [LaTeX 수식 오류·실수 완전 해결 가이드](/blog/posts/latex-math-errors-guide/)
