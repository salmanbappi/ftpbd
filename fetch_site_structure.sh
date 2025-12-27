#!/bin/bash
mkdir -p cloned_site
cd cloned_site
servers=(
    "https://server1.ftpbd.net/FTP-1/"
    "https://server2.ftpbd.net/FTP-2/"
    "https://server3.ftpbd.net/FTP-3/"
    "https://server4.ftpbd.net/FTP-4/"
    "https://server5.ftpbd.net/FTP-5/"
    "https://server7.ftpbd.net/FTP-7/"
    "https://old.ftpbd.net/"
)

for url in "${servers[@]}"; do
    name=$(echo $url | sed 's|https://||; s|/|_|g')
    echo "Fetching $url -> $name.html"
    curl -s -L "$url" > "$name.html"
done
