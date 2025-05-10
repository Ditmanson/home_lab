#!/bin/bash
set -euo pipefail

# Require keys to be set
: "${API_KEY:?Missing API_KEY}"
: "${SECRET_KEY:?Missing SECRET_KEY}"

bash get_records.sh > records.md

DOMAIN="tdebian.com"  # change this if needed
RECORDS_FILE="./records.md"
IP=$(./get_ip.sh)
TTL=600
TYPE="A"
NAME="@"  # Change to subdomain if needed, e.g., "www"

echo $IP

echo "Updating records in $RECORDS_FILE to IP $IP..."

for ID in $(<"$RECORDS_FILE"); do
  echo "Updating record ID: $ID"

  curl -s -X POST "https://api.porkbun.com/api/json/v3/dns/edit/${DOMAIN}/${ID}" \
    -H "Content-Type: application/json" \
    -d "{
      \"apikey\": \"${API_KEY}\",
      \"secretapikey\": \"${SECRET_KEY}\",
      \"name\": \"${NAME}\",
      \"type\": \"${TYPE}\",
      \"content\": \"${IP}\",
      \"ttl\": \"${TTL}\"
    }" | jq
done

