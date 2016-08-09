#!/bin/bash

#########################################################################################
# Check if the script is being running by a root or sudoer user				#
#########################################################################################
if [ "$(id -u)" != "0" ]; then echo ""; echo "This script must be executed by a root or sudoer user"; echo ""; exit 1; fi

# Add common variables
if [ -n "$1" ]; then scriptRootFolder="$1"; else scriptRootFolder="`pwd`/../.."; fi
. $scriptRootFolder/common/commonVariables.properties

#########################################################################################
# CONSIDERATIONS									#
# - No need to use 'sudo' because this script must be executed as root user.		#
# - No need to execute 'apt-get update' because main script will execute it.		#
# - This script must be non-interactive, this means, no interaction with user at all:	#
# 	* No echo to standard output (monitor)						#
#	* No read from standard input (keyboard)					#
#	* Use auto-confirm for commands. Example: apt-get -y install <package>		#
#	* etc.										#
#########################################################################################

# Variables
repositoryURL="..."
repository="deb $repositoryURL <parameters>"
repositorySource="deb-src $repositoryURL <parameters>"
targetFilename="destinationFilename"

# Commands to add third-party repository of the application.
# SE ESTA DUPLICANDO DEB-SRC
if [ ! -f "/etc/apt/sources.list.d/$targetFilename" ] || [ ! grep -q "$repositoryURL" "/etc/apt/sources.list.d/$targetFilename" ]; then
	# Command to add repository key if needed
	# ...
	echo "$repository" >> "/etc/apt/sources.list.d/$targetFilename"
	# Uncomment if needed [optional]
	# echo "$repositorySource" >> "/etc/apt/sources.list.d/$targetFilename"
fi 2>/dev/null