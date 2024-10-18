#!/bin/sh

mkdir -p /root/data

blocknotify=$(yq e '.bitcoind.blocknotify' "/root/start9/config.yaml")

if [ "$blocknotify" = "null" ] || [ -z "$blocknotify" ]; then
    echo "Error: The blocknotify field is null or not set in Bitcoin's configuration. Your Start9 Bitcoin package may not support adding this. Knots is required."
    exit 1
else
    echo "blocknotify is set to: $blocknotify"
fi

yq eval -o=json /root/start9/config.yaml > /root/data/datum_gateway_config.json
printf "\n\n [i] Starting Datum Gateway ...\n\n"

exec datum_gateway -c /root/data/datum_gateway_config.json