---
title: "구글 문서로 쓴 논문 초안, Overleaf로 옮기기"
date: 2026-10-29 09:00:00 +0900
categories: [LaTeXFlow, 사용법]
tags: [latexflow, google-docs, overleaf, latex, 논문, 참고문헌, bibtex, 인용, 수식-번호]
math: false
pin: false
description: "지도교수와 구글 문서에서 댓글로 다듬던 논문 초안을 Overleaf 로 옮겨야 할 때 — 초안 단계에서 인용을 [@키] 로, 수식 번호를 탭 + (1) 로 적어 두면 참고문헌 목록과 쪽수 인용, 번호 달린 수식까지 Overleaf 에서 그대로 컴파일됩니다. 학부 연구생 보고서 한 편으로 순서대로 확인합니다."
---

초안은 구글 문서에서 쓰는 경우가 많습니다. 지도교수님이 댓글을 달기 쉽고, 공동 연구자와 동시에 고칠 수 있으니까요. 그런데 학회 템플릿이나 학위논문 양식이 LaTeX 라면 결국 Overleaf 로 옮겨야 하고, 그때 제일 귀찮은 것이 **참고문헌** 과 **수식 번호** 입니다.

이 글은 그 둘이 그대로 넘어가도록 초안을 쓰는 법과, 구글 문서 애드온 **LaTeXFlow** 의 **LaTeX file** 탭에서 **Convert to LaTeX** 로 옮기는 순서를 정리합니다. 이 기능은 라이선스 키가 있어야 열립니다. 예시는 학부 연구생의 중간 보고서 한 편(열방정식의 유한차분법)입니다.

## 1. 초안에서 미리 해 둘 세 가지

옮기는 것보다 **초안을 어떻게 적어 두느냐** 가 더 중요합니다. 세 가지만 지키면 됩니다.

**인용은 `[@키]` 로.** 키는 `.bib` 파일의 키와 같게 씁니다.

| 구글 문서에 쓰는 것 | .tex 에 나오는 것 |
|---|---|
| `[@crank1947]` | `\cite{crank1947}` |
| `[@leveque2007, @strikwerda2004]` | `\cite{leveque2007,strikwerda2004}` |
| `[@evans2010, p. 45]` | `\cite[p.~45]{evans2010}` |

쪽수가 붙은 인용과 여러 키를 한 괄호에 묶는 인용은 [버전 15](/latexflow/changelog/#version-15) 부터 이렇게 나옵니다.

**번호 달 수식은 수식 뒤에 탭 + (1).** 구글 문서 수식 편집기(삽입 › 수식)로 넣은 디스플레이 수식 뒤에 탭을 치고 `(1)` 처럼 번호를 적어 두면, .tex 에서는 그 번호가 붙은 디스플레이 수식 `\[ … \tag{1} \]` 이 됩니다.

**장 제목은 제목 스타일로.** 제목 1·제목 2 스타일을 쓰면 `\section`·`\subsection` 이 됩니다. "1. 서론" 처럼 번호를 직접 쳐 두었다면 LaTeX 가 번호를 한 번 더 붙이지 않도록 `\section*{1. 서론}` 으로 나옵니다.

보고서 초안의 첫 쪽입니다. 인용이 `[@crank1947]` 같은 표시로, 수식 번호가 오른쪽 끝의 `(2)`, `(3)` 으로 적혀 있습니다.

![구글 문서의 보고서 초안 첫 쪽: 제목, 부제, 저자와 요약, 1. 서론의 초기-경계값 문제와 번호 (1), [@leveque2007, @strikwerda2004] 인용 표시, 2.1 전진 오일러 방법과 2.2 크랭크-니콜슨 방법의 차분식에 오른쪽 끝 번호 (2) (3), 아래쪽 각주](/assets/img/posts/2026-10-29/01-draft-in-google-docs.png){: width="500" }

## 2. .bib 를 사이드바에 붙여넣기

Zotero, Google Scholar, 학회 사이트에서 받은 BibTeX 항목을 `.bib` 하나로 모읍니다. LaTeXFlow 사이드바의 **LaTeX file** 탭에서 **Bibliography (.bib)** 칸에 붙여넣고 저장하면, 그 항목들이 이 문서에 저장됩니다. 한 번 저장해 두면 다음에 내보낼 때마다 다시 붙일 필요가 없습니다.

<!-- TODO image (web pane): LaTeX file tab — Bibliography (.bib) box with pasted entries and the "N entries" badge after saving. File: /assets/img/posts/2026-10-29/04-bib-box.png -->

`.bib` 를 붙이지 않고 내보내도 파일은 컴파일됩니다. 인용이 `[?]` 로 찍히고, 파일 맨 위 주석에 나중에 참고문헌을 붙이는 방법이 적혀 있습니다.

## 3. Convert to LaTeX → Open in Overleaf

**Full document** 가 선택된 채로 **Convert to LaTeX** 를 누릅니다. 이 보고서에서는 결과 줄이 이렇게 나왔습니다.

```text
50 native · 0 image · 0 text equations · 1 table · 1 image · 2 citations
```

**Open in Overleaf** 를 누르면 새 Overleaf 프로젝트로 열리고(Overleaf 로그인 필요), Overleaf 가 BibTeX 까지 돌려서 컴파일합니다. 로컬에서 할 때는 pdfLaTeX → BibTeX → pdfLaTeX 두 번입니다.

<!-- TODO image (web pane): the exported Korean paper opened in Overleaf, compiled PDF on the right with [1] [2, 3] citations. File: /assets/img/posts/2026-10-29/05-overleaf.png -->

## 4. .tex 안에서 참고문헌은 이렇게 들어갑니다

붙여넣은 `.bib` 는 따로 파일을 올릴 필요가 없도록 `.tex` 안에 들어갑니다.

```latex
\usepackage{kotex}        % Korean — works under pdfLaTeX and XeLaTeX

\begin{filecontents*}{refs.bib}
@article{crank1947,
  author  = {Crank, J. and Nicolson, P.},
  ...
}
\end{filecontents*}

\begin{document}
...
\section*{1. 서론}
...
유한차분법의 일반적인 이론은 \cite{leveque2007,strikwerda2004} 를 참고하였다.\footnote{...}
...
\bibliographystyle{plain}
\bibliography{refs}
```

- 한글이 있으니 `kotex` 가 들어갑니다.
- 구글 문서의 각주(삽입 › 각주)는 `\footnote` 가 됩니다.
- 참고문헌 스타일은 `plain` 입니다. 학회가 정한 스타일이 있으면 이 한 줄만 바꾸면 됩니다.

## 5. 컴파일한 결과

![컴파일한 PDF 첫 쪽: 제목과 부제, 저자, 요약의 [1] 인용, 1. 서론의 번호 (1) 수식, [2, 3] 인용, 2.1 과 2.2 의 차분식에 번호 (2) (3), 아래쪽 각주](/assets/img/posts/2026-10-29/02-compiled-first-page.png){: width="500" }

![References 목록: [1] Crank and Nicolson 1947, [2] LeVeque 2007, [3] Strikwerda 2004](/assets/img/posts/2026-10-29/03-references.png){: width="420" }

인용은 `[1]`, `[2, 3]` 으로 번호가 매겨지고, 끝에 참고문헌 목록이 생겼습니다. 수식 (1)~(3) 은 번호가 붙은 디스플레이 수식입니다.

## 6. 남은 손질 — 각각 한 번이면 됩니다

- **그림.** 그림은 `.tex` 에 `Image 1` 상자로 들어가고, 파일 머리 경고 목록에 그림마다 한 줄씩 적힙니다. 그림 파일을 Overleaf 프로젝트에 올리고 `\fbox{Image 1}` 을 `\includegraphics[width=0.8\linewidth]{fig1.png}` 처럼 바꿉니다. 그림 아래 설명 줄은 `\caption{…}` 안으로 옮기면 됩니다.
- **학회·학위논문 템플릿.** 내보낸 파일의 `\begin{document}` 와 `\end{document}` 사이를 템플릿의 본문 자리에 붙여넣고, 머리말에서 `kotex` 와 `amsmath,amssymb` 만 템플릿에 없으면 더합니다. 참고문헌은 `filecontents*` 블록을 그대로 옮기거나 `refs.bib` 로 저장해 올립니다.
- **글꼴·줄 간격·여백** 은 옮기지 않습니다. 템플릿이 정하는 부분이라 오히려 섞이지 않는 편이 낫습니다.
- **수식 모양이 이상한 곳.** 위 결과에서 식 (1) 의 sin 이 기울어 있는 것은, 이 보고서가 원래 워드 파일을 구글 문서로 연 것이라 그 단계에서 생긴 일입니다. 이런 수식은 구글 문서에서 지우고 `$$u_t = \kappa u_{xx}, \quad u(x,0) = \sin(\pi x)$$` 처럼 LaTeX 를 글자로 쳐 두면, 내보낼 때 친 그대로 들어가서 정확합니다.

저희가 버전마다 돌리는 시험 문서 중 논문형 10편은 이 보고서처럼 인용·번호 수식·표·그림이 섞인 문서입니다. 버전 15 를 출시 전에 시험했을 때 10편 모두 `.bib` 를 붙여 컴파일되었고 인용이 전부 번호로 풀렸습니다. `.bib` 없이 내보낸 그대로도 10편 모두 컴파일되었습니다(인용은 `[?]`).

초안을 쓸 때 `[@키]` 와 `(1)` 만 적어 두면, 옮기는 날 할 일은 **Convert to LaTeX** 한 번과 그림 넣기 정도입니다.

- 라이선스 키: [LaTeXFlow 스토어](https://teolemma.lemonsqueezy.com/?utm_source=blog&utm_medium=post&utm_campaign=google-docs-paper-draft-to-overleaf)
- 무엇이 어떻게 바뀌는지, 활성화·해지·환불: [Export & Import 안내](/latexflow/export/)
- 지난 글: [구글 문서로 만든 시험지·학습지, LaTeX 파일로 바꾸는 법](/blog/posts/google-docs-exam-worksheet-to-latex/)
