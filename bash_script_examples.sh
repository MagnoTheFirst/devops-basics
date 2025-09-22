#!/bin/bash
# Assign a value to a variable
name="World"
echo "Hello, $name!"



name="John Doe"
echo "Hello, $name!"
number=42
echo "The number is $number"



# Display the PATH environment variable
echo "Your PATH is $PATH"

# Define a local variable in a function
my_function() {
  local local_var="I am local"
  echo $local_var
}
my_function




# Concatenation
greeting="Hello, "
name="World"
echo "$greeting$name"

# Arithmetic
num1=5
num2=10
sum=$((num1 + num2))
echo "The sum is $sum"



# String example
greeting="Hello, World!"
name="Alice"
full_greeting="$greeting, $name!"
echo $full_greeting




# Number example
num1=5
num2=10
sum=$((num1 + num2))
difference=$((num2 - num1))
product=$((num1 * num2))
quotient=$((num2 / num1))
echo "Sum: $sum, Difference: $difference, Product: $product, Quotient: $quotient"




# Array example
fruits=("apple" "banana" "cherry")
for fruit in "${fruits[@]}"; do
  echo $fruit
done




# Associative array example
declare -A colors
colors[apple]="red"
colors[banana]="yellow"
colors[grape]="purple"
unset colors[banana]
echo ${colors[apple]} # red
echo ${colors[grape]} # purple



Understanding Bash Operators

This section provides an overview of operators used in Bash scripting, including comparison, string, arithmetic, logical, and file test operators.
Comparison Operators

    -eq: Equal to
    -ne: Not equal to
    -lt: Less than
    -le: Less than or equal to
    -gt: Greater than
    -ge: Greater than or equal to

String Comparison Operators

    =: Equal to
    !=: Not equal to
    <: Less than, in ASCII alphabetical order
    >: Greater than, in ASCII alphabetical order

Arithmetic Operators

    +: Addition
    -: Subtraction
    *: Multiplication
    /: Division
    %: Modulus (remainder of division)
    For exponentiation, use external tools like bc or awk.


Logical Operators

    &&: Logical AND
    ||: Logical OR
    !: Logical NOT


File Test Operators

    -e: Checks if a file exists
    -d: Checks if a directory exists
    -f: Checks if a file is a regular file
    -s: Checks if a file is not empty


 

# Basic if statement
num=15
if [ $num -gt 10 ]; then
  echo "Number is greater than 10"
fi





# If...else statement
num=8
if [ $num -gt 10 ]; then
  echo "Number is greater than 10"
else
  echo "Number is 10 or less"
fi





# If...elif...else statement
num=10
if [ $num -gt 10 ]; then
  echo "Number is greater than 10"
elif [ $num -eq 10 ]; then
  echo "Number is exactly 10"
else
  echo "Number is less than 10"
fi







# Nested if statement
num=5
if [ $num -gt 0 ]; then
  if [ $num -lt 10 ]; then
    echo "Number is between 1 and 9"
  fi
fi





# For loop example
for i in {1..5}; do
  echo "Iteration $i"
done





# While loop example
count=1
while [ $count -le 5 ]; do
  echo "Count is $count"
  ((count++))
done





# Until loop example
count=1
until [ $count -gt 5 ]; do
  echo "Count is $count"
  ((count++))
done





# Break and continue example
for i in {1..5}; do
  if [ $i -eq 3 ]; then
    continue
  fi
  echo "Number $i"
  if [ $i -eq 4 ]; then
    break
  fi
done





# Nested loops example
for i in {1..3}; do
  for j in {1..2}; do
    echo "Outer loop $i, Inner loop $j"
  done
done




my_function() {
  echo "Hello, World!"
}






greet() {
  local name=$1
  echo "Hello, $name!"
}
greet "Alice"





add() {
  local sum=$(($1 + $2))
  echo $sum
}
result=$(add 5 3)
echo "The sum is $result"




Example: Create an Array

my_array=("value1" "value2" "value3")



Accessing Array Elements

To access elements in a Bash array, use the index of the element.

The index is specified in square brackets:
Example: Access Array Elements

echo ${my_array[0]}





Example: Modify Array Elements

my_array[1]="new_value"


