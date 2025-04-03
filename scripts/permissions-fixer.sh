#!/bin/bash

if [[ "$#" -ne 2 ]]; then
    echo -e "This script will help convert linux file and folder permissions,"
    echo -e "after fuse and ntfs messed everything up"
    echo -e "Usage: $0 --ntfs | --ext4 <directory>"
    exit 1
fi

option="$1"
dir="$2"

if [[ ! -d "$dir" ]]; then
    echo -e "Error: Directory '$dir' does not exist."
    exit 1
fi

case "$option" in
"--ntfs")
    echo -e "Setting NTFS-like permissions (777) for directories and files in $dir"
    find "$dir" -type d -exec chmod 777 {} +
    find "$dir" -type f -exec chmod 777 {} +
    ;;
"--ext4")
    echo -e "Setting ext4-like permissions (755 for directories, 644 for files) in $dir"
    find "$dir" -type d -exec chmod 755 {} +
    find "$dir" -type f -exec chmod 644 {} +
    ;;
*)
    echo "Invalid option: $option. Use --ntfs or --ext4."
    exit 1
    ;;
esac

echo "Done."
