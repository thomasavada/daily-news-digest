---
name: daily-news-digest
description: >
  Daily briefing: same-day Tech/AI and Shopify/e-commerce wire news plus
  X+Reddit launches and social trends (SaaS, product ideas, AI Asia,
  agentic commerce). Use when the user asks for a daily digest, morning
  digest, news digest, trend radar, what's happening today, what's
  launching, what's trending on X, Shopify buzz, AI Asia trends, or runs
  /daily-news-digest or /trend-radar. Fetch live — never invent from training.
---

# Daily digest + trend radar

One briefing. Two sensors.

1. **Wire** — dated news (filings, changelog, funding, official blogs).
2. **Graph** — X first (keyword Latest + semantic), then Reddit.

Do not invent. Every social item needs a live URL from this run. Every wire item needs a dated source from this run.

If the user names a subset (“just Shopify”, “just X”), drop the other rails for that run. Do not change this file for a one-off.

## 1 · Pull (one parallel batch)

Queries live in [references/rails.md](references/rails.md) only.

**Wire** — `web_search` every wire row (`num_results: 8`). Prefer official or primary (SEC, changelog, company blog) over recaps.

- **Shopify official** row: `open_page` 1–2 posts dated inside that row’s window. SERP snippet is not enough.
- **shopify.dev/changelog**: if a hit is inside the window, `open_page` the changelog entry.

**X** (required when `x_keyword_search` exists)

- `x_keyword_search` — `mode: Latest`, `limit: 10`, rails.md keyword table. `min_faves:5` only on AI and E-commerce. Default window `within_time:2d`.
- `x_semantic_search` — one query per rail (`limit: 5`, `min_score_threshold: 0.2`).
- `x_thread_fetch` a `post_id` only for a launch or a fight with 3+ named products.

**Reddit** — `web_search` `site:reddit.com` rows. `open_page` 2–3 threads that are a launch or a repeated pain, not listing pages.

**Confirm** a platform change (API sunset, MCP, Catalog, “we shipped”) against the official page or `from:<company>` post. Aggregator “NEWS:” posts are not confirmation.

**No X tools:** do not skip the graph. Shell once:

```bash
grok -p "Same-day digest. Sections: Tech & AI (5-6), Shopify & E-commerce (5-6), Launches/trending on X (3-5 with real x.com/status/... links and handles). Bold headline + one sentence. No fluff." --output-format plain
```

Wait up to 120s. Strip grok preamble. Then still run Reddit `web_search` yourself. Do not nest `grok -p` when X tools already exist.

## 2 · Cluster

Group by **topic**, not platform.

Keep a cluster if **two independent voices** or **one official primary** (company blog, changelog, `from:<company>`). Drop ads, single-reply nothing, “AI will change everything” with no product. Semantic hits older than the rail window are context, not today’s news — say so or drop.

## 3 · Write

```markdown
# Digest · YYYY-MM-DD
Wire: today · graph: last 48h · X + Reddit + web

## What to notice
3 bullets. Cross-rail only.

## Tech & AI
- **Headline** — one sentence. Source.

## Shopify & E-commerce
Same. Deadlines (API sunsets) first. Official Shopify posts next.

## Launches
- **Name** — what it is. Why it might matter. [x](https://x.com/…) · optional [reddit]

## Ideas / gaps
Pain in their words. Who. Link.

## On X / Reddit
### AI · Asia
### Other social (only if not already above)
```

Empty rail: `No live signal in window`. Do not pad.

## 4 · File

[references/file.md](references/file.md). If nothing there applies, the chat briefing is enough.

## Out of scope

Building the products. A second skill for the same job.
