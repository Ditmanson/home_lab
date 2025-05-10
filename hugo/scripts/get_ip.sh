#! /bin/bash

response=$(./porkbun.sh ping.json ping)
echo $response | jq -r .yourIp 
