#!/bin/bash
#script allows for three arguments: name of the file to be wrapped, the name of the header/footer, the name
#of the resulting file.

#Variables
#Name of starting file
input_text=$1

#Prefix of header/footer
arg_prepend=$2

#Full header file name
header=$arg_prepend
header+="_header.html"

#Full footer file name
footer=$arg_prepend
footer+="_footer.html"

#Name of resulting file
output_file=$3

#Create an empty resulting file with our desired name
touch "$output_file"

#Crunch all of our text together into the output file
cat $header "$input_text" $footer > "$output_file"
