#!/bin/zsh

#please set parameter 4 in the policy with the g-sheet URL
#Replace the "document ID" with the one unique for yours
#example: https://docs.google.com/spreadsheets/u/0/d/<document ID>/export?format=csv&id=<document ID>&gid=0

#Example G-Sheet lawout
#Example columns: SerialNumber, Name, AssetTag
#Variable cName uses the column 2 to get the name information
#Variable assetTag uses column 3 to get the asset tag information

#version 1.0
#Created on 3/23/2022
#By Reiven Shadowmoon

#path of CSV for naming computers
CSV_PATH=/tmp/computernames.csv

#checks if URL for G-Sheet is set to Parameter 4
if [ "$4" != "" ]; then
  URL=$4
else
  echo "JAMF Policy Paramater 4 is not set."
  exit 0
fi

#Removes previous downloaded csv
if [ -e /tmp/computernames.csv ]
then
	rm /tmp/computernames.csv
  echo "Removed previous CSV file."
fi

#Downooads current version of csv
curl -L $URL -o /tmp/computernames.csv

#gets computer serialnumber
serialNumber=`(system_profiler SPHardwareDataType | grep "r (system)" | awk '{print $4}' )`

#finds serial number in CSV
#cat $CSV_PATH | grep -i $serialNumber
cName=`(cat $CSV_PATH | grep -i $serialNumber | awk -F',' '{print $2}' )`
assetTag=`(cat $CSV_PATH | grep -i $serialNumber | awk -F',' '{print $3}' )`

#leverages the jamf binary to set computer name. This will set ComputerName, LocalHostName, and HostName with a single command
/usr/local/bin/jamf setComputerName -name $cName

#By adding the assetTag variable tot he recon it will add the asset tag to the computer profile in JAMF.
#This is optional please uncommet if you want to use it.
#/usr/local/bin/jamf recon -assetTag $assetTag
