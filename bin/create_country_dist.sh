#!/bin/bash

#the directory given as a command line arg
given_dir="$1"

#saving top level dir for later
top_dir=$(pwd)

#changing into given dir
cd "$given_dir" || exit 1

#catting the failed login files (which we know will be in data/[computer_name]/failed_login_data.txt)
#and then grabbing the usernames from them and storing the info in a temporary text file
cat ./* ./*/* | awk '{print $5}' > countries.txt

#converting IP to country
sort -o stuff.txt countries.txt  
join -j 1 -o 2.2 stuff.txt "$top_dir"/etc/country_IP_map.txt > countries.txt 

sort countries.txt | uniq -c | awk '{print "data.addRow([\x27"$2"\x27, "$1"]);"}' > temp.txt

#removing temporary text files in $given_dir before changing directories
rm countries.txt stuff.txt

#need access to html files so we return to top level dir
cd "$top_dir" || exit
./bin/wrap_contents.sh ./"$given_dir"/temp.txt html_components/country_dist country_dist.html
mv country_dist.html ./"$given_dir"

#removing temp text
rm ./"$given_dir"/temp.txt

