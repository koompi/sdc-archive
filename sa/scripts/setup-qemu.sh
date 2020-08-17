#!/bin/bash
#set -x
check_root_access(){
    if [[ $(id -u) != 0 ]]; then
        echo "This program run as root."
        exit 0;
    fi
}


BRIDGE=$(brctl show | grep br0 | awk '{print $1}')

create_bridge(){
    echo "Create bridge br0 interface"
    if [[ "${BRIDGE}" == "br0" ]]; then
        echo "Interface br0 created."
    else
        ip link add br0 type bridge
        ip link set br0 up

        BRIDGE=$(brctl show | grep br0 | awk '{print $1}')
        if [[ "${BRIDGE}" == "br0" ]]; then
            echo "Create br0 success."
        else 
            echo "Create br0 failed."
        fi
    fi
}

create_tap(){
    printf "\nCreate New tap Interface\n"
    read -p "Do you want create new tap [Y/n]: " YN
    if [[ -z ${YN} || ${YN} == Y || ${YN} == y ]];then
        read -p "Tap Interface Name[]: " TAP
        ip tuntap add dev "${TAP}" mode tap group kvm
        ip link set dev "${TAP}" up promisc on
        ip link set "${TAP}" master br0 
        echo "Create "${TAP}" success." 

        create_tap #<-- call create_tap
    fi 

}

setip_bridge(){
    ip addr add 192.168.10.1/24 dev br0
}

restart_dhcpd4_dhcpcd(){
    systemctl restart dhcpcd dhcpd4
}

nat_routing(){
    wanInterface="wlp1s0"
    lanInterface="br0"

    iptables -t nat -A POSTROUTING -o ${wanInterface} -j MASQUERADE -w
    iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -w
    iptables -A FORWARD -i ${lanInterface} -o ${wanInterface} -j ACCEPT -w
}

delete_br0_defaut_route(){
    sleep 2
    sudo ip route del default via 192.168.10.1 dev br0
}
##call function
check_root_access #<-- call check_root_access
create_bridge #<-- call create_bridge
create_tap #<-- call create_tap
setip_bridge #<-- call setip_bridge
restart_dhcpd4_dhcpcd #<-- call restart_dhcpd4_dhcpcd
nat_routing #<-- call nat_routing
delete_br0_defaut_route #<-- call delete_br0_defaut_route
