#!/usr/bin/env bash
# Lab 1 setup: download practice data, start Splunk, convert Windows logs for Splunk.
# Tested on a Mac with an Apple chip. Run from anywhere:  bash 01_setup_and_convert.sh
set -euo pipefail

: "${SPLUNK_PASSWORD:?Set a password first, e.g.  export SPLUNK_PASSWORD='ChooseSomethingStrong1!'}"

ROOT="$HOME/soc-portfolio"
mkdir -p "$ROOT"/{data/linux-logs,screenshots,lab1-siem/json,lab2-detection,lab3-cloud}
cd "$ROOT"

echo "== 1. Download public practice data =="
[ -d data/EVTX-ATTACK-SAMPLES ] || git clone --depth 1 https://github.com/sbousseaden/EVTX-ATTACK-SAMPLES.git data/EVTX-ATTACK-SAMPLES
[ -d data/sigma ]               || git clone --depth 1 https://github.com/SigmaHQ/sigma.git data/sigma
curl -L -o data/linux-logs/Linux_2k.log \
  https://raw.githubusercontent.com/logpai/loghub/master/Linux/Linux_2k.log

echo "== 2. Download Chainsaw (Windows log tool) =="
if [ ! -d chainsaw ]; then
  curl -L -o chainsaw.zip "https://github.com/WithSecureLabs/chainsaw/releases/latest/download/chainsaw_all_platforms+rules.zip"
  unzip -q chainsaw.zip
  chmod +x chainsaw/chainsaw_aarch64-apple-darwin
fi
CH=./chainsaw/chainsaw_aarch64-apple-darwin
$CH --version

echo "== 3. Start Splunk in Docker (first start takes 5-10 minutes) =="
if ! docker ps -a --format '{{.Names}}' | grep -qx splunk; then
  docker run -d --platform linux/amd64 -p 8000:8000 \
    -e SPLUNK_GENERAL_TERMS=--accept-sgt-current-at-splunk-com \
    -e SPLUNK_START_ARGS=--accept-license \
    -e SPLUNK_PASSWORD="$SPLUNK_PASSWORD" \
    --name splunk splunk/splunk:latest
fi
echo "Open http://localhost:8000 (user: admin) once 'docker ps' shows (healthy)."

echo "== 4. Convert Windows .evtx attack samples to JSON lines for Splunk =="
S=data/EVTX-ATTACK-SAMPLES
convert() {  # $1 = path inside the samples folder, $2 = output name
  $CH dump "$S/$1" --jsonl -o "lab1-siem/json/$2"
}
convert "Defense Evasion/DE_1102_security_log_cleared.evtx"                    DE_1102_security_log_cleared.json
convert "Defense Evasion/DE_104_system_log_cleared.evtx"                       DE_104_system_log_cleared.json
convert "Lateral Movement/LM_Remote_Service02_7045.evtx"                       LM_Remote_Service02_7045.json
convert "Credential Access/babyshark_mimikatz_powershell.evtx"                 babyshark_mimikatz_powershell.json
convert "Persistence/Network_Service_Guest_added_to_admins_4732.evtx"          Guest_added_to_admins_4732.json

echo "Converted files:"; ls -lh lab1-siem/json
echo "Next: in Splunk use Settings > Add Data > Upload (source type: _json for the JSON files, index main)."
