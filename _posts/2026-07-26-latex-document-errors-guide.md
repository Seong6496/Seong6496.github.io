---
title: "LaTeX 오류 메시지 해결 사전 2편 — 환경·참고문헌·그림·한글·레이아웃"
date: 2026-07-26 09:00:00 +0900
categories: [LaTeX, Reference]
tags: [latex, 오류, 컴파일에러, 디버깅, 환경, 참고문헌, bibtex, 그림, includegraphics, kotex, 한글, overfull, float, overleaf]
math: false
pin: false
description: "수식 바깥에서 나는 LaTeX 오류 열두 가지를 메시지 그대로 정리한 사전 — 환경 짝 불일치, Missing \\begin{document}, Citation undefined, BibTeX 의 no \\bibstyle · no \\citation, File not found, pdftex.def 오류, 한글 □ 출력과 kotex 폰트, Overfull \\hbox 와 Float too large. 각 항목마다 언제 나오는지, 로그에서 어떻게 보이는지, 왜 나는지, 어떻게 고치는지를 붙였습니다."
---

컴파일이 실패했을 때 가장 먼저 할 일은 메시지를 그대로 읽는 것입니다. 그런데 LaTeX 문서에서 나오는 메시지는 전부 한 곳에서 오는 게 아닙니다. **LaTeX 엔진**이 내는 것, **BibTeX** 라는 별개 프로그램이 내는 것, PDF **출력 드라이버**가 내는 것, **패키지**(`kotex`, `graphicx` 등)가 내는 것이 섞여 있고, 이들은 로그에서 서로 다른 자리에 다른 형식으로 찍힙니다. 메시지 앞머리만 봐도 누가 낸 것인지 갈라집니다.

| 앞머리 | 낸 주체 | 컴파일 |
|---|---|---|
| `! LaTeX Error: ...` | LaTeX 엔진 | 멈춤 |
| `! Package <이름> Error: ...` | 해당 패키지 | 멈춤 |
| `LaTeX Warning: ...` | LaTeX 엔진 | 안 멈춤 |
| `Overfull \hbox ...` | 조판 엔진 | 안 멈춤 |
| `I found no ...` | BibTeX (별도 로그) | LaTeX 는 성공, 참고문헌만 빔 |

여기서 두 가지가 실무에 바로 걸립니다. 첫째, **경고는 컴파일을 멈추지 않습니다.** "컴파일 성공" 만 보고 넘기면 인용 자리에 `[?]` 가 찍힌 PDF, 여백 밖으로 글자가 튀어나온 PDF 를 그대로 제출하게 됩니다. 둘째, **BibTeX 오류는 LaTeX 로그에 없습니다.** BibTeX 는 LaTeX 와 따로 도는 프로그램이라 자기 로그(`.blg` 파일)에 기록합니다. 참고문헌이 통째로 비었는데 LaTeX 로그에는 아무 문제가 없어 보이는 상황은 대개 이것입니다.

아래는 수식 바깥에서 나는 오류 열두 가지를 다섯 갈래로 묶은 것입니다. 각각 *언제 나오는가 · 로그에서 어떻게 보이는가 · 왜 나는가 · 어떻게 고치는가* 순으로 적었습니다.

| 증상 | 볼 곳 |
|---|---|
| 그림·표 블록을 건드린 뒤 컴파일이 멈춤 | 1부 환경 오류 |
| 참고문헌 목록이 비었거나 인용이 `[?]` | 2부 참고문헌 오류 |
| 그림이 안 들어감 | 3부 그림·파일 오류 |
| 한글이 □ 로 찍히거나 안 보임 | 4부 한국어 오류 |
| 글자가 여백을 넘거나 그림이 엉뚱한 페이지로 밀림 | 5부 레이아웃 경고 |

# 1부 · 환경 오류

`\begin` 과 `\end` 의 짝이 어긋난 경우입니다. 셋 다 컴파일을 멈춥니다.

## \begin{figure} on input line N ended by \end{table}

**언제 나오는가.** 그림이나 표 블록을 복사해 붙인 직후에 가장 많습니다. `figure` 블록을 복사해서 표로 고치면서 여는 쪽만 `table` 로 바꾸고 닫는 쪽을 그대로 뒀을 때가 전형적입니다. 환경이 중첩된 곳 — `figure` 안의 `center`, `table` 안의 `tabular` — 에서 안쪽을 지우다 한 줄을 흘렸을 때도 나옵니다.

**로그에서 어떻게 보이는가.**

```
! LaTeX Error: \begin{figure} on input line 12 ended by \end{table}.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.20 \end{table}
```

환경 이름 자리(`figure` · `table`)에는 내 문서가 실제로 쓴 이름이 들어가므로 `align` · `itemize` · `tabular` 등 무엇이든 올 수 있습니다. 줄 번호가 **두 개** 나온다는 게 이 오류의 특징입니다. `on input line 12` 는 환경이 열린 자리, 마지막 줄의 `l.20` 은 닫으려다 어긋난 자리입니다. 고쳐야 할 것은 이 두 숫자 사이 구간 안에 있습니다.

**왜 나는가.** LaTeX 는 `\begin{이름}` 을 만나면 그 이름을 쌓아 두고, `\end{이름}` 에서 꺼내 같은 이름인지 대조합니다. 이름이 다르면 그 자리에서 멈춥니다. 그러니까 이 오류는 "짝이 없다" 가 아니라 **"짝은 있는데 이름이 다르다"** 입니다.

**어떻게 고치는가.** 로그가 알려 준 구간에서 모든 `\begin` 과 `\end` 가 같은 환경 이름을 쓰는지 확인합니다.

이름을 맞췄는데도 같은 오류가 난다면, 그 구간 안에 **중첩된 다른 환경**이 있는지 보세요. 안쪽 환경의 `\end` 가 빠져 있으면 바깥쪽 짝이 어긋난 것처럼 보고됩니다. 이때 실제로 고쳐야 하는 곳은 메시지가 지목한 바깥쪽이 아니라 안쪽입니다.

## Missing \begin{document}

**언제 나오는가.** 프리앰블에 뭔가를 추가한 직후 — 특히 웹에서 찾은 설정을 복사해 붙인 뒤입니다. 파일 맨 위에 메모나 제목을 그냥 텍스트로 적어 둔 경우에도 나옵니다.

**로그에서 어떻게 보이는가.**

```
! LaTeX Error: Missing \begin{document}.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.5 안
     녕하세요
```

마지막의 `l.5` 가 가리키는 것은 **LaTeX 가 본문이라고 판단한 첫 글자**입니다. 그 줄이 두 토막으로 나뉘어 찍히는데, 끊긴 자리가 정확히 문제가 감지된 지점입니다.

**왜 나는가.** 프리앰블은 선언만 허용되는 구간입니다. 공백과 주석을 제외한 문자가 하나라도 나타나면 LaTeX 는 본문이 시작됐다고 보는데, 아직 `\begin{document}` 를 만나지 못했으므로 멈춥니다. 흔한 트리거는 세 가지입니다 — 프리앰블에 그냥 쓴 텍스트, `\usepackage` 줄 뒤에 붙은 오타 문자, 복사 과정에 섞여 들어온 눈에 안 보이는 문자.

**어떻게 고치는가.** 프리앰블과 본문의 경계를 확인합니다. 모든 `\usepackage` 와 설정 선언은 `\begin{document}` **위**로, 실제 내용은 **아래**로 갑니다.

그렇게 했는데도 남는다면, 다른 파일을 `\input` 이나 `\include` 로 불러오고 있는지 확인하세요. 불러온 파일 안에 본문 텍스트가 들어 있고 그것이 `\begin{document}` 보다 먼저 읽히면 같은 결과가 됩니다.

## \begin{figure} ended by \end{document}

**언제 나오는가.** 문서를 어느 정도 쓴 뒤의 컴파일에서 나옵니다. 중간의 그림이나 표를 지우면서 닫는 줄만 함께 지웠거나, 붙여넣다 잘린 블록을 남겨 뒀을 때입니다.

**로그에서 어떻게 보이는가.**

```
! LaTeX Error: \begin{figure} on input line 30 ended by \end{document}.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.120 \end{document}
```

앞의 첫 번째 오류와 골격이 같지만 닫는 쪽이 `\end{document}` 라는 게 다릅니다. 이름이 어긋난 게 아니라 **짝이 아예 없어서 문서 끝까지 밀려갔다**는 뜻입니다. 그래서 범인이 있는 자리는 `on input line 30`, 즉 열린 쪽 하나뿐입니다.

**왜 나는가.** 열린 환경은 닫힐 때까지 쌓인 채로 남습니다. 문서 끝에 도달했는데 아직 닫히지 않은 환경이 남아 있으면, LaTeX 는 그 환경이 `\end{document}` 로 닫혔다고 보고 이 메시지를 냅니다.

**어떻게 고치는가.** `on input line` 이 가리키는 자리에서 열린 환경을 찾아 닫습니다.

하나 고쳤는데 또 같은 메시지가 뜬다면 정상입니다. 닫히지 않은 환경이 여럿이어도 한 번에 하나씩만 보고되기 때문입니다. 메시지가 사라질 때까지 고치고 다시 컴파일하는 과정을 반복하면 됩니다.

# 2부 · 참고문헌 오류

이 갈래를 다루기 전에 순서를 알아 둘 필요가 있습니다. 참고문헌은 LaTeX 혼자 만들지 않습니다.

1. LaTeX 가 한 번 돌면서 `\cite{}` 와 `\bibliographystyle{}` 의 흔적을 `.aux` 파일에 적습니다.
2. **BibTeX** 가 그 `.aux` 를 읽고, `.bib` 에서 해당 항목을 찾아 `.bbl` 파일을 만듭니다.
3. LaTeX 가 다시 돌면서 `.bbl` 의 내용을 본문에 채웁니다.

2번은 LaTeX 가 아니라 별개 프로그램입니다. 그래서 **이 갈래의 메시지는 LaTeX 로그에 없습니다.** 로컬이라면 `.blg` 파일이 BibTeX 의 로그이고, Overleaf 라면 로그 패널에서 raw log 를 펼쳐야 보입니다. 참고문헌이 비었는데 LaTeX 로그가 깨끗한 상황은 대개 여기를 안 봤기 때문입니다.

## Citation 'key' on page N undefined

**언제 나오는가.** 본문에 `\cite{}` 를 처음 넣고 컴파일했을 때입니다. 컴파일은 성공하고 PDF 도 나오는데, 인용이 있어야 할 자리에 `[?]` 가 찍혀 있습니다.

**로그에서 어떻게 보이는가.**

```
LaTeX Warning: Citation `einstein1905' on page 3 undefined on input line 42.

LaTeX Warning: There were undefined references.
```

`!` 로 시작하지 않는다는 데 주의하세요. 이건 오류가 아니라 **경고**라 컴파일이 멈추지 않습니다. 마지막 줄의 `There were undefined references` 는 문서 전체를 훑고 난 요약이므로, 이 줄이 보이면 어딘가에 `[?]` 가 남아 있다는 뜻입니다.

**왜 나는가.** 위의 세 단계 왕복 중 하나가 빠지면 본문에 채울 값이 없어 `[?]` 가 남습니다. 키가 `.bib` 에 실제로 없어서일 수도 있고, 있는데 아직 BibTeX 가 돌지 않았거나 그 결과를 반영할 마지막 LaTeX 실행이 없었을 수도 있습니다. 메시지만으로는 둘이 구분되지 않습니다.

**어떻게 고치는가.**

1. `.bib` 파일에 해당 항목이 있는지 확인합니다.
2. 키 이름의 대소문자와 철자가 본문의 `\cite{}` 와 정확히 일치하는지 확인합니다.
3. BibTeX 를 실행했는지 확인합니다 (Overleaf 는 자동으로 실행합니다).

셋이 다 맞는데도 `[?]` 가 남는다면 **컴파일 횟수** 문제입니다. 앞의 왕복 때문에 처음 참고문헌을 넣은 문서는 한 번의 컴파일로 완성되지 않습니다. Overleaf 는 Recompile 을 한 번 더 누르면 되고, 로컬이라면 LaTeX → BibTeX → LaTeX → LaTeX 순으로 직접 돌립니다. 그래도 이상하면 `.aux` 를 비롯한 중간 파일을 지우고 처음부터 컴파일해 보세요 (Overleaf 에도 캐시 파일을 지우는 항목이 있습니다).

## I found no \bibstyle command

**언제 나오는가.** `\bibliography{refs}` 를 넣고 컴파일했는데 참고문헌 목록 자리가 통째로 비어 있을 때입니다.

**로그에서 어떻게 보이는가.** LaTeX 로그가 아니라 BibTeX 로그입니다.

```
This is BibTeX, Version 0.99d
The top-level auxiliary file: main.aux
I found no \bibstyle command---while reading file main.aux
(There was 1 error message)
```

`---while reading file main.aux` 가 핵심입니다. BibTeX 가 보고 있는 건 내가 쓴 `.tex` 가 아니라 **LaTeX 가 만들어 준 `.aux`** 이고, 거기에 `\bibstyle` 줄이 없다는 뜻입니다.

**왜 나는가.** `\bibliographystyle{plain}` 을 선언하면 컴파일 시 `.aux` 에 `\bibstyle{plain}` 한 줄이 기록됩니다. BibTeX 는 그 줄을 읽어 어떤 서식(`plain`, `unsrt`, `apalike` 등)으로 목록을 조판할지 정합니다. 그 선언이 없으면 기준이 없어 아무것도 만들지 못합니다.

**어떻게 고치는가.** `\bibliographystyle{plain}` 을 `\bibliography{...}` 앞에 추가합니다.

추가했는데도 같은 메시지가 나온다면 두 가지를 확인하세요. 하나는 두 명령이 모두 `\begin{document}` 와 `\end{document}` **사이**에 있는지. 다른 하나는 `\bibliography{}` 에 적은 파일명에 확장자가 붙어 있지 않은지입니다 — `\bibliography{refs}` 가 맞고 `\bibliography{refs.bib}` 는 틀립니다.

## I found no \citation commands

**언제 나오는가.** 참고문헌 설정만 해 두고 본문에서 아직 한 번도 인용하지 않은 상태로 컴파일했을 때입니다. 템플릿을 받아 쓰기 시작한 초반에 자주 봅니다.

**로그에서 어떻게 보이는가.** 역시 BibTeX 로그입니다.

```
This is BibTeX, Version 0.99d
The top-level auxiliary file: main.aux
I found no \citation commands---while reading file main.aux
(There was 1 error message)
```

바로 앞의 메시지와 형태가 같고 찾는 대상만 다릅니다. 둘이 함께 뜨는 경우도 흔합니다.

**왜 나는가.** BibTeX 는 `.aux` 에 쌓인 `\citation{...}` 목록을 보고 **어떤 항목을 목록에 실을지** 고릅니다. 인용이 하나도 없으면 고를 대상이 없습니다. 즉 이건 문서가 망가졌다는 신호가 아니라, 참고문헌 기계를 켜 뒀는데 아직 쓰지 않고 있다는 신호입니다.

**어떻게 고치는가.** 참고문헌을 쓸 계획이 없다면 `\bibliography{}` 와 `\bibliographystyle{}` 을 지웁니다.

쓸 계획이라면 본문에 `\cite{}` 를 하나 넣고 다시 컴파일하면 사라집니다. 인용은 하지 않되 `.bib` 의 항목을 전부 목록에 싣고 싶다면 `\nocite{*}` 를 본문에 넣는 방법도 있습니다.

# 3부 · 그림·파일 오류

## LaTeX Error: File 'image.png' not found

**언제 나오는가.** `\includegraphics` 를 처음 넣고 컴파일했을 때, 그리고 **작업 환경을 옮긴 직후**입니다. 로컬에서 잘 되던 문서를 Overleaf 에 올렸을 때, 또는 그 반대일 때 몰려서 나옵니다.

**로그에서 어떻게 보이는가.**

```
! LaTeX Error: File `image.png' not found.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.30 \includegraphics[width=0.8\linewidth]{image.png}
```

따옴표 짝이 안 맞아 보이는 건 오타가 아닙니다. LaTeX 로그는 이름을 여는 백틱과 닫는 작은따옴표로 감싸는 관습이 있습니다. 그 안에 있는 것이 **LaTeX 가 실제로 찾은 이름**이므로, 내 파일 이름과 글자 단위로 비교하면 됩니다.

**왜 나는가.** 이름 대소문자 때문인 경우가 압도적으로 많습니다. Windows 와 macOS 는 파일명 대소문자를 구분하지 않는 설정이 기본인 반면, Overleaf 가 도는 리눅스는 구분합니다. 그래서 `Graph.PNG` 와 `graph.png` 가 내 컴퓨터에서는 같은 파일이고 Overleaf 에서는 다른 파일입니다. 환경을 옮긴 직후에 이 오류가 몰리는 이유가 이것입니다.

**어떻게 고치는가.**

1. 파일을 실제로 업로드했는지 확인합니다.
2. 파일 이름의 대소문자가 정확히 일치하는지 확인합니다.
3. 서브폴더에 있다면 경로를 포함합니다 — `\includegraphics{images/graph.png}`.

그래도 안 되면 경로 구분자를 보세요. Windows 식 역슬래시(`images\graph.png`)는 LaTeX 에서 명령어의 시작으로 읽히므로 반드시 슬래시(`/`)를 씁니다. 그림이 여러 폴더에 흩어져 있다면 프리앰블에 {% raw %}`\graphicspath{{images/}{figures/}}`{% endraw %} 를 선언해 두고 파일명만으로 부르는 편이 안전합니다.

## Package pdftex.def Error: File 'image' not found

**언제 나오는가.** 확장자를 빼고 `\includegraphics{graph}` 라고 적었을 때, 그리고 EPS 그림을 pdfLaTeX 로 컴파일했을 때입니다. 학회 템플릿이나 오래된 예제 파일을 그대로 가져오면 그림이 EPS 인 경우가 많습니다.

**로그에서 어떻게 보이는가.**

```
! Package pdftex.def Error: File `graph' not found: using draft setting.

See the pdftex.def package documentation for explanation.
Type  H <return>  for immediate help.
 ...

l.30 \includegraphics{graph}
```

앞의 오류와 달리 `Package pdftex.def Error` 로 시작합니다. LaTeX 본체가 아니라 **PDF 출력 드라이버**가 낸 메시지라는 뜻입니다. 뒤에 붙은 `using draft setting` 은 그림 자리에 빈 상자를 넣고 그냥 진행하겠다는 의미입니다.

**왜 나는가.** 확장자를 생략하면 드라이버가 자기가 처리할 수 있는 확장자를 순서대로 붙여 가며 파일을 찾습니다. pdfLaTeX 드라이버의 목록에는 PDF·PNG·JPG 가 있지만 EPS 는 없습니다. 그래서 폴더에 `graph.eps` 가 멀쩡히 있어도 "없다" 고 나옵니다. 파일이 없는 게 아니라 **이 드라이버로는 넣을 수 없는 형식**인 상황입니다.

**어떻게 고치는가.** PNG, JPG, PDF 형식을 씁니다. EPS 파일은 변환이 필요합니다.

원인이 형식인지 이름인지 헷갈린다면, 확장자를 명시해서 `\includegraphics{graph.pdf}` 처럼 어느 파일을 원하는지 못 박아 보세요. 그래도 못 찾으면 이름·경로 문제이고, 찾으면 형식 문제였던 것입니다.

# 4부 · 한국어 오류

## 한글이 □ 로 나오거나 아예 안 보일 때

**언제 나오는가.** 영문 템플릿에 한국어를 처음 입력했을 때입니다. 학회나 학교에서 받은 템플릿은 대부분 영문 기준이라, 제목만 영어이고 본문이 한국어인 문서에서 제목은 멀쩡한데 본문만 깨지는 형태로 나타납니다.

**로그에서 어떻게 보이는가.** 여기가 갈리는 지점입니다. 증상은 비슷해 보여도 로그는 두 갈래이고, 어느 쪽이냐에 따라 손댈 곳이 다릅니다.

컴파일러가 pdfLaTeX 이고 `kotex` 이 없으면 **아예 멈춥니다**.

```
! Package inputenc Error: Unicode character 한 (U+D55C)
(inputenc)                not set up for use with LaTeX.
```

컴파일러가 XeLaTeX / LuaLaTeX 인데 폰트에 한글 글자가 없으면 **멈추지 않고** 경고만 남습니다.

```
Missing character: There is no 한 in font [lmroman10-regular]:...
```

두 번째 경우가 까다롭습니다. 컴파일은 "성공" 으로 표시되고 PDF 도 생성되는데 그 글자 자리만 비거나 □ 로 찍힙니다. 로그를 펼쳐 `Missing character` 를 찾지 않으면 원인을 못 찾습니다.

**왜 나는가.** 한국어 출력에는 두 가지가 동시에 필요합니다. 한국어 문자를 처리할 줄 아는 **패키지**(`kotex`), 그리고 그 글자를 실제로 그릴 수 있는 **폰트**입니다. 첫 번째 오류는 패키지가 없는 경우이고, 두 번째 경고는 패키지는 있으나 지정된 폰트가 한글 글자를 갖고 있지 않은 경우입니다. pdfLaTeX 는 시스템 폰트를 직접 다루지 못해 한국어 문서에 적합하지 않고, XeLaTeX 와 LuaLaTeX 는 시스템 폰트를 이름으로 불러 쓸 수 있어 한국어의 기본 선택이 됩니다.

**어떻게 고치는가.**

1. 프리앰블에 `\usepackage{kotex}` 을 추가합니다.
2. 컴파일러를 바꿉니다. Overleaf 라면 메뉴 → **Settings** → **Compiler** 에서 **XeLaTeX** 또는 **LuaLaTeX** 를 선택합니다.

둘 다 했는데 여전히 `Missing character` 가 남는다면 남은 원인은 폰트입니다. 다음 절로 이어집니다.

## Package kotex Error: Can't find korean font

**언제 나오는가.** 컴파일러를 XeLaTeX 나 LuaLaTeX 로 바꾼 직후입니다. 앞 절의 조치를 하고 나서 이어서 만나는 경우가 많아, 사실상 같은 문제의 두 번째 단계로 보면 됩니다.

**로그에서 어떻게 보이는가.**

```
! Package kotex Error: Can't find korean font.
```

`Package kotex Error` 로 시작하므로 LaTeX 본체가 아니라 한국어 패키지가 낸 메시지입니다. 앞 절의 `Missing character` 가 "글자를 못 그렸다" 는 사후 보고라면, 이쪽은 "쓸 폰트를 아예 정하지 못했다" 는 사전 보고입니다.

**왜 나는가.** XeLaTeX 와 LuaLaTeX 는 시스템에 설치된 폰트를 **이름으로** 불러 씁니다. 어떤 폰트를 쓸지 지정하지 않으면 한국어 글자를 담당할 폰트가 정해지지 않습니다.

**어떻게 고치는가.** 프리앰블에서 폰트를 명시합니다.

```latex
\usepackage{kotex}
\setmainfont{Noto Serif CJK KR}   % 본문 폰트
\setsansfont{Noto Sans CJK KR}    % 산세리프 폰트
```

지정했는데도 같은 오류가 난다면 폰트 **이름**을 의심하세요. 이름은 시스템에 설치된 것과 정확히 일치해야 하고, 내 컴퓨터에 있는 폰트라도 Overleaf 서버에 없으면 똑같이 못 찾습니다. 로컬에서는 되는데 Overleaf 에서만 안 되는 경우라면 거의 이것입니다.

# 5부 · 레이아웃 경고

여기 둘은 오류가 아니라 경고입니다. 컴파일은 성공하고 PDF 도 정상적으로 나옵니다. 그래서 로그를 열지 않으면 그대로 지나가고, 인쇄하거나 제출한 뒤에야 발견하게 됩니다.

## Overfull \hbox (Xpt too wide)

**언제 나오는가.** 긴 URL, 긴 영문 단어, 하이픈 위치를 알 수 없는 고유명사를 넣은 뒤입니다. 두 단 조판에서는 단 폭이 좁아지는 만큼 급격히 늘어납니다.

**로그에서 어떻게 보이는가.**

```
Overfull \hbox (15.23448pt too wide) in paragraph at lines 42--45
[]\OT1/cmr/m/n/10 https://example.com/very/long/path/...
```

두 줄을 같이 봐야 합니다. 첫 줄의 `lines 42--45` 는 문제 단락의 범위이고, 둘째 줄은 **넘친 줄의 실제 내용**입니다. 둘째 줄을 보면 어떤 단어가 범인인지 바로 드러납니다. 넘친 양이 몇 pt 수준이면 육안으로는 알아채기 어렵고, 수십 pt 면 여백 밖으로 튀어나온 것이 보입니다.

**왜 나는가.** LaTeX 는 한 줄에 들어갈 단어를 고르고 단어 사이 공백을 늘였다 줄였다 하며 양쪽 끝을 맞춥니다. 그런데 줄바꿈할 자리를 찾을 수 없는 덩어리가 남은 폭보다 길면 더 손쓸 방법이 없습니다. 그래서 넘긴 채로 조판하고, 얼마나 넘쳤는지를 보고합니다.

**어떻게 고치는가.**

1. 해당 단락에 `\sloppy` 를 추가합니다 (공백을 더 늘려 넘김을 없애는 임시 조치).
2. 긴 URL 은 `\url{}` 로 감쌉니다.
3. 단어 중간에 하이픈이 들어갈 위치를 지정합니다 — `\hyp{}` 또는 `hyphenation` 설정.

이걸 다 해도 안 줄어든다면 원인이 단락이 아니라 **표**일 수 있습니다. 표가 넘칠 때는 `\sloppy` 가 듣지 않습니다. 셀 안에서 줄바꿈이 되도록 `p{3cm}` 처럼 폭을 직접 지정하는 열로 바꾸는 편이 확실합니다.

## Float too large for page by Xpt

**언제 나오는가.** 큰 이미지나 긴 표를 `figure` · `table` 환경에 넣었을 때입니다. 그림이 엉뚱한 페이지로 밀리거나 문서 맨 끝에 우르르 몰리는 증상과 함께 나타납니다.

**로그에서 어떻게 보이는가.**

```
LaTeX Warning: Float too large for page by 22.4pt on input line 60.
```

`LaTeX Warning:` 으로 시작하고 `!` 가 없습니다. `on input line 60` 이 문제의 `figure` 나 `table` 이 있는 자리입니다.

**왜 나는가.** float — `figure` 와 `table` — 는 페이지 안에 **통째로** 들어가야 배치됩니다. 캡션까지 합친 높이가 본문 영역의 높이를 넘으면 어느 페이지에도 앉히지 못해 계속 뒤로 밀립니다. 그림이 원고 끝에 몰려 나오는 현상의 흔한 원인이 이것입니다.

**어떻게 고치는가.** `\includegraphics[width=0.9\linewidth]{...}` 처럼 크기를 줄입니다.

폭을 줄였는데도 남는다면 원인은 **높이**입니다. 세로로 긴 그림은 폭을 줄여도 비율 때문에 높이가 충분히 줄지 않습니다. 이때는 `height` 를 기준으로 크기를 지정하는 편이 낫고, 캡션이 여러 줄이라면 캡션을 줄이는 것만으로도 해결되는 경우가 있습니다.

## 정리

| 메시지 | 멈추는가 | 먼저 볼 것 |
|---|---|---|
| `\begin{...} on input line N ended by \end{...}` | 멈춤 | 두 줄 번호 사이 구간의 환경 이름 |
| `Missing \begin{document}` | 멈춤 | 프리앰블에 섞인 본문 텍스트 |
| `\begin{...} ended by \end{document}` | 멈춤 | `on input line` 이 가리키는 열린 환경 |
| `Citation 'key' on page N undefined` | 안 멈춤 | `.bib` 의 키, 그리고 컴파일 횟수 |
| `I found no \bibstyle command` | LaTeX 는 성공 | `\bibliographystyle{}` 선언 유무 |
| `I found no \citation commands` | LaTeX 는 성공 | 본문에 `\cite{}` 가 하나라도 있는지 |
| `File 'image.png' not found` | 멈춤 | 파일명 대소문자, 경로 구분자 |
| `Package pdftex.def Error: File 'image' not found` | 멈춤 | 그림 형식 (EPS 인지), 확장자 명시 |
| 한글이 □ 로 출력 | 경우에 따라 | `kotex` 유무와 컴파일러 종류 |
| `Package kotex Error: Can't find korean font` | 멈춤 | `\setmainfont` 의 폰트 이름 |
| `Overfull \hbox` | 안 멈춤 | 로그 둘째 줄의 실제 내용 |
| `Float too large for page` | 안 멈춤 | 그림의 높이와 캡션 길이 |

메시지를 외울 필요는 없습니다. 앞머리로 **누가 낸 것인지**(LaTeX 본체 · 패키지 · BibTeX) 를 가르고, `!` 유무로 **멈추는 것인지** 를 가르고, 로그가 준 줄 번호에서 시작하는 순서만 몸에 붙으면 대부분은 몇 분 안에 끝납니다. 특히 경고는 컴파일이 성공했다고 표시되기 때문에, 제출 전에 로그를 한 번 훑는 습관이 결과물의 완성도를 크게 좌우합니다.

---

수식 안에서 나는 오류는 갈래가 달라 이 글에서 다루지 않았습니다. `! Missing $ inserted` · `! Missing \endgroup inserted` · `! Extra }, or forgotten $` · `! Undefined control sequence` 와, 컴파일은 되는데 출력이 어긋나는 수식 실수는 [LaTeX 수식 오류·실수 완전 해결 가이드](/blog/posts/latex-math-errors-guide/) 에 정리해 두었습니다.

*명령어 이름 자체가 헷갈릴 때는 — [LaTeX 명령어 치트시트](/blog/posts/latex-command-cheatsheet/) / [그리스 문자·수학 기호 레퍼런스](/blog/posts/latex-greek-letters-complete/) 가 참고가 됩니다.*
