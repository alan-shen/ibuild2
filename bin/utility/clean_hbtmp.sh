#!/bin/bash

TOP=`dirname ${0}`

. ${TOP}/colordefine.sh

TARGETPATH="./"
FINDED=false

echo -e "${red}+------------------------------------------------+${normal}"
for i in $*
do
        case $i in
        --path=*)
		FINDED=true
                TARGETPATH=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
		echo -e "Clean the path ${blue}${TARGETPATH}${normal}"
		find ${TARGETPATH} -name "*.hbtmp" | xargs rm -rfv
                ;;
        *)
		FINDED=false
		echo -e "\tUnknown option\n"
                ;;
        esac
done

if [ ${FINDED} == false ];then
	echo -e "ERROR: Plz give the work path.\n"
	echo -e "${green}\t\t# $0 --path=xx\n${normal}"
fi
echo -e "${red}+------------------------------------------------+${normal}"
