#!/bin/bash
#Mirko Rovere
#

# Ansi color code variables
reset="\e[0m"
bold="\e[1m"
yellow="\033[1;33m"

ask() {

    [[ $# = 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

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
  spinner stop
  echo -e "${bold}\nDone!${reset}\n"
  if zenity --question --title="Deletion" --text="You want to remove $1?" --no-wrap; then
	rm "$1"
	zenity --info --title="Success" --text="$1 was removed" --no-wrap
  fi
}

print_help(){
	echo -e "${bold}USAGE:${reset}\n"
	echo -e "$0 [options] <path/to/archive> <path/to/archive2> <...> "
	echo -e "\n${bold}OPTIONS:${reset}\n"
	echo -e "$0 {-h} Show the help page"
	echo -e "$0 {-l} List all compatible formats for each function"
	echo -e "$0 {-v} Print the version"
	echo -e "$0 {-x} Extract archives"
	echo -e "$0 {-i} Get info about archives"
	echo -e "$0 {-p} Protect archives with password"
  	echo -e "$0 {-t} Check archives integrity comparing the CRC"
	echo -e "$0 {-f} Try to fix archives"
	exit "$1"
}

print_version(){
	echo -e "
               ${yellow} ${bold}:;,,;:${reset}
              ${yellow}${bold}:;;;::::;:::${reset}		   Extrattor, versione 1.5 (x86_64-pc-linux-gnu)
         ${yellow}${bold}:;;:::::c::ccccc::;;${reset}
     ${yellow}${bold};;;;:::::cccccccc:::ccc::;;;:${reset}	   Copyright (C) 2021-2022 Mirko Rovere.
  ${yellow}${bold}::;;;;;::c::::::cccccc:::::::;,;;;;;; ${reset}	   Licenza GPLv3+: GNU GPL versione 3 o successiva <http://gnu.org/licenses/gpl.html>
${yellow}${bold}c,,;;:::;:::::::::::cccccc::;::;;;;,'.' ${reset}
${yellow}${bold}c..,;;,,;::::::::::::::;;:::;;,''''.... ${reset}  
${yellow}${bold}c....'.,;;;;;;:::;;;,;;;;;,,,'...'..... ${reset}
${yellow}${bold}c........''',;;;;:;;;,,,,'..'..... .... ${reset}   This is free software; you are free to change and redistribute it.
${yellow}${bold}c,,,,'.......','',;,'..''.....  ....... ${reset}   There is NO WARRANTY, to the extent permitted by law.
${yellow}${bold}c,,,;,'','.......',c'..............''...${reset}   
${yellow}${bold}c'',,,',MM;'''.....c... ......''..'....'${reset}
${yellow}${bold}c..',,',MM,,,,,,...c..........'...'.....${reset}
${yellow}${bold}c......'MM,',,,,',,c''..''...''.......  ${reset}
${yellow}${bold}c'........''',,,'',c''..'........   ....${reset}
${yellow}${bold}c,',''........''',,c,'.......... ......'${reset}
     ${yellow}${bold};',,,........'c'..............':${reset}
         ${yellow}${bold};''''.....c.   .......';${reset}
            ${yellow}${bold}:;,'''.c.......';${reset}
                ${yellow}${bold}:,,c'...;${reset}
		  ${yellow}${bold};c,${reset}
"
}

list_formats(){
	echo -e "\n${bold}FUNCTIONS EXTRACT (-x)\n"
	echo -e "compatible formats:${reset}\n"
	echo -e "\t(.arj), (.ace), (.cpio), (.bz2), (.dmg), (.gz), (.gpg), (.lzma), (.rar), (.tar.xz), (.tar.bz2)"
	echo -e "\t(.tar.gz), (.tar.zst), (.tbz2), (.tgz), (.pax), (pax.z), (.z), (.zip), (.7z)\n\n"
	echo -e "${bold}FUNCTION INFO (-i)\n"
	echo -e "compatible formats:${reset}\n"
	echo -e "\t(.cpio), (.tar.bz2), (.tar.gz), (.zip), (.7z)\n\n"
	echo -e "${bold}FUNCTION PASSWORD (-p)\n"
	echo -e "compatible formats:${reset}\n"
	echo -e "\t(.zip)\n\n"
  	echo -e "${bold}FUNCTION TEST (-t)\n"
  	echo -e "compatible formats:${reset}\n"
  	echo -e "\t(.zip)\n\n"
	echo -e "${bold}FUNCTION FIX (-f)\n"
	echo -e "compatible formats:${reset}\n"
	echo -e "\t(.zip)\n\n"
}

extract(){
	set "${!args[@]}"
	
	for i ; do

   		echo ""
   
   		if [ "${args[i]}" ]; then
			
			spinner --style 'bouncingBall' start "Extracting ${args[i]}.."

			case "${args[i]}" in
	           		#-------------------------Supported extensions
				*.arj)      unarj x "${args[i]}" && prompt "${args[i]}"    			                 ;;
    		          	*.ace)      unace x "${args[i]}" && prompt "${args[i]}"     			                 ;;
	        	      	*.bz2)      bunzip2 "${args[i]}" && prompt "${args[i]}"                           ;;
				*.cpio)	    cpio -i -vd < "${args[i]}" && prompt "${args[i]}"			  ;;
				*.dmg)      hdiutil mount "${args[i]}" && prompt "${args[i]}"                     ;;
	        		*.gz)       gunzip -fN${Verbose+v} "${args[i]}" && prompt "${args[i]}"                            ;;
				*.gpg)	    gpg -d "${args[i]}" | tar -xvzf - && prompt "${args[i]}"		           ;;
                  		*.lzma)     unlzma "${args[i]}" && prompt "${args[i]}"                            ;;
				*.rar)      7z x "${args[i]}" && prompt "${args[i]}"                              ;;
	                	*.tar)      tar -xvf "${args[i]}" && prompt "${args[i]}"                          ;;
	        		*.tar.xz)   tar -xvf "${args[i]}" && prompt "${args[i]}"                          ;;
				*.tar.zst)  tar -xvf "${args[i]}" && prompt "${args[i]}"			                     ;;
				*.tbz2)     tar -jxvf "${args[i]}" && prompt "${args[i]}"                         ;;
            			*.tgz)      tar -zxvf "${args[i]}" && prompt "${args[i]}"                         ;;
            			*.pax)      < "${args[i]}" pax -r && prompt "${args[i]}"                      ;;
            			*.pax.z)    uncompress "${args[i]}"  --stdout | pax -r && prompt "${args[i]}"     ;;
            			*.z)        uncompress "${args[i]}" && prompt "${args[i]}"                        ;;
            			*.zip)      unzip -q "${args[i]}" && prompt "${args[i]}"                          ;;
            			*.7z)       7z x "${args[i]}" && prompt "${args[i]}"                              ;;
	    
	          		#--------------------------- Errors
	          		*.*)	zenity --error --title="Error" --text="${args[i]} is not a supported file";
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
				
				*.cpio)		cpio -t < "${args[i]}"							;;
				*.tar.bz2)	tar -jtvf "${args[i]}"							;;
				*.tar.gz) 	tar -ztvf "${args[i]}"							;;
				*.zip) 		unzip -l "${args[i]}"							    ;;
				*.7z)		7z 1 "${args[i]}"							          ;;

	          		*.*)	zenity --error --title="Error" --text="${args[i]} is not a supported file";
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

	          		*.*)	zenity --error --title="Error" --text="${args[i]} is not a supported file";
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
	*.*)	zenity --error --title="Error" --text="${args[i]} is not a supported file";
      esac
    fi

  done
}

fix(){
	set "${!args[@]}"

	for i; do
		echo ""
		if [ "${args[i]}" ]; then
            		spinner --style 'bouncingBall' start "Fixing ${args[i]}.."
			case "${args[i]}" in

				*.zip)	zip -FFq "${args[i]}" --out "${args[i]}_repaired" ;;
				*.*)	zenity --error --title="Error" --text="${args[i]} is not a supported file";
			esac
			spinner stop
		fi
	done
}

if [ $# -lt 1 ]; then
    print_help 1
fi

args=("$@")

#-------------------------- Parameters
while getopts :hvxipltf par;do
	case $par in
		h)		print_help 0						      ;;
		v)		print_version						      ;;
		x)		extract "${args[@]}"					;;
		i)		info "${args[@]}"					    ;;
		p)		password "${args[@]}"					;;
		l)		list_formats 0						    ;;
    		t)    		test "${args[@]}"             ;;
		f)		fix  "${args[@]}"				;;
		?)		print_help 2                  ;;
	esac
done
