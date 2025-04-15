#!/bin/bash
echo "##############################################################"
echo "Write a scripts that read in two numbers and does 3 things:"
echo "It print error can't divide by zero if the second number is 0"
echo "If the first number is 0 or second number is 1, just print the first number"
echo "In all other cases, it divides the first number by the second number and print the result"
echo "##############################################################"

read -p "Enter the first and the second number in one line: " var1 var2
echo "Your number is: $var1 and $var2"

if [ $var1 -eq 0 -o $var2 -eq 1 ]
then
    echo "The result in this case is $var1"
elif [ $var2 == 0 ]
then
    echo "Can't divide by zero"
else
    echo "The result in this case is `expr $var1 / $var2`"
fi
