isin="$*"

cname="$(curl -s 'https://nsdl.co.in/master_search_res.php' --compressed -X POST -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/119.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate, br' -H 'Referer: https://nsdl.co.in/master_search.php' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: https://nsdl.co.in' -H 'Connection: keep-alive'  -H 'Upgrade-Insecure-Requests: 1' -H 'Sec-Fetch-Dest: document' -H 'Sec-Fetch-Mode: navigate' -H 'Sec-Fetch-Site: same-origin' -H 'Sec-Fetch-User: ?1' --data-raw "cnum=$isin" | pup -c '#nsdl-tables tbody tr text{}' -p | awk 'NF' | sed 's/^[[:space:]]*//' | sed -n '3p')"


echo "$isin : $cname"
