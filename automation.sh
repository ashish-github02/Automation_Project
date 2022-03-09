echo "***************************************package list at the start of the script***********************************"
apt list --installed
echo "***************************************update of the package details*********************************************"
sudo apt update -y
echo "***************************************Check on apache2 package installation status******************************"
Service="apache2"
echo "*****************************************APACHE2 Installation status check***************************************"
status=$(dpkg-query -W --showformat='${Status}\n' $Service|grep "install ok installed")
echo Checking for $Service: $status
if [ "" = "$status" ];
then
        echo "********************************No $Service Installed so Installing $Service.*************************************"
        sudo apt-get --yes install $Service
fi
echo "***********************************Apache2 service status check***************************************************"
if [ $(sudo systemctl status apache2| grep -v grep | grep 'dead' | wc -l) = 0 ]
then
 echo "Process is running."
 else
 echo "**********************************As APACHE2 service is down, starting it****************************************"
 sudo systemctl start apache2
 sudo systemctl status apache2
fi