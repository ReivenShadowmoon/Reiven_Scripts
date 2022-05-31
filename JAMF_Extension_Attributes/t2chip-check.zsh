#!/bin/zsh

#Variable to check if the computer has a security chip
schip="$(system_profiler SPiBridgeDataType | awk -F: '/Model Name/ {print $NF}' | sed 's/^ *//')"

#Checked the Variable against what you are looking for.
if [[ "$schip" = "Apple T2 Security Chip" ]]; then
  echo "<result>Yes T2 Security Chip</result>"
else
  echo "<result>No T2 Security Chip</result>"
fi

exit 0
