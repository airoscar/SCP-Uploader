#!/bin/bash 

remoteServer="wgmsrv.ucalgary.ca"

function upload {
	
	destination = "$1@${remoteServer}:~/$2"
	localDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	
	scp -r $1
}

echo "#############################"
echo "##### Auto File Uploader ####"
echo "##### wgmsrv.ucalgary.ca ####"
echo "#############################"

echo "Set upload source:"
OPTIONS=("All files in current directory" 
	# "Select a file from current directory" 
	"Specify a path")
select opt in "${OPTIONS[@]}" 
do
	case $opt in
		"All files in current directory")
			source="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
			echo "current directory selected: ${source}"
			break
			;;
		# "Select a file from current directory")
		# 	sourceRoot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
		# 	echo "Select one of the following files: "
		# 		for entry in "$sourceRoot"/*
		# 		do
		# 			echo "$entry"
		# 		done
		# 	break
		# 	;;
		"Specify a path")
			echo "Enter a source path: "
			read source
			break
			;;
		*)
			echo "Invalid selection"
	esac
done


echo "Enter username (ie: firstname.lastname)"
read username

echo "Please enter password."
read -s password

echo "Enter destination path relative to home folder: (ie: my_project/data)"
read destinationFolder
destination="${username}@${remoteServer}:~/${destinationFolder}"

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
done
