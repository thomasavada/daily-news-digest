# Query rails

Single source for search strings. Edit here, not in SKILL.md.

## Wire (`web_search`)

Same-day only. Do not reuse yesterday's headlines.

| Section | Queries (run both) |
|---|---|
| Tech & AI | `AI news today model release funding` · `OpenAI Anthropic Google Nvidia AI announcement` |
| Shopify & ecom | `Shopify changelog today UCP Catalog MCP` · `ecommerce news today TikTok Shop Amazon merchant` |

Date the `since:` / `until:` only if the user pins a window. Default: `within_time:2d` on keyword queries (X advanced operator).

## X keyword (`x_keyword_search`, Latest)

| Rail | Query |
|---|---|
| SaaS launch | `("we just launched" OR "we shipped" OR "just shipped" OR waitlist) (SaaS OR agent OR "AI app") -giveaway` |
| Product Hunt / launch week | `("Product Hunt" OR "launched on PH" OR "it's live") (SaaS OR shopify OR agent)` |
| Product ideas | `("someone should build" OR "I would pay for" OR "looking for a tool") (SaaS OR shopify OR ecommerce OR agent)` |
| AI | `(launched OR shipping OR release) (Claude OR GPT OR Grok OR Gemini OR "open source model" OR MCP OR agent)` |
| AI Asia | `(AI OR LLM OR agent) (China OR 中国 OR "Southeast Asia" OR SEA OR Korea OR Japan OR India OR ByteDance OR Alibaba OR Tencent OR "TikTok Shop")` |
| Shopify | `(Shopify) (Catalog OR UCP OR MCP OR "Agentic Storefront" OR changelog OR app OR Plus)` |
| E-commerce | `("TikTok Shop" OR "live shopping" OR "agentic commerce" OR "instant checkout" OR Shopify) (launch OR launched OR shipping)` |

Cap each call at `limit: 10`. Add `min_faves:5` on AI and E-commerce.

## X semantic (`x_semantic_search`)

One sentence per rail. `limit: 5`, `min_score_threshold: 0.2`.

| Rail | Query |
|---|---|
| SaaS launch | New SaaS or AI agent products that just launched or opened a waitlist |
| Ideas | Founders describing a product they wish existed for ecommerce or agents |
| AI | Breaking AI model, agent, or protocol news people are reacting to |
| AI Asia | AI products, labs, or regulation trending in China, Korea, Japan, India, or Southeast Asia |
| Shopify | Shopify platform, Catalog, UCP, or app-ecosystem news merchants care about |
| E-commerce | Livestream shopping, TikTok Shop, or agent checkout changes |

## Reddit (`web_search`)

| Rail | Query |
|---|---|
| SaaS | `site:reddit.com/r/SaaS launched OR shipped OR waitlist` |
| Ideas | `site:reddit.com/r/SaaS OR site:reddit.com/r/Entrepreneur "someone should build" OR "I would pay"` |
| Shopify | `site:reddit.com/r/shopify OR site:reddit.com/r/shopifyDev Catalog OR UCP OR MCP OR app` |
| Ecom | `site:reddit.com (TikTok Shop OR "live shopping" OR "agentic commerce")` |
| AI | `site:reddit.com/r/LocalLLaMA OR site:reddit.com/r/MachineLearning (release OR launched)` |

## Handles worth a targeted `from:` pass (optional, max 3 extra calls)

Only if the default rails look thin:

`from:shopify` · `from:tobi` · `from:OpenAI` · `from:AnthropicAI` · `from:ShopifyDevs`
