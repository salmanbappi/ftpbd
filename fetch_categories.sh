#!/bin/bash
mkdir -p cloned_site
cd cloned_site
urls=(
    "https://server5.ftpbd.net/FTP-5/Anime--Cartoon-TV-Series/"
    "https://server3.ftpbd.net/FTP-3/Hindi%20TV%20Series/"
    "https://server3.ftpbd.net/FTP-3/%5BToday%27s%20Upload%5D/"
    "https://server2.ftpbd.net/FTP-2/English%20Movies/"
    "https://server4.ftpbd.net/FTP-4/English-Foreign-TV-Series/"
)

for url in "${urls[@]}"; do
    name=$(echo $url | sed 's|https://||; s|/|_|g')
    echo "Fetching $url -> $name.html"
    curl -s -L "$url" > "$name.html"
done
