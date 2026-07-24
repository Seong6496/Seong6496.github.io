---
title: "BibTeX 참고문헌 — .bib 작성과 APA·IEEE 스타일 고르기"
date: 2026-08-07 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, 참고문헌, bibtex, biblatex, cite, natbib, apa, ieee, bib파일, 인용스타일, 논문]
math: false
pin: false
description: "LaTeX 참고문헌을 BibTeX 로 관리하는 법 — .bib 문헌 엔트리 유형(article·inproceedings·book·misc), cite 로 인용하기(다중·페이지), 그리고 plain·IEEE·APA(natbib)·biblatex 스타일을 언제 고르는지. .bib 자동 생성 방법과 인용 워크플로까지 정리합니다."
---

참고문헌 관리는 논문에서 생각보다 시간을 많이 잡아먹습니다. 인용 순서가 바뀌면 번호를 다시 매겨야 하고, 스타일에 따라 저자가 "성, 이름" 인지 "이름 성" 인지도 달라집니다. 50개가 넘어가면 손으로 관리하기 어렵습니다.

BibTeX 는 이 문제를 데이터베이스 방식으로 풉니다. `.bib` 파일에 문헌을 한 번 등록해 두면, 본문에서 `\cite{키}` 만 쓰면 됩니다 — 번호 정렬도 스타일 적용도 자동입니다. 이 글은 그 **.bib 를 작성하고, 인용하고, 스타일을 고르는** 데 집중합니다. BibTeX 가 컴파일 과정에서 내부적으로 어떻게 도는지(여러 번 컴파일해야 하는 이유)와 `[?]`·`Citation undefined` 가 떴을 때의 대처는 [LaTeX 오류 메시지 해결 사전 2편](/blog/posts/latex-document-errors-guide/) 의 2부에 따로 정리해 두었으니, 참고문헌이 목록에 안 나오는 문제를 겪고 있다면 그쪽을 먼저 보세요.

## 1. .bib 파일 — 문헌을 데이터로 적는다

`.bib` 파일에는 문헌을 아래 형태로 적습니다.

```bibtex
@유형{인용키,
  필드명 = {내용},
  필드명 = {내용},
}
```

`@유형` 은 문헌의 종류, `인용키` 는 본문에서 부를 이름, 나머지는 서지 정보입니다. 유형은 문헌 종류에 맞춰 고릅니다.

### 학술지 논문 — @article

```bibtex
@article{vaswani2017attention,
  author  = {Vaswani, Ashish and Shazeer, Noam and Parmar, Niki},
  title   = {Attention is All You Need},
  journal = {Advances in Neural Information Processing Systems},
  volume  = {30},
  year    = {2017},
  pages   = {5998--6008}
}
```

### 학회 논문 — @inproceedings

```bibtex
@inproceedings{he2016deep,
  author    = {He, Kaiming and Zhang, Xiangyu and Ren, Shaoqing and Sun, Jian},
  title     = {Deep Residual Learning for Image Recognition},
  booktitle = {Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition},
  year      = {2016},
  pages     = {770--778}
}
```

`@article` 이 `journal` 을 받는 데 비해 `@inproceedings` 는 `booktitle`(학회명)을 받습니다. 유형마다 요구하는 필드가 조금씩 다릅니다.

### 책과 프리프린트 — @book, @misc

```bibtex
@book{knuth1984texbook,
  author    = {Knuth, Donald E.},
  title     = {The {\TeX}book},
  publisher = {Addison-Wesley},
  year      = {1984}
}

@misc{brown2020gpt3,
  author        = {Brown, Tom B. and others},
  title         = {Language Models are Few-Shot Learners},
  year          = {2020},
  eprint        = {2005.14165},
  archivePrefix = {arXiv},
  primaryClass  = {cs.CL}
}
```

arXiv 프리프린트나 웹 자료처럼 정형화된 유형이 없는 문헌은 `@misc` 로 담습니다.

### 작성할 때의 관례

- **인용키**는 `저자연도키워드` 형식이 관례입니다 — `vaswani2017attention` 처럼. 나중에 본문에서 알아보기 쉽습니다.
- 저자가 여럿이면 `and` 로 구분합니다(쉼표가 아닙니다).
- **제목의 대문자를 지키려면** 그 부분을 중괄호로 묶습니다 — `{DeepMind}`. BibTeX 스타일에 따라 제목을 소문자화하는데, 중괄호가 그것을 막습니다.
- 페이지 범위는 대시 두 개(`--`)로 적습니다 — `{5998--6008}`. 하나(`-`)는 하이픈, 둘은 범위 대시로 조판됩니다.

## 2. 본문에서 인용하기 — cite

등록한 문헌은 인용키로 부릅니다.

```latex
Vaswani 등~\cite{vaswani2017attention}이 제안한 Transformer 모델은...
```

이름과 번호 사이의 `~` 는 **줄바꿈 방지 공백** 입니다. "Vaswani 등" 과 "[1]" 이 줄이 갈리며 떨어지지 않게 묶어 줍니다. 저자 이름과 인용 번호 사이에는 습관적으로 `~` 를 쓰는 편이 좋습니다.

여러 문헌을 한 번에 인용하려면 쉼표로 나열합니다.

```latex
다수의 연구가 진행되었다~\cite{he2016deep,vaswani2017attention,brown2020gpt3}.
```

한 괄호 안에 `[1, 2, 3]` 처럼 묶입니다. 특정 페이지를 가리키려면 대괄호로 덧붙입니다.

```latex
\cite[p.~42]{knuth1984texbook}   % → [1, p. 42]
```

## 3. 스타일 고르기 — 번호식이냐 저자-연도식이냐

참고문헌의 겉모습은 `\bibliographystyle{}` 하나로 정합니다. 스타일은 크게 **번호식** 과 **저자-연도식** 으로 갈리고, 이 선택이 본문 인용의 모양(`[1]` 이냐 `(Vaswani et al., 2017)` 이냐)까지 좌우합니다.

### 번호식 — plain 계열과 IEEE

```latex
\bibliographystyle{plain}   % 알파벳 순 정렬 후 번호
\bibliographystyle{unsrt}   % 인용한 순서대로 번호
\bibliographystyle{alpha}   % [Vas17] 같은 저자+연도 약어
```

`plain` 과 `unsrt` 의 차이는 **번호를 매기는 기준** 입니다 — `plain` 은 저자 알파벳 순, `unsrt` 는 본문에 처음 인용된 순서. 공학 논문에서 흔한 IEEE 번호식은 전용 스타일을 씁니다.

```latex
\usepackage{cite}            % 다중 인용을 [1]-[3] 으로 압축
\bibliographystyle{IEEEtran}
```

`IEEEtran.bst` 는 Overleaf 에 내장돼 있어 따로 올릴 필요가 없습니다.

### 저자-연도식 — APA와 natbib

APA 처럼 본문에 "(Vaswani et al., 2017)" 이 들어가는 방식은 `natbib` 패키지를 함께 씁니다. 이때는 `\cite` 대신 상황에 맞는 전용 명령을 골라 씁니다.

```latex
\usepackage{natbib}
\bibliographystyle{apalike}

\citet{vaswani2017attention}   % → Vaswani et al. (2017)  ... 문장 주어로
\citep{vaswani2017attention}   % → (Vaswani et al., 2017)  ... 문장 끝 괄호로
\citeauthor{vaswani2017attention}  % → Vaswani et al.
\citeyear{vaswani2017attention}    % → 2017
```

`\citet` 과 `\citep` 의 구분이 핵심입니다. 저자를 문장의 **주어**로 삼을 때는 `\citet`("Vaswani et al. (2017) 은 ..."), 문장 끝에 **괄호로 근거**를 달 때는 `\citep`("... 향상되었다 (Vaswani et al., 2017)."). 인문·사회과학 논문이 대개 이 저자-연도식입니다.

### 어떤 스타일을 고를까

| 스타일 | 본문 인용 | 언제 |
|---|---|---|
| `plain` / `unsrt` | `[1]` | 일반 번호식, 투고 규정 없을 때 |
| `IEEEtran` | `[1]` | IEEE 계열 공학 학회·저널 |
| `apalike` (`natbib`) | `(저자, 연도)` | APA — 인문·사회과학 |
| `ACM-Reference-Format` | 스타일별 | ACM 계열 |

**가장 확실한 기준은 투고할 학술지의 규정** 입니다. 저널이 스타일 파일을 제공하면 그것을 쓰고, 없으면 분야 관례(공학=번호식, 인문·사회=저자-연도식)를 따릅니다.

### biblatex — 현대적 대안

`biblatex` 는 BibTeX 를 대체하는 더 유연한 방식으로, 스타일 커스터마이징이 쉽습니다.

```latex
\usepackage[style=ieee, backend=biber]{biblatex}
\addbibresource{references.bib}

\cite{vaswani2017attention}

\printbibliography           % 목록을 출력할 위치
```

문법이 다릅니다 — `\bibliography` 대신 `\addbibresource`, 목록 출력은 `\printbibliography`, 그리고 컴파일 백엔드로 `bibtex` 가 아니라 `biber` 를 씁니다. 새로 시작하는 문서이고 스타일을 세밀하게 다루고 싶다면 `biblatex` 가 편하고, 저널 템플릿이 전통 BibTeX 를 전제한다면 그대로 BibTeX 를 씁니다.

## 4. .bib 를 손으로 안 적는 법

엔트리를 직접 타이핑하는 것은 번거롭고 오타도 납니다. 대개는 자동으로 가져옵니다.

- **Google Scholar** — 논문 아래 "인용" → "BibTeX" 를 눌러 나온 텍스트를 `.bib` 에 붙여넣기
- **doi2bib** — [doi2bib.org](https://doi2bib.org) 에 DOI 를 넣으면 BibTeX 로 변환
- **arXiv** — 논문 페이지의 "Export BibTeX citation" 링크
- **Zotero · Mendeley** — 문헌 관리 도구에서 `.bib` 로 내보내 Overleaf 에 업로드

가져온 엔트리는 인용키가 도구마다 제각각이라, 본문에서 부르기 좋게 키만 손봐 두면 편합니다.

한 가지 자주 만나는 상황 — **인용은 안 했지만 목록에는 넣고 싶은 문헌** 입니다. `\cite` 로 부른 문헌만 목록에 나오는 게 기본이라, 인용 없이 포함하려면 `\nocite{키}` 를, 등록한 문헌을 전부 넣으려면 `\nocite{*}` 를 씁니다.

## 정리

| 목적 | 방법 |
|---|---|
| 문헌 등록 | `.bib` 에 `@article`·`@inproceedings`·`@book`·`@misc` |
| 인용 | `\cite{키}` (다중은 쉼표, 페이지는 `\cite[p.~42]{키}`) |
| 줄바꿈 방지 | 이름과 인용 사이 `~` |
| 번호식 스타일 | `plain`·`unsrt`·`IEEEtran` |
| 저자-연도식 | `natbib` + `\citet`(주어)·`\citep`(괄호) |
| 목록에 강제 포함 | `\nocite{키}` / `\nocite{*}` |
| 자동 생성 | Google Scholar·doi2bib·arXiv·Zotero |
| 목록이 안 나올 때 | → 오류 사전 2부 |

참고문헌은 한 번 데이터로 만들어 두면 그다음이 편합니다 — `.bib` 에 문헌을 모으고, 본문에서 `\cite` 로 부르고, 분야에 맞는 스타일을 하나 고르면 번호와 형식은 컴파일이 알아서 맞춥니다. 인용을 50개 넣든 순서를 바꾸든 손으로 번호를 세는 일은 없습니다.
