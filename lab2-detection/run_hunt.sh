#!/usr/bin/env bash
# Lab 2: copy the five attack logs, then test the Sigma rules with Chainsaw.
# Run from your soc-portfolio folder:  bash lab2-detection/run_hunt.sh
set -euo pipefail
cd "$HOME/soc-portfolio"
CH=./chainsaw/chainsaw_aarch64-apple-darwin
S=data/EVTX-ATTACK-SAMPLES
MAP=chainsaw/mappings/sigma-event-logs-all.yml

mkdir -p lab2-detection/evtx
cp "$S/Defense Evasion/DE_1102_security_log_cleared.evtx"                  lab2-detection/evtx/
cp "$S/Defense Evasion/DE_104_system_log_cleared.evtx"                     lab2-detection/evtx/
cp "$S/Lateral Movement/LM_Remote_Service02_7045.evtx"                     lab2-detection/evtx/
cp "$S/Credential Access/babyshark_mimikatz_powershell.evtx"               lab2-detection/evtx/
cp "$S/Persistence/Network_Service_Guest_added_to_admins_4732.evtx"        lab2-detection/evtx/

echo "== Baseline: community Sigma rules =="
$CH hunt lab2-detection/evtx/ -s data/sigma/rules/windows/ --mapping "$MAP" --skip-errors | tail -20 || true

echo "== My rules =="
ls lab2-detection/my_rules
$CH hunt lab2-detection/evtx/ -s lab2-detection/my_rules/ --mapping "$MAP" --skip-errors

echo "== Compact summary (which rules fired) =="
$CH hunt lab2-detection/evtx/ -s lab2-detection/my_rules/ --mapping "$MAP" --skip-errors 2>&1 \
  | grep -E "Loaded|Detections found|Cleared|Suspicious|Installed|Added" || true

echo "== Direct event checks (does the event exist at all?) =="
for id in 1102 104 7045 4732; do
  echo "--- EventID $id ---"
  $CH search -t "Event.System.EventID: =$id" lab2-detection/evtx/ | grep -E "Found .* hits" || true
done
