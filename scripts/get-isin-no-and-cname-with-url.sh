#!/bin/bash
url="$*" #url of money contoal website for a mutual funds

curl_result="$(curl -s $url)"

cname=$(echo $curl_result | pup '.page_heading text{}')

isin=$(echo $curl_result | pup '#sel_isin_id attr{value}' | head -n 1)


echo "$cname : $isin"

