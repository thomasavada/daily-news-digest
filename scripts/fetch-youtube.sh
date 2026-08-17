#!/usr/bin/env bash
# Dated uploads from AI Engineer. Do not open_page the /videos HTML tab.
set -euo pipefail
CHANNEL_ID="${AIE_CHANNEL_ID:-UCLKPca3kwwd-B59HNr-_lvA}"
DAYS="${1:-14}"
FEED="https://www.youtube.com/feeds/videos.xml?channel_id=${CHANNEL_ID}"
OUT="${TMPDIR:-/tmp}/aie-feed.xml"
curl -fsS "$FEED" -o "$OUT"
python3 - "$OUT" "$DAYS" <<'PY'
import sys, xml.etree.ElementTree as ET
from datetime import datetime, timezone, timedelta
path, days = sys.argv[1], int(sys.argv[2])
ns = {"a": "http://www.w3.org/2005/Atom", "yt": "http://www.youtube.com/xml/schemas/2015"}
root = ET.parse(path).getroot()
cutoff = datetime.now(timezone.utc) - timedelta(days=days)
n = 0
for e in root.findall("a:entry", ns):
    pub = e.findtext("a:published", default="", namespaces=ns)
    try:
        dt = datetime.fromisoformat(pub.replace("Z", "+00:00"))
    except ValueError:
        continue
    if dt < cutoff:
        continue
    title = e.findtext("a:title", default="", namespaces=ns)
    vid = e.findtext("yt:videoId", default="", namespaces=ns)
    print(f"{pub[:10]}\t{title}\thttps://www.youtube.com/watch?v={vid}")
    n += 1
if n == 0:
    print("NO_UPLOADS_IN_WINDOW")
PY
