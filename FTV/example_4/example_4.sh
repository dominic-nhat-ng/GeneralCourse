#!/bin/bash
echo "################################################################"
echo "Merge the content of 2 files input_4_1.txt and input_4_2.txt. the content of input_2_2.txt will beinserted at the line #insert input_4_2.txt here in input_4_1.txt file. Refer ex_output_4.txt for expected output"

file1="input_4_1.txt"
file2="input_4_2.txt"
output="ex_output_4.txt"

while IFS= read -r line;
do
    if [[ "$line"=="#insert input_4_2.txt here" ]];
    then
        cat "$file2"
    fi
    echo "$line"
done < "$file1" > "ex_output_4.txt"
