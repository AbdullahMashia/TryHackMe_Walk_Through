#!/bin/bash



	if [[ "$1" == "help" ]];then
		echo "=========> syntax"
		printf "========> hash_gen.sh username  wordlist.txt output.txt\n\n"
		exit	
	fi



if [ $# -lt 3 ]; then 
	echo "enter all required arguments"
	exit
fi


perc=$(wc -l $1 | awk '{print $1}')
echo "prec ==$perc"
tracker=0



while IFS= read -r word; do
	if [[ $tracker -gt 1 ]]; then
		
		out=$(awk -v t=$tracker -v p=$perc 'BEGIN { if (t == 0){ print "tracker is 0" } else {print (t*100/p)*100 } }')
		
		echo -en "$out ....\r"
		
	fi
	hashed=$(echo -n "$word" | md5sum | awk '{print $1}')
	bas=$(echo -n "$2:$hashed" | base64)	
	echo -e "$bas\n" >> $3

	((tracker++))
done < $1


figlet "Finished!"
exit
