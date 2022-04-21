#!/usr/bin/env bash



ID=$1

if [ -z "$ID" ]; then
   echo ""
   echo "Usage: ./download.sh <videoId>"
   echo ""
fi

URL=https://smotrim.ru/video/$ID

CONTENT_URL=$(curl --silent $URL | grep embedUrl | awk '{print $2}' | tr -d '"' | tr -d ",")
CONTENT_URL=$(curl --silent ${CONTENT_URL} | grep window.pl.data.dataUrl | awk '{print $3}' | tr -d "'" | tr -d ";")
LINK=$(curl --silent -L http:${CONTENT_URL} | jq ".data.playlist.medialist[].sources.http" | grep 720 | awk '{print $2}' | tr -d '"' | tr -d ',')
wget -O $ID.mp4 $LINK