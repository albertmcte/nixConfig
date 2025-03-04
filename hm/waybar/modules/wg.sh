#!/bin/sh
state=$(ip a | grep wg0 >/dev/null && printf "HYDRA\n" || printf "wg:down\n")
state2=$(ip a | grep wg1 >/dev/null && printf "HKG\n" || printf "\n")
[ "$state" = "HYDRA" ] && class=good || class=notgood
[ "$state2" = "HKG" ] && class=ubu || class=$class
[ "$state2" = "HKG" ] && state=$state2
echo -e "{\"text\":\""$state"\", \"class\":\""$class"\"}"
echo $state $class
