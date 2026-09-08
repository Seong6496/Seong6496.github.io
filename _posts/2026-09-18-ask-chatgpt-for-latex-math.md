---
title: "How to Ask ChatGPT for Math You Can Actually Paste Into a Document"
date: 2026-09-18 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/ask-chatgpt-for-latex-math/
categories: [LaTeXFlow, Guide]
tags: [chatgpt, gemini, latex, prompt, docx, ai, equations]
math: true
pin: false
description: "Whether a chatbot answer converts cleanly is decided by the request, not by the conversion tool. Why the delimiter a tool can read is not the delimiter you should ask for, what survives the copy path, how to rescue an answer you already have, and how to check the format before you paste a hundred lines."
---

You asked a chatbot for some maths problems, copied the answer, and pasted it into a document. On screen the fractions and integral signs were immaculate. In the document you have this:

```
[\lim_{x \to 2} \frac{x^2-4}{x-2}]
```

or sometimes this:

```
( x^2 + y^2 = r^2 )
```

Same cause for both. The chat window is a surface that **renders** Markdown, and what you copy is the rendered result. The delimiters' backslashes fall off along the way.

The first one can be recovered. The second one cannot. That difference is the whole reason to care about how you phrase the request — because by the time you are pasting, the outcome is already fixed.

**The one-line answer:** put this in the prompt before you ask for anything.

> Write every formula in LaTeX — `$...$` for inline, `$$...$$` for display. Never write math as plain text.

The rest of this post is why that sentence has exactly that shape.

## 1. It is decided before the answer arrives

The flow of using a conversion tool usually looks like this:

```
ask → answer → copy → paste → upload → convert
```

The step where failure becomes certain is not the last one. It is the **first**. After you paste, the format is already what it is, and the only remaining option is fixing it by hand.

So you pin the format down in the prompt. The [web app](/latexflow/web/) prints that line on its upload screen for exactly this reason.

## 2. The delimiter you can read is not the delimiter to ask for

This is the point that trips people up. The tool reads five delimiters. But only **two of them** are worth asking a chatbot for. The two lists differing is deliberate, not an oversight.

| Delimiter | Tool reads it | Worth asking a chatbot for |
|---|---|---|
| `$…$` | ✅ | ✅ **recommended** |
| `$$…$$` | ✅ | ✅ **recommended** |
| `\[…\]` | ✅ | △ recoverable even if the backslashes drop |
| `\(…\)` | ✅ | ❌ **do not** |
| `[ … ]` | ✅ (bracket mode) | — not something to request; it is a recovery path |

The columns answer two different questions. The first is *"if it arrives in the document like this, will it be found?"*. The second is *"how likely is it to survive the chat window and reach the document at all?"*

## 3. What survives the copy path

Passing through the chat window's Markdown rendering, the delimiters meet different fates.

**Dollar signs come through untouched.**

```
$x^2$  →  $x^2$
```

`$` is not Markdown syntax, so the renderer leaves it alone. Copy it and it comes along exactly as it was. This is why it is the safest option.

**Bracket delimiters lose their shell but leave a trace.**

```
\[E = mc^2\]  →  [E = mc^2]
```

The two outer backslashes are gone. But the square brackets remain, and bracket mode can work with that — its rule is *a bracket containing a LaTeX sign is math*. In the web app that mode is on by default.

**Paren delimiters leave nothing to work with.**

```
\(a_i\)  →  ( a_i )
```

Again the backslashes go, but what is left is **an ordinary parenthesis**. Recovery stops here. Unlike square brackets, parentheses are everywhere in prose:

> "(where n is a natural number)"
> "(see 3)"
> "(a, b)"

Treating those as maths would produce an unmanageable pile of false positives. So the bracket scanner looks at **square brackets only**, on purpose.

Summarised:

| Written as | After the copy | Recovery |
|---|---|---|
| `$…$` | `$…$` | no loss |
| `$$…$$` | `$$…$$` | no loss |
| `\[…\]` | `[…]` | bracket mode recovers it |
| `\(…\)` | `( … )` | **impossible — permanently lost** |

That is why you must not ask for `\(…\)` in a prompt. Not because the tool cannot read it, but because **it never reaches the document**.

The mechanism of the stripping itself, and how bracket mode recovers from it, is walked through with screenshots in [ChatGPT wrote your math in square brackets](/blog/en/posts/chatgpt-bracket-math-to-latex/).

## 4. The third failure: math written out in words

There is another failure with a different character. Sometimes the chatbot **describes the equation in a sentence**:

```
the sum from n equals 1 to infinity of 1 divided by n squared
```

It reads fine. But there is no equation there to wrap. What you would be wrapping is a sentence, and putting `$` around a sentence just gets you a sentence trying and failing to render as maths.

This one is harder to spot than the other two, because the document contains a perfectly ordinary English sentence and the absence of an equation does not jump out. It rarely reaches the candidate list on the zero-detect screen either — that list keys on `=`, `^`, `_`, `\`, and a sentence has none of them. (If a fragment like `n=1` survives, the paragraph does become a candidate, but opening the card leaves you nothing to wrap.)

The last sentence of the recommended prompt is aimed precisely at this:

> Never write math as plain text.

What you want instead is:

```
$$\sum_{n=1}^{\infty} \frac{1}{n^2}$$
```

If the equation genuinely needs explaining, ask for **both**:

> For each problem, write the LaTeX formula first, then one line of plain-language explanation underneath.

That separates the thing to be converted from the thing a human reads, and the tool picks out only the equations.

## 5. Why asking for a file does not help

Trying to save a step with *"generate 20 practice problems and give me a .docx"* makes the result worse. The chatbot, trying to be helpful, embeds the equations as **Word equation objects**.

An equation object is not text but a separate structure inside the file, so there is nowhere to attach a delimiter.

- ❌ "…and give it to me as a .docx" → equation objects (not convertible)
- ✅ "…show it as text in the chat answer" → LaTeX text (convertible)

Saving one paste costs you the whole request.

## 6. Rescuing an answer you already have

This is the part you need most often in practice. You have a long answer in the wrong format. **Do not ask for it to be regenerated.** Regenerating changes the content. If you carefully picked twenty problems and get a different twenty back, you review everything again from scratch.

Ask for the **same content, reformatted**:

> Keep the content of your last answer exactly as it is and rewrite only the formatting. Wrap every formula in `$...$` for inline and `$$...$$` for display. Keep the problem numbers, the ordering and the wording unchanged.

Three things are doing work there:

1. **Pin the content explicitly** — drop *"keep the content as it is"* and different problems quietly appear.
2. **Write the delimiters literally** — *"in LaTeX"* alone gets you a different delimiter each time.
3. **Pin the structure** — if the numbering or order shifts, your earlier review is void.

The same approach fixes an answer that came back in Unicode symbols (∑, ∫, ½, ≤):

> Replace the Unicode math symbols in your answer with LaTeX commands — ∑ as `\sum`, ∫ as `\int`, ½ as `\frac{1}{2}` — and wrap each formula in `$...$`.

## 7. Pasting without formatting

When you copy the answer into the document, paste **text only**. In both Word and Google Docs that is `Ctrl` + `Shift` + `V`, or *Keep text only* in the paste options.

Pasting with formatting drags the chat window's code-block styling, background colours and fonts along. It does not affect detection — the tool concatenates a paragraph's characters and reads those — but it is work for you later when you tidy the document.

One more check. After pasting, look at whether any equation was **split across paragraphs**. A display equation arriving as:

```
$$
\int_0^1 x^2\,dx
$$
```

is three separate paragraphs as far as the tool is concerned, and the opening and closing `$$` never pair. Join it into one line and it works.

## 8. Checking that the format took

Whether your prompt worked is hard to judge by eye. Let the tool tell you. Upload the file and this line appears at the top:

```
Scanned 84 paragraphs · 61 equations found
```

- **Detected count close to the number of equations you can count** → the format took.
- **Zero** → no delimiters at all, or equation objects. Go back to the reformat request in section 6.
- **Fewer than you can count** → only some were wrapped. Look at which form is missing and re-request just that part.

Do this check **before you generate all twenty problems**. Ask for two or three first, paste them, upload. If the format passes, continue the rest in the same conversation. If it fails, you have thrown away three problems instead of twenty.

## 9. Defaults differ by chatbot

Ask without specifying a format and different chatbots answer differently. The observed tendencies:

- **ChatGPT** — display equations frequently arrive as `[ … ]`. That is a `\[ … \]` that lost its backslashes. Bracket mode exists for exactly this case.
- **Gemini** — `$$ … $$` often arrives intact. Dollar signs do not get stripped, so it is usually detected as-is.

These are **tendencies, not guarantees.** Even within one service the result shifts with conversation context and with time. Pinning the format in a line of the prompt is still the reliable move.

## 10. FAQ

**If bracket mode exists, can I just accept brackets?**
Mostly, yes. But bracket mode is a heuristic and not perfect. An expression with none of `\`, `^`, `_`, `=` inside the brackets — an interval like `[1,5]`, say — is not caught; and in a document with many brackets, the wrong things can be. Receiving dollars means none of that judgement is needed.

**I put the delimiters in the prompt and it still drifts.**
Formatting tends to fall apart in the later part of a long answer. Four batches of five beat one batch of twenty. The small-batch check in section 8 helps here too.

**There are tables as well as equations.**
Equations inside tables are scanned normally. But a Markdown table pasted into a document can break its structure — if you need a table, build it in the document first and paste only the equations into the cells.

**Is the add-on the same?**
The Google Docs add-on (*Extensions → LatexFlow → Open Equation Panel*) reads the same four delimiters. The difference is that its bracket mode checkbox is **off by default**, so to catch equations that arrived as brackets you need to switch it on.

## 11. Summary

- Success is decided in the **request**, not after the paste.
- Through the chat window, `$…$` survives whole, `\[…\]` keeps only its brackets, and `\(…\)` disappears without a trace.
- So pin the request to **the two dollar forms**. The list a tool reads and the list worth requesting are different lists.
- Asking for a file gets you equation objects and blocks conversion. Take the answer as text in the chat.
- Fix an answer you already have by **reformatting, not regenerating**.
- Upload a small batch and read the scan line before committing to the full job.

---

- The delimiters themselves, in detail → [the four delimiters, and which is safe where](/blog/en/posts/latex-math-delimiters-which-to-use/)
- Nothing detected at all → [detected 0 equations](/blog/en/posts/no-latex-delimiters-recover-document/)
