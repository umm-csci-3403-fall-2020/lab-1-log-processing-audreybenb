#!/bin/bash

temp_dir=$(mktemp -d)
top_dir=$(pwd)

#loop through all provided tgz files and...
for file in "$@"
do
	#grab basename of file so we can make a directory with that name
	base_name="$(basename "$file" .tgz)"
	mkdir "$temp_dir"/"$base_name"
	tar -xzf "$file" -C "$temp_dir"/"$base_name"
	#create failed login data for each of the clients
	./bin/process_client_logs.sh "$temp_dir"/"$base_name"
done

./bin/create_username_dist.sh "$temp_dir"
./bin/create_hours_dist.sh "$temp_dir"
./bin/create_country_dist.sh "$temp_dir"
./bin/assemble_report.sh "$temp_dir"

#move the end product to our top directory so we can view it
mv "$temp_dir"/failed_login_summary.html "$top_dir"
rm -rf "$temp_dir"

