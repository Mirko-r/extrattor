#!/bin/bash
echo -e "\nInstalling packages\n"
    
install -Dm0755 "extrattor.sh" "/usr/bin/extrattor"
install -Dm0755 "spinner" "/usr/bin/spinner"
	   
echo -e "\nInstalling man page\n"

install -Dm0644 "man/extrattor.1" "/usr/share/man/man1/extrattor.1"
