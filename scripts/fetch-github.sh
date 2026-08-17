#!/usr/bin/env bash
# GitHub search API. Do not open_page github.com/trending (JS-walled).
set -euo pipefail
python3 - <<'PY'
import json, urllib.request, urllib.parse, datetime
since = (datetime.date.today() - datetime.timedelta(days=7)).isoformat()
headers = {"Accept": "application/vnd.github+json", "User-Agent": "daily-news-digest"}

def search(q, sort="stars"):
    url = (
        "https://api.github.com/search/repositories?"
        + urllib.parse.urlencode({"q": q, "sort": sort, "order": "desc", "per_page": "8"})
    )
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=20) as r:
        return json.load(r)

def show(title, q, sort):
    print(f"=== {title} ===")
    try:
        d = search(q, sort)
    except Exception as e:
        print("ERROR", e)
        return
    print("total", d.get("total_count"))
    for i in d.get("items", []):
        desc = (i.get("description") or "").replace("\n", " ")[:110]
        print(f"{i['stargazers_count']:6}★  {i['full_name']}")
        print(f"         {desc}")
        print(f"         {i['html_url']}  created={i['created_at'][:10]} pushed={i['pushed_at'][:10]}")

show("new agent/mcp (7d, by stars)", f"mcp OR agent created:>{since}", "stars")
print()
show("org:Shopify pushed 7d", f"org:Shopify pushed:>{since}", "updated")
print()
show("mcp stars>200 pushed 7d", f"mcp stars:>200 pushed:>{since}", "updated")
PY
