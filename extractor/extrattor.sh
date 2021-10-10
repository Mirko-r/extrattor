#
#!/bin/bash
# Mirko Rovere
#

SLEEP_DURATION=${SLEEP_DURATION:=0.1}  

# Ansi color code variables
red="\e[0;91m"
reset="\e[0m"
bold="\e[1m"

progress-bar() {
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
  percentage() { printf "| %s%%" $(( ((elapsed)*100)/(duration)*100/100 )); }
  clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=duration; elapsed=elapsed+1 )); do
      already_done; remaining; percentage
      sleep "$SLEEP_DURATION"
      clean_line
  done
  clean_line
}

print() {
    echo -e "${bold}Extracting ${args[i]}.....${reset}"
    echo ""
    progress-bar 10
    echo -e "${bold}\nDone!${reset}"
}

print_help(){
	echo -e "${bold}USAGE:${reset}\n\n extrattor <path/to/file_name> <path/to/file_name_2> [...] "
	echo -e "\n\n${bold}OPTIONS:${reset}\n\n extractor {-h --help} Show the help page"
	echo -e "\n\n extrattor {-v --version} Print the version"
        exit 1
}

print_version(){
	echo -e  "
                 :;,,;:
              :;;;::::;:::		   Extrattor, versione 1.0 (x86_64-pc-linux-gnu)
          :;;:::::c::ccccc::;;
      ;;;;:::::cccccccc:::ccc::;;;:	   Copyright (C) 2021 Mirko Rovere.
  ::;;;;;::c::::::cccccc:::::::;,;;;;;;	   Licenza GPLv3+: GNU GPL versione 3 o successiva <http://gnu.org/licenses/gpl.html>
c,,;;:::;:::::::::::cccccc::;::;;;;,'.'
c..,;;,,;::::::::::::::;;:::;;,''''....   
c....'.,;;;;;;:::;;;,;;;;;,,,'...'.....
c........''',;;;;:;;;,,,,'..'..... ....    This is free software; you are free to change and redistribute it.
c,,,,'.......','',;,'..''.....  .......    There is NO WARRANTY, to the extent permitted by law.
c,,,;,'','.......',c'..............''...   
c'',,,',MM;'''.....c... ......''..'....'
c..',,',MM,,,,,,...c..........'...'.....
c......'MM,',,,,',,c''..''...''.......  
c'........''',,,'',c''..'........   ....
c,',''........''',,c,'.......... ......'
     ;',,,........'c'..............':
         ;''''.....c.   .......';
            :;,'''.c.......';
                :,,c'...;
		  ;c,
"
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
	  rm $1
    progress-bar 10
	  echo -e "\n${bold}Done!${reset}\n"
  else
	  echo -e "\n${bold}Aborting..${reset}\n"
  fi
}

if [ $# -lt 1 ]; then
    print_help
    exit 1
fi

args=( "$@")
set ${!args[@]}
for i ; do

   echo ""
   
   if [ "${args[i]}" ]; then

        case "${args[0]}" in

        	  #-------------------------- Parameters
	          #HELP 
	          -h)		print_help						;;
	          --help)	print_help						;;
		  -v)		print_version						;;
		  --version)	print_version						;;
		  -*)		echo -e "${red}${bold}ERROR: ${reset}${red}'${args[i]}' not found${reset}"	;;

        esac

        case "${args[i]}" in
            
	           #-------------------------Supported extensions
		*.arj)      unarj x "${args[i]}" && print && prompt "${args[i]}"    			   ;;
    		*.ace)      unace x "${args[i]}" && print && prompt "${args[i]}"     			   ;;
	        *.bz2)      bunzip2 "${args[i]}" && print && prompt "${args[i]}"                           ;;
	        *.dmg)      hdiutil mount "${args[i]}" && print && prompt "${args[i]}"                     ;;
	        *.gz)       gunzip "${args[i]}" && print && prompt "${args[i]}"                            ;;
		*.gpg)	    gpg -d "${args[i]}" | tar -xvzf - && print && prompt "${args[i]}"		   ;;
		*.rar)      7z x "${args[i]}" && print && prompt "${args[i]}"                              ;;
	        *.tar)      tar -xvf "${args[i]}" && print && prompt "${args[i]}"                          ;;
	        *.tar.xz)   tar -xvf "${args[i]}" && print && prompt "${args[i]}"                          ;;
            	*.tar.bz2)  tar -jxvf "${args[i]}" && print && prompt "${args[i]}"                         ;;
            	*.tar.gz)   tar -zxvf "${args[i]}" && print && prompt "${args[i]}"                         ;;
		*.tar.zst)  tar -xvf "${args[i]}" && print && prompt "${args[i]}"			   ;; 
		*.tbz2)     tar -jxvf "${args[i]}" && print && prompt "${args[i]}"                         ;;
            	*.tgz)      tar -zxvf "${args[i]}" && print && prompt "${args[i]}"                         ;;
            	*.pax)      cat "${args[i]}" | pax -r && print && prompt "${args[i]}"                      ;;
            	*.pax.z)    uncompress "${args[i]}"  --stdout | pax -r && print && prompt "${args[i]}"     ;;
            	*.z)        uncompress "${args[i]}" && print && prompt "${args[i]}"                        ;;
            	*.zip)      unzip -q "${args[i]}" && print && prompt "${args[i]}"                          ;;
            	*.7z)       7z x "${args[i]}" && print && prompt "${args[i]}"                              ;;
	    
	          #--------------------------- Errors
	          *.*)	echo -e "${red}${bold}ERROR: ${reset}${red}'${args[i]}' not a valid file${reset}";
			      exit 1										;;
        esac
  fi

done