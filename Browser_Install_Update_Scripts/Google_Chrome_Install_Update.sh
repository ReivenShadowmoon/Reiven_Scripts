#!/bin/sh
#####################################################################################################
#
# ABOUT THIS PROGRAM
#
# NAME
#	GoogleChromeInstall.sh -- Installs the latest Google Chrome version
#
# SYNOPSIS
#	sudo GoogleChromeInstall.sh
#
####################################################################################################
#
# HISTORY
#
#	Version: 1.0
#	- Joe Farage, 17.03.2015
#
#	Version 1.1
#	- Reiven Shadowmoon, 30.09.2021
#	- Change: Updated to include Apple Silicon and Universal installer.
####################################################################################################


dmgfile="googlechrome.dmg"
volname="Google Chrome"
logfile="/Library/Logs/GoogleChromeInstallScript.log"

url='https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg'

# Are we running on Intel?
if [ '`/usr/bin/uname -p`'="i386" -o '`/usr/bin/uname -p`'="x86_64" -o '`/usr/bin/uname -p`'="arm" ]; then
		/bin/echo "--" >> ${logfile}
		/bin/echo "`date`: Downloading latest version." >> ${logfile}
		/usr/bin/curl -s -o /tmp/${dmgfile} ${url}
		/bin/echo "`date`: Mounting installer disk image." >> ${logfile}
		/usr/bin/hdiutil attach /tmp/${dmgfile} -nobrowse -quiet
		/bin/echo "`date`: Installing..." >> ${logfile}
		ditto -rsrc "/Volumes/${volname}/Google Chrome.app" "/Applications/Google Chrome.app"
		/bin/sleep 10
		/bin/echo "`date`: Unmounting installer disk image." >> ${logfile}
		/usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "${volname}" | awk '{print $1}') -quiet
		/bin/sleep 10
		/bin/echo "`date`: Deleting disk image." >> ${logfile}
		/bin/rm /tmp/"${dmgfile}"
	else
		/bin/echo "`date`: ERROR: This script is not suported by this Mac." >> ${logfile}

fi

exit 0
