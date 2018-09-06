#!/bin/sh

# accounts="gy3danbsgmge gyydomrtgege gmztqmzqgqge mifanxp22222 gu3dgnbsg4ge gezteojrhage gu2dknzyhage gq4danbxgyge gyytgmjtgmge heytgobsgege gyzdsnrwgige gqztamjvguge" 

# length=${#accounts[@]}

node_api="http://api.eosnewyork.io"
wallet_api="http://127.0.0.1:8900"
cls="/github/eos/build/programs/cleos/cleos"
proxy="http://127.0.0.1:10810"
executer="eosauthorcom"

for (( i = 0; i < 10; i++ )); do
    res=`curl -x $proxy -s https://faucet.eosfavor.com/airdropaccount | jq -r .[].name`
    echo $res
    for account in $res 
    do
        echo $account
        token=`curl -x $proxy -d "{\"code\":\"ethsidechain\",\"symbol\":\"EETH\",\"account\":\"${account}\"}" -H "Content-Type:application/json"  -s https://api1.eosdublin.io/v1/chain/get_currency_balance `
        if [[ $token = "[]" ]]; then
            $cls   -u $node_api --wallet-url $wallet_api push action ethsidechain transfer "[\"${executer}\", \"${account}\", \"5000.0000 EETH\", \"免费领取EETH代币, eosfavor.com\"]" -p ${executer}@active
        else
            echo $token
        fi;
    done;
    $cls  -u $node_api --wallet-url $wallet_api get currency balance ethsidechain  $executer
done


# for account in $accounts
# do
#     echo $account;

#    $cls   -u $node_api --wallet-url $wallet_api push action ethsidechain transfer "[\"eosauthorcom\", \"${account}\", \"5000.0000 EETH\", \"免费领取EETH代币, eosfavor.com\"]" -p eosauthorcom@active
# done;

# echo $length;



