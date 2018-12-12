#!/bin/bash
# In The Name of God
# ========================================
# [] File Name : shecan.sh
#
# [] Creation Date : 19-11-2018
#
# [] Created By : Parham Alvani <parham.alvani@gmail.com>
# =======================================
program_name=$0

usage() {
        echo "Are you using shecan? Do you want to use it? Do you want your default DNS?"
        echo "shecan.sh is here for you"
        echo "usage: $program_name [-r] [-s] [-h] [-p ip]"
        echo "  -r   reset dns to default"
        echo "  -s   set dns to awesome shecan"
        echo "  -h   display help"
        echo "  -p   shecan dns server ip address"
}

reset=false
shecan="178.22.122.100"
# parses options flags
while getopts 'rhp:' argv; do
        case $argv in
                h)
                        usage
                        exit
                        ;;
                r)
                        reset=true
                        ;;
                p)
                        shecan=$OPTARG
                        ;;
        esac
done

# checks you shecan status
http_code=$(curl -s -o /dev/null -w "%{http_code}" https://check.shecan.ir)
if [ $http_code -eq 200 ]; then
        echo "You are using shecan"
else
        echo "You are not using shecan"
fi

# sets or rests shecan DNS in OSx
if [[ "$OSTYPE" == "darwin"* ]]; then
        if [ reset = true ]; then
                echo "Resets DNS to DHCP defaults"
                networksetup -setdnsservers Wi-Fi empty
        fi
        if [ set = true ]; then
                echo "Sets DNS to Awesome shecan $shecan"
                networksetup -setdnsservers Wi-Fi $shecan
        fi
else
        echo "This script just works with OSx"
fi
