#!/bin/bash
# Mirko Rovere
SLEEP_DURATION=${SLEEP_DURATION:=0.1}  

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

if [ $# -lt 1 ]; then
    echo "Usage: extract /path/to/file1 /path/to/file2 ..."
    exit 1
fi

args=( "$@")
set ${!args[@]}

for i ; do

    echo ""
   
   if [ "${args[i]}" ]; then

        case "${args[i]}" in
            *.tar.xz)   tar -xvf "${args[i]}" | print                          ;;
            *.tar.bz2)  tar -jxvf "${args[i]}" | print                         ;;
            *.tar.gz)   tar -zxvf "${args[i]}" | print                         ;;
            *.bz2)      bunzip2 "${args[i]}" | print                           ;;
            *.dmg)      hdiutil mount "${args[i]}" | print                     ;;
            *.gz)       gunzip "${args[i]}" | print                            ;;
            *.tar)      tar -xvf "${args[i]}" | print                          ;;
            *.tbz2)     tar -jxvf "${args[i]}" | print                         ;;
            *.tgz)      tar -zxvf "${args[i]}" | print                         ;;
            *.zip)      unzip -q "${args[i]}" | print                          ;;
            *.pax)      cat "${args[i]}" | pax -r | print                      ;;
            *.pax.z)    uncompress "${args[i]}"  --stdout | pax -r | print     ;;
            *.rar)      7z x "${args[i]}" | print                              ;;
            *.z)        uncompress "${args[i]}" | print                        ;;
            *.7z)       7z x "${args[i]}" | print                              ;;
            *)          echo "'${args[i]}' cannot be extracted" | print        ;;
        esac

    else
        echo "'${args[i]}' not a valid file"
    fi
done
