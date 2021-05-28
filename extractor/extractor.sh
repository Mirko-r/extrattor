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
            *.tar.xz)   tar -xvf "${args[i]}" >/dev/null | print                          ;;
            *.tar.bz2)  tar -jxvf "${args[i]}" >/dev/null | print                         ;;
            *.tar.gz)   tar -zxvf "${args[i]}" >/dev/null | print                         ;;
            *.bz2)      bunzip2 "${args[i]}" >/dev/null | print                           ;;
            *.dmg)      hdiutil mount "${args[i]}" >/dev/null | print                     ;;
            *.gz)       gunzip "${args[i]}" >/dev/null | print                            ;;
            *.tar)      tar -xvf "${args[i]}" >/dev/null | print                          ;;
            *.tbz2)     tar -jxvf "${args[i]}" >/dev/null | print                         ;;
            *.tgz)      tar -zxvf "${args[i]}" >/dev/null | print                         ;;
            *.zip)      unzip  "${args[i]}" >/dev/null | print                            ;;
            *.pax)      cat "${args[i]}" | pax -r >/dev/null | print                      ;;
            *.pax.z)    uncompress "${args[i]}"  --stdout | pax -r >/dev/null | print     ;;
            *.rar)      7z x "${args[i]}" >/de/null | print                               ;;
            *.z)        uncompress "${args[i]}" >/dev/null | print                        ;;
            *.7z)       7z x "${args[i]}"  >/dev/null | print                             ;;
            *)          echo "'${args[i]}' cannot be extracted" | print        ;;
        esac

    else
        echo "'${args[i]}' not a valid file"
    fi
done
