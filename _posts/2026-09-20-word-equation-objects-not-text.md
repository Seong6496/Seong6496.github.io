---
title: "Word Equation Objects Are Not Text — Why Your Converter Finds Nothing"
date: 2026-09-20 09:00:00 +0900
lang: en
locale: en_US
permalink: /blog/en/posts/word-equation-objects-not-text/
categories: [LaTeXFlow, Troubleshooting]
tags: [word, docx, omml, equations, conversion, troubleshooting]
math: true
pin: false
description: "An equation typed with the Word equation editor is not a run of characters — it is a separate object inside the file, and no amount of adding dollar signs around it will help. What the docx actually stores, how to tell which kind you have, and the routes back to text."
---

You uploaded a Word document with about twenty equations in it to the [web app](/latexflow/web/), and got this:

```
Scanned 46 paragraphs · 0 equations found
This document contains 20 Word equation objects.
Those are not text, so no delimiter can reach them.
```

All 46 paragraphs were read. It counted the twenty equation objects and told you they are there. And it converted none of them.

The file is not broken and the tool did not fail. Those are **a kind of equation that cannot be read as text**. This post is why, and how to get them into a form that can be.

The short version, so you do not waste an afternoon: **adding delimiters will never fix this.** The maths has to become text before anything can convert it.

## 1. Same screen, different storage

There are two ways to put an equation into a Word document.

**① Type it as characters.** You just type `$\frac{1}{2}bh$`. The backslash and braces are visible on screen. It is ugly, but as far as the document is concerned it is **ordinary text**.

**② Insert it with the equation editor.** Press `Alt` + `=` in Word, or choose *Insert → Equation*, and an equation box opens. What you put in it appears beautifully typeset. But it is not text — it is **a separate object inside the document**.

On screen ② is obviously better. The trouble starts at the next step. A converter reads ①, and ② is not in the text stream at all.

## 2. Inside the docx

A `.docx` is a zip archive. Rename it to `.zip`, unpack it, and you will find `word/document.xml` with the whole body in it as XML.

An equation typed as characters is stored like this:

```xml
<w:p>
  <w:r><w:t>The area is $\frac{1}{2}bh$.</w:t></w:r>
</w:p>
```

`w:t` means "text". A paragraph (`w:p`) contains character runs (`w:r`), and the `w:t` inside holds exactly what you typed.

An equation from the equation editor is stored like this:

```xml
<w:p>
  <m:oMath>
    <m:f>
      <m:num><m:r><m:t>1</m:t></m:r></m:num>
      <m:den><m:r><m:t>2</m:t></m:r></m:den>
    </m:f>
    <m:r><m:t>bh</m:t></m:r>
  </m:oMath>
</w:p>
```

Every tag begins with `m:`. This is a **different specification** — OOXML Math, usually shortened to OMML — and the structure itself is an equation tree: `m:f` for the fraction, `m:num` for the numerator, `m:den` for the denominator. Even the character-level part is `m:t`, not `w:t`.

## 3. What a text-based converter sees

The tool walks each paragraph, concatenates its `w:t` fragments in order into one line of text, and then looks for delimiters in that line.

- `w:t` → concatenated ✅
- `m:t` → not in scope ❌

So for a paragraph containing an equation object, the concatenated result is **an empty string, or just the surrounding prose**. There is no text in which to find a delimiter.

Which gives the conclusion that matters:

> **An equation object cannot be fixed with delimiters.** It does not matter where or how you put `$…$`. A delimiter can only attach to characters, and the contents of an equation object are outside the character stream.
{: .prompt-warning }

This is a different cause from [a document with no delimiters](/blog/en/posts/no-latex-delimiters-recover-document/). There, the characters exist and are simply unwrapped, so wrapping them fixes it. Here there are no characters to wrap.

## 4. How the count is produced

The reason the zero-detect screen can state flatly that there are *20 equation objects* is simple: the document XML is already in memory as a string, so counting tags that start with `oMath` is all it takes.

There is one wrinkle in the counting rule. A tag called `m:oMathPara` also exists, but that is the **outer container** for an equation, so counting it would double-count. The rule therefore requires the character after `oMath` to be whitespace, `>` or `/`, which excludes `oMathPara` exactly.

With that number in hand the screen can state a fact rather than a guess:

- **0 equation objects** → the general note, *"if you used the equation editor, delimiters will not help"*
- **1 or more** → a definite diagnosis, *"this document contains N of them"*

## 5. Where documents like this come from

Equation-object documents usually arrive by one of four routes.

**① Written directly in Word.** `Alt` + `=` is Word's default way to enter an equation, so most maths documents written in Word are this.

**② The Google Docs equation tool.** An equation inserted with *Insert → Equation* is an object inside Docs too, and exporting to `.docx` turns it into an OOXML equation object.

**③ A .docx exported from another word processor.** Equations built in another program's equation editor are converted to the same specification on export. The count keys on the tag, so the originating program does not matter.

**④ Asking a chatbot for a .docx file.** This one is more common than you would think. Receiving a file feels like it saves a paste, but the chatbot embeds the equations as objects to make them look good, and conversion is blocked as a result. [Ask for the answer as text instead](/blog/en/posts/ask-chatgpt-for-latex-math/).

## 6. Checking which kind you have

You do not have to open the file and dig through XML. Three checks, quickest first.

**① Put the cursor in it.** Click into the middle of the equation. If the caret blinks between characters, it is text. If the whole expression is selected as one box and you drop into a separate editing mode inside it, it is an object.

**② Paste it into a plain text editor.** Copy the paragraph and paste it somewhere with no formatting — Notepad, VS Code, anything.

- Text equation → `$\frac{1}{2}bh$` comes through **exactly as it is**.
- Equation object → the backslashes and braces are gone and you get scattered characters like `1 2 bh`, or nothing at all.

This test is reliable because an unformatted paste moves only what is in the character stream — precisely the same criterion the converter uses.

**③ Upload it.** The most accurate. The scan line and notices give you the paragraph count, the detected equation count and the equation-object count in one go.

```
Scanned 46 paragraphs · 0 equations found
This document contains 20 Word equation objects.
```

The combination of the three numbers separates the causes:

| Paragraphs | Equations detected | Equation objects | Diagnosis |
|---|---|---|---|
| normal | 0 | 0 | missing delimiters — wrapping fixes it |
| normal | 0 | N | equation objects — must be turned into text |
| normal | some | N | a mixed document — only the objects remain |
| near zero | 0 | 0 | body is empty, or lives in another structure |

Note the third row: because some equations were detected, the zero-detect screen never appears, and so neither does the *"contains N equation objects"* notice. If the number detected is lower than the number you can count by eye, suspect this.

## 7. Three forms compared

The same equation can take three forms in a document, and each is good at something different.

| | Text LaTeX | Equation object | Converted PNG |
|---|---|---|---|
| How it looks while editing | the source (`$\frac{1}{2}$`) | typeset | typeset image |
| Find and replace | works | awkward | no |
| Convertible by this tool | yes | no | already converted |
| Original LaTeX preserved | the source *is* the body | there is no "source" | kept in the alt text |
| Moving to another document | copy and paste is enough | depends on cross-program support | it is an image, it travels |
| What a collaborator sees | backslashes | typeset | typeset |

Text wins while you are writing; PNG wins in the finished copy. The equation object aims at the middle — easy to write *and* good-looking — but is the most work the moment the document has to go anywhere else.

## 8. Getting back to text

### 8-1. A few equations: the Word LaTeX toggle

Recent versions of Word (the Microsoft 365 line) can **switch an equation's notation to LaTeX**. Click the equation, the Equation tab appears on the ribbon, and switching the notation shows the object's contents as LaTeX syntax like `\frac{1}{2}bh`.

One more step is needed. **Changing the notation leaves it an object.** Copy the LaTeX you can now see, delete the object, and paste it back **as text** in its place. Use paste-as-text (`Ctrl` + `Shift` + `V`, or *Keep text only*) to be safe.

Then wrap it:

```
The area is $\frac{1}{2}bh$.
```

Menu names vary a little between versions. Rather than hunting for the menu, check the result: **if clicking the paragraph lets the caret move between characters, it is text; if the whole expression selects as a box, it is still an object.**

### 8-2. Many equations: convert in bulk

Moving dozens of equations by hand is not realistic. For that, run the document through a converter once. [Pandoc](https://pandoc.org/), for example, has a path that turns the equation objects inside a `.docx` into LaTeX syntax:

```bash
pandoc paper.docx -o paper.tex
```

It is a command-line tool and needs installing, but against a document with dozens of objects there is no comparison with doing it by hand. From the converted output you can lift the equations back into the original document as text — or simply carry on in LaTeX.

### 8-3. Not writing them that way in the first place

The most reliable option is to type them as text from the start. Instead of `Alt` + `=` in Word, just type `$\int_0^1 x^2\,dx$`.

Seeing raw backslashes while you write is less pleasant, but one pass through the tool at the end turns all of them into typeset images. In the meantime you get find-and-replace (objects do not), and the source survives for whoever you send it to.

## 9. The other direction

A `.docx` exported by the tool has its equations as PNG images. Are those not also "not text"? They are. Which is why each image carries the **original LaTeX in its alt text**:

```
AIMATH_FORMULA::v1::\frac{1}{2}bh
```

That tag is what makes this the opposite of an equation object. An object has no original LaTeX to recover — it was stored as an equation tree, so there is no source text to go back to. An exported image carries its source with it.

## 10. FAQ

**Can I just turn the equation objects into images?**
You can, but not with this tool. It renders LaTeX text it has been given; baking an object into a picture is a Word-side operation (screenshot, or paste as picture).

**Does turning an object into text make the typesetting ugly?**
Right after the change, in the editing view, yes. After a pass through the tool it is a typeset image again. The ugly stretch only lasts while you are writing.

**Do candidate cards appear for paragraphs that contain an equation object?**
They do if the paragraph's *text* contains one of `=`, `^`, `_`, `\` — for instance when the surrounding prose says *"where x_1 is …"*. But the object itself cannot be touched from the card either; a card only ever shows characters.

**What about a mixed document, with both objects and text equations?**
Only the text ones are found. Because the count is not zero, the zero-detect screen does not appear, and so the *"contains N equation objects"* notice is not shown either. If the detected count is lower than what you count by eye, this is the likely reason.

**What about a PDF?**
Only `.docx` is read. A PDF has a fundamentally different structure and is not supported.

**Google Docs has the same problem, doesn't it?**
It does, and worse in one specific way. An equation made with *Insert → Equation* in Docs is an object there too, and its paragraph text reads back mangled rather than empty — `\frac{1}{2}` comes back as `12`. So wrapping it in `$$` produces `$$12$$`, which is perfectly valid LaTeX and will convert happily into an image reading **12**. There is no error and the result looks plausible. Do not wrap a native Docs equation; retype the maths as LaTeX text instead. [What Google Docs actually stores for those equations](/blog/en/posts/google-docs-equation-editor-internals/) has the full table.

## 11. Summary

- An equation from a word processor's equation editor is not text but **a separate object inside the document**.
- The tool concatenates a paragraph's characters (`w:t`) and scans those, so an object's contents (`m:t`) are out of reach.
- Therefore **delimiters can never fix it.** The object has to be turned into text.
- A few of them: use Word's LaTeX notation. Many: run the document through a converter once.
- The zero-detect screen counts the objects for you, so you can tell this apart from [plain missing delimiters](/blog/en/posts/no-latex-delimiters-recover-document/) immediately.

Inserting an equation attractively and moving that equation somewhere else later are two different requirements. Objects are optimised for the first, text for the second. If you already know where the document is going, that is the criterion to choose on.
