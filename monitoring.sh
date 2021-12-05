#!/bin/bash
echo -n > result

# The architecture of your operating system and its kernel version
echo '#Architercture :' $(uname -a) >> result

#The number of physical processors
echo '#CPU physical : ' $(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l) >> result

#The number of virtual processors.
echo '#vCPU : ' $(cat /proc/cpuinfo | grep "cpu cores" | cut -d ' ' -f3) >> result

#The current available RAM on your server and its utilization rate as a percentage
echo '#Memory Usage: ' $(free -m | awk 'NR==2 {printf("%d/%dMB (%.2f%%)\n", $3, $2, $3*100/$2)}') >> result

#The current available memory on your server and its utilization rate as a percentage.
echo -n '#Disk Usage : ' >> result
nonh=$(df --total | awk 'END{print}' | cut -d ' ' -f34)
echo $nonh/$(df --total -h | awk 'END{printf("%s (%s%%)", $2, $3*100/$2)}') >> result

#The date and time of the last reboot.
echo 'Last boot : ' $(who -b | cut -d ' ' -f13-)

# The number of active connections
echo 'Connections TCP : ' $(netstat -n | grep 'ESTABLISHED' | wc -l) >> result

#The number of users using the server
echo 'User log : ' $(users | cut -d ' ' -f1- | tr ' ' '\n' | uniq -c | wc -l) >> result

#echo 'nbcalls : ' $(cat log.txt | wc -l ) >> result
cat result | wall 
#cat result | wall 
