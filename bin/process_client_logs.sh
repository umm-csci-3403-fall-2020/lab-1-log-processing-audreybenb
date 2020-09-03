#!/usr/bin/env bash
given_dir="$1"

#Move to the specified directory
cd "$given_dir" || exit

#Grab all of the log files in our specified directory and put them into a text file
cat var/log/* >  all_login_data.txt

#Grab only the relevant lines of text from failed_login_data.txt (invalid users and failed known users)
#cat var/log/* | awk 'match($0,/([a-zA-Z0-9 ]):([A-Za-z0-9 ]): Failed password for invalid user ([a-zA-Z]+) from ([0-9].)/, groups) || match($0,/([a-zA-Z0-9 ]):([a-zA-Z0-9 ]): Failed password for ([a-zA-Z]+) from ([0-9].)/, groups) {print groups[1] groups[3] groups[4] "\n"}' > failed_login_data.txt

#cat var/log/* | awk 'match($0,/([a-zA-Z0-9 ]):([A-Za-z0-9 ]): Failed password for invalid user ([a-zA-Z]+) from ([0-9].)/, groups) {print groups[1] groups[3] groups[4] "\n"}' > failed_login_data.txt

awk '/Failed password for invalid user/ {print $1, $2, $3, $11, $13} /Failed password for ^(?!invalid)/ {print $1, $2, $3, $9, $11}' | awk 'match($0, /([a-zA-Z0-9 ]):([0-9:]) ([a-zA-Z0-9 ])/, groups) {print groups[1] groups[2]}' all_login_data.txt > failed_login_data.txt
