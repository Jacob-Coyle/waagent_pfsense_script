#! /bin/sh

#Install required packages
pkg install -y sudo bash git py311-setuptools-63.1.0

#Download waagent
cd /tmp
git clone https://github.com/Azure/WALinuxAgent.git
cd WALinuxAgent/
git checkout v2.9.1.1

#Install waagent
/usr/local/bin/python3.11 setup.py install
mv /etc/waagent.conf /usr/local/etc/
mv /etc/rc.d/waagent /usr/local/etc/rc.d/

#Specify interpreter
#need to replace the first line of /usr/local/sbin/waagent with the path of the python binary that was installed.

cd /tmp
git clone "https://github.com/Jacob-Coyle/waagent_pfsense_script.git"

mv /tmp/waagent_pfsense_script/waagent.conf /usr/local/etc/
mv /tmp/waagent_pfsense_script/rc.d/waagent /usr/local/etc/rc.d/
mv /tmp/waagent_pfsense_script/waagent /usr/local/sbin
ln -s /tmp/waagent_pfsense_script/rc.d/waagent /tmp/waagent_pfsense_script/rc.d/waagent.sh
ln -s /usr/local/etc/rc.d/waagent /usr/local/etc/rc.d/waagent.sh

chmod 755 /usr/local/etc/rc.d/waagent
chmod 755 /usr/local/sbin/waagent

#Enabled service
echo 'waagent_enable="YES"' >> /etc/rc.conf.local

