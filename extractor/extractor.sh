#!/bin/bash
# Mirko Rovere

print() {
    echo ""
    pv
    echo ""
    echo "Done!"
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
            *.zip)      unzip  "${args[i]}" | print                            ;;
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
