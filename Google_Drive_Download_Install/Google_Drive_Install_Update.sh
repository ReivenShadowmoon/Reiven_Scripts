#!/bin/zsh
#####################################################################################################
#
# NAME
#	Google_Drive_Install_Update.sh -- Installs the latest Google Drive version
#
# SYNOPSIS
#	sudo Google_Drive_Install_Update.sh
#
# Based on the GoogleChromeInstall.sh script by Joe Farage
####################################################################################################
#
# HISTORY
#
#	Version: 1.0
#	- Reiven Shadowmoon 4/10/2021
#
####################################################################################################

#Variablea
dmgfile="GoogleDrive.dmg"
pkgname="GoogleDrive.pkg"
volname="Install Google Drive"
logfile="/Library/Logs/GoogleDriveInstallScript.log"
url='https://dl.google.com/drive-file-stream/GoogleDrive.dmg'

#install starts
# Creates log file
/bin/echo "--" >> ${logfile}
/bin/echo "`date`: Downloading latest version." >> ${logfile}
# Downloads latest version from Goole
/usr/bin/curl -s -o /tmp/${dmgfile} ${url}
# Mounts the DMG silently
/bin/echo "`date`: Mounting installer disk image." >> ${logfile}
/usr/bin/hdiutil attach /tmp/${dmgfile} -nobrowse -quiet
/bin/sleep 10
# Begins installing GoogleDrive.pkg
/bin/echo "`date`: Installing..." >> ${logfile}
/usr/sbin/installer -pkg "/Volumes/${volname}/"${pkgname} -target /Applications -dumplog >> ${logfile}
/bin/sleep 10
# Unmounts DMG silently
/bin/echo "`date`: Unmounting installer disk image." >> ${logfile}
/usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "${volname}" | awk '{print $1}') -quiet
/bin/sleep 10
# Deletes DMG to clean up after install
/bin/echo "`date`: Deleting disk image." >> ${logfile}
/bin/rm /tmp/"${dmgfile}"

exit 0
