#!/bin/bash

#directory given in command line argument
given_dir="$1"

#saving top level dir to return to
top_dir=$(pwd)

#change to work in given directory
cd "$given_dir" || exit 1

#grab our failed_login_data.txt file in our subdirectories and print out the hours into a temporary text file
cat ./*/*.txt | awk '{print $3}' > hours.txt

#add the hours and failed logins into a temporary text file in the form: hours, failed logins
sort hours.txt | uniq -c | awk '{print "data.addRow([\x27"$2"\x27, "$1"]);"}' > temp.txt

#get rid of unneeded text file
rm hours.txt

#return to top level directory to squish our text file in between a header and footer
cd "$top_dir" || exit 1

#wrap the file
./bin/wrap_contents.sh "$given_dir"/temp.txt html_components/hours_dist hours_dist.html

#move the newly created html file to our command line directory
mv hours_dist.html "$given_dir"

#get rid of the other temp text file we made
rm "$given_dir"/temp.txt
