#!/bin/sh


node2_api="https://api.eossweden.se"
# node_api="https://mainnet.eoscanada.com"
node_api="http://api-mainnet.starteos.io"
wallet_api="http://127.0.0.1:8900"
cls="/github/eos/build/programs/cleos/cleos"
executer="dappdropzone"

# filename="/slamdunk/toolkit/eos_accounts.txt"
filename="/slamdunk/toolkit/candy.txt"

i=0

function unlock_wallet(){

    status=`$cls -u $node_api  wallet list |awk '/default \*/ {print "1"}'`

    if [[ ! $status ]]; then
        # 解锁钱包
        $cls -u $node_api  wallet unlock -n default --password PW5JUsAy2Dj9Xxpth4y6Cizx8pfzDbUgayTQ6vWkLtzNGoEtNSBxA
    fi
}

unlock_wallet

while read -r account
do
    i=$(($i+1))
    if [[ $account ]]; then
        balance=`$cls   -u $node_api  get currency balance ethsidechain $account`
        if [[ $balance ]]; then
            # actions=`$cls -u $node2_api get actions $account -1 -1 |tail -n 1`
            # echo $actions;
            echo $account;
            # if [[ "$actions" =~ 2018-12 ]]; then
                # echo "match";
                $cls   -u $node_api  push action ethsidechain transfer "[\"${executer}\", \"${account}\", \"6.6000 EETH\", \"http://gamebet.one上线21点庄家版游戏,让普通用户也可以做庄,玩游戏即送GBT,加入电报群https://t.me/gamebetone。Online blackjack banker game.\"]" -p ${executer}@active
            # fi
            # exit;
        fi
    fi
done < $filename;
