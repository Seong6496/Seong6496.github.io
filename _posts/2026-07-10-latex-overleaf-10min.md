---
title: "Overleaf 10분 만에 시작하기 — 설치 없이 LaTeX 한 페이지 쓰기"
date: 2026-07-10 09:00:00 +0900
categories: [LaTeX, Tutorial]
tags: [latex, overleaf, 입문, 첫문서, documentclass, 사용법]
math: true
pin: false
description: "Overleaf 가입부터 첫 LaTeX 문서 컴파일까지 10분 안에 끝내는 가이드. 화면 세 영역의 역할, 첫 문서 코드 전문, 자주 만나는 오류, 그리고 Docs/Word 와 함께 쓰는 워크플로우 한 줄까지 정리합니다."
---

LaTeX 를 시작할 때 가장 자주 멈추는 자리는 문법이 아니라 **설치** 입니다. 과거에는 TeX Live 나 MiKTeX 같은 배포판을 수십 GB 분량으로 받고, 에디터를 따로 깔고, 패키지 관리도 직접 해야 했습니다. 이 과정에서 포기하는 사람이 정말 많았습니다.

**Overleaf** 는 그 장벽을 통째로 없앤 도구입니다. 브라우저에서 접속해 계정만 만들면, 그 자리에서 LaTeX 문서를 작성하고 컴파일할 수 있습니다. 이 글에서는 가입부터 첫 문서 컴파일까지 10분 안에 끝내는 과정을 압축해 보여 드립니다.

[이전 글 #11]({% post_url 2026-07-08-latex-vs-word-docs %}) 에서 LaTeX 가 Word·Google Docs 와 어떻게 다른지 이야기했다면, 이번 글은 그 다른 도구의 **입장권** 입니다. 10분 안에 첫 페이지가 만들어집니다.

## 1. Overleaf 가 다른 LaTeX 환경과 다른 점

Overleaf 는 웹 기반 LaTeX 편집 플랫폼입니다. Chrome·Safari·Firefox 어느 브라우저에서든 동작하고, 설치 파일이 없고, 환경 설정이 없습니다.

기본적으로 제공되는 것들:

- **실시간 컴파일** — 버튼 한 번으로 PDF 미리 보기.
- **수천 개의 템플릿** — 논문·이력서·발표 슬라이드.
- **협업 기능** — 링크 공유로 공동 편집 (Google Docs 처럼).
- **버전 관리** — 변경 이력 자동 저장.
- **1,000 개 이상의 학술지 템플릿** — Elsevier, IEEE, ACM, arXiv 등 투고 규정 그대로.

무료 플랜으로도 개인 프로젝트는 충분히 다룰 수 있습니다. 공동 편집자 수와 일부 고급 기능은 유료 플랜에서 열리지만, 첫 한두 학기 안에 부딪치는 문제는 아닙니다.

## 2. 가입 — 1분

1. [overleaf.com](https://www.overleaf.com) 에 접속합니다.
2. 우측 상단 **Register** 클릭.
3. 이메일·비밀번호 입력 (또는 Google 계정으로 가입).
4. 이메일 인증 완료.

가입이 끝나면 대시보드로 이동합니다. 가운데에 **New Project** 버튼이 보입니다.

## 3. 첫 프로젝트 — 2분

**New Project** 를 누르면 옵션 네 가지가 나옵니다.

| 옵션 | 의미 |
|---|---|
| **Blank Project** | 빈 문서 — 이 글에서 사용할 옵션 |
| **Example Project** | 기본 예제 코드가 채워진 문서 |
| **Upload Project** | 로컬의 `.tex` 파일 업로드 |
| **Templates** | Overleaf 템플릿 갤러리 |

**Blank Project** 를 선택하고 프로젝트 이름을 적습니다. `my-first-latex` 정도면 충분합니다.

프로젝트가 생성되면 편집 화면으로 이동합니다. 기본으로 `main.tex` 한 파일이 만들어져 있고, 최소 골격의 코드가 들어 있습니다.

## 4. 화면 세 영역의 역할 — 1분

Overleaf 의 편집 화면은 세 영역으로 나뉩니다.

```
┌─────────────────┬─────────────────────────┬─────────────────┐
│   파일 패널      │      코드 에디터         │   PDF 프리뷰    │
│  (왼쪽)         │     (가운데)             │   (오른쪽)      │
│                 │                         │                 │
│ main.tex        │  \documentclass{article}│  [컴파일된 PDF] │
│                 │  \begin{document}        │                 │
│                 │  Hello, World!          │                 │
│                 │  \end{document}          │                 │
└─────────────────┴─────────────────────────┴─────────────────┘
```

- **왼쪽 — 파일 패널**: 프로젝트에 포함된 파일 목록. 이미지·참고문헌 `.bib`·여러 `.tex` 파일을 여기서 관리합니다. 처음에는 `main.tex` 하나뿐입니다.
- **가운데 — 코드 에디터**: LaTeX 코드를 직접 작성하는 영역. 문법 하이라이팅과 자동 완성 (`\begin{}` 을 치면 `\end{}` 가 자동 제안) 이 지원됩니다.
- **오른쪽 — PDF 프리뷰**: 컴파일된 결과물. 처음에는 비어 있거나 이미 한 번 컴파일된 상태일 수 있습니다.

가장 위쪽 가운데에 **Recompile** 버튼이 있습니다. 단축키는 **`Ctrl+Enter`** (Mac: `Cmd+Enter`). 코드를 수정할 때마다 이 버튼을 눌러 PDF 를 갱신하는 게 기본 작업 흐름입니다.

## 5. Hello, LaTeX — 첫 페이지 5분

`main.tex` 를 열고 기존 내용을 모두 지운 뒤 아래 코드를 그대로 입력합니다.

```latex
\documentclass{article}

\usepackage{amsmath}
\usepackage[utf8]{inputenc}
\usepackage{kotex}  % 한글 사용 시

\title{나의 첫 LaTeX 문서}
\author{홍길동}
\date{2026년 7월}

\begin{document}

\maketitle

\section{소개}

이것은 \LaTeX 로 작성한 첫 번째 문서입니다.
\textbf{굵게}, \textit{이탤릭}, \underline{밑줄} 을 이렇게 씁니다.

\section{수식 맛보기}

인라인 수식은 달러 기호로 감쌉니다: $E = mc^2$.

디스플레이 수식은 이렇게 씁니다:
\begin{equation}
  \int_{-\infty}^{\infty} e^{-x^2} \, dx = \sqrt{\pi}
\end{equation}

\section{목록}

순서 있는 목록:
\begin{enumerate}
  \item 첫 번째 항목
  \item 두 번째 항목
  \item 세 번째 항목
\end{enumerate}

순서 없는 목록:
\begin{itemize}
  \item 사과
  \item 바나나
  \item 체리
\end{itemize}

\end{document}
```

입력이 끝나면 `Ctrl+Enter` 를 눌러 컴파일합니다. 오른쪽 프리뷰에 PDF 가 나타납니다.

처음 한 번에 다 보일 것:

- 제목·저자·날짜가 첫 페이지 중앙에 정렬 (`\maketitle` 의 효과).
- "1 소개", "2 수식 맛보기", "3 목록" — **번호가 자동으로** 붙음 (`\section{}`).
- 수식 (1) 이 오른쪽에 번호와 함께 정렬 (`equation` 환경).
- 순서 있는 목록은 1, 2, 3 으로, 순서 없는 목록은 점 (•) 으로 자동 처리.

**모든 외형이 명령어의 결과로 나온 것** — `\maketitle`, `\section`, `enumerate`, `equation` 각각이 정해진 모양을 만들어 줍니다. 외워야 할 게 많아 보이지만, 첫 한 페이지에 필요한 명령어는 위 코드 안의 8 개가 전부입니다.

> **`\usepackage{kotex}`**: 한글을 쓰려면 이 한 줄이 필요합니다. Overleaf 의 컴파일러 설정 (Menu → Compiler) 이 **XeLaTeX** 로 되어 있어야 한글이 깨지지 않습니다. `pdfLaTeX` 로 두면 한글 자리가 빈칸이 되거나 `?` 로 표시됩니다.
{: .prompt-tip }

## 6. 처음 만나는 오류 — 1분

컴파일에서 빨간 오류 메시지가 떴다면 당황하지 마세요. **본문 어딘가의 한 줄에 오타가 있다** 는 신호일 뿐입니다.

가장 자주 만나는 세 가지:

### 6.1 `! Undefined control sequence`

존재하지 않는 명령어를 썼습니다. 보통 `\sectionn{}` 처럼 `n` 을 하나 더 친 오타입니다. 오류 메시지의 줄 번호를 확인해 그 줄을 보면 거의 바로 보입니다.

### 6.2 `! Missing $ inserted`

수식 명령어 (`\frac`, `^`, `_` 등) 를 수식 환경 밖에서 썼습니다. 해당 부분을 `$...$` 로 감싸 주세요.

### 6.3 `! LaTeX Error: File 'X.sty' not found`

패키지가 빠졌습니다. Overleaf 의 패키지 매니저는 대부분 자동이지만, 일부는 프리앰블에 `\usepackage{X}` 한 줄을 추가하면 해결됩니다.

처음에는 오류 메시지가 낯설지만, 줄 번호를 보고 그 줄의 직전·직후를 살피는 습관만 들이면 90% 의 오류는 자기 손으로 잡을 수 있습니다.

## 7. 다음 단계 — Docs/Word 와 같이 쓰기

Overleaf 만으로 논문을 처음부터 끝까지 쓰는 것도 좋지만, **초안은 Docs/Word, 완성은 LaTeX** 의 두 도구 분담이 [#11]({% post_url 2026-07-08-latex-vs-word-docs %}) 에서 이야기한 현실적인 워크플로우입니다. 본문을 익숙한 도구에서 빠르게 쏟아 두고, 수식과 최종 PDF 만 LaTeX 로 넘기는 방식입니다.

이때 가장 자주 깨지는 자리는 **두 도구 사이를 건너가는 한 단계** — Docs/Word 본문 안의 수식을 LaTeX 품질로 시각화하는 자리입니다. `mathsystem.dev/latexflow/web/` 의 변환기가 그 자리를 메우는 도구로, `.docx` 한 번 업로드로 본문 안의 `$...$` 수식을 LaTeX 렌더링 이미지로 치환한 `.docx` 를 돌려줍니다. Overleaf 가입 후 첫 일주일 동안은 이 두 도구를 같이 쓰면서 "어디까지가 본문 작업, 어디부터가 LaTeX 작업" 인지 본인 워크플로우의 경계를 잡아 보세요.

## 정리

10분 안에 다음을 끝낸 셈입니다.

1. Overleaf 가입 + 첫 프로젝트 만들기.
2. 화면 세 영역의 역할 파악.
3. 첫 LaTeX 문서 코드 입력·컴파일.
4. 자주 만나는 오류 세 가지 대응.

여기까지 왔으면 **LaTeX 의 입장권은 떼었습니다.** 다음 단계는 본인의 본문 콘텐츠를 가져와 같은 골격에 올리는 것입니다. 학기 노트 한 절, 보고서 한 챕터 같은 작은 단위로 시작해서 점차 분량을 늘려 가면, 한두 주 안에 Overleaf 가 본인 손에 익은 도구가 됩니다.

다음 글부터는 본격적으로 **본인 작업물 — Google Docs 강의 노트, Word 학술 논문, AI 챗봇이 뱉은 수식** — 을 LaTeXFlow 흐름에 올리는 실전 시나리오를 정리합니다.

---

이전 글: [#11 Word·Google Docs 로 논문 쓰다 막힌 분께 — LaTeX 가 다른 이유]({% post_url 2026-07-08-latex-vs-word-docs %})
다음 글: #13 Google Docs 의 수식을 깔끔하게 — Web 변환기 데모 (작성 예정)

> **Docs/Word 의 수식을 한 번에 깔끔하게** — [LaTeXFlow Web 바로 가기](https://mathsystem.dev/latexflow/web/) (sign-in 없이 즉시)
{: .prompt-info }
