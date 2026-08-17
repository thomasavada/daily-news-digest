# daily-news-digest

Agent skill. Same-day Tech/AI + Shopify/e-commerce wire, then X + Reddit launches.

Triggers: `/daily-news-digest`, `/trend-radar`, “morning digest”, “what’s launching”.

## Clone (this is the skill folder)

`SKILL.md` is at the repo root. Clone **into** the host’s skills directory — do not nest another folder.

```bash
# Claude Code
git clone https://github.com/thomasavada/daily-news-digest.git ~/.claude/skills/daily-news-digest

# Grok
git clone https://github.com/thomasavada/daily-news-digest.git ~/.grok/skills/daily-news-digest

# Codex / other Agent Skills hosts
git clone https://github.com/thomasavada/daily-news-digest.git ~/.agents/skills/daily-news-digest
```

Update later:

```bash
git -C ~/.claude/skills/daily-news-digest pull
```

Then run `/daily-news-digest`.

## What the agent needs

- Web search
- X tools if the host has them (`x_keyword_search`, `x_semantic_search`). If not, the skill shells out to `grok -p` once, then the agent still searches Reddit itself.

## Optional file destinations

Chat briefing is enough. If you want a file:

| Env / path | What happens |
|---|---|
| `DIGEST_REPORTS_DIR` | Write `YYYY-MM-DD-digest.md` there |
| `plugins/joy-knowledge/knowledge/reports/` in cwd | Same filename there |
| `reports/` in cwd (or user said save) | Same filename there |
| `OBSIDIAN_VAULT` or `~/Documents/Obsidian Vault` | Also log into that vault (raw + wiki source note) |

Write once per day. Same-day second pull uses `-2`.

## Layout

```
SKILL.md
references/rails.md
```

Edit search strings in `references/rails.md` only.
