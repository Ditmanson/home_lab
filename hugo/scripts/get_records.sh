#! /bin/zsh

response=$(./porkbun.sh ping.json dns/retrieve/tdebian.com)
echo $response | jq -r '.records[].id' 2>/dev/null
