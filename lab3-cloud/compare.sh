#!/usr/bin/env bash
# Lab 3: compare failed-check counts before and after your fixes.
set -uo pipefail
cd "$HOME/soc-portfolio/lab3-cloud"
echo "== BEFORE (original) =="; checkov -d terragoat/terraform/aws --compact | grep -B1 "Passed checks"
echo "== AFTER (aws-fixed) =="; checkov -d aws-fixed --compact | grep -B1 "Passed checks"
diff -ru terragoat/terraform/aws aws-fixed > remediation.diff || true
echo "Saved your changes as remediation.diff"
