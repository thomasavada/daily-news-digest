#!/usr/bin/env bash
# Recent AI Engineer uploads ranked by attention (views / days live).
# Do not open_page the /videos HTML tab.
set -euo pipefail
CHANNEL_ID="${AIE_CHANNEL_ID:-UCLKPca3kwwd-B59HNr-_lvA}"
DAYS="${1:-14}"
FEED="https://www.youtube.com/feeds/videos.xml?channel_id=${CHANNEL_ID}"
OUT="${TMPDIR:-/tmp}/aie-feed.xml"
curl -fsS "$FEED" -o "$OUT"

python3 - "$OUT" "$DAYS" <<'PY' > "${TMPDIR:-/tmp}/aie-meta.tsv"
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
    print(f"{pub[:10]}\t{vid}\t{title}")
    n += 1
if n == 0:
    print("NO_UPLOADS_IN_WINDOW")
PY

if grep -qx "NO_UPLOADS_IN_WINDOW" "${TMPDIR:-/tmp}/aie-meta.tsv"; then
  echo "NO_UPLOADS_IN_WINDOW"
  exit 0
fi

URLS=()
while IFS=$'\t' read -r _date vid _title; do
  [[ -n "$vid" ]] || continue
  URLS+=("https://www.youtube.com/watch?v=$vid")
done < "${TMPDIR:-/tmp}/aie-meta.tsv"

yt-dlp --skip-download --no-warnings --print "%(id)s|%(view_count)s" "${URLS[@]}" \
  > "${TMPDIR:-/tmp}/aie-views.tsv"

python3 - "$DAYS" "${TMPDIR:-/tmp}/aie-meta.tsv" "${TMPDIR:-/tmp}/aie-views.tsv" <<'PY'
import sys, datetime
days = int(sys.argv[1])
meta_path, views_path = sys.argv[2], sys.argv[3]
views = {}
for line in open(views_path):
    line = line.rstrip("\n").replace("\\t", "|")
    sep = "|" if "|" in line else "\t"
    if sep not in line:
        continue
    vid, vc = line.split(sep, 1)
    try:
        views[vid] = int(vc)
    except ValueError:
        views[vid] = 0
today = datetime.date.today()
rows = []
for line in open(meta_path):
    parts = line.rstrip("\n").split("\t", 2)
    if len(parts) < 3:
        continue
    date_s, vid, title = parts
    try:
        d = datetime.date.fromisoformat(date_s)
        age = max(1, (today - d).days)
    except ValueError:
        age = days
    vc = views.get(vid, 0)
    rows.append((vc / age, vc, age, date_s, title, vid))
rows.sort(reverse=True)
print(f"# window={days}d  ranked by views/day  n={len(rows)}")
print("views/day\tviews\tage_d\tdate\ttitle\turl")
for vpd, vc, age, date_s, title, vid in rows:
    print(f"{vpd:.0f}\t{vc}\t{age}\t{date_s}\t{title}\thttps://www.youtube.com/watch?v={vid}")
PY
