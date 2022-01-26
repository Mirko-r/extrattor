#!/bin/bash
#Mirko Rovere
#

SLEEP_DURATION=${SLEEP_DURATION:=0.1}  

# Ansi color code variables
reset="\e[0m"
bold="\e[1m"

progress_bar() {
  local duration
  local columns
  local space_available
  local fit_to_screen  
  local space_reserved

  space_reserved=6   
  duration=${1}
  columns=$(tput cols)
  space_available=$(( columns-space_reserved ))

  if (( duration < space_available )); then 
  	fit_to_screen=1; 
  else 
    fit_to_screen=$(( duration / space_available )); 
    fit_to_screen=$((fit_to_screen+1)); 
  fi

  already_done() { for ((done=0; done<(elapsed / fit_to_screen) ; done=done+1 )); do printf "▇"; done }
  remaining() { for (( remain=(elapsed/fit_to_screen) ; remain<(duration/fit_to_screen) ; remain=remain+1 )); do printf " "; done }
  percentage() { printf "| %s%%" $(( ((elapsed)*100)*(duration)/(100/100))); }
  clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=duration; elapsed=elapsed+1 )); do
      already_done; remaining; percentage
      sleep "$SLEEP_DURATION"
      clean_line
  done
  clean_line
}

ask() {
    local prompt default reply

    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'
        default='N'
    else
        prompt='y/n'
        default=''
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

prompt(){
  echo ""
  if ask "Do you want to remove $1?" Y; then
	  echo -e "\n${bold}Removing $1${reset}\n"
	  rm "$1"
	  progress_bar 10
	  echo -e "\n${bold}Done!${reset}\n"
  else
	  echo -e "\n${bold}Aborting..${reset}\n"
  fi
}

print() {
    echo -e "${bold}Extracting ${args[i]}.....${reset}"
    echo ""
    progress_bar 10
    echo -e "${bold}\nDone!${reset}"
}

print_help(){
	echo -e "${bold}USAGE:${reset}\n"
	echo -e "$0 [options] <path/to/archive> <path/to/archive2> <...> "
	echo -e "\n${bold}OPTIONS:${reset}\n"
	echo -e "$0 {-h | --help} Show the help page"
	echo -e "$0 {-l | --list_formats} List all compatible formats for each function"
	echo -e "$0 {-v | --version} Print the version"
	echo -e "$0 {-x | --extract} Extract archives"
	echo -e "$0 [-i | --info] Get info about archives"
	echo -e "$0 [-p | --password] Protect archives with password"
  	echo -e "$0 [-t | --test] Check archives integrity comparing the CRC"
	exit "$1"
}

print_version(){
	echo -e  "
                ${bold}:;,,;:${reset}
              ${bold}:;;;::::;:::${reset}		   Extrattor, versione 1.4 (x86_64-pc-linux-gnu)
         ${bold}:;;:::::c::ccccc::;;${reset}
     ${bold};;;;:::::cccccccc:::ccc::;;;:${reset}	   Copyright (C) 2021 Mirko Rovere.
  ${bold}::;;;;;::c::::::cccccc:::::::;,;;;;;; ${reset}	   Licenza GPLv3+: GNU GPL versione 3 o successiva <http://gnu.org/licenses/gpl.html>
${bold}c,,;;:::;:::::::::::cccccc::;::;;;;,'.' ${reset}
${bold}c..,;;,,;::::::::::::::;;:::;;,''''.... ${reset}  
${bold}c....'.,;;;;;;:::;;;,;;;;;,,,'...'..... ${reset}
${bold}c........''',;;;;:;;;,,,,'..'..... .... ${reset}   This is free software; you are free to change and redistribute it.
${bold}c,,,,'.......','',;,'..''.....  ....... ${reset}   There is NO WARRANTY, to the extent permitted by law.
${bold}c,,,;,'','.......',c'..............''...${reset}   
${bold}c'',,,',MM;'''.....c... ......''..'....'${reset}
${bold}c..',,',MM,,,,,,...c..........'...'.....${reset}
${bold}c......'MM,',,,,',,c''..''...''.......  ${reset}
${bold}c'........''',,,'',c''..'........   ....${reset}
${bold}c,',''........''',,c,'.......... ......'${reset}
     ${bold};',,,........'c'..............':${reset}
         ${bold};''''.....c.   .......';${reset}
            ${bold}:;,'''.c.......';${reset}
                ${bold}:,,c'...;${reset}
		  ${bold};c,${reset}
"
}

list_formats(){
	echo -e "\n${bold}FUNCTIONS EXTRACT (-x)\n"
	echo -e "compatible formats:${reset}\n"
	echo -e " (.arj), (.ace), (.bz2), (.dmg), (.gz), (.gpg), (.lzma), (.rar), (.tar.xz), (.tar.bz2), (.tar.gz)"
	echo -e " (.tar.zst), (.tbz2), (.tgz), (.pax), (pax.z), (.z), (.zip), (.7z)\n\n"
	echo -e "${bold}FUNCTION INFO (-i)\n"
	echo -e "compatible formats:${reset}\n"
	echo -e " (.tar.bz2), (.tar.gz), (.zip), (.7z)\n\n"
	echo -e "${bold}FUNCTION PASSWORD (-p)\n"
	echo -e "compatible formats:${reset}\n"
	echo -e " (.zip)\n\n"
  	echo -e "${bold}FUNCTION TEST (-t)\n"
  	echo -e "compatible formats:${reset}\n"
  	echo -e " (.zip)\n\n"
}

extract(){
	set "${!args[@]}"
	
	for i ; do

   		echo ""
   
   		if [ "${args[i]}" ]; then

        		case "${args[i]}" in
            
	           		#-------------------------Supported extensions
				*.arj)      unarj x "${args[i]}" && print && prompt "${args[i]}"    			                 ;;
    		          	*.ace)      unace x "${args[i]}" && print && prompt "${args[i]}"     			                 ;;
	        	      	*.bz2)      bunzip2 "${args[i]}" && print && prompt "${args[i]}"                           ;;
	        		*.dmg)      hdiutil mount "${args[i]}" && print && prompt "${args[i]}"                     ;;
	        		*.gz)       gunzip "${args[i]}" && print && prompt "${args[i]}"                            ;;
				*.gpg)	    gpg -d "${args[i]}" | tar -xvzf - && print && prompt "${args[i]}"		           ;;
                  		*.lzma)     unlzma "${args[i]}" && print && prompt "${args[i]}"                            ;;
				*.rar)      7z x "${args[i]}" && print && prompt "${args[i]}"                              ;;
	                	*.tar)      tar -xvf "${args[i]}" && print && prompt "${args[i]}"                          ;;
	        		*.tar.xz)   tar -xvf "${args[i]}" && print && prompt "${args[i]}"                          ;;
				*.tar.zst)  tar -xvf "${args[i]}" && print && prompt "${args[i]}"			                     ;;
				*.tbz2)     tar -jxvf "${args[i]}" && print && prompt "${args[i]}"                         ;;
            			*.tgz)      tar -zxvf "${args[i]}" && print && prompt "${args[i]}"                         ;;
            			*.pax)      < "${args[i]}" pax -r && print && prompt "${args[i]}"                      ;;
            			*.pax.z)    uncompress "${args[i]}"  --stdout | pax -r && print && prompt "${args[i]}"     ;;
            			*.z)        uncompress "${args[i]}" && print && prompt "${args[i]}"                        ;;
            			*.zip)      unzip -q "${args[i]}" && print && prompt "${args[i]}"                          ;;
            			*.7z)       7z x "${args[i]}" && print && prompt "${args[i]}"                              ;;
	    
	          		#--------------------------- Errors
	          		*.*)	zenity --error --text="${args[i]} is not a supported file";
			      	        exit 1										                                                             ;;
        		esac
  		fi

	done
}

info(){
	set "${!args[@]}"

	for i; do

		echo ""

		if [ "${args[i]}" ]; then
			case "${args[i]}" in
				
				*.tar.bz2)	tar -jtvf "${args[i]}"							;;
				*.tar.gz) 	tar -ztvf "${args[i]}"							;;
				*.zip) 		unzip -l "${args[i]}"							    ;;
				*.7z)		7z 1 "${args[i]}"							          ;;

	          		*.*)	zenity --error --text="${args[i]} is not a supported file";
				     exit 1											;;
			esac
		fi

	done
}

password(){
	set "${!args[@]}"

	for i; do

		echo ""

		if [ "${args[i]}" ]; then
			case "${args[i]}" in

				*.zip) zip -e "${args[i]}_protected.zip" "${args[i]}";;

	          		*.*)	zenity --error --text="${args[i]} is not a supported file";
				     exit 1											;;
			esac
		fi

	done

}

test(){
  set "${!args[@]}"

  for i; do

    echo ""

    if [ "${args[i]}" ]; then
      case "${args[i]}" in

        *.zip)  unzip -t "${args[i]}"    ;;
	*.*)	zenity --error --text="${args[i]} is not a supported file";
      esac
    fi

  done
}

## [cleaner.sh](./cleaner.sh) : 
Simple script for cleaning Linux

if [ $# -lt 1 ]; then
    print_help 1
fi

args=("$@")

#-------------------------- Parameters
while getopts :hvxiplt par;do
	case $par in
		h)		print_help 0						      ;;
		v)		print_version						      ;;
		x)		extract "${args[@]}"					;;
		i)		info "${args[@]}"					    ;;
		p)		password "${args[@]}"					;;
		l)		list_formats 0						    ;;
    		t)    		test "${args[@]}"             ;;
		?)		print_help 2                  ;;
	esac
done
