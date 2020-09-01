#!/usr/bin/env
given_dir="$1"

cd "$given_dir" | exit

#make the intermediate txt file
touch failed_login_data.txt

#Grab all of the log files in our specified directory and put them into a text file
cat ./*.log > failed_login_data.txt 

#Grab only the relevant lines of text from failed_login_data.txt

