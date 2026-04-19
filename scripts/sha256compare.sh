#!/usr/bin/env bash

if [[ "$#" -ne 2 ]]; then
    echo -e "Usage: $(basename "$0") file1 file2"
    exit 1
fi

file1="$1"
file2="$2"

for file in "$@"; do
    if [[ ! -f "./${file}" ]]; then
        echo -e "ERROR: ${file} does not exist"
        exit 1
    fi
done

file1hash=$(sha256sum "${file1}")
file2hash=$(sha256sum "${file2}")

if [[ "${file1hash}" == "${file2hash}" ]]; then
    echo -e "\e[1;32mChecksum matches\e[0m"
    exit 0
else
    echo -e "\e[1;31mChecksum does not match\e[0m"
    exit 1
fi
