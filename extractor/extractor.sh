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
    echo "Extracting '${args[i]}'....."
    echo ""
    progress-bar 10
    echo "Done!"
}

print_help(){
	echo -e "${bold}USAGE:${reset}\n\n extract <path/to/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz> <path/to/file_name_2>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz> [...] "
	echo -e "\n\n${bold}OPTIONS:${reset}\n\n extract {-h --help} Show the help page"
        exit 1
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

        case "${args[i]}" in
            
	    #-------------------------Supported extensions
	    *.tar.xz)   tar -xvf "${args[i]}" && print                          ;;
            *.tar.bz2)  tar -jxvf "${args[i]}" && print                         ;;
            *.tar.gz)   tar -zxvf "${args[i]}" && print                         ;;
            *.bz2)      bunzip2 "${args[i]}" && print                           ;;
            *.dmg)      hdiutil mount "${args[i]}" && print                     ;;
            *.gz)       gunzip "${args[i]}" && print                            ;;
            *.tar)      tar -xvf "${args[i]}" && print                          ;;
            *.tbz2)     tar -jxvf "${args[i]}" && print                         ;;
            *.tgz)      tar -zxvf "${args[i]}" && print                         ;;
            *.zip)      unzip -q "${args[i]}" && print                          ;;
            *.pax)      cat "${args[i]}" | pax -r && print                      ;;
            *.pax.z)    uncompress "${args[i]}"  --stdout | pax -r && print     ;;
            *.rar)      7z x "${args[i]}" && print                              ;;
            *.z)        uncompress "${args[i]}" && print                        ;;
            *.7z)       7z x "${args[i]}" && print                              ;;
	    
	    #-------------------------- Parameters
	    #HELP 
	    -h)		print_help						;;
	    --help)	print_help						;;
	    
	    #--------------------------- Errors
	    *.*)	echo -e "${red}${bold}ERROR: ${reset}${red}'${args[i]}' not a valid file${reset}";
			exit 1										;;
	    -*)		echo -e "${red}${bold}ERROR: ${reset}${red}'${args[i]}' not found${reset}"	;; 
        esac
  fi

done
