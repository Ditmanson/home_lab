#! /bin/bash

response=$(./porkbun.sh domains.json domain/listAll)
echo $response | jq -r '.domains[0].domain' | sed -n '2p'
