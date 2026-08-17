# daily-news-digest

Team skill. Scan the news most people on the team skip: **Shopify updates**, **AI**, **e-commerce Shopify is focusing on**, **new launches**, **GitHub**. Graph is **X + LinkedIn**. Talks: **[AI Engineer](https://www.youtube.com/@aiDotEngineer)**.

Triggers: `/daily-news-digest`, `/trend-radar`, “morning digest”, “what’s launching”, “LinkedIn scan”.

This repo is the only source.

## Install — clone into skills

`SKILL.md` is at the repo root. Clone **into** the host skills directory — do not nest another folder.

```bash
git clone https://github.com/thomasavada/daily-news-digest.git ~/.claude/skills/daily-news-digest
# or
git clone https://github.com/thomasavada/daily-news-digest.git ~/.grok/skills/daily-news-digest
# or
git clone https://github.com/thomasavada/daily-news-digest.git ~/.agents/skills/daily-news-digest
```

```bash
git -C ~/.claude/skills/daily-news-digest pull
```

Then `/daily-news-digest`.

## Install — Claude plugin

```bash
claude plugin marketplace add thomasavada/daily-news-digest
claude plugin install daily-news-digest@daily-news-digest
```

## What a run covers

| Sensor | Job |
|---|---|
| Wire | Shopify official blog + changelog (7 days), same-day AI + ecom |
| X | Launches, Shopify, AI, GitHub chatter |
| LinkedIn | How operators and Shopify people frame the same news |
| GitHub | `scripts/fetch-github.sh` (API — not trending HTML) |
| AI Engineer | `scripts/fetch-youtube.sh` (RSS — not `/videos` HTML) |

Edit search strings in [references/rails.md](references/rails.md) only.

## Optional file destinations

See [references/file.md](references/file.md). Chat briefing is enough if nothing matches.

| Env / path | What happens |
|---|---|
| `DIGEST_REPORTS_DIR` | Write `YYYY-MM-DD-digest.md` there |
| `reports/` in cwd (or user said save) | Same filename there |
| `OBSIDIAN_VAULT` or `~/Documents/Obsidian Vault` | Log into that vault |

## Layout

```
SKILL.md
references/rails.md
references/file.md
scripts/fetch-youtube.sh
scripts/fetch-github.sh
.claude-plugin/
skills/daily-news-digest → same skill (plugin discovery)
```
