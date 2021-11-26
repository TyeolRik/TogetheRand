#!/bin/bash

endPoint="http://192.168.0.100:7545"
header="Content-Type:application/json"
contractAddress="0x44768495Cf167d5BF1B8ef53Cf2D7ceB54E7b68e"

# Get All Accounts
accounts=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1}' -H $header $endPoint | jq '.result')
accounts=($(echo "${accounts//[\[\],]/}" | xargs))

# eth_sendTransaction
# eth_call

# GETmyRandomNumber()
for (( i=0; i<${#accounts[@]}; i=i+1 ))
do
    echo "'"${accounts[$i]}"'"
    curl -s -X POST --data '{
        "jsonrpc": "2.0",
        "method": "eth_call",
        "params": [
                {
                    "from": "'"${accounts[$i]}"'",
                    "to": "'"${contractAddress}"'",
                    "data": "'"${accounts[$i]}"'"
                }
            ],
        "id": 1
    }' -H $header $endPoint
echo "" # Line break
done