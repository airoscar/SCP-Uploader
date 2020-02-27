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

# Demo
- In the repo folder, run:
```
chmod +x ./connection.sh
chmod +x ./uploader.sh
./uploader.sh
```
- Enter server address, username, password when prompted.
- Enter source path:
```
demo
```
- Leave destination path default.
- In a new terminal, log into the remote cluster, eg:
```
ssh user.name@helix.hpc.ucalgary.ca
```
- Navigate into the demo folder which should be now in the user's home directory
```
cd demo
```
- Load Python environment
```
module load python/anaconda3
```
- Run the run_script.sh, which will execute the py file. Both of these are included in the demo folder:
```
sbatch run_script.sh
```
- You can check the status of the job by using:
```
squeue -u user.name
```
- After the job is finished, there will be an output file created in the demo folder:
```
ls
```
- For example the output file maybe named 'slurm-123456.out'
- To preview the file:
```
cat slurm-123456.out
```
- To download the output file, open a new terminal window, and download file using scp, e.g.:
```
scp user.name@helix.hpc.ucalgary.ca:demo/slurm-491073.out ~/Downloads
```