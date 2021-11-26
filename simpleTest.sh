#!/bin/bash

endPoint="http://192.168.0.100:7545"
header="Content-Type:application/json"
contractAddress="0x2d04187D9DD02d8C6F580650a125Fa8A67F80B28"

# Get All Accounts
accounts=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1}' -H $header $endPoint | jq '.result')
accounts=($(echo "${accounts//[\[\],]/}" | xargs))

# set(uint)
curl -s -X POST --data '{
        "jsonrpc": "2.0",
        "method": "eth_sendTransaction",
        "params": [
                {
                    "from": "'"${accounts[0]}"'",
                    "to": "'"${contractAddress}"'",
                    "data": "0x60fe47b1000000000000000000000000000000000000000000000000000000000001e240"
                }
            ],
        "id": 1
    }' -H $header $endPoint
echo ""

sleep 6s
# get()
curl -s -X POST --data '{
        "jsonrpc": "2.0",
        "method": "eth_call",
        "params": [
                {
                    "from": "'"${accounts[0]}"'",
                    "to": "'"${contractAddress}"'",
                    "data": "0x6d4ce63c"
                }
            ],
        "id": 1
    }' -H $header $endPoint