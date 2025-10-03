#!/bin/bash

LOG_FILE="$1" 
> "$LOG_FILE"

mapfile -t ip_array < <(echo -e "192.168.1.45\n10.0.0.12\n172.16.5.3\n203.0.113.27\n198.51.100.14\n185.199.108.153\n216.58.209.78\n62.217.190.200\n142.250.190.14\n77.88.8.8")

mapfile -t status_array < <(echo -e "200\n201\n400\n401\n403\n404\n500\n501\n502\n503")

#2xx - successful responses; 200 - ok, 201 - created
#4xx - client errors; 400 - bad request, 401 - unauthorized, 403 - forbidden, 404 - not found
#5xx - server errors; 500 - internal server error, 501 - not implemented, 502 - bad gateway, 503 - service unavailable

mapfile -t methods_array < <(echo -e "GET\nPOST\nPUT\nPATCH\nDELETE")

mapfile -t url_array < <(echo -e "/index.html\n/about\n/products/item123\n/api/v1/users/images/logo.png\n/contact-us\n/blog/2025/06/23/article-title\n/search\n/download/file.zip\n/settings")

mapfile -t user_agent_array < <(echo -e "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:115.0) Gecko/20100101 Firefox/115.0\nMozilla/5.0 (Macintosh; Intel Mac OS X 12_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15\nMozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36\nMozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36\nMozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Edge/91.0.864.67 Safari/537.36\nMozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)\nOpera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.16\nMozilla/5.0 (Linux; Android 10; SM-G975F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Mobile Safari/537.36\nMozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)\ncurl/8.1.2")


total_num=10 
random_generation=$((RANDOM % 901 + 100))
methods_num=5


log_item() {
    local ip_value="$1"
    local date_value="$2"
    local method_value="$3"
    local url_value="$4"
    local status_value="$5"
    local response_size="$6"
    local agent_value="$7"
    echo "$ip_value - - $date_value \"$method_value $url_value HTTP/1.1\" $status_value $response_size \"-\" $agent_value" >> "$LOG_FILE"
}

for ((i=0; i < random_generation; i++)); do
    rand_index=$((RANDOM % total_num))
    rand_ua_index=$((RANDOM %total_num))
    method_index=$((RANDOM % methods_num))
    response_size=$((RANDOM % 2201 + 300))
    ip_value="${ip_array[$rand_index]}"
    date_value=$(date '+[%d/%b/%Y:%H:%M:%S %z]')
    method_value="${methods_array[$method_index]}"
    url_value="${url_array[$rand_index]}"
    status_value="${status_array[$rand_index]}"
    agent_value="${user_agent_array[$rand_ua_index]}"
    log_item "$ip_value" "$date_value" "$method_value" "$url_value" "$status_value" "$response_size" "$agent_value"
done