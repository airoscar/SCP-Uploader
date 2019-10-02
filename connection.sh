#!/usr/bin/expect -f
 
set timeout -1

set remoteServer [lindex $argv 0]
set username [lindex $argv 1]
set password [lindex $argv 2]
set uploadFrom [lindex $argv 3]
set uploadTo [lindex $argv 4]

spawn rsync -avz -e "ssh" --exclude "*.git" ${uploadFrom} "${uploadTo}"

expect "${username}@${remoteServer}'s password: "
 
send "${password}\r"

expect eof