#!/bin/sh
# `-e` -- exit on the first error, don't resume.
# `-x` -- print each executed command.
set -ex

ipfs init
ipfs daemon &
waitForIpfs
ipfs pin remote service add origin $ENDPOINT $ACCESS_TOKEN
CID=$(ipfs add -r -q --cid-version 1 $UPLOAD_PATH | tail -1)
ipfs pin remote add --service=origin --name=$NAME $CID

echo "::set-output name=cid::$CID"
