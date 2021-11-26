#!/bin/bash

endPoint="http://192.168.0.100:7545"
header="Content-Type:application/json"
contractAddress="0x3873E4EB621570699bCbe298EC5d10fbE4A83072"

# Get All Accounts
accounts=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1}' -H $header $endPoint | jq '.result')
accounts=($(echo "${accounts//[\[\],]/}" | xargs))

# eth_sendTransaction
# eth_call

# Check GlobalOrderCounter
echo "Check GlobalOrderCounter"
curl -s -X POST --data '{
    "jsonrpc": "2.0",
    "method": "eth_call",
    "params": [
            {
                "from": "'"${accounts[0]}"'",
                "to": "'"${contractAddress}"'",
                "data": "0x47e9f582"
            }
        ],
    "id": 1
    }' -H $header $endPoint
echo ""

# Do Participate
echo "Participate"
for (( i=0; i<${#accounts[@]}; i=i+2 ))
do
    curl -s -X POST --data '{
        "jsonrpc": "2.0",
        "method": "eth_sendTransaction",
        "params": [
                {
                    "from": "'"${accounts[$i]}"'",
                    "to": "'"${contractAddress}"'",
                    "data": "0xedd475680000000000000000000000000000000000000000000000000000000000123456"
                }
            ],
        "id": 1
    }' -H $header $endPoint
    echo "" # line break
    # sleep 2s
    j=$((i+1))
    curl -s -X POST --data '{
        "jsonrpc": "2.0",
        "method": "eth_sendTransaction",
        "params": [
                {
                    "from": "'"${accounts[$j]}"'",
                    "to": "'"${contractAddress}"'",
                    "data": "0xedd475680000000000000000000000000000000000000000000000000000000000654321"
                }
            ],
        "id": 1
    }' -H $header $endPoint
    echo "" # line break
    # sleep 4s
done

sleep 6s # For waiting block write
echo "check" # PrintPersonalinputs()
for (( i=0; i<${#accounts[@]}; i=i+2 ))
do
    curl -s -X POST --data '{
        "jsonrpc": "2.0",
        "method": "eth_call",
        "params": [
                {
                    "from": "'"${accounts[$i]}"'",
                    "to": "'"${contractAddress}"'",
                    "data": "0x440bef0b"
                }
            ],
        "id": 1
    }' -H $header $endPoint
    echo "" # line break
    echo "" # line break
    echo "" # line break
done