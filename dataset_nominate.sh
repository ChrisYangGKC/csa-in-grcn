#!/bin/bash

if [[ $# -ne 3 ]]; then
	echo "Usage: dataset_nominate.sh [DIR] [project_id] [dataset name]"
	exit 2
fi       

sql_dir=$1
project_id=$2
dataset_name=$3

echo "$sql_dir/*.*"

for filename in $sql_dir/*; do
    [ -e "$filename" ] || continue
    echo "Processing.....$filename"
    sed -i "s/\[[A-Z_]*\]\.\[[A-Z_]*\]\./$project_id\.$dataset_name\./g" $filename
done
