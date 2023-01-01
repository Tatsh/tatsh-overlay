#!/usr/bin/env bash
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.."
while IFS=$'\n' read -r name; do
    {
        xq -r '.pkgmetadata.use.flag[]|(."@name" + " - " + ."#text")' \
            "$name" 2> /dev/null ||
            xq -r '.pkgmetadata.use.flag|(."@name" + " - " + ."#text")' \
                "$name" 2> /dev/null
    } |
        sed -re "s|(.*)|$(dirname "${name:2}"): \1|"
done < <(find -name 'metadata.xml' -exec grep -HF '<use>' {} \; |
    cut -d ':' -f1) |
    sort -u > profiles/use.local.desc
