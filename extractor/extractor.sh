#!/bin/bash
# Mirko Rovere


print() {
    echo "Extracting '${args[i]}'....."
    echo ""
    duration=10
    barsize=$((`tput cols` - 7))
    unity=$(($barsize / $duration))
    increment=$(($barsize%$duration))
    skip=$(($duration/($duration-$increment)))
    curr_bar=0
    prev_bar=
    for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
        # Elapsed
        prev_bar=$curr_bar
        let curr_bar+=$unity
        [[ $increment -eq 0 ]] || {  
            [[ $skip -eq 1 ]] &&
            { [[ $(($elapsed%($duration/$increment))) -eq 0 ]] && let curr_bar++; } ||
            { [[ $(($elapsed%$skip)) -ne 0 ]] && let curr_bar++; }
        }
        [[ $elapsed -eq 1 && $increment -eq 1 && $skip -ne 1 ]] && let curr_bar++
        [[ $(($barsize-$curr_bar)) -eq 1 ]] && let curr_bar++
        [[ $curr_bar -lt $barsize ]] || curr_bar=$barsize
        for (( filled=0; filled<=$curr_bar; filled++ )); do
            printf "▇"
        done
        # Remaining
        for (( remain=$curr_bar; remain<$barsize; remain++ )); do
            printf " "
        done
        # Percentage
        printf "| %s%%" $(( ($elapsed*100)/$duration))
        # Return
        sleep 0.1
        printf "\r"
    done
echo ""
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
