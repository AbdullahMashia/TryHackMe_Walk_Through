#!/bin/zsh

BLD=$(tput bold)
RED=$(tput setaf 1)
GR=$(tput setaf 2)
BL=$(tput setaf 4)
RST=$(tput sgr0)

source ~/.zshrc

if ! command -v figlet &> /dev/null; then

        echo "===========>CTF_Set_UP=========="

else
        figlet "CTF _ Set _ UP"
        echo "--author $RED dummyclick $RST"
fi

printf "\n\n\n"
sleep 1

echo "$BLD Are you working on $BL CTF$RST? (y/n/c) (c= for reset script)"
read answer




if [[ "$answer" == "n" ]]; then



        echo "=========> stopping the setup"

        exit 1

elif [[ "$answer" == "c" ]]; then
        unset OVPN_P
        unset CTF
        unset USE_VPN_FILE_A

        sed -i '/OVPN_P/d' ~/.zshrc
        sed -i '/CTF/d' ~/.zshrc
        sed -i '/USE_VPN_FILE_A/d' ~/.zshrc
        sleep 1
        echo " ================> all vars are cleared"


fi

printf "\n\n\n"
sleep 1

reuse_p="k"

if [[ -n "$CTF" && "$USE_PATH" == "false"  ]]; then
        echo "=====>$GR Found $RST a Path ==> $CTF"
        echo "=====>$BLD $BL Do $RST you want to use the $BLD $BLpath $RST?(n,y,ya)"
        echo "====> n = NO , y = yes , ya = Yes Always ( don't ask again)"



        read use_path

        if [[ -n "$use_path" && "$use_path" == "y" ]]; then
                sleep 1
                echo "======> path is used successfully"
        elif [[ -n "$use_path" && "$use_path" == "n" ]]; then

                reuse_p="n"

        else
                reuse_p="ya"
                echo "export USE_PATH=true" >> ~/.zshrc
                export $USE_PATH="true"


        fi
fi

if [[ -z "$CTF" || "$reuse_p" == "n" ]]; then
        echo "=======>$BL Set $RST up the CTF variable: $BL  the full path for the CTF directory $RST"
        echo "=====> ex. /home/usr/CTFs"
        printf "\n\n"
        read ctf
        echo "export CTF=$ctf" >> ~/.zshrc 
        export CTF=$ctf
        echo "CTF here====> $CTF"

fi


if ! mkdir -p "$CTF" &> /dev/null; then
       echo "=======> directory already exists"
else
        echo "========> CTF directory created"
        sleep 1
fi

sleep 1
cd "$CTF"

printf "\n\n\n"
echo "======> checking OpenVpn "


sleep 1
counter=0

use_v_f=""

vpn_file="$OVPN_P"
USE_VPN_FILE_A="fasle"
printf "\n\n\n"
if [[ -n "$OVPN_P" && "$USE_VPN_FILE_A" == "false" ]]; then

        echo "=========> $GR Found $RST openvpn file = $OVPN_P"
        echo "=========>$BL Do $RST you want to use it (y,n,ya)"

        if [[ "$USE_VPN_FILE_A" == "true" ]]; then
                echo "=======> default set to yes always"
                sleep 1
        else

                echo "$BLD    (y =yes,  n = no , ya = yes always) $RST"
                printf "\n\n\n"
                read use_vpn_file
        fi

        if [[ -n "$use_vpn_file" && "$USE_VPN_FILE_A" == "false" ]] ; then
                echo "===###$$ USE_VPN_FIle_A = $USE_VPN_FILE_A"
                case "$use_vpn_file" in 
                        "n" )
                                use_v_f="n"

                                ;;

                        "y" )
                                use_v_f="y"

                                ;;
                        "ya" )
                                use_v_f="ya"
                                echo "export USE_VPN_FILE_A=true" >>    ~/.zshrc
                                export USE_VPN_FILE_A="true"

                                ;;

                        esac


        fi

fi

if [[ -z "$OVPN_P" || "$use_v_f" == "n" ]] ; then
        echo "OVPN_P =====> $OVPN_P"

        echo "===========> set the openvpn file with path"
        echo "====>e.x /home/user/vvpn.ovpn"
        printf "\n\n\n"
        read file_name

        sleep 1

        echo "==========> clearning previous openvpn processes (if any)"
        sudo killall -9 openvpn
        echo "======>foudn $tun_num residual interfaces"



        echo "========killing previous proces"
        printf "\n\n\n"
        sleep 2
        echo "export OVPN_P=$file_name"  >> ~/.zshrc
        export OVPN_P=$file_name

        echo "============file_name = $file_name & OVPN_P= $OVPN_P"

fi

        echo "OVPN_P =====> $OVPN_P"

        tun_num=$(ip link show | grep -c tun)
        for i in {0..$tun_num}; do

                sudo ip link delete tun$i

                echo "=======> tun$i cleaned"

        done


        sudo openvpn --config "$OVPN_P" --daemon 
        sleep 2
        echo "============> checking vpn connection"

        printf "\n\n\n"
        while ! ip link show tun0 > /dev/null ; do 
                sleep 2

                echo "$counter ==========> Start connecting"

                if [[ "$counter" -gt 3 ]];then

                        echo "================> $BLD $BL connecting $RST "
                       
                       while ! ping -c 1 8.8.8.8  &> /dev/null && [ "$counter" -lt 8 ] ; do
                                sleep 2
                                printf "\n\n"
                                echo "==========> Internet connection is$RED lost $RST"
                                ((counter++))

                        done
                        echo "=============> ! OpenVpn service has a problem"

                        exit 1
                fi
                ((counter++))

        done


echo "================OpenVPN is $GR connected$RST"

sleep 1

echo "===============> Save $file_name for permenant usage"

printf "\n\n\n"


sleep 1
printf "\n\n\n"
echo "========> $BL Enter$RST CTF name"
read name 



if ! mkdir -p ./"$name" &> /dev/null; then
        echo "========>check the CTF name"
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
echo "===============> $BL $BLD pening $RST the terminal"
qterminal --workdir $PWD 
