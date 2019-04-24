#!/bin/sh

api="https://eos.greymass.com"
# account="gamebetcandy"
account="dhboneplay11"
eos="cleos -u $api get actions $account"
page=0
# limit=3
limit=300

while [[ 1 ]]; do
    # actions=`cleos -u $api get actions -j $account $page $(($page+$limit))`
    # actions=`cleos -u $api get actions -j $account $page $(($page+$limit)) |jq .actions[].action_trace.act.data.to`
    actions=`cleos -u $api get actions -j $account $page $(($page+$limit)) |jq .actions[].action_trace.act.data.from`
    page=$(($page+limit))
    # echo $actions >> /d/gamebetcandy.log
    echo $actions >> /d/${account}.log
done