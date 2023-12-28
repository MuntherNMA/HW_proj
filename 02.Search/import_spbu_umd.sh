#!/bin/bash

show_help() {
    echo "Usage: $0 -s|--source [url] -d|--destination [path] [-p|--probe]"
    echo "  -s | --source       URL to download from."
    echo "  -d | --destination  Directory path to save the downloaded files."
    echo "  -p | --probe        Optional: Download 10 random files if specified."
}

SOURCE=""
DESTINATION=""
PROBE=false

# Parse command-line options
if ! OPTIONS=$(getopt -o s:d:p --long source:,destination:,probe -- "$@"); then
    echo "Error: Failed parsing options." >&2
    exit 1
fi

eval set -- "$OPTIONS"

while true; do
    case "$1" in
    -s | --source)
        SOURCE="$2"
        shift 2
        ;;
    -d | --destination)
        DESTINATION="$2"
        shift 2
        ;;
    -p | --probe)
        PROBE=true
        shift
        ;;
    --)
        shift
        break
        ;;
    *)
        show_help
        exit 1
        ;;
    esac
done

# Validate input parameters
if [ -z "$SOURCE" ] || [ -z "$DESTINATION" ]; then
    show_help
    exit 1
fi

# Create destination directory if it does not exist
mkdir -p "$DESTINATION"

dl_spbu_s_e () {
    curl "$SOURCE" -s --compressed -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/118.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3' -H 'Accept-Encoding: gzip, deflate, br' -H 'DNT: 1' -H 'Connection: keep-alive'
}

dl_spbu_oop () {
    local result
    result=$(dl_spbu_s_e | grep -o -E "'https://nc\.spbu\.ru/.+?'" | sed "s/'//g" | \ grep -oP 'https://nc\.spbu\.ru/s/[^\s<>"'\'']+' | sort | uniq)
    if [ "$PROBE" = true ]; then
        echo "$result" | sort -R | head -n 10
    else
        echo "$result"
    fi
}


function download {
    local url="$1"
    local filename=$(echo "$url" | sed 's/[^a-zA-Z0-9]/_/g')
    local filepath="$DESTINATION/$filename"
    
    echo "Downloading: $url"  

    if ! wget -O "$filepath" "$url"; then
        >&2 echo "Cannot download $url"
        return 15
    fi

    echo "$url" >> "$DESTINATION/downloaded_urls.txt"
}

for u in $(dl_spbu_oop); do
    download "$u"
    echo $?
done
