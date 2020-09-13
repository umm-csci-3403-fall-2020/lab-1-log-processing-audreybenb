#!/usr/bin/env bash

given_dir="$1"

#Move to the specified directory
cd "$given_dir" || exit

#Grab only the relevant lines of text from failed_login_data.txt (invalid users and failed known users)
cat var/log/* | awk -F '[: ]+' '/Failed password for invalid user/ {print $1, $2, $3, $13, $15} /Failed password for/ && !/Failed password for invalid/ {print $1, $2, $3, $11, $13}' > failed_login_data.txt

