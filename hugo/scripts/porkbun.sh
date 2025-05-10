#!/bin/bash
set -euo pipefail

show_help() {
  echo "Usage: ./porkbun.sh <template.json> <endpoint>"
  echo ""
  echo "Example:"
  echo "  ./porkbun.sh ping.json ping"
  echo ""
  echo "Available endpoints and templates:"
  for f in *.json; do
    name="${f%.json}"
    echo "  $name.json  ->  Endpoint: $name"
  done
  exit 0
}

# Help option
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  show_help
fi

# Arguments
TEMPLATE_FILE="$1"
ENDPOINT="$2"

# Require these to be set
: "${API_KEY:?Missing API_KEY}"
: "${SECRET_KEY:?Missing SECRET_KEY}"
# Read and replace placeholders
JSON_PAYLOAD=$(<"$TEMPLATE_FILE")
JSON_PAYLOAD="${JSON_PAYLOAD//\$\{API_KEY\}/$API_KEY}"
JSON_PAYLOAD="${JSON_PAYLOAD//\$\{SECRET_KEY\}/$SECRET_KEY}"

#echo $JSON_PAYLOAD
# Make the request
curl -s -X POST "https://api.porkbun.com/api/json/v3/$ENDPOINT" \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD" | jq

