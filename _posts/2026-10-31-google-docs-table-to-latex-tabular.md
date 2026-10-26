---
title: "구글 문서 표를 LaTeX 표(tabular)로 바꾸기"
date: 2026-10-31 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, google-docs, latex, 표, tabular, multicolumn, multirow, booktabs, overleaf]
math: false
pin: false
description: "구글 문서에서 만든 성적표·실험 데이터 표를 칸마다 & 를 손으로 치지 않고 LaTeX tabular 로 옮깁니다. 병합한 칸은 \\multicolumn 으로, 표 안 수식은 그대로 나오고, 세로 병합·가운데 정렬·학술지 스타일 선(booktabs)·표 번호는 몇 줄로 채웁니다. 내보낸 그대로와 고친 뒤를 컴파일해 비교합니다."
---

LaTeX 에서 표를 손으로 짜 본 분은 압니다. 칸마다 `&`, 줄마다 `\\`, 줄 사이에 `\hline` — 열이 다섯 개, 줄이 스무 개만 되어도 한참 걸리고, 칸 하나를 빠뜨리면 컴파일이 멈춥니다. 표는 구글 문서에서 만드는 편이 훨씬 빠릅니다. 칸을 늘리고 합치고 숫자를 붙여넣는 데 몇 분이면 되니까요.

그렇게 만든 표를 **LaTeX 표(tabular)** 로 옮기는 방법입니다. 구글 문서 애드온 **LaTeXFlow** 의 **LaTeX file** 탭에 있는 **Convert to LaTeX** 를 씁니다. 이 기능은 라이선스 키가 있어야 열립니다.

## 1. 예시 표

반별 성적 요약 표와, 계산에 쓴 식을 정리한 표 두 개입니다.

- 첫 번째 표: 머리글 칸을 합쳤습니다. "중간고사"·"기말고사" 는 두 칸을 가로로 합쳤고, "반" 은 두 줄을 세로로 합쳤습니다. 머리글은 굵게 했습니다.
- 두 번째 표: 칸 안에 수식이 있고, 한 칸에는 줄을 바꿔 두 줄로 적었습니다.

<!-- TODO image (web pane, mathfolis.support): a Google Doc with the two example tables — table 1 header: "반" merged over 2 rows, "중간고사"/"기말고사" each merged over 2 columns, sub-header 평균/표준편차, rows 1반 72.4 11.3 75.1 10.8 / 2반 69.8 12.6 73.0 11.9; table 2: 지표|식|비고 with x-bar and sigma equations and a cell "단위: 점" + line break + "(100점 만점)". File: /assets/img/posts/2026-10-31/table-00-in-google-docs.png -->

## 2. 표만 내보내기

문서 전체가 아니라 표 하나만 필요하다면, 표 안의 칸을 몇 개(또는 표 전체를) 드래그해 선택하고, 사이드바에서 **Selection** 을 고른 뒤 **Convert to LaTeX** 를 누릅니다. 선택이 걸친 표는 **표 전체** 가 나옵니다. 칸 몇 개만 잘라 나오지는 않습니다.

문서 전체를 내보내려면 **Full document** 를 그대로 두면 됩니다. 결과는 **Copy .tex** 로 복사해 이미 쓰고 있는 `.tex` 에 붙여넣거나, **Download .tex** · **Open in Overleaf** 로 받습니다.

<!-- TODO image (web pane, mathfolis.support): sidebar after Convert to LaTeX with Selection on table 1 — result line with "1 table", the warning "Table 1 has merged cells or uneven rows — columns may need adjusting", Copy .tex button. File: /assets/img/posts/2026-10-31/table-03-sidebar.png -->

## 3. 나온 LaTeX

첫 번째 표는 이렇게 나옵니다.

```latex
\begin{center}
\begin{tabular}{|l|l|l|l|l|}
\hline
\textbf{반} & \multicolumn{2}{l|}{\textbf{중간고사}} & \multicolumn{2}{l|}{\textbf{기말고사}} \\
\hline
 & 평균 & 표준편차 & 평균 & 표준편차 \\
\hline
1반 & 72.4 & 11.3 & 75.1 & 10.8 \\
\hline
2반 & 69.8 & 12.6 & 73.0 & 11.9 \\
\hline
\end{tabular}
\end{center}
```

- **가로로 합친 칸** 은 `\multicolumn{2}{l|}{…}` 이 됩니다. 칸 수가 맞으니 그대로 컴파일됩니다.
- **세로로 합친 칸**("반")은 첫 줄에만 글자가 나오고, 사이드바와 파일 머리의 경고 목록에 "Table 1 has merged cells or uneven rows" 가 한 줄 붙습니다. `\multirow` 는 쓰지 않으므로 4절에서 한 줄로 채웁니다.
- **굵은 글씨** 는 `\textbf` 가 됩니다.
- 모든 열이 왼쪽 정렬 `l`, 줄마다 `\hline`, 표 전체는 가운데(`center`)입니다.

두 번째 표입니다.

```latex
\begin{tabular}{|l|l|l|}
\hline
\textbf{지표} & \textbf{식} & \textbf{비고} \\
\hline
평균 & $\bar{x} = \frac{1}{n}\sum_{i=1}^{n} x_i$ & 단위: 점 (100점 만점) \\
\hline
표준편차 & $\sigma = \sqrt{\frac{1}{n}\sum_{i=1}^{n} (x_i - \bar{x})^2}$ & $n$ 은 학생 수 \\
\hline
\end{tabular}
```

- **칸 안 수식** 은 `$…$` 로 나옵니다. 구글 문서 수식 편집기로 넣었든, `$…$` 사이에 LaTeX 를 글자로 쳤든, LaTeXFlow 로 바꾼 수식 그림이든 같습니다. 칸 안에서는 디스플레이 수식도 문장 안 수식(`$…$`)으로 씁니다.
- **칸 안 줄바꿈** 은 띄어쓰기 한 칸이 됩니다. "단위: 점 (100점 만점)".

받은 그대로 pdfLaTeX 로 컴파일하면 이렇습니다.

![내보낸 그대로 컴파일한 PDF: 첫 번째 표는 왼쪽 정렬, 머리글 반 아래 빈 칸, 중간고사·기말고사가 두 칸에 걸침. 두 번째 표는 칸 안에 작은 크기의 평균과 표준편차 식](/assets/img/posts/2026-10-31/table-01-exported.png){: width="480" }

## 4. 몇 줄로 다듬기

여기서부터는 LaTeX 쪽 취향입니다. 각각 한두 줄이고, 아래 결과는 모두 실제로 컴파일한 것입니다.

**세로 병합.** 머리말에 `\usepackage{multirow}` 를 넣고, 첫 칸을 `\multirow` 로 바꾼 뒤, 두 줄 사이 선을 "반" 열만 빼고 긋습니다.

```latex
\multirow{2}{*}{\textbf{반}} & \multicolumn{2}{c|}{\textbf{중간고사}} & \multicolumn{2}{c|}{\textbf{기말고사}} \\
\cline{2-5}
 & 평균 & 표준편차 & 평균 & 표준편차 \\
```

**가운데 정렬.** 열 지정의 `l` 을 `c`(가운데)나 `r`(오른쪽)로 바꿉니다. 숫자 열은 `c` 나 `r` 가 읽기 좋습니다.

```latex
\begin{tabular}{|c|c|c|c|c|}
```

**표 번호와 제목.** `center` 를 `table` 로 바꾸고 `\caption` 을 넣으면 "Table 1: …" 이 붙고, 본문에서 `\ref` 로 가리킬 수 있습니다.

```latex
\begin{table}[h]
\centering
\caption{반별 성적}
\begin{tabular}{|c|c|c|c|c|}
...
\end{tabular}
\end{table}
```

**학술지 스타일 선.** 세로선을 빼고 `booktabs` 의 가로선 세 개만 쓰면 논문에서 흔히 보는 모양이 됩니다. 머리말에 `\usepackage{booktabs}`.

```latex
\begin{tabular}{lll}
\toprule
\textbf{지표} & \textbf{식} & \textbf{비고} \\
\midrule
평균 & $\displaystyle \bar{x} = \frac{1}{n}\sum_{i=1}^{n} x_i$ & 단위: 점 (100점 만점) \\
표준편차 & $\displaystyle \sigma = \sqrt{\frac{1}{n}\sum_{i=1}^{n} (x_i - \bar{x})^2}$ & $n$ 은 학생 수 \\
\bottomrule
\end{tabular}
```

칸 안 수식을 디스플레이 크기로 보이고 싶으면 위처럼 `$\displaystyle …$` 로 씁니다.

네 가지를 넣은 결과입니다.

![고친 뒤 컴파일한 PDF: 첫 번째 표는 Table 1: 반별 성적 제목이 붙고, 반이 두 줄에 걸쳐 가운데, 숫자가 가운데 정렬. 두 번째 표는 세로선 없이 위·가운데·아래 가로선만 있고 식이 디스플레이 크기](/assets/img/posts/2026-10-31/table-02-after-fixes.png){: width="480" }

**표가 쪽 너비보다 넓을 때.** 열이 많은 표는 오른쪽 여백 밖으로 넘칠 수 있습니다. `tabular` 를 `\resizebox{\linewidth}{!}{…}` 로 감싸면 쪽 너비에 맞게 줄어듭니다. 필요한 `graphicx` 는 내보낸 파일에 이미 들어 있습니다.

```latex
\resizebox{\linewidth}{!}{
\begin{tabular}{|l|l|l|l|l|}
...
\end{tabular}}
```

## 5. 옮기지 않는 것

**칸 색, 테두리 두께와 색, 열 너비** 는 옮기지 않습니다. LaTeX 에서는 위처럼 열 지정과 선 명령이 정하는 부분입니다. 칸 색이 꼭 필요하면 `\usepackage[table]{xcolor}` 를 넣고 `\cellcolor{gray!15}` 를 칸 앞에 씁니다. 표 안에 또 표를 넣은 경우는 안쪽 표의 칸이 바깥 칸 하나로 합쳐지고 경고가 붙습니다.

정리하면, 표의 칸·병합·굵은 글씨·수식은 구글 문서에서 만든 그대로 `tabular` 로 넘어오고, 세로 병합과 모양은 위의 몇 줄로 채웁니다. `&` 와 `\\` 를 손으로 칠 일은 없습니다.

- 라이선스 키: [LaTeXFlow 스토어](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=google-docs-table-to-latex-tabular)
- 무엇이 어떻게 바뀌는지, 활성화·해지·환불: [Export & Import 안내](/latexflow/export/)
- 함께 보기: [구글 문서로 만든 시험지·학습지, LaTeX 파일로 바꾸는 법](/blog/posts/google-docs-exam-worksheet-to-latex/) · [구글 문서로 쓴 논문 초안, Overleaf로 옮기기](/blog/posts/google-docs-paper-draft-to-overleaf/)
