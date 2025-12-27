#!/bin/bash
cd cloned_site
links=$(grep -oP '/FTP-5/Anime--Cartoon-TV-Series/[^"]+/' server5.ftpbd.net_FTP-5_Anime--Cartoon-TV-Series_.html | head -n 10)
for link in $links; do
    url="https://server5.ftpbd.net$link"
    name=$(echo $link | sed 's|/|_|g')
    echo "Fetching $url -> $name.html"
    curl -s -L "$url" > "$name.html"
done
