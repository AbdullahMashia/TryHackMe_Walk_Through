#!/bin/bash


BLD=$(tput bold)
RED=$(tput setaf 1)
GR=$(tput setaf 2)
BL=$(tput setaf 4)
RST=$(tput sgr0)

if ! command -v figlet &> /dev/null; then

        echo "===========>setting the CTF environemnet"

else
        figlet "CTF_SetUP"
        echo "--author $RED dummyclick $RST"
fi

printf "\n\n\n"
sleep 2

echo "$BLD Are you working on $BL CTF$RST? (y/n)"  
read answer




if [[ "$answer" == "n" ]]; then



        echo "=========> stopping the setup"

        exit 1

fi

printf "\n\n\n"
sleep 1

reuse_p="n"

if [[ -n "$CTF" ]]; then
        echo "$GR Found $RST a Path ==> $CTF"
        echo "$BLD Do $RST you want to use the path?" 
        read use_path

        if [[ -n "$use_path" && "$use_path" == "y" ]]; then
                sleep 1
                echo "======> path is used successfully"
        else

                reuse_p="y"

                echo "using $reuse_p"
        fi
fi

if [[ -z "$CTF" || "$reuse_p" == "y" ]]; then
        echo "=======>Set up the CTF variable: $BL  the full path for the CTF directory $RST"
        echo "=====> ex. /home/usr/CTFs"
        printf "\n\n"
        read ctf
        export CTF="$ctf"
fi

echo "CTF var = $CTF"

if ! mkdir -p "$CTF" &> /dev/null; then
       echo "=======> directory already exists"
else
        echo "========> CTF directory created"
        sleep 1
fi

sleep 1
cd "$CTF"

sleep 1
printf "\n\n\n"
echo "======> checking OpenVpn "


sleep 1
counter=0

printf "\n\n\n"
if ! systemctl is-active openvpn-client@dummyclick.service &> /dev/null ; then
        echo "==========> OpenVpn not running"
        sleep 1
        while  ! systemctl is-active openvpn-client@dummyclick.service &> /dev/null  ; do
                echo "$counter ==========> Start connecting"

                sudo systemctl enable openvpn-client@dummyclick.service
                sleep 2
                systemctl start openvpn-client@dummyclick.service
                if [[ "$counter" -eq 3 ]];then
                        echo "=============> ! OpenVpn service has a problem"
                        exit 1
                fi
                ((counter++))

        done
fi

echo "================OpenVPN is $GR connected$RST"


sleep 1
printf "\n\n\n"
echo "========> $BL Enter$RST CTF name"
read name 



if ! mkdir -p ./"$name" &> /dev/null; then
        echo "check the CTF name"
        exit 1
else
        echo "========> switching path to $name"
        cd "$name"

fi



sleep 1
printf "\n\n\n"
echo "================> $BLD $GR Everything $RST is setup"
sleep 1
printf "\n\n\n"
echo "===============> opening the terminal"
 qterminal --workdir $PWD 
