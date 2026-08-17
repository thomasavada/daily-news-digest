---
name: daily-news-digest
description: >
  Team scan of Shopify updates, AI and Shopify-shaped e-commerce trends,
  new launches, and GitHub momentum. Also use for X and LinkedIn trend
  reads. Triggers: daily digest, morning digest, news digest, trend radar,
  Shopify buzz, what's launching, what's trending on X, LinkedIn,
  GitHub, or AI Engineer YouTube, /daily-news-digest, /trend-radar.
  Fetch live — never invent from training.
---

# Daily digest — team trend scan

This skill exists so the team actually sees the news they skip: **Shopify platform**, **AI**, **e-commerce Shopify is pushing**, **new launches**, **GitHub**, plus what [AI Engineer](https://www.youtube.com/@aiDotEngineer) is putting on stage.

One briefing. Five sensors.

1. **Wire** — dated Shopify + AI + ecom (changelog, official blog, funding).
2. **X** — fastest social graph (keyword Latest + semantic).
3. **LinkedIn** — operator / founder / Shopify-staff framing.
4. **GitHub** — new repos, trending, releases (agents, MCP, commerce).
5. **AI Engineer (@aiDotEngineer)** — talks and uploads as a trend read, not a recap of one video.

Do not invent. Every social item needs a live URL from this run. Every wire item needs a dated source from this run.

If the user names a subset (“just Shopify”, “just GitHub”), drop the other rails for that run. Do not change this file for a one-off.

## 1 · Pull (one parallel batch)

Queries live in [references/rails.md](references/rails.md) only.

**Wire** — `web_search` every wire row (`num_results: 8`). Prefer official or primary (changelog, company blog, SEC) over recaps.

- **Shopify official** row: `open_page` 1–2 posts dated inside that row’s window. SERP snippet is not enough.
- **shopify.dev/changelog**: if a hit is inside the window, `open_page` the entry.

**X** (required when `x_keyword_search` exists)

- `x_keyword_search` — `mode: Latest`, `limit: 10`, rails.md keyword table. `min_faves:5` only on AI and E-commerce. Default window `within_time:2d`.
- `x_semantic_search` — one query per rail (`limit: 5`, `min_score_threshold: 0.2`).
- `x_thread_fetch` a `post_id` only for a launch or a fight with 3+ named products.

**LinkedIn** — `web_search` the LinkedIn rows. `open_page` 1–2 posts if the page is readable. If LinkedIn is login-walled, keep the search URL and the snippet; do not invent the rest of the post.

**GitHub** — `web_search` the GitHub rows. `open_page` trending or the repo README for anything that looks like a real launch (stars/release in-window), not a random hello-world.

**AI Engineer YouTube** — `open_page` [youtube.com/@aiDotEngineer/videos](https://www.youtube.com/@aiDotEngineer/videos) every run. Also `web_search` the YouTube row in rails.md. Keep 1–3 uploads inside the window (title + URL). Do not watch or summarize a full talk unless the title itself is the trend. This channel supplements the scan; it does not replace wire / X / LinkedIn / GitHub.

**Reddit** — optional, only if X + LinkedIn are thin on merchant pain. Same rows as rails.md.

**Confirm** a platform change (API sunset, MCP, Catalog, “we shipped”) against the official page or `from:<company>` post. Aggregator “NEWS:” posts are not confirmation.

**No X tools:** do not skip the graph. Shell once:

```bash
grok -p "Team trend scan. Sections: Shopify (official first), AI, ecom Shopify is pushing, launches, GitHub repos/releases, X+LinkedIn (real urls), new AI Engineer YouTube uploads (titles+urls only). Bold headline + one sentence. No fluff." --output-format plain
```

Wait up to 120s. Strip grok preamble. Then still run LinkedIn, GitHub, YouTube, and Reddit `web_search` yourself. Do not nest `grok -p` when X tools already exist.

## 2 · Cluster

Group by **topic**, not platform.

Keep a cluster if **two independent voices** or **one official primary** (Shopify blog, changelog, `from:<company>`, GitHub release). An AI Engineer talk title can *amplify* a cluster; it is not enough alone. Drop ads, recruiter spam, single-reply nothing, “AI will change everything” with no product. Hits older than the rail window are context, not today’s news — say so or drop.

## 3 · Write

```markdown
# Digest · YYYY-MM-DD
Wire: today · graph: last 48h · X + LinkedIn + GitHub + AI Engineer + web

## What to notice
3 bullets. Cross-rail only. What attention is moving toward — not three random headlines.

## Shopify
Deadlines (API sunsets, checkout scripts) first. Then official blog / changelog / what Shopify is telling merchants to care about.

## AI
Models, agents, infra. One sentence + source.

## E-commerce (Shopify-shaped)
What Shopify is focusing on (Catalog, UCP, agentic storefronts, live/social checkout) plus merchant-visible shifts. Skip generic Amazon-vs-TikTok evergreen.

## Launches
- **Name** — what it is. Why a Shopify/AI/ecom team might care. Link.

## GitHub
- **repo/release** — what shipped. Why it might matter. URL.

## AI Engineer
- **Video title** — why it maps to a cluster above. [YouTube](https://youtube.com/…). Empty rail if nothing new in window.

## X / LinkedIn
How operators and Shopify people are talking about the same clusters. Real post URLs. Skip if already covered above.

## Trend read
2–3 sentences. What to watch next week. No TED talk.
```

Empty rail: `No live signal in window`. Do not pad.

## 4 · File

[references/file.md](references/file.md). If nothing there applies, the chat briefing is enough.

## Out of scope

Building the products. Replacing this scan with a single YouTube recap. A second skill for the same job.
