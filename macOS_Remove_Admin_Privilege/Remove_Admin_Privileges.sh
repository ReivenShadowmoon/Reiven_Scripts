#!/bin/sh

# Finds all users in the admin group and retreives user names
adminUsers=$(dscl . -read Groups/admin GroupMembership | cut -c 18-)

# For each user name it will parse through the users
for user in $adminUsers
do
#If the user name is not in this list then the do will proceed
#If more accounts need admin priv then add "&& [ "$user" != "localadmin" ]"
#per user name that needs it
    if [ "$user" != "root" ]  && [ "$user" != "localadmin" ]; then
      #Command to remove admin priv
      dseditgroup -o edit -d $user -t user admin
      #output to so which user was removed from the admin group
        if [ $? = 0 ]; then echo "Removed user $user from admin group"; fi
    else
      #Anouncing that the admin account was left alone
      echo "Admin user $user left alone"
    fi
done

#updates the preboot of APFS partitions
diskFormat=$(diskutil info / | awk -F': ' '/File System/{print $NF}' | xargs)
if [[ $diskFormat != APFS ]]; then
  #echos out the disk format
  echo "Disk format is" $diskFormat "no preboot to update."
else
  #echos the disk format
  echo "Disk format is" $diskFormat "updating preboot."
  #command updates the preboot on APFS partitions
  diskutil apfs updatePreboot /
fi
