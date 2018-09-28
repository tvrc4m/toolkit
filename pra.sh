#!/bin/sh
#
node_api="http://api-mainnet.starteos.io"
wallet_api="http://127.0.0.1:8900"
cls="/github/eos/build/programs/cleos/cleos"
bt_accounts="ifallinloveu 2gether4ever eostonystark eosauthorcom eosluckystar eosnewsflash babyilikeyou ilikeyoubaby  microcapsule saysomething"
pra_accounts="kungfupanda4 newsflashpro kungfupanda5 eoswalletkit sublimetext3 makelovetime officialbank dappfreezone eosontheroad spacecapsule onlongerlove eosunitunion dappdropzone eosauctionex tosayloveyou ihateuiloveu qingdaoblock qdblockchain dragonballtv chinaculture ionlylikeyou ohbabyiloveu cnliterature eosplateform iboflytomars chinalibrary imtheironman k2haitangwan"

function unlock_wallet(){

    status=`$cls -u $node_api --wallet-url $wallet_api wallet list |awk '/default \*/ {print "1"}'`

    if [[ ! $status ]]; then
        # 解锁钱包
        $cls -u $node_api --wallet-url $wallet_api wallet unlock -n default --password PW5KZ8X132W9pxRADQDT6KzvfAFUFBg3SRpskdioJbaroL539Kyua
    fi
}

while [[ 1 ]]; do
    
    unlock_wallet

    for account in $bt_accounts; do
        res=`$cls -u $node_api --wallet-url $wallet_api push action prochaintech click "{\"clickRequest\":{\"account\":\"${account}\",\"candyId\":4}}" -p $account@active | awk '/Error/{print 1}'`
        echo $res
        echo $account
        $cls -u $node_api --wallet-url $wallet_api get currency balance eosbtextoken $account "BT"
        if [[ res -eq 1 ]]; then
            echo "error"
        fi
    done
    for account in $pra_accounts; do
        res=`$cls -u $node_api --wallet-url $wallet_api push action prochaintech click "{\"clickRequest\":{\"account\":\"${account}\",\"candyId\":0}}" -p $account@active | awk '/Error/{print 1}'`
        echo $res
        echo $account
        $cls -u $node_api --wallet-url $wallet_api get currency balance epraofficial $account "EPRA"
        if [[ res -eq 1 ]]; then
            echo "error"
        fi

    done
    sleep 14400
done

