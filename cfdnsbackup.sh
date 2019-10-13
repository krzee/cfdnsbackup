#!/bin/bash

#all other scripts use the global key. we are supposed to use a token so we can restrict permissions.
#this requires sending auth in headers instead of the old api style.
key="1234567890abcdef"
date="$(date '+%Y%m%d')"
listdomains(){
curl -s -X GET "https://api.cloudflare.com/client/v4/zones" \
-H "Authorization: Bearer $key" \
-H "Content-Type:application/json"|jq '.result'|grep -E '^    "name": "|^    "id": "'|awk -F'"' '{print $4}'|paste - -
}

mkdir backup.dns
while read -r id domain ;do
 curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${id}/dns_records/export" -H "Authorization: Bearer $key" -H "Content-Type: application/json" > "backup.dns/$domain"
done < <(listdomains)

zip -r "$date.cfdns.zip" "backup.dns" -9 && rm -rf backup.dns
