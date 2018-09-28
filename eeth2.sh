#!/bin/sh


# node_api="https://api.eossweden.se"
# node_api="https://mainnet.eoscanada.com"
node_api="http://api-mainnet.starteos.io"
wallet_api="http://127.0.0.1:8900"
cls="/github/eos/build/programs/cleos/cleos"
executer="eosauthorcom"

filename="/slamdunk/toolkit/eos_accounts.txt"

i=0

function unlock_wallet(){

    status=`$cls -u $node_api --wallet-url $wallet_api wallet list |awk '/default \*/ {print "1"}'`

    if [[ ! $status ]]; then
        # 解锁钱包
        $cls -u $node_api --wallet-url $wallet_api wallet unlock -n default --password PW5KZ8X132W9pxRADQDT6KzvfAFUFBg3SRpskdioJbaroL539Kyua
    fi
}

unlock_wallet

while read -r account
do
    i=$(($i+1))
    if [[ $account ]]; then
        balance=`$cls   -u $node_api --wallet-url $wallet_api get currency balance ethsidechain $account`
        if [[ ! $balance ]]; then
            echo $account
            $cls   -u $node_api --wallet-url $wallet_api push action ethsidechain transfer "[\"${executer}\", \"${account}\", \"1.0000 EETH\", \"免费领取EETH， wallet.eosfavor.com或者TP钱包Dapp发现栏搜索Eosfavor(Send 1 'EETH' to another account without 'EETH', you will get 5000 EETH as award),电报群:https://t.me/anyosio,更多请进:anyos.io\"]" -p ${executer}@active
        fi
        if [[ $i -gt 10 ]]; then
            $cls  -u $node_api --wallet-url $wallet_api get currency balance ethsidechain  $executer
            i=0
        fi
    fi
done < $filename;
