import csv
import html
import json
import sys
from collections import Counter

if len(sys.argv) != 3:
    sys.exit("Usage: python3 make_dashboard.py <results_json.json> <output.html>")

data = json.load(open(sys.argv[1]))
if isinstance(data, list):  # Checkov returns a list when several frameworks are scanned
    data = data[0]

passed = data["results"]["passed_checks"]
failed = data["results"]["failed_checks"]


def priority(name):
    n = name.lower()
    if any(k in n for k in ["public", "0.0.0.0", "ingress", "ssh", "rdp", "admin", "wildcard", "full"]):
        return "High"
    if any(k in n for k in ["encrypt", "kms", "tls", "https", "ssl", "password", "secret", "key"]):
        return "Medium"
    return "Low"


order = {"High": 0, "Medium": 1, "Low": 2}
rows = []
for c in failed:
    line = (c.get("file_line_range") or ["", ""])[0]
    rows.append({
        "priority": priority(c["check_name"]),
        "check_id": c["check_id"],
        "issue": c["check_name"],
        "resource": c["resource"],
        "type": c["resource"].split(".")[0],
        "file": c["file_path"].lstrip("/"),
        "line": line,
    })
rows.sort(key=lambda r: (order[r["priority"]], r["type"]))

csv_path = sys.argv[2].replace(".html", ".csv")
with open(csv_path, "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
    w.writeheader()
    w.writerows(rows)


def bar_block(title, counter, top=10):
    items = counter.most_common(top)
    mx = max((v for _, v in items), default=1)
    body = "".join(
        '<div class="row"><span class="lbl">' + html.escape(str(k)) + '</span>'
        '<span class="track"><span class="bar" style="width:' + str(int(v / mx * 100)) + '%"></span></span>'
        '<span class="num">' + str(v) + '</span></div>'
        for k, v in items
    )
    return "<section><h2>" + title + "</h2>" + body + "</section>"


total = len(passed) + len(failed)
rate = round(100 * len(passed) / total) if total else 0
prio = Counter(r["priority"] for r in rows)

css = """
body{font-family:-apple-system,Helvetica,Arial,sans-serif;margin:24px;background:#f5f6f8;color:#1a202c}
h1{margin:0 0 4px}.sub{color:#555;margin-bottom:18px}
.cards{display:flex;gap:12px;flex-wrap:wrap;margin-bottom:18px}
.card{background:#fff;border-radius:8px;padding:14px 20px;box-shadow:0 1px 3px #0002;min-width:140px}
.card b{display:block;font-size:28px}
section{background:#fff;border-radius:8px;padding:14px 18px;margin-bottom:16px;box-shadow:0 1px 3px #0002}
h2{margin:0 0 10px;font-size:17px}
.row{display:grid;grid-template-columns:300px 1fr 40px;gap:8px;align-items:center;margin:4px 0;font-size:13px}
.track{background:#e2e8f0;border-radius:4px;height:14px}.bar{display:block;height:14px;background:#2b6cb0;border-radius:4px}
.num{text-align:right}
table{border-collapse:collapse;width:100%;font-size:12px}th,td{border-bottom:1px solid #e2e8f0;padding:6px;text-align:left;vertical-align:top}
th{background:#edf2f7}.High{color:#c53030;font-weight:700}.Medium{color:#b7791f;font-weight:700}.Low{color:#2f855a;font-weight:700}
"""

table_rows = "".join(
    "<tr><td class='" + r["priority"] + "'>" + r["priority"] + "</td><td>" + html.escape(r["check_id"]) +
    "</td><td>" + html.escape(r["issue"]) + "</td><td>" + html.escape(r["resource"]) +
    "</td><td>" + html.escape(r["file"]) + ":" + str(r["line"]) + "</td></tr>"
    for r in rows
)

page = (
    "<html><head><meta charset='utf-8'><title>Cloud Security Dashboard</title><style>" + css + "</style></head><body>"
    "<h1>Cloud Security Dashboard</h1>"
    "<div class='sub'>Checkov scan of intentionally vulnerable Terraform (TerraGoat, AWS)</div>"
    "<div class='cards'>"
    "<div class='card'><b>" + str(len(failed)) + "</b>Failed checks</div>"
    "<div class='card'><b>" + str(len(passed)) + "</b>Passed checks</div>"
    "<div class='card'><b>" + str(rate) + "%</b>Pass rate</div>"
    "<div class='card'><b class='High'>" + str(prio["High"]) + "</b>High priority</div>"
    "<div class='card'><b class='Medium'>" + str(prio["Medium"]) + "</b>Medium priority</div>"
    "<div class='card'><b class='Low'>" + str(prio["Low"]) + "</b>Low priority</div>"
    "</div>"
    + bar_block("Failed checks by resource type", Counter(r["type"] for r in rows))
    + bar_block("Top 10 misconfigurations", Counter(r["issue"] for r in rows))
    + bar_block("Failed checks by file", Counter(r["file"].split("/")[-1] for r in rows))
    + "<section><h2>All findings (sorted by priority)</h2><table><tr><th>Priority</th><th>Check</th>"
      "<th>Issue</th><th>Resource</th><th>File:line</th></tr>" + table_rows + "</table></section>"
    "</body></html>"
)

open(sys.argv[2], "w").write(page)
print("Wrote", sys.argv[2], "and", csv_path)