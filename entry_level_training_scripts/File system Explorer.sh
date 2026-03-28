#!/bin/bash

check_item() {
    local item="$1"
    echo "Checking: $item"
    
    # TODO: Implement the checks for existence, type, and readability
    # Use -e, -f, -d, and -r tests as appropriate
    
    exists=""
    if [ -e "$item" ] &>/dev/null; then
        exists="Yes"
    else
        exists="No"
    fi

    if [ "$exists" == "No" ]; then
        echo "Exists: $exists"
        exit 0
    fi

    type=""
    read=""
    if [ -d "$item" ] &>/dev/null; then
        type="Directory"
    elif [ -f "$item" ] &>/dev/null; then
        type="File"
    fi
    
    if [ -r "$item" ] &>/dev/null; then
        read="Yes"
    else
        read="No"
    fi

    echo "Exists: $exists"
    echo "Type: $type"
    echo "Readable: $read"
}

# Main script
if [ $# -eq 0 ]; then
    echo "Please provide a file or directory name as an argument."
    exit 1
fi

check_item "$1"
