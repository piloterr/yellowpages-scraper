#!/usr/bin/env bash
# Yellowpages Business API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./business.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/yellowpages/business" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode 'query=https://www.yellowpages.com/los-angeles-ca/mip/anawalt-lumber-13945594?lid=1002108313121'
