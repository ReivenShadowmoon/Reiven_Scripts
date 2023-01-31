#!/bin/zsh

# Waiting for JAMF Connect to load
# Process Grep for "Jamf Connect"
JConnect=$(/usr/bin/pgrep "Jamf Connect")

#While loop looking for "Jamf Connect" process with PID greater that 1 else it will try again after 5 seconds
while [[ "$JConnect" -lt 1 ]]; do
	sleep 5
done

# Requests Kerberos Ticket
loggedInUser=$(stat -f%Su /dev/console) #Get the username of the current logged in user
/usr/bin/sudo -u $loggedInUser /usr/bin/open jamfconnect://gettickets

exit 0