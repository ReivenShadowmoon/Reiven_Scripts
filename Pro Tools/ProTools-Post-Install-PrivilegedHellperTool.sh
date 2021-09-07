#!/bin/bash

#
# Pro Tools Post Install Script
# Tested on Pro Tools 20.12
#

# Copy the com.avid.bsd.shoe Helper Tool
appName=$(ls -t -U /Applications/Pro\ Tools.app/Contents/Library/LaunchServices/ | grep -m 1 "com.avid" )
PHT_SHOE=/Library/PrivilegedHelperTools/$appName

/bin/cp -f /Applications/Pro\ Tools.app/Contents/Library/LaunchServices/$appName $PHT_SHOE
/usr/sbin/chown root:wheel $PHT_SHOE
/bin/chmod 544 $PHT_SHOE
