#!/bin/sh

set -e

notifications=$(swaync-client -c)

# The output should take the form of "$text\n$tooltip\n$class"

if [ $notifications -gt 0 ]; then
    printf "$notifications 󱅫\n"
    printf "There's notifications!\n"
    printf "unread"
else
    printf "$notifications 󰂜\n"
    printf "No notifications :(\n"
    # no css class
fi
