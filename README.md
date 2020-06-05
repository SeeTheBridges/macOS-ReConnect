macOS-ReConnect
===============
A simple launchd script to force your mac to auto reconnect to a preferred network.

## Details ##
I've been using a Mac Mini as a plex server for a while now, but I noticed a really weird problem. Sometimes it would just end up disconnected from the wifi for whatever reason. You would think it would search for the network again right? Well it never did, so I went looking for a solution to my little issue. I came across [airport-autojoin], but I could never get it to cooperate or work.

  [airport-autojoin]:https://github.com/tjluoma/airport-autojoin

## My Solution ##
tjluoma's solution was a little overly complicated for me to understand, so I went for a MUCH more simplified code. The general flow is as follows, every 10 minutes:
1. network-reconnect is launched (automatically or by the user)
2. A networksetup command is ran to see if you are connected
3. You're connected? The script closes.
4. Not connected? networksetup is run again to connect to the user specified network, then closes.

## Setup ##
### Custom launch interval ###
In the plist file under `<key>StartInterval</key>`, you can change the 600 to any number of seconds you'd like to have the network checked. 10 Mins X 60 Seconds = 600 seconds

#### Reconnect Script ###
At the top of the reconnect script, there are 3 variables you need to set. The adapter, SSID, and Password. To find what your network adapter is, you can check by going to:

`the Apple at the top left -> About this mac -> System report... -> Network`

My wifi is listed as en1, but it could also be another number for you. 

Then just enter your network name and password into the quotation marks, and save your changes.


## Installation ##
When you open finder, you can press Command + Shift + G to get to these folders,

Put the **network-reconnect.sh** in `/usr/local/bin/`

then install [com.seethebridges.network-reconnect.plist] to `/Library/LaunchDaemons` (which will make sure that it is run as `root`).

  [com.seethebridges.network-reconnect.plist]: https://github.com/SeeTheBridges/macOS-ReConnect/blob/master/com.seethebridges.network-reconnect.plist
 
 ### Permissions ###
 Open Terminal
 1. First, we'll give root ownership over the plist with: `chmod 644 /Library/LaunchDaemons/com.seethebridges.network-reconnect`
 2. Next, we'll change the owner/group: `sudo chown root:wheel /Library/LaunchDaemons/com.seethebridges.network-reconnect`
 3. Then, we'll add the plist to launchd so it can run automatically: `sudo launchctl load /Library/LaunchDaemons/com.seethebridges.network-reconnect`
 
 4. Just to be safe, we'll also make sure the reconnect script is executable with: `sudo chmod 755 /usr/local/bin/network-reconnect.sh`
