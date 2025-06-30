#!/bin/bash
set -e
RESPONSE=$(curl -s https://zenquotes.io/api/random)
QUOTE=$(echo "$RESPONSE" | jq -r '.[0].q')
AUTHOR=$(echo "$RESPONSE" | jq -r '.[0].a')
echo "💡 Motivation für dich: \"$QUOTE\" – $AUTHOR"
