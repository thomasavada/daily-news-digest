# Query rails

Single source for search strings. Edit here, not in SKILL.md.

Team scan: Shopify updates, AI, e-commerce Shopify is pushing, launches, GitHub. Graph: X + LinkedIn. Talks: AI Engineer YouTube.

## Wire (`web_search`)

| Section | Queries (run both) | Window |
|---|---|---|
| Shopify official | `site:shopify.com/enterprise/blog` · `site:shopify.com/news OR site:shopify.dev/changelog (AI OR Catalog OR UCP OR agentic OR checkout)` | **7 days** |
| Shopify & ecom | `Shopify changelog today UCP Catalog MCP Agentic` · `ecommerce news today Shopify TikTok Shop merchant` | same-day |
| AI | `AI news today model release funding agent` · `OpenAI Anthropic Google Nvidia AI announcement` | same-day |

Same-day rows: do not reuse yesterday’s headlines.

Shopify official: research and changelog drop weekly. `open_page` 1–2 items dated in the 7-day window (enterprise blog, shopify.com/news, shopify.dev/changelog). Do not stop at the SERP snippet.

Date `since:` / `until:` only if the user pins a window. Default on X keyword queries: `within_time:2d`.

## X keyword (`x_keyword_search`, Latest)

| Rail | Query |
|---|---|
| Shopify | `(Shopify) (Catalog OR UCP OR MCP OR "Agentic Storefront" OR changelog OR Plus OR checkout)` |
| E-commerce | `("TikTok Shop" OR "live shopping" OR "agentic commerce" OR "instant checkout" OR Shopify) (launch OR launched OR shipping)` |
| AI | `(launched OR shipping OR release) (Claude OR GPT OR Grok OR Gemini OR "open source model" OR MCP OR agent)` |
| SaaS launch | `("we just launched" OR "we shipped" OR "just shipped" OR waitlist) (SaaS OR agent OR "AI app" OR shopify) -giveaway` |
| Product Hunt | `("Product Hunt" OR "launched on PH" OR "it's live") (SaaS OR shopify OR agent)` |
| GitHub | `(github.com OR "we open sourced" OR "just released") (agent OR MCP OR shopify OR commerce) (launch OR shipped OR trending)` |

Cap each call at `limit: 10`. Add `min_faves:5` on AI and E-commerce.

## X semantic (`x_semantic_search`)

One sentence per rail. `limit: 5`, `min_score_threshold: 0.2`.

| Rail | Query |
|---|---|
| Shopify | Shopify platform, Catalog, UCP, or checkout changes merchants and app teams should notice |
| E-commerce | What Shopify is pushing in commerce: agent checkout, live shopping, Catalog |
| AI | Breaking AI model, agent, or protocol news people are reacting to |
| Launches | New SaaS or AI agent products that just launched |
| GitHub | New open-source agent, MCP, or commerce repos people are starring or releasing |

## LinkedIn (`web_search`)

| Rail | Query |
|---|---|
| Shopify staff | `site:linkedin.com (Shopify) (Catalog OR UCP OR "agentic commerce" OR Sidekick OR checkout)` |
| Operators | `site:linkedin.com (ecommerce OR DTC OR "Shopify Plus") (AI OR agent OR "AI search")` |

Window: last 7 days when the snippet has a date. `open_page` if readable; otherwise keep the LinkedIn URL + snippet.

## GitHub

Do not fetch `github.com/trending` HTML.

Every run, from this skill folder:

```bash
bash scripts/fetch-github.sh
```

That hits the GitHub search API for: new agent/MCP repos (7d), `org:Shopify` pushes (7d), popular MCP repos pushed (7d). Drop 0-star theme noise.

## AI Engineer YouTube

Channel: [youtube.com/@aiDotEngineer](https://www.youtube.com/@aiDotEngineer) · id `UCLKPca3kwwd-B59HNr-_lvA` · site [ai.engineer](https://ai.engineer)

Do not fetch `/videos` HTML.

Every run, from this skill folder:

```bash
bash scripts/fetch-youtube.sh 30
```

Last ~30 days, ranked by **total views**. `WATCH` = ≥50k views (batch drops, not views/day). Only those go in “gợi ý xem”. Optional: `web_search` `site:ai.engineer (talk OR conference OR schedule)` for upcoming events.

## Reddit (`web_search`, only if X + LinkedIn are thin)

| Rail | Query |
|---|---|
| Shopify | `site:reddit.com/r/shopify OR site:reddit.com/r/shopifyDev Catalog OR UCP OR MCP OR app` |
| Ecom | `site:reddit.com (TikTok Shop OR "agentic commerce")` |

## Handles worth a targeted `from:` pass (optional, max 3 extra calls)

Only if a launch or platform claim is still unconfirmed:

`from:shopify` · `from:tobi` · `from:ShopifyDevs` · `from:OpenAI` · `from:AnthropicAI`
