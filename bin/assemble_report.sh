#!/bin/bash

given_dir="$1"

top_dir=$(pwd)

cd "$given_dir" || exit 1

cat *.html > "$top_dir"/temp.html

cd "$top_dir" || exit 1

./bin/wrap_contents.sh temp.html html_components/summary_plots "$given_dir"/failed_login_summary.html 

rm -r temp.html
