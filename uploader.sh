#!/bin/bash 

echo "#############################"
echo "##### Auto File Uploader ####"
echo "##### wgmsrv.ucalgary.ca ####"
echo "#############################"

currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
scriptFileName="${BASH_ARGV[0]}"

function setUser {
	echo "Enter username (ie: firstname.lastname)"
	read username

	echo "Please enter password."
	read -s password
}

function setServer {
	echo "Enter server address (Default: wgmsrv.ucalgary.ca)"
	read remoteServer
	if [[ -z "$remoteServer" ]]; then
		remoteServer="wgmsrv.ucalgary.ca"
	fi
}

function setSource {

	echo "Set up source:"
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
				echo "Invalid selection"
		esac
	done
}

function setDestination {
	echo "Enter destination path: (Default: ~/)"
	read destinationFolder

	if [[ -z "$destinationFolder" ]]; then
		destinationFolder="~/"
	fi

	destination="${username}@${remoteServer}:${destinationFolder}"
}

function upload {
	uploadFrom=$source
	uploadTo=$destination
	command="rsync -avz -e ssh --exclude \"${scriptFileName}\" --exclude \"*.git\" ${uploadFrom} ${uploadTo}"
	echo $command
	eval $command
	
}

setServer
setUser
setSource
setDestination
echo "Auto uploader has been set up to upload from ${source} to ${destination}, press any key to upload, press ESC to exit."

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
			echo "Uploading.."
			upload $source $destination $password
			;;
	esac

	echo "Press any key to sync again, ESC to exit.."
done
