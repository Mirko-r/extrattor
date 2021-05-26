#!/bin/bash
# Mirko Rovere

if [ $# -lt 1 ]; then
    echo "Usage: extract /path/to/file1 /path/to/file2 ..."
    exit 1
fi

args=( "$@")
set ${!args[@]}

for i ; do
    if [ "${args[i]}" ]; then
        echo ""
        echo "::extraction '${args[i]}' in prograss..."
        echo ""
        case "${args[i]}" in
            *.tar.xz)   tar -xvf "${args[i]}"                          ;;
            *.tar.bz2)  tar -jxvf "${args[i]}"                         ;;
            *.tar.gz)   tar -zxvf "${args[i]}"                         ;;
            *.bz2)      bunzip2 "${args[i]}"                           ;;
            *.dmg)      hdiutil mount "${args[i]}"                    ;;
            *.gz)       gunzip "${args[i]}"                            ;;
            *.tar)      tar -xvf "${args[i]}"                          ;;
            *.tbz2)     tar -jxvf "${args[i]}"                         ;;
            *.tgz)      tar -zxvf "${args[i]}"                         ;;
            *.zip)      unzip "${args[i]}"                             ;;
            *.pax)      cat "${args[i]}"  | pax -r                     ;;
            *.pax.z)    uncompress "${args[i]}"  --stdout | pax -r     ;;
            *.rar)      7z x "${args[i]}"                              ;;
            *.z)        uncompress "${args[i]}"                        ;;
            *.7z)       7z x "${args[i]}"                              ;;
            *)          echo "'${args[i]}' cannot be extracted" ;;
    esac
    else
        echo "'${args[i]}' not a valid file"
    fi
    echo ""
    echo "::Done!"
    echo ""
done