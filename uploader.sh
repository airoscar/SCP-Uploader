#!/bin/bash

echo "##################################################"
echo "#              Bash Auto Uploader                #"
echo "#             Created by Oscar Chen              #"
echo "# https://github.com/airoscar/bash-auto-uploader #"
echo "##################################################"


defaultServer="wgmsrv.ucalgary.ca"
defaultDestinationFolder="~/"

currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
scriptFileName="${BASH_ARGV[0]}"

function setUser {
	echo "Enter username (ie: firstname.lastname)"
	read username

	echo "Please enter password."
	read -s password
}

function setServer {
	echo "Enter server address (Default: ${defaultServer})"
	read remoteServer
	if [[ -z "$remoteServer" ]]; then
		remoteServer=$defaultServer
	fi
}

function setSource {

	echo "Set up source, select option below:"
	OPTIONS=("All files in current directory" 
		"Specify a path")
	select opt in "${OPTIONS[@]}" 
	do
		case $opt in
			"All files in current directory")
				source=$currentDir
				break
				;;

			"Specify a path")
				echo "Enter a source path: "
				read source
				break
				;;
			*)
				echo "Invalid selection."
				;;
		esac
	done
}

function setDestination {
	echo "Enter destination path: (Default: ${defaultDestinationFolder})"
	read destinationFolder

	if [[ -z "$destinationFolder" ]]; then
		destinationFolder=$defaultDestinationFolder
	fi

	destination="${username}@${remoteServer}:${destinationFolder}"
}

function upload {
	uploadFrom=$source
	uploadTo=$destination
	
	eval "${currentDir}/connection.sh ${remoteServer} ${username} ${password} ${uploadFrom} ${uploadTo}"
	
	echo "Sync completed."
}

setServer
setUser
setSource
setDestination
echo "Auto uploader has been set up, press any key to sync, press ESC to exit: ${command}"

while :
do
	read -s -n1 keystroke
	echo $keystroke
	case $keystroke in 
		$'\e') 
			echo " Goodbye."
			break
			;;
		*)
			upload $source $destination $password
			;;
	esac

	echo "Press any key to sync again, ESC to exit.."
done
