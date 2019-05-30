#!/bin/sh
node_api="http://api-mainnet.starteos.io"

rammarket=`cleos -u $node_api get table eosio eosio rammarket`

balance=`echo $rammarket | jq .rows[0].base.balance | awk -F '"' '{printf "%f", $2}'`
total=`echo $rammarket | jq .rows[0].quote.balance | awk -F '"' '{printf "%f", $2}'`


awk 'BEGIN{printf "%.4f\n", '$total' / ('$balance' / 1024)}'

