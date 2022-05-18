#!/bin/bash
arc=$(uname -a)
# Num de nucleos fisicos
cpu=$(nproc)
# Num de nucleos virtuales
v_cpu=$(grep "processor" /proc/cpuinfo | wc -l)
# Memoria RAM disponible y % de uso
mem=$(free -m | awk 'NR==2{printf("%s/%sMB (%.2f%%)"), $3, $2, $3*100/$2}')
# Memoria disponible en el servidor y % de su utilizacion
disk=$(df -h | awk 'NR==4{printf("%d/%dGb (%s)"), $2, $3, $5}')
# Porcetaje de uso de los nucleos
load=$(top -bn1 | awk 'NR==3{printf("%.1f%%"), $2}')
# Fecha y hora del último reinicio
lb=$(who -b | awk '{print $4, $5}')
# Si LVM está activo o no
lvm=$(lsblk | grep "lvm" | awk '{if($1) {print "yes"; exit;} else {print "no"} }')
# Num. de conexiones activas
tcp=$(netstat -an | grep ESTABLISHED |  wc -l | awk)
# Num. de usuarios del servidor
users=$(users | wc -w)
# Dirección IPv4 del servidor y su MAC (Media Access Control)
ip=$(hostname -I)
mac=$(ip a | grep "link/ether" | awk '{print $2}')
# Num. de comandos ejecutados con sudo
sudo=$(grep "COMMAND" /var/log/sudo/sudo.log | wc -l)
wall "  Architecture: $arc
        CPU physical: $cpu
        vCPU: $v_cpu
        Memory Usage: $mem
        Disk Usage: $disk
        CPU load: $load
        Last boot: $lb
        LVM use: $lvm
        Connexions TCP: $tcp
        User log: $users
        Network: IP $ip ($mac)
        Sudo: $sudo"
