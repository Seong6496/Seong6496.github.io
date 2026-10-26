---
title: "워드(.docx) 문서를 LaTeX로 바꾸기 — 구글 문서를 거치는 방법"
date: 2026-11-04 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, google-docs, word, docx, latex, 워드, 수식, 변환, 평가지]
math: false
pin: false
description: "워드로 만든 평가지나 보고서를 LaTeX 로 옮기는 방법 — .docx 를 구글 드라이브에 올려 구글 문서로 열면 워드 수식이 구글 문서 수식으로 넘어오고, 그대로 .tex 로 내보낼 수 있습니다. 변환에서 sin 이 기울거나 연립식이 한 줄로 펴지는 몇 개의 수식은 LaTeX 로 다시 쳐서 정확하게 만드는 법까지, 중3 삼각비 평가지로 확인합니다."
---

학교 평가지도, 학회에 냈던 원고도 워드로 만든 것이 많습니다. 이것을 LaTeX 로 옮기려면 보통 변환 프로그램을 설치하거나 처음부터 다시 쳐야 합니다. 구글 계정이 있다면 설치 없이 가는 길이 하나 더 있습니다.

1. `.docx` 를 구글 문서로 열면, 구글 문서가 **워드 수식을 구글 문서 수식으로** 바꿔 줍니다.
2. 그 문서를 구글 문서 애드온 **LaTeXFlow** 의 **Convert to LaTeX** 로 `.tex` 로 내보냅니다(**LaTeX file** 탭, 라이선스 키 필요).

중학교 3학년 삼각비 형성평가 한 장으로 따라가 봅니다. 워드로 만들고 워드 수식으로 수식을 넣은 문서입니다.

## 1. 구글 드라이브에 올리고 구글 문서로 열기

[구글 드라이브](https://drive.google.com/)에서 **새로 만들기 › 파일 업로드** 로 `.docx` 를 올립니다. 올린 파일을 더블클릭하면 구글 문서 화면으로 열리지만, 제목 옆에 **.DOCX** 표시가 있는 동안은 아직 워드 파일입니다. 이 상태에서는 애드온이 문서를 읽지 못합니다.

**파일 › Google Docs로 저장**(Save as Google Docs)을 누르면 구글 문서로 바뀐 사본이 따로 만들어지고 열립니다. 원래 `.docx` 는 그대로 남습니다. 워드 수식이 구글 문서 수식으로 바뀌는 것이 이 단계입니다.

![구글 문서에서 연 워드 파일: 제목 삼각비-형성평가 옆에 .DOCX 표시, 파일 메뉴가 열려 있고 Google Docs로 저장 이 강조됨](/assets/img/posts/2026-11-04/03-save-as-google-docs.png){: width="640" }

워드 파일을 자주 옮긴다면 드라이브 **설정** 에서 **업로드 항목을 Google Docs 편집기 형식으로 변환**을 켜 두면, 올릴 때부터 구글 문서로 들어옵니다.

## 2. 수식이 넘어왔는지 확인하기

변환된 평가지의 첫 쪽입니다.

![구글 문서로 변환한 3학년 삼각비 형성평가: 제목, 이름 칸, 1. 피타고라스 정리 복습의 a²+b²=c², 직각삼각형 그림 두 개와 문제 1·2, 2. 삼각비의 값의 sinA, cosA, tanA 정의 수식, 특수각의 삼각비 표](/assets/img/posts/2026-11-04/01-word-exam-opened-in-docs.png){: width="500" }

수식을 하나 클릭해 보면 구글 문서 수식 도구 모음이 나옵니다. 워드 수식이 구글 문서 수식이 되었다는 뜻이고, 내보낼 때 LaTeX 로 다시 쓰입니다. 이 평가지는 워드에서 수식 40개였고, 구글 문서에서도 40개였습니다.

그래도 수식은 한 번 훑어보세요. 구글 문서의 변환이 모든 것을 옮기지는 않습니다.

- **sin, cos, tan, lim 같은 함수 이름** 이 기울어진 글자(변수의 곱)가 될 수 있습니다. 위 그림의 sinA, cosA, tanA 가 그렇습니다.
- **연립식(cases), 행렬, 여러 줄 정렬** 은 한 줄로 펴집니다.
- 수식이 아주 많은 문서에서는 **몇 개가 빠지기도** 했습니다. 저희 시험 문서 중 가장 긴 것은 워드 254개 → 구글 문서 247개였습니다.

모두 LaTeXFlow 가 문서를 읽기 전, 구글 문서의 변환에서 생기는 일입니다. 대부분의 문서에서는 몇 개의 수식에 그치고, 다음 단계로 정확하게 고칠 수 있습니다.

## 3. 그 몇 개는 LaTeX 로 다시 치기

변환이 어긋난 수식은 구글 문서에서 지우고, 그 자리에 LaTeX 를 달러 기호 사이에 **글자로** 칩니다. 빠진 수식도 같은 방법으로 넣습니다.

```latex
$$\sin A = \frac{\overline{BC}}{\overline{AC}}, \qquad \cos A = \frac{\overline{AB}}{\overline{AC}}, \qquad \tan A = \frac{\overline{BC}}{\overline{AB}}$$
$\sin 30^\circ \times \cos 60^\circ + \tan 45^\circ$
$$\begin{cases} x^2-3x-10 \le 0 \\ x^2-4x+3 > 0 \end{cases}$$
```

`$…$` 는 문장 안 수식, `$$…$$` 는 따로 한 줄을 차지하는 수식입니다. 이렇게 친 LaTeX 는 내보낼 때 **친 그대로** `.tex` 에 들어갑니다. 고치기 전과 후를 컴파일해 비교하면 이렇습니다.

![위: 변환된 그대로의 sinA, cosA, tanA 는 기울어진 글자, 문제 3 의 sin30°×cos60°+tan45° 도 기울어진 글자. 아래: LaTeX 로 다시 친 뒤 sin, cos, tan 이 바로 선 함수 이름으로 나옴](/assets/img/posts/2026-11-04/02-sin-before-after.png){: width="560" }

붙여넣기보다 **직접 치는** 것이 좋습니다. 구글 문서는 붙여넣은 `$…$` 를 자기 수식으로 다시 바꾸기도 하는데, 그러면 한 번 되돌리기(Ctrl+Z)하면 글자로 남습니다.

구글 문서에서도 수식 모양으로 보여야 한다면(동료가 구글 문서로 읽는다면) LaTeXFlow 의 **Scan** 탭(무료)에서 **Scan Document** › **Convert All** 을 누릅니다. LaTeX 글자가 제대로 조판된 수식 그림이 되고, 그림 안에 LaTeX 가 저장되어 있어서 내보내기는 그대로 정확합니다. 그 수식을 나중에 고칠 때는 구글 문서 수식 편집기 대신 LaTeX 로 고친다는 점만 다릅니다.

## 4. 내보내기

**확장 프로그램 › LaTeXFlow** › **LaTeX file** 탭에서 **Full document** 로 **Convert to LaTeX** 를 누릅니다. 결과 줄의 `native` 는 구글 문서 수식, `text equations` 는 3절에서 LaTeX 로 친 수식, `image` 는 Scan 으로 바꾼 수식의 수입니다. 합이 원래 수식 수보다 적으면 변환에서 빠진 것이 있으니 3절로 넣으면 됩니다.

![변환한 평가지와 LaTeXFlow 사이드바: 본문의 sinA, cosA, tanA 정의 줄은 $…$ 사이 LaTeX 글자로 다시 쳐 있고, 결과 줄은 38 native · 0 image · 2 text equations · 1 table · 1 image · 0 citations](/assets/img/posts/2026-11-04/04-export-result.png){: width="660" }

**Download .tex** 로 받거나 **Open in Overleaf** 로 바로 엽니다. 한글이 있으면 `kotex` 가 들어가고, 원 숫자 보기 ①~⑤ 는 정의와 함께 들어가서, 받은 파일 그대로 컴파일됩니다.

## 5. 옮겨지지 않는 것과 채우는 법

- **모양.** 글꼴, 글자 크기, 색, 줄 간격, 머리글·바닥글, 2단 배치, 문제 사이 빈 공간은 옮기지 않습니다. LaTeX 에서는 몇 줄로 채웁니다(`fancyhdr`, `multicol`, `\vspace`). 실제 시험지에 넣어 본 예는 [구글 문서로 만든 시험지·학습지, LaTeX 파일로 바꾸는 법](/blog/posts/google-docs-exam-worksheet-to-latex/) 5절에 있습니다.
- **그림.** 직각삼각형 그림 같은 이미지는 `.tex` 에 `Image 1` 상자로 들어갑니다. 그림 파일을 Overleaf 에 올리고 `\includegraphics` 로 바꿉니다.
- **번호 목록.** 번호 목록 사이에 다른 문단이 끼면 다시 1 부터 시작하는 경우가 있습니다. 원본과 번호를 한 번 맞춰 보세요.
- **옛 .doc 파일의 MathType 수식** 은 워드 수식이 아니라 그림처럼 끼워 넣은 개체입니다. 이 경로로는 시험해 보지 않았으니, 구글 문서에서 수식으로 보이지 않으면 3절처럼 LaTeX 로 쳐 주세요.

## 6. 어디까지 시험했나

저희는 이 경로를 버전마다 돌리는 시험 세트로 씁니다. 워드로 만들고 워드 수식을 넣은 문서 20개(평가지·학습지 10개, 논문형 10개, 한국어 문서 포함)를 구글 문서로 열고 내보냅니다. [버전 15](/latexflow/changelog/#version-15) 를 출시 전에 시험했을 때 **20개 모두 내보낸 그대로 컴파일** 되었습니다.

정리하면, 워드 문서는 구글 문서로 열고, 변환이 어긋난 몇 개의 수식만 LaTeX 로 다시 친 뒤 내보내면 됩니다. 그러면 `.tex` 의 수식은 정확하고, 남는 일은 LaTeX 에서 모양을 고르는 것뿐입니다.

- 라이선스 키: [LaTeXFlow 스토어](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=word-docx-to-latex-google-docs)
- 무엇이 어떻게 바뀌는지, 활성화·해지·환불: [Export & Import 안내](/latexflow/export/)
