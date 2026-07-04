# CTF_env_setup V2:

## 🚀 this version is more versatile than the pervious one due to the following reasons.

- It got rid of using systemd to make it easier for configuration and running the script
- Offers a way to save prefered options so a user don't need to repeat them selves ( stores them in .zshrc)
- offers an option to reset the script options ( if you changed the path or the config file for OPENVPN)
- Clears the duplicate interfaces left over from perivous CTFS
  



## Problems you could encouter:
- the paths aren't saved right ( check your shell, make sure you're using zshell)
- vpn not connecting ( check the path to config file in .zshrc, if it's set incorrectly just change it there)

## modifying the script:
- You can use this script and modify it as you wish
