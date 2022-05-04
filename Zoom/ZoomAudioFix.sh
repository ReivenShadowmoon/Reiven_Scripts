#!/bin/zsh

#Copy's the Zoom Audio driver so that Admin rights are not needed after Zoom install
cp -R /Applications/zoom.us.app/Contents/PlugIns/ZoomAudioDevice.driver /Library/Audio/Plug-Ins/HAL/

exit 0
