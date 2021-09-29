#!/bin/bash

#Checked is storage device is Fusion Drive or SSD
SSD=$(/usr/sbin/diskutil info / | /usr/bin/awk '/Solid State/{print $NF}')
FUS=$(/usr/sbin/diskutil info / | /usr/bin/awk '/Fusion Drive/{print $NF}')

#Takes results from the check and displays SSD if Fusion Drive is No
if [ $SSD == Yes ] && [ $FUS == No ]; then

/bin/echo "<result>SSD</result>"

#If SSD is Yes and Fusion Drive is Yes then resilts wil be Fusion
elif [ $FUS == Yes ]; then

/bin/echo "<result>Fusion</result>"

#If both SSD and Fusion Drive are No then device is HDD
else

/bin/echo "<result>HDD</result>"

fi
exit 0
