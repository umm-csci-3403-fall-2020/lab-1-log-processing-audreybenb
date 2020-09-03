#!/usr/bin/env bash
given_dir="$1"

#Move to the specified directory
cd "$given_dir" | exit

#make the intermediate txt file
touch failed_login_data

echo $given_dir
ls
#Grab all of the log files in our specified directory and put them into a text file
cat * > failed_login_data.txt 

#Grab only the relevant lines of text from failed_login_data.txt (invalid users and failed known users)
#cat *.log > awk 'match($0,/([a-zA-Z0-9]+_):([A-Za-z0-9]+_): Failed password for invalid user ([a-zA-Z]+) from ([0-9].)/, groups) || match($0,/([a-zA-Z0-9]+_):([a-zA-Z0-9]+_): Failed password for ([a-zA-Z]+) from ([0-9].)/, groups) {print groups[1] groups[3] groups[4] "\n"}' > failed_login_data.txt

