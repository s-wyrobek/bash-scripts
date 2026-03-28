#!/usr/bin/env bash
#
# User management script for classroom servers.
# Creates/deletes teacher and student accounts.
#
# Usage: sh userctr.sh <operation> <teacher> <student_prefix> <count>

if [ $# -ne 4 ]; then
    echo "You need to put exactly 4 arguments"
    echo "sh userctr.sh <operation> <teacher_name> <student_prefix> <student_count>"
    exit 1
fi

set -euo pipefail

operation=$1
teacher=$2
student_prefix=$3
student_count=$4

if [[ ! "$student_prefix" =~ ^[a-z]+$ ]]; then #validate prefix
    echo "student prefix must contains only lower-case letters"
    exit 1
elif [[ "$student_count" -lt 1 || "$student_count" -gt 10 ]]; then #validate student count
    echo "student_count must be number betwen 1 and 10"
    exit 1
fi

add() {
    # teacher
    password=$(shuf -i 100000-999999 -n 1)
    if id -u "$teacher" &>/dev/null; then
    echo "$teacher:******"
    else
    sudo useradd -m -s /bin/zsh -G sudo "$teacher"
    echo "$teacher:$password" | sudo chpasswd
    echo "$teacher:$password"
    fi
    
    # studenci
    for (( i=1; i<=student_count; i++ )); do
        username="${student_prefix}${i}"
        password=$(shuf -i 100000-999999 -n 1)
        if id -u "$username" &>/dev/null; then
            echo "$username:******"
        else
            sudo useradd -m -s /bin/zsh "$username"
            echo "$username:$password" | sudo chpasswd
            echo "$username:$password"
        fi
    done
}

del() {
    #teacher
    if id -u "$teacher" &>/dev/null; then
        sudo userdel -r "$teacher"
    fi
    
    #students
    for (( i=1; i<=student_count; i++ )); do
        username="${student_prefix}${i}"
        if id -u "$username" &>/dev/null; then
            sudo userdel -r "$username"
        fi
    done
}

if [[ "$operation" == "add" ]]; then
    add
elif [[ $operation == "del" ]]; then
    del
else
    echo "unrecognized $operation"
    exit 1
fi