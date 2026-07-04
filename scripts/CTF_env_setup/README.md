# CTF_env_setup:
As a person who is fond with CTFs challeges, routine tasks like:
- starting a vpn connection to the remote machine
- creating a folder for the new challenge
- checking the connection to the internet
- switch directory to the CTF directory you want to work on 
- other tasks


## executing the script
- was build to take advantage of Desktop Autostart. if you don not know anything about [see this] [https://www.antonysallas.com/docs/auto-launch-apps-linux-startup/]
- you nedd to create a Desktop file and place it in ~/.config/autostart/ctf_setup.desktop  ( pay attenion to the extension)
- the add the need info to this file:
example:
<p>[Desktop Entry]
Name=Firefox
Exec=your script path here
</p>

##   🔥Now your script that you want it to run every time your machine reboots:

- After you create your script make it executable ( chomd +x your_script)
- place in a location accessible by the Desktop ( e.x /usr/bin/your_script)
- now just reboot and everything will run after you login to your machine


## 🏛️What Does my script do?
- building upon my introduction. To make things easier on me. I made the script runs the first thing after I login and just ask me few question about:
- the path of my CTF challenges
- the config file of OpenVPN 
- the name of the new CTF challenge
- finally questions if I want to use those answers all the time ( never ask me again option ). which will start executing everything by it self and just asks for the new CTF challenge name


## 🕐this version of the script also use systemd services to launch openvpn-client :
- just to avoid the sudo password request
