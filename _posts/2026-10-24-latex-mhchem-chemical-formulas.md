---
title: "LaTeX 화학식 쓰기 — mhchem \\ce 로 첨자·전하·반응 화살표까지"
date: 2026-10-24 09:00:00 +0900
categories: [LaTeX, 수식]
tags: [latex, mhchem, ce, 화학식, 반응식, 이온, 전하, 평형, 화학, 실험보고서]
math: true
pin: false
description: "H_2O 를 수식으로 치면 H 와 O 가 이탤릭 변수가 되는 문제를 mhchem 의 \\ce 하나로 푸는 법을 실측으로 정리합니다 — \\ce{H2O} 처럼 숫자는 알아서 아래 첨자, \\ce{SO4^2-} 의 전하, 수화물의 가운뎃점, 동위원소, 반응 화살표 -> 와 평형 <=>, 기체 ^ 와 침전 v, 상태 (aq), 화살표 위아래 조건. [version=4] 옵션을 빼면 나는 경고, 그리고 화살표 위에 한글을 그냥 치면 PDF 에서는 오류인데 이 블로그 (MathJax) 에서는 보인다는 차이까지."
---

화학식을 LaTeX 수식으로 치면 [수식 글자체 글](/blog/posts/latex-math-fonts-text-mathrm-mathbf/)과 같은 문제가 생깁니다. `$H_2SO_4$` 는 H, S, O 가 전부 **이탤릭 변수** 가 됩니다. 원소 기호는 세워 써야 하고, 그러려면 `\mathrm{H_2SO_4}` 처럼 감싸야 하는데, 전하·화살표·상태 표시까지 가면 손으로 치기가 번거롭습니다.

`mhchem` 패키지의 `\ce{…}` 는 화학식을 **화학식으로** 읽습니다. 숫자는 알아서 아래 첨자, 원소는 세운 글자, `->` 는 반응 화살표.

```latex
\usepackage[version=4]{mhchem}
```

아래 결과는 MiKTeX 25.12 (pdfTeX, LaTeX2e 2025-11-01, `mhchem` **v4.10**, 한글은 `kotex`) 로 컴파일한 것이고, 같은 원본을 Tectonic 0.17 (`mhchem` v4.09) 로도 컴파일해 보았습니다 (§5 의 한 줄에서 갈림).

> 이 블로그의 수식 엔진 MathJax (실측 3.2.2) 는 `\ce` 를 읽습니다. 그래서 이 글의 본문 수식은 MathJax 렌더이고, 그림은 pdfLaTeX 로 컴파일한 PDF 입니다. 둘이 다른 곳이 한 군데 있어서 §5 에 따로 적었습니다.
{: .prompt-info }

## 1. 한눈에 — 입력과 출력

![mhchem 실측 — $H_2O$ 와 $H_2SO_4$ 는 이탤릭, \ce{H2O} 와 \ce{H2SO4} 는 세운 글자에 아래 첨자, SO4 2- · Fe 3+ · NH4 + · Cl - 전하, CuSO4 · 5H2O 수화물, 탄소 14 와 우라늄 235 동위원소, 반응 화살표, 평형 쌍화살표, 기체 위 화살표와 침전 아래 화살표, (aq)(l)(g) 상태, 화살표 위 Δ 와 위아래 Pt / 300 K, 마지막 줄은 한글을 그냥 친 라벨이 사라지고 \text 로 감싼 가열은 화살표 위에 나옴](/assets/img/posts/2026-10-24/01-mhchem-formulas-reactions.png){: width="720" }

## 2. 화학식 — 숫자·전하·수화물·동위원소

| 입력 | MathJax 렌더 | 규칙 |
|---|---|---|
| `\ce{H2SO4}` | $\ce{H2SO4}$ | 원소 뒤 숫자는 아래 첨자 |
| `\ce{SO4^2-}` | $\ce{SO4^2-}$ | `^` 뒤는 전하. 숫자와 부호를 함께 |
| `\ce{Fe^3+}` · `\ce{NH4+}` · `\ce{Cl-}` | $\ce{Fe^3+}$ · $\ce{NH4+}$ · $\ce{Cl-}$ | 전하가 1 이면 `^` 없이 `+`·`-` 만 |
| `\ce{CuSO4 * 5H2O}` | $\ce{CuSO4 * 5H2O}$ | `*` 는 수화물의 가운뎃점 |
| `\ce{^{14}_{6}C}` | $\ce{^{14}_{6}C}$ | 질량수·원자번호는 왼쪽에 |

- **앞의 숫자는 계수입니다.** `\ce{5H2O}` 의 5 는 첨자가 아니라 크기 그대로, 뒤에 가는 공백. 원소 **뒤** 의 숫자만 아래 첨자가 됩니다.
- **`$H_2O$` 와 `\ce{H2O}` 의 차이** 는 그림 첫 줄입니다. 수식 모드는 원소를 이탤릭으로 기울이고, `\ce` 는 세웁니다.
- 수식 안에서도 그대로 씁니다 — `$\ce{H2O}$` 와 본문의 `\ce{H2O}` 는 실측 폭이 같습니다 (19.76 pt).

## 3. 반응식 — 화살표와 평형

```latex
\ce{2H2 + O2 -> 2H2O}
\ce{N2 + 3H2 <=> 2NH3}
\ce{CaCO3 -> CaO + CO2 ^}
\ce{Ba^2+ + SO4^2- -> BaSO4 v}
```

$$\ce{2H2 + O2 -> 2H2O} \qquad \ce{N2 + 3H2 <=> 2NH3}$$

$$\ce{CaCO3 -> CaO + CO2 ^} \qquad \ce{Ba^2+ + SO4^2- -> BaSO4 v}$$

| 입력 | 뜻 |
|---|---|
| `->` | 반응 화살표 |
| `<=>` | 평형 (쌍화살표) |
| `<-` · `<->` | 역방향 · 공명 |
| `^` (앞뒤 공백) | 기체 발생 ↑ |
| `v` (앞뒤 공백) | 침전 ↓ |

`^` 와 `v` 는 **앞에 공백** 이 있어야 기체·침전 기호로 읽힙니다. 공백 없이 `\ce{CO2^}` 처럼 붙이면 실측으로 화살표 없이 `CO₂` 만 남습니다 (오류도 경고도 없음). `+` 도 앞뒤에 공백을 두는 것이 규칙입니다 — `\ce{Ba^2+ + SO4^2-}` 에서 첫 `+` 는 전하, 공백으로 떨어진 둘째 `+` 가 더하기입니다.

## 4. 상태와 조건

**상태 표시** 는 괄호 그대로 붙입니다. `\ce{NaCl(aq)}` · `\ce{H2O(l)}` · `\ce{CO2(g)}` → $\ce{NaCl(aq)}$ · $\ce{H2O(l)}$ · $\ce{CO2(g)}$.

**화살표 위아래 조건** 은 대괄호입니다. 첫째 대괄호가 위, 둘째가 아래.

```latex
\ce{A ->[\Delta] B}          % 위에 Δ (가열)
\ce{A ->[Pt][300 K] B}       % 위 Pt, 아래 300 K
```

$$\ce{A ->[\Delta] B} \qquad \ce{A ->[Pt][300 K] B}$$

화살표는 위아래 글자 길이에 맞춰 늘어납니다 (그림의 `Pt / 300 K` 줄).

## 5. 화살표 위 한글 — PDF 와 블로그가 다르다

한국어 보고서라면 조건을 "가열" 처럼 한글로 쓰고 싶어집니다.

```latex
\ce{A ->[가열] B}           % pdfLaTeX: 오류, 라벨이 사라진다
\ce{A ->[\text{가열}] B}    % 셋 다 정상
```

- **pdfLaTeX** (mhchem 4.10) — 실측으로 `! Package mhchem Error: Assertion failed: Unexpected input character.` 오류가 나고, 오류를 넘겨 만든 PDF 에서는 화살표만 남고 "가열" 이 사라집니다 (그림 마지막 줄 왼쪽).
- **Tectonic** (mhchem 4.09) — 같은 오류. Tectonic 은 오류가 나면 PDF 를 만들지 않으므로 컴파일 실패.
- **이 블로그의 MathJax** — 오류 없이 화살표 위에 "가열" 이 그려집니다. **블로그나 웹 미리보기에서 잘 보였다고 PDF 에서도 되는 것은 아닙니다.**

`\text{가열}` 로 감싸면 세 곳 모두 정상입니다 (그림 마지막 줄 오른쪽). 화살표 위아래에 한글을 쓸 때는 항상 `\text{…}` — [글자체 글](/blog/posts/latex-math-fonts-text-mathrm-mathbf/)의 "수식 안 한글은 `\text` 안에" 와 같은 규칙입니다.

## 6. [version=4] 를 빼면

`\usepackage{mhchem}` 만 쓰면 실측으로 경고가 납니다.

```text
Package mhchem Warning: You did not specify a 'version' option for the mhchem
(mhchem)                package. Please write \usepackage[version=4]{mhchem}
(mhchem)                in your preamble (or any lower number for
(mhchem)                compatibility mode), because you might get slightly
(mhchem)                different output with the same input in future versions
```

컴파일은 되지만, 판이 바뀌어도 같은 출력을 받으려면 경고가 시키는 대로 `[version=4]` 를 적어 둡니다.

## 7. 자주 하는 실수

- **`$H_2O$`** → 이탤릭 원소. `\ce{H2O}`.
- **`\ce{SO4 2-}`** 처럼 `^` 없이 띄운 전하 → 실측으로 `SO₄ 2⁻` 처럼 2 가 본문 크기로 떨어져 나온다. `\ce{SO4^2-}`.
- **`\ce{CO2^}` (공백 없음)** → 기체 화살표가 조용히 사라진다. `\ce{CO2 ^}`.
- **화살표 위 한글 그대로** → PDF 에서 오류 (§5). `->[\text{가열}]`.
- **`[version=4]` 없음** → 경고 (§6).

## 정리

| 하고 싶은 것 | 코드 |
|---|---|
| 준비 | `\usepackage[version=4]{mhchem}` |
| 분자식 | `\ce{H2SO4}` |
| 이온 · 전하 | `\ce{SO4^2-}`, `\ce{Fe^3+}`, `\ce{Cl-}` |
| 수화물 | `\ce{CuSO4 * 5H2O}` |
| 동위원소 | `\ce{^{14}_{6}C}` |
| 반응 · 평형 | `\ce{A + B -> C}`, `\ce{A <=> B}` |
| 기체 · 침전 | `\ce{CO2 ^}`, `\ce{BaSO4 v}` (앞에 공백) |
| 상태 | `\ce{NaCl(aq)}` |
| 화살표 조건 | `\ce{A ->[위][아래] B}`, 한글은 `\text{…}` |

물리 쪽 단위는 [siunitx](/blog/posts/latex-siunitx-units-numbers/), 그래프는 [pgfplots](/blog/posts/latex-pgfplots-plots-from-data/) — 실험 보고서 한 편에 필요한 세 가지가 이것으로 갖춰집니다.

---

이전 글: [LaTeX 로 그래프 그리기 — pgfplots 로 함수·CSV 데이터 플롯](/blog/posts/latex-pgfplots-plots-from-data/)
함께 보기: [LaTeX 수식 안 글자체 네 가지](/blog/posts/latex-math-fonts-text-mathrm-mathbf/) · [LaTeX 단위와 숫자 — siunitx](/blog/posts/latex-siunitx-units-numbers/) · [LaTeX 미분·편미분 — physics 패키지](/blog/posts/latex-physics-package-dv-pdv-abs-braket/)
