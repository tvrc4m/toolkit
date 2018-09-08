#!/bin/sh

resource_url="http://explorer.fibos.rocks/api/resource"

ram_limit=0.82

echo $resource

regex="[0-9]+\.[0-9]+"

while [[ 1 ]]; do
    resource=`curl -s $resource_url | jq -r .ram` 
    echo $resource
    if [[ $resource =~ $regex && "$resource" > "$ram_limit" ]]; then
        node /slamdunk/fo/test.js;
    fi;
    sleep 10
done;
