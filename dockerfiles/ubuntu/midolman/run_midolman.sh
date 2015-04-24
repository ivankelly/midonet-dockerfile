#!/bin/bash

echo "Running midolman"

if [ ! -e /etc/nsuuid ]; then
    uuidgen | cut -b 1-8 > /etc/nsuuid
fi

UUID=$(cat /etc/nsuuid)

NS=ns-$UUID
echo $NS

ip netns add $NS
for i in $(seq 1 20); do
    DP=dp-$UUID-$i
    PR=pr-$UUID-$i
    ip link add name $DP type veth peer name $PR
    ip link set $DP up
    ip link set $PR netns $NS
    ip netns exec $NS ip link set $PR up
    ip netns exec $NS ip address add 172.16.30.1/24 dev $PR
    ip netns exec $NS ifconfig lo up
done

exec /usr/share/midolman/midolman-start
