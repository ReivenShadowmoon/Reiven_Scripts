#!/bin/bash

#Checked is storage device is SSD or HDD
SSD=$(/usr/sbin/diskutil info / | /usr/bin/awk '/Solid State/{print $NF}')
FUS=$(/usr/sbin/diskutil info / | /usr/bin/awk '/Fusion Drive/{print $NF}')

#Takes results from the check and displays SSD or HDD
if [ $SSD == Yes ] && [ $FUS == No ]; then

/bin/echo "<result>SSD</result>"

elif [ $FUS == Yes ]; then

/bin/echo "<result>Fusion</resuly>"

else

/bin/echo "<result>HDD</result>"

fi
exit 0
