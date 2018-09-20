#!/bin/sh
#
node_api="http://api-mainnet.starteos.io"
wallet_api="http://127.0.0.1:8900"
cls="/github/eos/build/programs/cleos/cleos"
executer="eostonystark"
account="eosbtextoken"

function wallet_status(){

    status=`$cls -u $node_api --wallet-url $wallet_api wallet list |awk '/default \*/ {print "1"}'`

    if [[ ! $status ]]; then
        # 解锁钱包
        $cls -u $node_api --wallet-url $wallet_api wallet unlock -n default --password PW5KZ8X132W9pxRADQDT6KzvfAFUFBg3SRpskdioJbaroL539Kyua
    fi
}

while [[ 1 ]]; do

    # supply=`$cls -u $node_api --wallet-url $wallet_api get currency stats $account "BT" | jq -r .BT.supply| awk '{print int($1)}'`   
    right=`$cls -u $node_api --wallet-url $wallet_api get table $account $executer btexrights | jq -r .rows[0].rights | awk '{print int($1)}'`

    # echo $right
    # if [[ supply -ge 30000000 ]]; then
    if [[ right -gt 0 ]]; then

        wallet_status
        
        $cls  -u $node_api --wallet-url $wallet_api push action $account transfer "[\"${executer}\",\"${account}\",\"${right}.0000 BT\",\"SELL BT\"]" -p ${executer}@active  
    else

        echo 'sleep 60s'
        sleep 60
    fi
done
 
