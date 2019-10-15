#!/bin/sh

path=$(pwd)

if [[ $1 = "-h" || $1 = "--help" ]]; then
    echo "Script to search for files with the same md5  checksum"
    echo "Usage: sript [OPTION] or [PATH]"
    echo "-h, --help     display this help and exit"
    exit 0
fi

if [ -n "$1" ]; then
    path="$1"
fi

echo "$path"

touch list_files

for line in "$(find $path -maxdepth 1 -type f)"; do
    md5sum $line >> list_files
    #echo $line
done

equal_files=$(uniq -D -w 32 list_files | cut -d ' ' -f 3)

#echo "$equal_files"

for item in $equal_files; do
  size=$(stat --format=%s $item)
  echo "$item  size = $size"
done

rm -f list_files
exit 0
 
