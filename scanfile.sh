#!/bin/bash
#
#
#

error(){
	printf "\033[35mError:\033[0m\t\033[31m${1}!\033[0m\n"
}

scandir(){
	_dirname=$1
	printf "DIRECTORY: ${_dirname}\n"
	if [ -d "${_dirname}" ];
	then
		for file_path in `find "${_dirname}" -type f`;
		do
			printf "\033[36mScanning File:\t\033[33m${file_path}\033[0m\n"
			yara -w -s -p 10 index.yar "${file_path}"
		done
	else
		error "Missing or invalid directory name was given"
	fi
}

command(){
	printf "\033[36mCOMMAND:\033[0m\n"
	printf "\033[35mScan Directory\t\033[33m[ scan, scanner ]\033[0m\n"
	printf "\n"
}

usage(){
	printf "\033[36mUSAGE:\033[0m\n"
	printf "\033[35m$0\t\033[32m--action=\033[33mscan \033[32m--dirname=\033[33mname_of_directory\033[0m\n"
	printf "\n"
}

help(){
	printf "\033[36mSCANFILE Wrapper\033[0m\n"
	printf "\033[35mAction to Execute\t\033[32m[ action:COMMAND, --action=COMMAND ]\033[0m\n"
	printf "\033[35mSet Directory Name\t\033[32m[ dirname:DIRECTORY, --dir=DIRECTORY, --dirname=DIRECTORY ]\033[0m\n"
	printf "\n"
	command
	usage
	exit 0
}

for argv in $@
do
	case $argv in
		--action=*) _action=$(echo "${argv}" | cut -d'=' -f2);;
		--dir=*|--dirname=*|dirname:*) _dirname=$(echo "${argv}" | cut -d'=' -f2);;
		-h|-help|--help) help;;
	esac
done

case $_action in
	scan|scanner) scandir "${_dirname}";;
	*) error "Missing or invalid parameter was entered";;
esac

