---
name: explainer-page
description: House style for explainer pages published as artifacts — why a tool exists, how a subsystem works, what changed and why. Use whenever making or restyling a page like "Why Talos exists" or "Admin and debug servers": a single-file HTML explainer for a mixed audience of engineers and non-engineers. Load alongside artifact-design; this skill decides the writing, structure and visual system.
---

# Explainer pages

Single-file HTML pages that explain why a tool exists, how a subsystem works, or what changed and why. Readers are mixed: engineers, plus support, product and finance people who don't read code. The page must work for both without talking down to either.

Reference pages: "Why Talos exists" (https://claude.ai/artifact/9ch8iSCi97AypNybKmfsGQ, green accent) and "Admin and debug servers" (https://claude.ai/artifact/QRmqKzfvnNzkmVVW777fKc, PostgreSQL blue accent). Read one with the Artifact tool when unsure how a component should look.

## Writing

- Plain British English (prioritised, colour, behaviour). Short sentences, one idea each.
- Lead with the consequence, then the mechanism: say what goes wrong and for whom before saying how it is fixed.
- Be concrete. Use real numbers, thresholds, ports, limits, paths and names ("at most 5 files and 200 lines", "0.75 or above", "port 8090"). Never use "various", "robust", "seamless", "powerful", "leverage" or "simply".
- Calm, confident, slightly dry. No marketing, no exclamation marks, no emoji, no hedging, no recap or conclusion.
- Define a term in the same sentence where a non-engineer would first trip on it.
- Say what something does not do as clearly as what it does. Use "only" and "never" precisely and truthfully.
- Identifiers, routes, env vars, metrics and file names go in `<code>`. Everything else is prose.
- Every example is either real or labelled. Put a short faint caption above it: "Real output from the audit service running locally with DB_MAX_OPEN_CONNS=25." or "An example, based on the real Mandates page in the playbook."
- Headings are plain, sentence-case phrases a reader would ask: "The problems it solves", "What each health check means", "Why it is safe to trust", "What it doesn't do". Problem titles state the problem as a fact: "A database blip restarted every instance".
- The page title is a 2–4 word name ("Why Talos exists", "Admin and debug servers"). Use it for both `<title>` and `<h1>`.

## Page structure

Use these sections in this order and leave out any that don't fit. Bands alternate between tinted and plain, starting with tinted.

1. **Hero** (tinted). Two columns. Left: an optional 64px logo, the h1, and a lede of 2–3 sentences saying what it is and why it matters. Right: a "jobs" card with one row per job, route or component. Each row has a bold name (mono if it's a route), a right-aligned accent label for when it happens or who uses it ("Every new issue", "Prometheus", "A person"), and one sentence below. Optional grey group rows split the card ("Admin server on :8090 · always on").
2. **The problems it solves** (plain). An intro paragraph naming the one root cause the problems share. Then a 2×2 grid of cards, each with an h3 problem, a paragraph on why it hurts, and a left-ruled paragraph starting with a bold accent label ("Fix:" or "<Name>:") that gives the answer.
3. **How it works** (tinted). One picture: an inline SVG diagram, a realistic example such as a comment thread, or a step sequence. When there is explanatory text, use the split layout: on the left a heading, paragraph and bullets with bold lead-ins; on the right the picture.
4. **Detail sections** (alternating), as many as needed, built from the components below: a two-column "You do / It does" table card, numbered failure walkthroughs (failing step in red), terminal blocks with copy buttons and real output, and query or idea cards.
5. **Trust or safety** (tinted). Show thresholds as a segmented bar with a scale underneath, then 3–4 guard columns. Each guard has an accent top rule (amber for warnings), an h3, and 1–2 sentences.
6. **Closing** (plain). Two columns: a "What it doesn't do" bullet list, and a "Read more" grid of link cards. Each link card has a bold accent title and a one-line faint description of the question it answers.
7. **Footer**. One quiet line. A small human touch is fine.

## Visual system

- Fonts: Figtree (400, 500, 700, italic 400) and IBM Plex Mono 400, loaded from Google Fonts.
- Use one accent hue per page, chosen to suit the subject. Amber and red are reserved for warning and failure states. Nothing else is coloured. Neutrals are tinted slightly towards the accent.
- No shadows, gradients, icons or decorative animation. Separate things with 1px borders, band tints and whitespace.
- Content goes up to 76rem wide. Any block of prose is capped at 46rem (about 60 characters a line).
- Radii are 14px for cards, 12px for small cards and 10px for links and bars.
- Breakpoints are 1000, 820 and 520px. Grids go from 4 to 2 to 1 columns, splits stack, and band side padding drops to 1rem. No horizontal page scroll at phone width.
- Light and dark themes both work through tokens.
- Diagrams are inline SVG. Every colour comes from `var(--…)` so the diagram follows the theme. Text is 12–14px. Containers are dashed in faint. The primary part uses tint fill with an accent stroke, optional parts use amber-tint with an amber stroke, and arrows are accent with a marker. Put a swatch legend underneath. The SVG has a `<title>` and `<desc>`. Wrap it in a scrolling figure with min-width 600px.
- Accessibility: segmented bars get `role="img"` and an `aria-label`, div tables get ARIA table roles, focus-visible outlines use the accent, and reduced motion is respected.
- JavaScript only when needed, for example copy buttons that fall back to selecting the text.

## Base stylesheet

Use this as-is and change only the palette tokens. Repeat the dark values in both the media-query block and the `[data-theme="dark"]` block.

```css
:root {
  /* Light palette. Talos green shown; PostgreSQL blue alternative in comments. */
  --bg:#f7f9f8;      /* #f6f8fb */
  --band:#edf4f0;    /* #ebf0f6 */
  --surface:#ffffff;
  --ink:#18261f;     /* #162232 */
  --soft:#44564d;    /* #44526a */
  --faint:#6b7d74;   /* #6a7890 */
  --line:#dde6e1;    /* #dbe2ec */
  --accent:#1f6f4a;  /* #2f5f8f */
  --tint:#e3f0e8;    /* #e4edf7 */
  --code-bg:#eef4f0; /* #eef2f8 */
  --amber:#8a5a10; --amber-tint:#f8f0e0;
  --red:#9b2f2a;   --red-tint:#f8e8e6;
  --sans:"Figtree","Avenir Next","Segoe UI",system-ui,sans-serif;
  --mono:"IBM Plex Mono",ui-monospace,"SF Mono",Menlo,monospace;
}
@media (prefers-color-scheme: dark) { :root:not([data-theme="light"]) {
  --bg:#111814; --band:#15201a; --surface:#1a251f; --ink:#e6eee9; --soft:#b6c6bd; --faint:#8a9c92; --line:#29372f;
  --accent:#6ccb9a; --tint:#1c3226; --code-bg:#15201a;
  /* blue: #10151d #141b25 #19212d #e5ebf3 #b4c0d0 #8794a8 #273244 accent #84b3e6 tint #1b2a3d */
  --amber:#e3b56b; --amber-tint:#30260f; --red:#ef948d; --red-tint:#361d1b; color-scheme:dark; } }
:root[data-theme="dark"] { /* same values as the dark block above */ }

* { box-sizing:border-box; }
body { margin:0; background:var(--bg); color:var(--soft); font-family:var(--sans); font-size:1.0625rem; line-height:1.65; }
.band { padding:4.5rem 1.5rem; } .band.tinted { background:var(--band); }
.inner { max-width:76rem; margin:0 auto; }
h1,h2,h3 { color:var(--ink); line-height:1.2; text-wrap:balance; margin:0; font-weight:700; }
h1 { font-size:clamp(2.4rem,5vw,3.6rem); letter-spacing:-0.025em; }
h2 { font-size:clamp(1.6rem,3vw,2.1rem); letter-spacing:-0.015em; }
h3 { font-size:1.2rem; }
p { margin:0; } strong { color:var(--ink); }
a { color:var(--accent); text-underline-offset:0.2em; }
a:focus-visible, button:focus-visible { outline:2px solid var(--accent); outline-offset:3px; border-radius:2px; }
code { font-family:var(--mono); font-size:0.88em; color:var(--ink); }
.head { display:grid; gap:0.85rem; max-width:46rem; margin-bottom:2.5rem; } .head p { font-size:1.125rem; }
.note { font-size:0.88rem; color:var(--faint); }

/* Hero + jobs card */
.hero { display:grid; grid-template-columns:minmax(0,1.25fr) minmax(0,1fr); gap:4rem; align-items:center; }
.hero-text { display:grid; gap:1.25rem; }
.lede { font-size:1.3rem; line-height:1.6; color:var(--ink); max-width:36rem; }
.jobs { display:grid; background:var(--surface); border:1px solid var(--line); border-radius:14px; overflow:hidden; }
.jobs-group { padding:0.75rem 1.35rem; font-size:0.82rem; color:var(--faint); background:var(--bg); border-top:1px solid var(--line); }
.job { display:grid; grid-template-columns:minmax(0,1fr) auto; gap:0.15rem 1rem; padding:1.1rem 1.35rem; }
.job + .job { border-top:1px solid var(--line); }
.job b { color:var(--ink); font-size:1.1rem; }
.job .when { font-size:0.85rem; color:var(--accent); font-weight:500; text-align:right; align-self:center; }
.job p { grid-column:1/-1; font-size:0.98rem; }

/* Problem cards */
.problems { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:1.5rem; }
.problem { background:var(--surface); border:1px solid var(--line); border-radius:14px; padding:1.75rem; display:grid; gap:0.85rem; align-content:start; }
.fix { border-left:3px solid var(--accent); padding-left:1rem; } .fix-label { color:var(--accent); font-weight:700; }

/* Split, points, steps */
.split { display:grid; grid-template-columns:minmax(0,1fr) minmax(0,1.2fr); gap:4rem; align-items:start; }
.split .head { margin-bottom:0; }
.points { margin:0.5rem 0 0; padding-left:1.2rem; display:grid; gap:0.5rem; } .points li::marker { color:var(--accent); }
.steps { display:grid; gap:0.75rem; }
.step { background:var(--surface); border:1px solid var(--line); border-radius:12px; padding:1rem 1.25rem; display:grid; grid-template-columns:2rem minmax(0,1fr); gap:0.75rem; }
.step .n { width:1.75rem; height:1.75rem; border-radius:50%; background:var(--tint); color:var(--accent); font-weight:700; display:grid; place-items:center; font-size:0.9rem; }
.step.bad .n { background:var(--red-tint); color:var(--red); }

/* Terminal */
.term { background:var(--surface); border:1px solid var(--line); border-radius:12px; overflow:hidden; }
.term-bar { display:flex; justify-content:space-between; align-items:center; gap:1rem; padding:0.6rem 1rem; border-bottom:1px solid var(--line); font-size:0.85rem; color:var(--faint); }
.term pre { margin:0; padding:1rem 1.1rem; overflow-x:auto; font:0.86rem/1.6 var(--mono); color:var(--ink); background:var(--code-bg); }
.copy { font:500 0.82rem var(--sans); border:1px solid var(--line); background:var(--surface); color:var(--accent); border-radius:8px; padding:0.25rem 0.7rem; cursor:pointer; }

/* Threshold bar + guards */
.bar { display:grid; height:3rem; border-radius:10px; overflow:hidden; font-weight:700; } /* set grid-template-columns per page, e.g. 55fr 20fr 25fr */
.bar div { display:flex; align-items:center; padding:0 1rem; min-width:0; white-space:nowrap; overflow:hidden; }
.b-ok { background:var(--tint); color:var(--accent); } .b-warn { background:var(--amber-tint); color:var(--amber); } .b-bad { background:var(--red-tint); color:var(--red); }
.scale { position:relative; height:1.4rem; font-size:0.85rem; color:var(--faint); font-variant-numeric:tabular-nums; margin-top:0.4rem; }
.scale span { position:absolute; top:0; transform:translateX(-50%); } .scale span:first-child { transform:none; } .scale span:last-child { transform:translateX(-100%); }
.guards { display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:2rem; }
.guard { display:grid; gap:0.5rem; align-content:start; padding-top:1.1rem; border-top:2px solid var(--accent); } .guard.warn { border-top-color:var(--amber); }

/* Figure */
.figure { background:var(--surface); border:1px solid var(--line); border-radius:14px; padding:1.5rem; overflow-x:auto; }
.figure svg { display:block; width:100%; min-width:600px; height:auto; } .figure svg text { font-family:var(--sans); }
.legend { display:flex; flex-wrap:wrap; gap:0.5rem 1.5rem; font-size:0.88rem; color:var(--faint); margin-top:1rem; }
.sw { width:12px; height:12px; border-radius:3px; border:1.5px solid; display:inline-block; }

/* Closing + footer */
.closing { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:4rem; }
.closing > div { display:grid; gap:1rem; align-content:start; }
.closing ul { margin:0; padding-left:1.2rem; display:grid; gap:0.55rem; } .closing li::marker { color:var(--accent); }
.links { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:0.75rem; }
.links a { display:grid; gap:0.1rem; padding:0.9rem 1rem; background:var(--surface); border:1px solid var(--line); border-radius:10px; text-decoration:none; }
.links a b { color:var(--accent); } .links a span { font-size:0.92rem; color:var(--faint); } .links a:hover { border-color:var(--accent); }
footer { padding:2rem 1.5rem 3rem; }
footer .inner { border-top:1px solid var(--line); padding-top:1.5rem; font-size:0.95rem; color:var(--faint); }

@media (max-width:1000px) { .guards { grid-template-columns:repeat(2,minmax(0,1fr)); } }
@media (max-width:820px) { .band { padding:3.25rem 1rem; } footer { padding:1.5rem 1rem 2.5rem; }
  .hero, .split, .closing, .problems { grid-template-columns:minmax(0,1fr); gap:2.5rem; } }
@media (max-width:520px) { .guards, .links { grid-template-columns:minmax(0,1fr); } .lede { font-size:1.15rem; } .problem { padding:1.35rem; } }
@media (prefers-reduced-motion: reduce) { * { transition:none !important; } }
```

## New accent palette

Pick a hue H. Light theme: bg is H at about 98% lightness and low saturation, band about 94%, surface white, ink about 12%, soft about 30%, faint about 45%, line about 88%, accent about 30–35% at moderate saturation, tint about 92%. Dark theme: bg about 8%, band about 11%, surface about 14%, ink about 92%, soft about 75%, faint about 58%, line about 20%, accent about 68%, tint about 17%. Accent text must reach 4.5:1 contrast on surface in both themes.

## Before publishing

Check every number and name against its source. Make sure every example is real or labelled. Cut any sentence that repeats another. Check the page at 375px wide and in dark mode.
