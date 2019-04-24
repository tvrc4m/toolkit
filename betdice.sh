#!/bin/sh
#
node_api="http://api-mainnet.starteos.io"
wallet_api="http://127.0.0.1:8900"
cls="/github/eos/build/programs/cleos/cleos"
bt_accounts="kungfupanda4 newsflashpro kungfupanda5 eoswalletkit sublimetext3 makelovetime officialbank  eosontheroad spacecapsule onlongerlove eosunitunion  eosauctionex tosayloveyou ihateuiloveu  dragonballtv chinaculture ionlylikeyou ohbabyiloveu eosplateform iboflytomars imtheironman k2haitangwan ifallinloveu 2gether4ever eostonystark eosauthorcom eosluckystar eosnewsflash babyilikeyou ilikeyoubaby  microcapsule saysomething"

function unlock_wallet(){

    status=`$cls -u $node_api wallet list |awk '/default \*/ {print "1"}'`

    if [[ ! $status ]]; then
        # 解锁钱包
        $cls -u $node_api wallet unlock -n default --password PW5KZ8X132W9pxRADQDT6KzvfAFUFBg3SRpskdioJbaroL539Kyua
    fi
}

while [[ 1 ]]; do
    
    unlock_wallet

    for account in $bt_accounts; do
        res=`$cls -u $node_api push action betdicelucky draw "{\"from\":\"${account}\",\"b\":\"25103157\",\"c\":\"1705\"}" -p $account@active | awk '/Error/{print 1}'`
        echo $account
        echo $res
    done
    exit
done

