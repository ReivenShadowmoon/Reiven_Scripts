#!/bin/bash

#
# Pro Tools Post Install Script
# Tested on Pro Tools 20.12
#

# Copy the com.avid.bsd.shoe Helper Tool
#Set variable appName to the PHT (Privileged Helper Tool) for Avid Pro Tools
appName=$(ls -t -U /Applications/Pro\ Tools.app/Contents/Library/LaunchServices/ | grep -m 1 "com.avid" )

#Path and file name using $appName for the PHT
PHT_SHOE=/Library/PrivilegedHelperTools/$appName

#Copies PHT from with in the Pro Tools.app file into /Library/PHT
/bin/cp -f /Applications/Pro\ Tools.app/Contents/Library/LaunchServices/$appName $PHT_SHOE

#Sets the corect owner for the PHT
/usr/sbin/chown root:wheel $PHT_SHOE
#Sets the needed permissions so that PHT will work correctly
/bin/chmod 544 $PHT_SHOE
