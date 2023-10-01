#!/bin/bash

echo -n "Would you like to sort the processes output by memory or CPU? (m/c) "
read -r sortby

echo -n "How many results do you want to display? "
read -r lines

if [[ "$sortby" == "m" ]]; then
    ps_output=$(ps aux --sort -rss 2>/dev/null)
elif [[ "$sortby" == "c" ]]; then
    ps_output=$(ps aux --sort -%cpu 2>/dev/null)
else
    echo "Invalid input. Exiting."
    exit 1
fi

if [[ -n "$ps_output" ]]; then
    echo "$ps_output" | grep -i "$(whoami)" | head -n "$lines"
else
    echo "Error: Failed to retrieve process information. Exiting."
    exit 1
fi
