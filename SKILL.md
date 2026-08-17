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

1. **Wire** — dated news (filings, changelog, funding, outages).
2. **Graph** — X first (keyword Latest + semantic), then Reddit. Fastest social signal.

Do not invent. Every social item needs a live URL from this run. Every wire item needs a dated source from this run.

If the user names a subset (“just Shopify”, “just X”), drop the other rails for that run. Do not change this file for a one-off.

## 1 · Pull (one parallel batch)

Queries live in [references/rails.md](references/rails.md) only.

**Wire** — `web_search` the wire rows in rails.md (`num_results: 8` each). Prefer official or primary (SEC, changelog, company blog) over recaps.

**X** (required when `x_keyword_search` exists)

- `x_keyword_search` — `mode: Latest`, `limit: 10`, rails.md keyword table. `min_faves:5` only on AI and E-commerce. Default window `within_time:2d`.
- `x_semantic_search` — one query per rail (`limit: 5`, `min_score_threshold: 0.2`). This is the graph pass.
- `x_thread_fetch` a `post_id` only for a launch or a fight with 3+ named products.

**Reddit** — `web_search` `site:reddit.com` rows in rails.md. `open_page` 2–3 threads that are a launch or a repeated pain, not listing pages.

**Confirm** a platform change (API sunset, MCP, Catalog) against the official page if X and Reddit disagree.

**No X tools** (Claude, Codex, etc.): do not skip the graph. Shell once:

```bash
grok -p "Same-day digest. Sections: Tech & AI (5-6), Shopify & E-commerce (5-6), Launches/trending on X (3-5 with real x.com/status/... links and handles). Bold headline + one sentence. No fluff." --output-format plain
```

Wait up to 120s. Strip grok preamble. Then still run Reddit `web_search` yourself. Do not nest `grok -p` when X tools already exist.

## 2 · Cluster

Group by **topic**, not platform.

Keep a cluster if **two independent voices** or **one primary + one amplifier**. Drop ads, single-reply nothing, “AI will change everything” with no product. Semantic hits older than the window (e.g. January launch posts) are context, not today’s news — say so or drop.

## 3 · Write

```markdown
# Digest · YYYY-MM-DD
Wire: today · graph: last 48h · X + Reddit + web

## What to notice
3 bullets. Cross-rail only.

## Tech & AI
- **Headline** — one sentence. Source.

## Shopify & E-commerce
Same. Deadlines (API sunsets) first.

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

Write once per calendar day. Never edit yesterday. Same-day second pull → `YYYY-MM-DD-digest-2.md`.

**Reports dir** (first match):

1. `$DIGEST_REPORTS_DIR` if set
2. `plugins/joy-knowledge/knowledge/reports/` if that folder exists in cwd
3. `reports/` in cwd if the user said save, or if that folder already exists

Path: `<dir>/YYYY-MM-DD-digest.md`

**Obsidian** — only if a vault exists. Vault root = `$OBSIDIAN_VAULT`, else `~/Documents/Obsidian Vault` when that folder exists. Skip if neither is there.

1. `.raw/daily-digest/YYYY-MM-DD-digest.md` — immutable
2. `wiki/sources/daily-digest/YYYY-MM-DD Daily Digest.md` — once
3. Prepend the day on `wiki/sources/Daily News Digest.md` and `wiki/sources/_index.md`
4. Prepend `wiki/index.md` and `wiki/log.md`. Overwrite `wiki/hot.md` (under 500 words)
5. Wikilink pages that already exist. Do not invent entity pages.

If neither a reports dir nor a vault is present, the chat briefing is enough.

## Out of scope

Building the products. A second skill for the same job.
