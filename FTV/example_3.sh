#!/bin/bash

echo "###########################################################"
echo "Write the scripts uses the "while loop" to print out the first 10 number from an input number from keyboard in an ascending order"
echo "###########################################################"

read -p "Input the number to start the requirement: " number
max_val=`expr $number + 10`
while [ $number -lt $max_val ]
do
    printf "$number\t"
    number=`expr $number + 1`

done


