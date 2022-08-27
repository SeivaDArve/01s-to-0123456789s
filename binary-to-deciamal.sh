#!/bin/bash
# Title: Converting Binary numbers into decimal
# Name of file: binary-to-decimal.sh
# Description: Are you a good programer? (a challenge by a facebook user)
# Requirements: To convert 100100 is the first goal
# Response link: https://www.facebook.com/groups/improgramer/permalink/5611765862207890/
# Programing Language: Bash
# Author: Seiva D'Arve

clear	# Clear the screen

function f_say_hi {
	# Display the name of the program and another empty line
	echo -e "App binary-to-decimal.sh \n"
}

function f_ask_number {
	# Ask for a number to convert
	echo -n " > Insert a binary number to convert: "
	read v_ans
}

function f_clean_garbage {
	# If this app was ran before, erase previous garbage
	rm -rf ./fileA.txt
	rm -rf ./fileB.txt
}

function f_send_to_file {
	# Separate all numbers in a file line by line
	for (( i=0; i<${#v_ans}; i++ )); do
		echo "${v_ans:$i:1}" >> fileA.txt
	done
}

function f_count_lines {
	# Count the number of lines
	n_lines=$(cat fileA.txt | wc -l)
}

function f_test_if_0-or-1 {
	# Test if any number inside "fileA.txt" is diferent than 1 or 0
	lines=$(cat fileA.txt)

	for line in $lines; do
		if [ $line != 0 ] && [ $line != 1 ]; then
			echo -e "\nnumber is not binary: Exiting"
			f_clean_garbage
			exit 1
		fi
	done
}

function f_invert_order {
	# Invert the order of each line inside fileA.txt
	for (( i=$n_lines; i>0 ; i-- )); do
		#echo $i
		tail -n 1 fileA.txt >> fileB.txt
		# Needed: a method to remove last line of file
		head -n -1 fileA.txt > fileA.txt.tmp
		rm fileA.txt
		mv fileA.txt.tmp fileA.txt
	done

	# Debug:
	#cat fileB.txt
}

function f_calculate {
	# Ensure there is a var before math error

	v_peso=1  # Used to descbribe how heavy is each individual binary slot
	v_sum=0   # Used to sum all the "1" in the user's input

	for (( i=1; i<$(($n_lines+1)); i++ )); do

		# Debug:
		#echo -e "\nNew loop"

		# Telling the weight that v_var will assume
		#echo "This slot wighs: $v_peso"

		# Get the first number of the first line of the file
		v_var=$(head -n 1 fileB.txt)

		# Debug:
		#echo "first line of file is: $v_var"


		# Remove first line of the file before looping again
		tail -n +2 fileB.txt > fileA.txt
		rm fileB.txt
		mv fileA.txt fileB.txt

		# Debug:
		#cat fileB.txt

		# Calculate if first number is 1
		if [ $v_var == 1 ]; then 
			v_sum=$(($v_sum+$v_peso))

			# Debug:
			#echo "calc so far: $v_sum"
		fi

		# Pass if it is 0 (do not calculate: It will be removed instead)
		#	if [ $v_var == 0 ]; then
		#		# do nothing these lines are not needed
		#	fi

		# Debug:
		#echo "v_var é igual a: $v_var"

		# Changing the weight of v_peso
		v_peso=$(($v_peso+$v_peso))
	done

	# Debug:
	#echo "cat fileB.txt"; cat fileB.txt

	# Present the result
	echo -e "\nfinal calculation: $v_sum (Decimal Number)"
}

function f_exec {
	# Run each function one by one
		# Method to debug code easily
		# Toggle ON/OFF any function or any "print" statement
	f_say_hi
		#echo hi
	f_ask_number
		#echo f_number
	f_clean_garbage
		#echo f_clean
	f_send_to_file
		#echo "cat file:"; cat fileA.txt # UNCOMMENT FOR DEBUGGING
	f_count_lines
		#echo "number of lines is" $n_lines # UNCOMMENT FOR \DEBUGGING
	f_test_if_0-or-1
		echo " > testing if it is 0 or 1: PASSED"
	f_invert_order
		#echo "inverted order of lines: DONE" #UNCOMENT FOR DEBUGG
	f_calculate
	f_clean_garbage

}
f_exec
