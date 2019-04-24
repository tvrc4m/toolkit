#!/bin/sh


node_api="https://api.eossweden.se"
wallet_api="http://127.0.0.1:8900"
cls="/github/eos/build/programs/cleos/cleos"  
executer="k2haitangwan"

# $cls  -u $node_api --wallet-url $wallet_api push action ethsidechain transfer "[\"${executer}\", \"eetheetheeth\", \"300.0000 EETH\", \"充值，追抢大佬\"]" -p ${executer}@active
$cls  -u $node_api --wallet-url $wallet_api push action ethsidechain transfer "[\"${executer}\", \"haytmnjwgyge\", \"6.6666 EETH\", \"300充值，追抢大佬\"]" -p ${executer}@active
