#! /bin/bash

#Variables declared
package="wget unzip httpd"
svc="httpd"
tmp="/tmp/webfiles/"
url="https://www.tooplate.com/zip-templates/2131_wedding_lite.zip"
if [[ "$url" =~ ^(http.+)/([^/]+)/([^/]+)$ ]]; then
    domain="${BASH_REMATCH[1]}"
    section1="${BASH_REMATCH[2]}"
    section2="${BASH_REMATCH[3]}"
fi
rootLoc="/var/www/html/"

#installing Dependencies
echo "########################################"
echo "Installing Packages"
echo "########################################"
sudo yum install $package -y > /dev/null
echo

#start and enable httpd services
echo "########################################"
echo "Start & enable httpd service"
echo "########################################"
sudo systemctl start $svc
sudo systemctl enable $svc
echo

#create temp directory
echo "########################################"
echo "Start Artifact Deployment"
echo "########################################"
mkdir -p $tmp && cd $tmp
echo

#downloading source code
echo "########################################"
echo "Cloning the source code"
echo "########################################"
wget $url
unzip $section2
echo

#copying the artifact to the var/www/html/ dir
echo "########################################"
echo "Deploying......."
echo "########################################"
sudo cp -r ${section2%.zip}/* $rootLoc
echo

#restart httpd services
echo "########################################"
echo "Restarting httpd services "
echo "########################################"
sudo systemctl restart $svc
echo

#removing existing cloned files
echo "########################################"
echo "Cleaning up"
echo "########################################"
sudo rm -rf $tmp 
echo

echo "########################################"
echo "Httpd Status"
echo "########################################"
sudo systemctl status $svc
echo


ls $rootLoc
echo

echo "########################################"
echo "ip address"
echo "########################################"
ip addr show | grep enp0s8 | grep inet 
echo
echo
