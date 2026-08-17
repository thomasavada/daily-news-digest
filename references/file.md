# File destinations

Write once per calendar day. Never edit yesterday. Same-day second pull → `YYYY-MM-DD-digest-2.md`.

## Reports (first match)

1. `$DIGEST_REPORTS_DIR` if set
2. `reports/` in cwd if the user said save, or if that folder already exists

Path: `<dir>/YYYY-MM-DD-digest.md`

## Obsidian

Only if a vault exists. Root = `$OBSIDIAN_VAULT`, else `~/Documents/Obsidian Vault` when that folder exists. Skip if neither is there.

1. `.raw/daily-digest/YYYY-MM-DD-digest.md` — immutable
2. `wiki/sources/daily-digest/YYYY-MM-DD Daily Digest.md` — once
3. Prepend the day on `wiki/sources/Daily News Digest.md` and `wiki/sources/_index.md`
4. Prepend `wiki/index.md` and `wiki/log.md`. Overwrite `wiki/hot.md` (under 500 words)
5. Wikilink pages that already exist. Do not invent entity pages.
