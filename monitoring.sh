#!/usr/bin/bash
#
# Some basic monitoring functionality; Tested on Amazon Linux 2.
#
TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
MEMORYUSAGE=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
PROCESSES=$(expr $(ps -A | grep -c .) - 1)
HTTPD_PROCESSES=$(ps -A | grep -c httpd)
CPUUSAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | awk '{printf "%.2f%%", $1}')

echo "               /\_____/\ "
echo "              /  o   o  \ "
echo "             ( ==  ^  == ) "
echo "              )         ( "
echo "             (           ) "
echo "            ( (  )   (  ) ) "
echo "           (__(__)___(__)__)"
echo "Instance ID: $INSTANCE_ID"
echo "Memory utilisation: $MEMORYUSAGE"
echo "CPU utilisation: $CPUUSAGE"
echo "No of processes: $PROCESSES"
if [ $HTTPD_PROCESSES -ge 1 ]
then
    echo "Web server is running"
else
    echo "Web server is NOT running"
fi
