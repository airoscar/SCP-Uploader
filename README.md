# bash-auto-uploader
Bash script for automatically uploading files using rsync and not having to enter password repeatedly.

# Typical Usage
- Copy script files connection.sh and uploader.sh into project folder on your local machine, this would be the folder that you would like to get sync'd to the remote machine.
- cd into the project folder and make the files executable by running the following command:
```
chmod +x ./connection.sh
chmod +x ./uploader.sh
```
- Run the uploader.sh script:
```
./uploader.sh
```

Follow the prompts and set up remote and login credentials. By default, the script will sync the content of the project folder to the user's home directory on the remote machine. You may set up different local source and remote destination paths explicitly if needed.
