---
title: "LaTeX 단위와 숫자 — siunitx 로 고치는 다섯 가지"
date: 2026-10-14 09:00:00 +0900
categories: [LaTeX, 수식]
tags: [latex, siunitx, 단위, qty, unit, num, ang, 불확도, 실험보고서, 물리, 공학]
math: true
pin: false
description: "단위가 이탤릭으로 붙고, 큰 수에 자릿수 구분이 없고, 1.23e4 가 그대로 찍히고, ± 불확도와 각도·범위 표기가 문서마다 제각각인 다섯 장면의 답 — \\qty·\\unit (단위), \\num (자릿수·지수·불확도), \\ang, \\qtyrange·\\qtylist — 을 실측으로 정리합니다. v2 의 \\SI·\\si 가 v3 에서 \\qty·\\unit 로 바뀐 것과 내 버전 확인법, physics 패키지와 \\qty 가 충돌할 때, 단위 안에 한글을 그냥 치면 깨지는 이유까지."
---

실험 보고서나 공학 논문에서 숫자와 단위를 손으로 치다 보면 다섯 가지 장면이 나옵니다.

1. `$v = 3 m/s$` — 단위가 변수처럼 기울고 숫자에 붙는다.
2. `12345678` — 큰 수가 한 덩어리라 자릿수가 안 읽힌다.
3. `1.23e4` — 계산기·코드에서 복사한 지수 표기가 그대로 찍힌다.
4. `1.23 \pm 0.04`, `1.23(4)` — 불확도 표기가 문서 안에서 섞인다.
5. `30^\circ`, `25^\circ C`, `10\%`, `1 m to 10 m` — 각도·온도·퍼센트·범위의 간격이 매번 다르다.

[수식 안 글자체 글](/blog/posts/latex-math-fonts-text-mathrm-mathbf/)에서는 단위를 `3\,\mathrm{m/s}` 로 세우라고 했습니다. 그것으로 한 문장은 해결되지만, 문서 전체에서 같은 간격·같은 모양을 지키는 일은 사람 몫으로 남습니다. `siunitx` 는 이 일을 패키지가 맡게 합니다. 숫자는 `\num`, 단위는 `\unit`, 둘을 합친 양은 `\qty` 에 넣고, 모양은 프리앰블의 설정 한 곳에서 정합니다.

아래 결과는 전부 MiKTeX 25.12 (pdfTeX, LaTeX2e 2025-11-01, `siunitx` **v3.6.2**, `amsmath` + `kotex` 로드) 로 컴파일한 것이고, 같은 원본을 Tectonic 0.17 (`siunitx` v3.0.49) 로 한 번 더 컴파일해 결과가 같은 것을 확인했습니다. 다른 점은 한 군데뿐이라 §7 에 적었습니다.

> 이 블로그의 수식 엔진 (MathJax) 은 `siunitx` 명령을 모릅니다. 그래서 이 글의 출력은 수식 렌더가 아니라 **pdfLaTeX 로 컴파일한 PDF 를 잘라 낸 그림**입니다. 웹 수식 미리보기에서 `\qty` 가 렌더되지 않아도 PDF 에서는 나옵니다.
{: .prompt-info }

## 1. 시작 — 한 줄 로드

```latex
\usepackage{siunitx}
```

기본 설정 그대로도 아래 다섯 장면이 전부 해결됩니다. 설정을 바꾸는 것은 §8 에서 한 번에 모았습니다.

## 2. 단위 — \qty 와 \unit

![단위 입력 실측 — $v = 3 m/s$ 는 이탤릭 3m/s 로 붙고, \mathrm 과 \qty{3}{m/s} 는 세운 3 m/s, \qty{3}{\metre\per\second} 는 3 m s⁻¹, per-mode=symbol 은 3 m/s, per-mode=fraction 은 분수, \per\second\per\second 는 s⁻¹ s⁻¹ 로 두 번, \per\second\squared 는 s⁻²](/assets/img/posts/2026-10-14/01-units-per-mode.png){: width="720" }

`\qty{숫자}{단위}` 가 양 (quantity), `\unit{단위}` 가 숫자 없는 단위입니다. 실측 다섯 가지.

- **`$3 m/s$` 는 `3m/s` 이탤릭.** `m` 과 `s` 가 변수가 되고 공백은 버려집니다 (수식 모드의 규칙 — [글자체 글](/blog/posts/latex-math-fonts-text-mathrm-mathbf/) §1).
- **`\qty{3}{kg}` 와 `$3\,\mathrm{kg}$` 는 폭까지 같습니다.** 실측 폭이 둘 다 17.08 pt — `siunitx` 가 숫자와 단위 사이에 넣는 것이 바로 가는 공백 `\,` 입니다. `$3 kg$` 는 15.65 pt 로 공백이 없습니다. 즉 `\qty` 는 손으로 하던 일을 똑같이, 빠짐없이 하는 것입니다.
- **단위는 두 가지로 칠 수 있습니다.** 글자 그대로 `\qty{3}{m/s}` 는 쓴 대로 `3 m/s`, 명령으로 `\qty{3}{\metre\per\second}` 는 `3 m s⁻¹`. 명령으로 쓰면 모양을 설정 한 줄로 바꿀 수 있습니다 — 다음 항목.
- **`\per` 의 모양은 `per-mode` 가 정합니다.** 기본값은 음의 지수 (`m s⁻¹`), `per-mode=symbol` 은 빗금 (`m/s`), `per-mode=fraction` 은 분수. 논문 투고 규정이 "단위는 m s⁻¹ 형식" 이라고 할 때 문서 전체를 고치는 데 설정 한 줄이면 됩니다.
- **`\per\second\per\second` 는 `s⁻¹ s⁻¹`** 로 두 번 찍힙니다. 합쳐 주지 않습니다. 가속도는 `\per\second\squared`.

자주 쓰는 단위 명령은 이름 그대로입니다 — `\metre` `\gram` `\second` `\kelvin` `\joule` `\newton` `\pascal` `\volt` `\ohm` `\hertz` `\litre`, 접두어 `\kilo` `\milli` `\micro` `\nano` `\mega`, 거듭제곱 `\squared` `\cubed`. 실측으로 `\qty{5}{\micro\litre}` 는 `5 µL`, `\qty{2}{\kilo\ohm}` 는 `2 kΩ`, `\qty{3}{\angstrom}` 은 `3 Å`. `\kg` `\cm` `\MHz` 같은 약어 명령도 들어 있습니다 (실측 `3 kg` `3 cm` `5 MHz`).

## 3. 숫자 — \num 의 자릿수와 지수

![숫자 입력 실측 — 12345 는 그대로, \num{12345} 는 12 345, 1234 는 둘 다 1234, \num{0.12345} 는 0.123 45, \num{1.23e4} 는 1.23 × 10⁴, \qty{1.6e-19}{\coulomb} 는 1.6 × 10⁻¹⁹ C, \num{1,234} 는 1.234, 불확도 1.23(4) 는 기본에서 괄호형, uncertainty-mode=separate 에서 1.23 ± 0.04](/assets/img/posts/2026-10-14/02-numbers-uncertainty.png){: width="720" }

**자릿수 구분.** `\num{12345}` 는 `12 345` 로 세 자리마다 가는 공백을 넣습니다. 쉼표가 아니라 공백인 것은 ISO 규정 (쉼표는 나라에 따라 소수점이라 헷갈리지 않게) 이고, 소수 쪽도 `0.123 45` 로 묶습니다. **네 자리 수는 묶지 않습니다** — 실측으로 `\num{1234}` 는 `1234`. 기본값이 "다섯 자리부터" 이기 때문이고, `group-minimum-digits=4` 로 바꾸면 `1 234` 가 됩니다.

**지수.** `\num{1.23e4}` 는 `1.23 × 10⁴`, `\num{1.23E-4}` 는 `1.23 × 10⁻⁴`. 코드나 엑셀에서 복사한 값을 그대로 넣으면 됩니다. 곱셈 기호를 가운뎃점으로 하려면 `exponent-product=\cdot` (실측 `1.6 · 10⁻¹⁹ C`).

> **`\num{1,234}` 는 천이백삼십사가 아닙니다.** 실측 출력은 `1.234` — 쉼표를 **소수점으로** 읽습니다 (쉼표 소수점을 쓰는 나라의 입력을 받기 위해서). `\num{1,234,567}` 은 `Invalid number` 오류로 멈춥니다. 천 단위 쉼표는 입력에 넣지 말고, 출력에 쉼표가 필요하면 `group-separator={,}` 로 설정합니다 (실측 `1,234,567`).
{: .prompt-warning }

## 4. 불확도 — 괄호형과 ± 형

측정값의 불확도는 두 가지로 쓰고, `siunitx` 는 어느 쪽으로 입력해도 **한 가지 모양으로 맞춰서** 냅니다.

- 기본값은 괄호형입니다. `\num{1.23(4)}` 도 `\num{1.23 +- 0.04}` 도 실측으로 똑같이 `1.23(4)` 가 됩니다. `(4)` 는 마지막 자리의 불확도, 즉 ±0.04 라는 뜻입니다.
- `uncertainty-mode=separate` 로 바꾸면 둘 다 `1.23 ± 0.04` 가 됩니다.
- 단위가 붙으면 차이가 하나 더 생깁니다. 괄호형은 `9.81(2) m s⁻²` 로 그대로이고, ± 형은 실측으로 `(9.81 ± 0.02) m s⁻²` — 단위가 두 숫자 모두에 걸린다는 뜻으로 **괄호를 자동으로** 씌웁니다. 손으로 쓸 때 가장 자주 빠뜨리는 괄호입니다.

한 보고서 안에서 괄호형과 ± 형이 섞여 있다면, 입력은 그대로 두고 설정만 하나 고르면 됩니다.

## 5. 각도 · 온도 · 퍼센트 · 범위 · 목록

![각도·범위 실측 — $30^\circ$ 와 \ang{30} 은 같은 30°, \ang{12;30;15} 는 12°30′15″, $25^\circ C$ 는 C 가 이탤릭, \qty{25}{\degreeCelsius} 는 25 °C, $10\%$ 는 붙고 \qty{10}{\percent} 는 10 % 로 띄움, \qtyrange 기본은 1 m to 10 m, \qtylist 기본은 1 m, 2 m and 3 m, 설정을 바꾸면 1–10 m 와 1 m, 2 m, 3 m, \qty{3}{킬로그램} 은 한글이 사라지고 \text 로 감싸면 3 킬로그램](/assets/img/posts/2026-10-14/03-angles-ranges-korean.png){: width="720" }

- **각도.** `\ang{30}` 은 `30°` 로 `$30^\circ$` 와 같습니다. 차이는 도·분·초에서 납니다 — `\ang{12;30;15}` 가 `12°30′15″` 로 프라임 기호까지 맞춰 줍니다.
- **섭씨.** `$25^\circ C$` 는 `C` 가 이탤릭 변수가 됩니다. `\qty{25}{\degreeCelsius}` 는 세운 `°C` 에 가는 공백. (v2 이름 `\celsius` 도 v3.6.2 에서 실측으로 같은 결과입니다.)
- **퍼센트.** `\qty{10}{\percent}` 는 `10 %` 로 **띄웁니다** — ISO 규정이 퍼센트도 단위로 보기 때문입니다. 투고 규정이나 학위논문 양식이 `10%` 로 붙이라고 하면 `\num{10}\%` 로 씁니다 (실측 `10%`).
- **범위와 목록.** `\qtyrange{1}{10}{\metre}` 는 `1 m to 10 m`, `\qtylist{1;2;3}{\metre}` 는 `1 m, 2 m and 3 m` — 기본값의 연결어가 **영어**입니다. 한글 문서에서는 이 둘을 §8 처럼 설정해 두면 `1–10 m`, `1 m, 2 m, 3 m` 이 됩니다.

## 6. v2 의 \SI 와 v3 의 \qty — 내 버전 확인

인터넷의 예제는 둘로 나뉩니다. 오래된 글은 `\SI{3}{\metre}` · `\si{\metre}` · `\SIrange`, 최근 글은 `\qty` · `\unit` · `\qtyrange`. **v3 에서 이름이 바뀌었습니다.**

| v2 | v3 |
|---|---|
| `\SI{3}{\metre}` | `\qty{3}{\metre}` |
| `\si{\metre}` | `\unit{\metre}` |
| `\SIrange` · `\SIlist` | `\qtyrange` · `\qtylist` |
| `\num` · `\ang` | 그대로 |

두 방향의 결과가 다릅니다.

- **v3 에서 v2 이름을 쓰면 → 그대로 됩니다.** 실측으로 v3.6.2 에서 `\SI{3}{\metre\per\second}` · `\si{\kilo\gram}` · `\SIrange{1}{10}{\metre}` 가 경고 없이 `\qty` 와 같은 결과를 냅니다. 옛 예제를 붙여 넣어도 문제없습니다.
- **v2 에서 v3 이름을 쓰면 → 오류.** v3 에 들어 있는 v2 판 (`\usepackage{siunitx}[=v2]`, 마지막 v2 인 2.8e, 2021-04-17) 으로 실측하면 `\qty` 에서 `Undefined control sequence` 로 멈춥니다.

마지막 v2 가 2021년 4월이므로, 그 뒤의 TeX 배포판은 v3 입니다. 오래된 TeX Live 를 쓰는 학교 서버나, 프로젝트의 TeX Live 연도를 예전 것으로 둔 Overleaf 프로젝트에서 이 오류가 납니다. **내 버전은 로그에 적혀 있습니다.** `.log` 파일에서 `Package: siunitx` 를 찾으면 됩니다.

```text
Package: siunitx 2026-09-18 v3.6.2 A comprehensive (SI) units package
```

v2 와 v3 양쪽에서 컴파일되어야 하는 원고라면 `\SI` · `\si` 로 쓰는 것이 안전합니다.

### physics 패키지와 \qty 가 부딪칠 때

`physics` 패키지에도 `\qty` 가 있습니다 (괄호 크기를 맞추는 명령). 둘을 함께 로드하면 실측으로 `siunitx` 가 이렇게 알리고 **자기 `\qty` 를 정의하지 않습니다** — 로드 순서를 바꿔도 같습니다.

```text
Package siunitx Warning: Detected the "physics" package:
(siunitx)                omitting definition of \qty.
```

이때 `\qty{3}{\metre}` 는 `physics` 의 `\qty` 로 처리되어 `Missing $ inserted` 오류가 줄줄이 납니다. 해결은 위 표의 v2 이름입니다 — `physics` 와 함께 쓴 문서에서 `\SI{3}{\metre\per\second}` 는 실측으로 오류 없이 `3 m s⁻¹` 입니다. 경고문은 `\AtBeginDocument{\RenewCommandCopy\qty\SI}` 도 제안하지만, 그러면 `physics` 의 `\qty` 를 잃습니다.

## 7. 단위 안에 한글

`\qty{3}{킬로그램}` 처럼 단위 자리에 한글을 그냥 치면 **오류 없이 한글만 사라집니다.** 실측 출력은 pdfLaTeX 에서 `3 \`, Tectonic 에서 `3` 이고, 로그에 `Missing character` 경고만 남습니다. [글자체 글](/blog/posts/latex-math-fonts-text-mathrm-mathbf/) §3 의 "수식 안 한글" 과 같은 원인입니다 — `siunitx` 는 단위를 수식 글꼴로 조판하고, 수식 글꼴에는 한글이 없습니다. 두 엔진의 결과가 다른 것은 이 한 줄뿐이었습니다.

`\qty{3}{\text{킬로그램}}` 으로 감싸면 본문 글꼴로 넘어가 `3 킬로그램` 이 나옵니다. "명", "회", "개" 같은 한글 단위도 같은 방법입니다.

## 8. 설정은 프리앰블 한 곳에

모양을 바꾸는 설정은 명령마다 `[...]` 로 줄 수도 있지만 (그림의 `per-mode=symbol` 처럼), 문서 전체에 한 번 정하는 것이 `siunitx` 를 쓰는 이유입니다. 한글 보고서용으로 실측한 설정입니다.

```latex
\usepackage{siunitx}
\sisetup{
  range-units          = single,  % 1–10 m (단위를 끝에 한 번)
  range-phrase         = --,      % "to" 대신 en dash
  list-pair-separator  = {, },    % "and" 대신 쉼표 (두 개)
  list-final-separator = {, },    % "and" 대신 쉼표 (세 개 이상)
  uncertainty-mode     = separate,% 1.23 ± 0.04
}
```

```latex
측정 범위는 \qtyrange{1}{10}{\metre} 이고, 시료는 \qtylist{1;2;3}{\gram} 입니다.
중력가속도는 \qty{9.81(2)}{\metre\per\second\squared} 로 측정했습니다.
```

실측 출력은 `1–10 m`, `1 g, 2 g, 3 g`, `(9.81 ± 0.02) m s⁻²` 입니다 (pdfLaTeX · Tectonic 동일). 필요하면 `per-mode = symbol` (m/s), `group-minimum-digits = 4` (1 234), `exponent-product = \cdot` 을 같은 자리에 더합니다.

## 9. 자주 하는 실수

- **`$3 m/s$`** → 이탤릭 `3m/s`. `\qty{3}{m/s}` 또는 `\qty{3}{\metre\per\second}`.
- **`\num{1,234}`** → 천이백이 아니라 `1.234`. 입력에 천 단위 쉼표를 넣지 않는다 (§3).
- **`\per\second\per\second`** → `s⁻¹ s⁻¹`. `\per\second\squared`.
- **`$25^\circ C$`** → 이탤릭 `C`. `\qty{25}{\degreeCelsius}`.
- **한글 문서에서 `\qtyrange` 를 기본값으로** → `1 m to 10 m`. §8 설정.
- **오래된 TeX 에서 `\qty`** → `Undefined control sequence`. 로그에서 버전 확인, 또는 `\SI`.
- **`physics` 와 함께 `\qty{3}{\metre}`** → `Missing $ inserted`. `\SI`.
- **단위 자리에 한글 그대로** → 오류 없이 사라짐. `\text{…}` 로 감싼다.

## 정리

| 하고 싶은 것 | 코드 |
|---|---|
| 숫자 + 단위 | `\qty{3}{\metre\per\second}` (v2: `\SI`) |
| 단위만 | `\unit{\kilo\gram}` (v2: `\si`) |
| 큰 수 · 지수 | `\num{12345}` → 12 345, `\num{1.23e4}` → 1.23 × 10⁴ |
| 불확도 | `\num{1.23(4)}`, ± 형은 `uncertainty-mode=separate` |
| 각도 · 섭씨 · 퍼센트 | `\ang{12;30;15}`, `\qty{25}{\degreeCelsius}`, `\qty{10}{\percent}` |
| 범위 · 목록 | `\qtyrange{1}{10}{\metre}`, `\qtylist{1;2;3}{\gram}` + §8 설정 |
| 분수 단위의 모양 | `per-mode = power / symbol / fraction` |
| 단위 안 한글 | `\qty{3}{\text{킬로그램}}` |

손으로 `3\,\mathrm{m/s}` 를 치는 것은 틀린 것이 아닙니다. 다만 한 문서에 수치가 수십 개가 되면, 간격과 모양을 한 곳에서 정하는 쪽이 고치기 쉽습니다. 그것이 `siunitx` 가 하는 일의 전부입니다.

---

이전 글: [LaTeX 정리·증명 환경 — amsthm \newtheorem 과 번호 체계, \qedhere 까지](/blog/posts/latex-theorem-proof-amsthm/)
함께 보기: [LaTeX 수식 안 글자체 네 가지](/blog/posts/latex-math-fonts-text-mathrm-mathbf/) · [kotex 로 한국어 논문 처음부터 세팅하기](/blog/posts/kotex-korean-setup/) · [LaTeX 문서 완성도 패키지 — hyperref·geometry·listings](/blog/posts/latex-essential-packages/)
