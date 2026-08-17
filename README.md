# daily-news-digest

Standalone agent skill. Same-day Tech/AI + Shopify wire, then X + Reddit launches.

Triggers: `/daily-news-digest`, `/trend-radar`, “morning digest”, “what’s launching”.

This repo is the only source.

## Install — clone into skills (simplest)

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

## What the agent needs

- Web search
- X tools if the host has them. If not, it shells out to `grok -p` once, then still searches Reddit itself.

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
references/rails.md      # search strings — edit here
references/file.md       # where to write the briefing
.claude-plugin/          # plugin + marketplace catalog
skills/daily-news-digest → same skill (for plugin discovery)
```
