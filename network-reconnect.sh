#!/bin/sh

## User settings go up here
networkAdapter="en1"
networkSSID="NETWORK NAME GOES HERE"
networkPassword="NETWORK PASSWORD GOES HERE"


## Script occurs below here, shouldn't need any changes
networkStatus=$(networksetup -getairportnetwork "$networkAdapter")
connected="Current Wi-Fi Network: "$networkSSID""
disconnected="You are not associated with an AirPort network."
if [ "$networkStatus" = "$connected" ] ;
then
	#echo "You are connected to the internet"
	exit 0
elif [ "$networkStatus" = "$disconnected" ] ;
then
	#echo "You are not connected"
	#delay 100
	#echo "Connecting..."
	networksetup -setairportnetwork "$networkAdapter" "$networkSSID" "$networkPassword"
	exit 0
else
	#echo "Error occurred"
	exit 0
fi
