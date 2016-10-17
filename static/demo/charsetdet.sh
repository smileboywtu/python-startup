#!/bin/bash

# install the python packages
pip install chardet >/dev/null

# check flags
inplace=0
while test $# -gt 0;
do
    case "$1" in
        -h|--help)
            echo "detect the python files recursively inside the directory"
            echo ""
            echo "charsetdet [-i] directory"
            echo ""
            echo "options:"
            echo "-h, --help        show help message"
            echo "-i,               convert to utf-8 with no nom inplace"
            echo ""
            shift
            ;;
        -i)
            inplace=1
            shift
            ;;
        *)
            break
            ;;
    esac
done

# set the file directory
if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
    echo "Usage: $0 DIRECTORY" >&2
    exit 1
fi

# for each the files inside the directory
for file in $(find $1 -type f -name "*.py")
do
    result=`chardet3 $file`
    if [[ $result =~ .+ascii|.+utf-8 ]]; then
        echo -e "\e[0;32m$result"
    else
        if $inplace -gt 0; then
            iconv -t $file
        fi
        echo -e "\e[0;31m$result"
    fi
done
