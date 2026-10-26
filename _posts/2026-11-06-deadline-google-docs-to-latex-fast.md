---
title: "논문·시험지 마감이 이번 주라면 — 구글 문서를 LaTeX로 빨리 바꾸는 법과 드는 비용"
date: 2026-11-06 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, google-docs, latex, overleaf, 마감, 학위논문, 시험지, 가격, 이용권]
math: false
pin: false
description: "학위논문 초안, 학회 원고, 기말 시험지를 이번 주 안에 LaTeX 로 내야 하는데 원고는 구글 문서에 있을 때 — 사기 전에 준비할 것, 변환하고 확인하는 순서, 그리고 한 번만 필요할 때 드는 비용과 환불 조건까지 한 번에 정리합니다."
---

원고는 구글 문서에 있는데, 제출은 LaTeX 로 해야 하는 주가 있습니다. 학위논문 초안을 학과 LaTeX 양식으로 내야 하거나, 학회가 Overleaf 템플릿만 받거나, 기말 시험지를 문제은행 양식에 맞춰야 할 때입니다. 다시 칠 시간은 없습니다.

이 글은 그런 주에 **무엇을 어떤 순서로 하면 되는지**, 그리고 **얼마가 드는지** 를 정리합니다. 쓰는 도구는 구글 문서 애드온 **LaTeXFlow** 입니다. 수식을 그림으로 바꾸는 기능은 무료이고, 문서 전체를 `.tex` 로 내보내는 **Convert to LaTeX** 와 `.tex` 를 구글 문서로 가져오는 **Import** 는 라이선스 키가 있어야 열립니다.

## 1. 사기 전에 원고부터

뒤에서 설명하겠지만 7일 이용권은 **산 시각부터** 7일입니다. 원고 준비를 먼저 해 두고, 내보낼 준비가 된 날 사는 것이 좋습니다. 준비는 구글 문서 안에서 합니다.

- **장 제목** 에 제목 1·제목 2 스타일을 씁니다. `\section`·`\subsection` 이 됩니다.
- **인용** 을 `[@키]` 로 적습니다. 쪽수는 `[@키, p. 12]`, 여러 개는 `[@키1, @키2]`. 키는 `.bib` 파일과 같게 합니다.
- **번호 달 수식** 은 수식 뒤에 탭을 치고 `(1)` 을 적습니다. 번호 달린 디스플레이 수식이 됩니다.
- **`.bib` 파일** 을 하나로 모읍니다. Zotero 나 Google Scholar 에서 BibTeX 로 내보낸 것이면 됩니다.
- **그림 파일** 을 한 폴더에 모읍니다. 그림은 `.tex` 에 자리만 표시되고 파일은 직접 올려야 하기 때문입니다.
- **워드에서 가져온 원고** 라면 sin 이 기울거나 연립식이 한 줄로 펴진 수식이 없는지 봅니다. 있으면 그 수식만 `$…$` 사이에 LaTeX 로 다시 칩니다. 친 그대로 `.tex` 에 들어갑니다([워드 문서를 LaTeX로 바꾸기](/blog/posts/word-docx-to-latex-google-docs/)).

## 2. 사고 활성화하기

[LaTeXFlow 스토어](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=deadline-google-docs-to-latex-fast)에서 고르고 결제하면, 결제 영수증 이메일에 **라이선스 키** 가 들어 있습니다. 따로 기다릴 메일은 없습니다.

구글 문서에서 **확장 프로그램 › LaTeXFlow** 로 사이드바를 열고, **LaTeX file** 탭의 **License** 칸에 키를 붙여넣고 **Activate** 를 누릅니다. 그 구글 계정으로 여는 모든 문서에서 열립니다.

![LaTeX file 탭의 License 칸: Licensed 표시와 플랜 이름 Monthly, Paste a license key 입력란, Activate 와 Deactivate 버튼](/assets/img/posts/2026-11-06/01-activate.png){: width="300" }

## 3. 변환하고 Overleaf 로

1. `.bib` 를 **Bibliography (.bib)** 칸에 붙여넣고 저장합니다.
2. **Full document** 로 **Convert to LaTeX** 를 누릅니다.
3. **Open in Overleaf** 로 새 프로젝트를 엽니다. 로컬에서 할 거라면 **Download .tex**.

학과나 학회 템플릿이 따로 있으면, 내보낸 파일의 `\begin{document}` 와 `\end{document}` 사이를 템플릿 본문 자리에 붙여넣고, 템플릿 머리말에 없는 `kotex`·`amsmath,amssymb` 만 더합니다. 참고문헌은 파일 안의 `filecontents*` 블록에 들어 있습니다.

## 4. 확인은 이 순서로

마감 전에는 어디를 볼지가 중요합니다. 위에서부터 봅니다.

1. **파일 맨 위 주석의 경고 목록.** 그림 자리, `.bib` 에 없는 인용 키, LaTeX 로 옮길 수 없었던 글자가 한 줄씩 적혀 있습니다. 여기 없는 것은 옮겨진 것입니다.
2. **그림.** `Image 1` 상자마다 그림 파일을 올리고 `\includegraphics[width=0.8\linewidth]{fig1.png}` 로 바꿉니다.
3. **인용.** PDF 에 `[?]` 가 있으면 그 키가 `.bib` 에 없는 것입니다.
4. **수식 수.** 사이드바 결과 줄의 수식 수가 원고와 맞는지 봅니다.
5. **모양.** 글꼴·줄 간격·여백은 옮기지 않습니다. 템플릿이 정합니다. 시험지라면 2단·답 쓸 공간·머리글을 몇 줄로 채웁니다([시험지 글](/blog/posts/google-docs-exam-worksheet-to-latex/) 5절).

지도교수님이 `.tex` 로 수정본을 돌려주시면, **Import** 로 그 파일을 구글 문서로 열어 댓글을 달 수도 있습니다([.tex 파일 가져오기 안내, 영문](/blog/en/posts/tex-file-into-google-docs-import/)).

## 5. 드는 비용

| 상품 | 가격 | 이런 경우 |
|---|---|---|
| **7일 이용권** | **$1.99** (한 번 결제) | 이번 주 마감 하나. 산 시각부터 7일, 자동 갱신 없음 |
| 월 구독 | $4.99 / 월 | 학기 중 매달 시험지·보고서를 만들 때 |
| 연 구독 | $49 / 년 | 일 년 내내 쓸 때 |

- 세 상품 모두 **내보내기와 가져오기가 다 열리고, 문서 수 제한이 없습니다.** 다른 것은 기간뿐입니다.
- **키 하나 = 구글 계정 하나.** 그 계정이면 컴퓨터가 바뀌어도 됩니다.
- 결제는 Lemon Squeezy 가 받고 **미국 달러** 로 청구됩니다. 나라에 따라 부가세가 더해질 수 있고, 카드 명세서에는 `LEMSQZY*` 로 찍힙니다.
- 기간이 끝나면 내보내기·가져오기만 잠깁니다. 이미 만든 `.tex` 와 가져온 문서는 그대로이고, 수식을 그림으로 바꾸는 무료 기능은 계속 씁니다.
- **환불:** 내 문서에서 제대로 되지 않으면 환불합니다. 7일 이용권은 산 뒤 7일 안에, 구독은 첫 결제 뒤 14일 안에 주문 번호와 함께 연락하면 됩니다. 자세한 조건은 [Export & Import 안내](/latexflow/export/)에 있습니다.

## 6. 정리

- 원고 준비(제목 스타일, `[@키]`, 탭 + (1), `.bib`, 그림 파일)를 먼저 합니다.
- 준비가 끝난 날 7일 이용권($1.99)을 사서 활성화합니다.
- **Convert to LaTeX** → **Open in Overleaf** → 경고 목록부터 확인합니다.

[버전 15](/latexflow/changelog/#version-15) 를 출시 전에 시험할 때, 시험지·논문형 문서 20개를 내보냈는데 모두 받은 그대로 컴파일되었습니다. 마감 주에 할 일은 대부분 그림을 넣고 템플릿에 맞추는 일로 줄어듭니다.

- 라이선스 키: [LaTeXFlow 스토어](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=deadline-google-docs-to-latex-fast)
- 활성화·해지·환불 자세히: [Export & Import 안내](/latexflow/export/)
