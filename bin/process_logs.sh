#!/bin/env bash

temp = $(mktemp -d)

for file in "$@"
do
	tar -xzf file -C "$temp"  
done
ls "$temp"
echo "$@"
