#!/bin/sh


node_api="http://api.eosnewyork.io"
wallet_api="http://127.0.0.1:8900"
cls="/github/eos/build/programs/cleos/cleos"
executer="eosauthorcom"

filename="/slamdunk/toolkit/eos_accounts.txt"

i=0

while read -r account
do
    i=$(($i+1))
    if [[ $account ]]; then
        balance=`$cls   -u $node_api --wallet-url $wallet_api get currency balance ethsidechain $account`
        if [[ ! $balance ]]; then
            echo $account
            $cls   -u $node_api --wallet-url $wallet_api push action ethsidechain transfer "[\"${executer}\", \"${account}\", \"5000.0000 EETH\", \"免费领取EETH代币, eosfavor.com\"]" -p ${executer}@active
        fi
        if [[ $i -gt 10 ]]; then
            $cls  -u $node_api --wallet-url $wallet_api get currency balance ethsidechain  $executer
            i=0
        fi
    fi
done < $filename;
