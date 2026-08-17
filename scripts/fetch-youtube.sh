#!/usr/bin/env bash
# AI Engineer talks in the last ~month, ranked by total views.
# Batch drops are the norm — 50k+ views in this window = watch.
# Do not open_page the /videos HTML tab.
set -euo pipefail
DAYS="${1:-30}"
WATCH_MIN="${AIE_WATCH_MIN:-50000}"
PLAYLIST_END="${AIE_PLAYLIST_END:-40}"
RAW="${TMPDIR:-/tmp}/aie-raw.tsv"

# One pass: date + views (not RSS — RSS is only ~15 items and misses the prior batch).
yt-dlp --playlist-end "$PLAYLIST_END" --skip-download --no-warnings \
  --print "%(upload_date)s|%(view_count)s|%(id)s|%(title)s" \
  "https://www.youtube.com/@aiDotEngineer/videos" > "$RAW"

python3 - "$DAYS" "$WATCH_MIN" "$RAW" <<'PY'
import sys, datetime
days = int(sys.argv[1])
watch_min = int(sys.argv[2])
path = sys.argv[3]
today = datetime.date.today()
cutoff = today - datetime.timedelta(days=days)
rows = []
for line in open(path):
    line = line.rstrip("\n")
    parts = line.split("|", 3)
    if len(parts) < 4:
        continue
    date_s, vc_s, vid, title = parts
    try:
        d = datetime.datetime.strptime(date_s, "%Y%m%d").date()
    except ValueError:
        continue
    if d < cutoff:
        continue
    try:
        vc = int(vc_s)
    except ValueError:
        vc = 0
    age = max(1, (today - d).days)
    rows.append((vc, age, d.isoformat(), title, vid))
rows.sort(reverse=True)
watch = [r for r in rows if r[0] >= watch_min]
print(f"# window={days}d  ranked by total views  n={len(rows)}  watch>={watch_min}: {len(watch)}")
print("flag\tviews\tage_d\tdate\ttitle\turl")
for vc, age, date_s, title, vid in rows:
    flag = "WATCH" if vc >= watch_min else "—"
    print(f"{flag}\t{vc}\t{age}\t{date_s}\t{title}\thttps://www.youtube.com/watch?v={vid}")
if not rows:
    print("NO_UPLOADS_IN_WINDOW")
PY
