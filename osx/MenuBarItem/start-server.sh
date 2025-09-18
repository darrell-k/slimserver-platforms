#!/bin/bash
SERVER_RUNNING=`ps -axww | grep "slimserver\.pl\|slimserver" | grep -v grep | cat`

PRODUCT_NAME=Squeezebox
LOG_FOLDER="$HOME/Library/Logs/$PRODUCT_NAME"

if [ z"$SERVER_RUNNING" = z ] ; then
	if [ ! -e "$LOG_FOLDER" ] ; then
		mkdir -p "$LOG_FOLDER";
	fi

	if [ z"$USER" != zroot ] ; then
		chown -R $USER "$LOG_FOLDER"
	fi

	BASE_FOLDER=$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)
	cd "$BASE_FOLDER/server"

	MAJOR_OS_VERSION=`sw_vers | fgrep ProductVersion | tr -dc '0-9.' | cut -d '.' -f 1`

	echo "Major macOS version: $MAJOR_OS_VERSION"
	PERL_518=`which perl5.18`
	echo "System Perl 5.18: $PERL_518"

	if [ $MAJOR_OS_VERSION = 10 -a -x "/usr/bin/perl5.18" ] ; then
		echo "Using Apple's Perl 5.18"
		PERL_BINARY="/usr/bin/perl5.18"
	else
		echo "Using our custom Perl build"
		PERL_BINARY="$BASE_FOLDER/../MacOS/perl"
	fi

	"$PERL_BINARY" slimserver.pl $1 &> /dev/null &
fi
