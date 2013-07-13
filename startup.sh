#!/bin/bash
# usage : $1 is vagrant machine type (i.e. centos, ubuntu, etc...)
#         $2 is target directory

TYPE=$1

if [ "aa$1" == "aa" ]; then
    echo "You must specify a type of machine"
    echo "Example: $./startup.sh centos or $./startup.sh ubuntu"
    exit 1
fi

function choice
{
    case "$TYPE" in
        centos)
            option;;
        ubuntu)
            option;;
        *)
            echo "choice not valid, has to be ubuntu or centos";;
    esac
}

function option
{
    cp -a types/$TYPE/ .
    vagrant up
}

choice