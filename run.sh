#!/bin/bash

if [ -z "$@" ]
then
    echo "No URL resources were provided; exiting"
else
    echo "Starting Tor"

    service tor start

    echo "Mirroring content hosted at $@"

    torsocks wget \
    -e robots=off \
    --timeout=5 \
    --tries=10 \
    --adjust-extension \
    --content-disposition \
    --convert-links \
    --mirror \
    --page-requisites \
    --no-parent \
    $@
fi