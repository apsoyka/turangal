#!/bin/bash

user_agent="Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0"

function print_hosts() {
    pattern="^(?:http|https):\/\/(?:[a-z0-9]+\.)*\K([a-z0-9]+\.[a-z0-9]+)"
    hosts=()

    # Use a regular expression to extract the domain name from each URI
    for host in "$@"
    do
        match=$(echo $host | grep -oP $pattern)
        hosts+=($match)
    done

    # Remove duplicates
    hosts=($(printf "%s\n" "${hosts[@]}" | sort -u))

    # Get size of array
    count=${#hosts[@]}

    if [ "$count" -gt "0" ]
    then
        echo "Mirroring content from ${count} hosts:"

        # Print each host
        for host in "${hosts[@]}"
        do
            echo "$host"
        done
    else
        echo "Could not find any hosts"
    fi
}

if [ "$#" -eq "0" ]
then
    echo "No URI resources were provided; exiting"
else
    print_hosts "$@"

    echo "Starting Tor"

    service tor start

    date=$(date +"%Y-%m-%d")
    filename="$date"

    torsocks \
    wget \
    --execute robots=off \
    --user-agent="$user_agent" \
    --warc-file="$filename" \
    --no-warc-keep-log \
    --read-timeout=5 \
    --tries=10 \
    --adjust-extension \
    --html-extension \
    --content-disposition \
    --convert-links \
    --mirror \
    --page-requisites \
    --no-parent \
    $@
fi