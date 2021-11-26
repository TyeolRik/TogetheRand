#!/bin/bash

endPoint="http://192.168.0.100:7545"
header="Content-Type:application/json"
contractAddress="0x44768495Cf167d5BF1B8ef53Cf2D7ceB54E7b68e"

# Get All Accounts
accounts=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1}' -H $header $endPoint | jq '.result')
accounts=($(echo "${accounts//[\[\],]/}" | xargs))
# Print All Accounts
# for (( i=0; i<${#accounts[@]}; i++ ))
# do
#     echo -e "$i\t${accounts[$i]}"
# done

# Do Participate
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
    sleep 2s
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
    sleep 4s
done

echo "END()"
# END
curl -s -X POST --data '{
        "jsonrpc": "2.0",
        "method": "eth_sendTransaction",
        "params": [
                {
                    "from": "0xac582e97209b67bef04a3d3d5121131835105df9",
                    "to": "'"${contractAddress}"'",
                    "data": "0xefe7a504"
                }
            ],
        "id": 1
    }' -H $header $endPoint
echo "" # Line break

echo "GETmyRandomNumber()"
# GETmyRandomNumber()
for (( i=0; i<${#accounts[@]}; i=i+1 ))
do
    curl -s -X POST --data '{
        "jsonrpc": "2.0",
        "method": "eth_sendTransaction",
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

echo "eth_call()"
# eth_call()
for (( i=0; i<${#accounts[@]}; i=i+1 ))
do
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