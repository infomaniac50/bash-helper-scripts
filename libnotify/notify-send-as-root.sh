#!/bin/bash
#
# This script shows how to send a libnotify message
# to a specific user.
#
# It looks for a process that was started by the user and is connected to dbus.

# process to determine DBUS_SESSION_BUS_ADDRESS
USER_DBUS_PROCESS_NAME="gconfd-2"

NOTIFY_SEND_BIN="/usr/bin/notify-send"

TITLE="title"
MESSAGE="notify message"

DBUS_PID_LINE=`ps aux | grep $USER_DBUS_PROCESS_NAME | grep -v grep`

# get user of first dbus process
USER=`echo $DBUS_PID_LINE | awk '{ print $1 }'`

# get pid of first user dbus process
DBUS_PID=`echo $DBUS_PID_LINE | awk '{ print $2 }'`

# get DBUS_SESSION_BUS_ADDRESS variable
DBUS_SESSION=`grep -z DBUS_SESSION_BUS_ADDRESS /proc/$DBUS_PID/environ | sed -e s/DBUS_SESSION_BUS_ADDRESS=//`

# send notify
DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION su -c "$NOTIFY_SEND_BIN \"$TITLE\" \"$MESSAGE\"" $USER
