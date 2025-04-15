#!/bin/tcsh -f

echo "#######################################"

echo "This is requirement for example 1"
read -p "Enter the number: " number
result=`expr $number \* 2`
echo "Your result: $result"

echo "######################################"
