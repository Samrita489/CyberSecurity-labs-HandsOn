#!/usr/bin/env bash
# Lab 3: scan intentionally vulnerable Terraform (TerraGoat) with Checkov. Nothing is ever deployed.
# Run from anywhere:  bash scan.sh
# Checkov needs Python 3.9-3.12, so install it with Homebrew:  brew install checkov
set -uo pipefail
cd "$HOME/soc-portfolio/lab3-cloud"

[ -d terragoat ] || git clone --depth 1 https://github.com/bridgecrewio/terragoat.git

echo "== Scan 1: original code =="
checkov -d terragoat/terraform/aws --compact | tee scan-before.txt | grep -B1 "Passed checks"
checkov -d terragoat/terraform/aws -o json --output-file-path results-before >/dev/null

python3 make_dashboard.py results-before/results_json.json dashboard-before.html
echo "Open dashboard-before.html in your browser."

echo
echo "== Where the risky 0.0.0.0/0 values are =="
grep -n "0.0.0.0/0" terragoat/terraform/aws/*.tf || true
echo "Note: a destination_cidr_block route is normal; a security-group ingress range is the risk."

cat <<'NOTE'

== Remediation step (manual) ==
1. cp -r terragoat/terraform/aws aws-fixed
2. Edit two findings in aws-fixed/ (for example, change an ingress "0.0.0.0/0" to a private range
   such as "10.0.0.0/16", and fix a second finding from the dashboard).
3. Run:  bash compare.sh
NOTE
