#! /bin/bash

#Variables declared
tmp="/tmp/webfiles/"
rootLoc="/var/www/html/"
url="https://www.tooplate.com/zip-templates/2137_barista_cafe.zip"
if [[ "$url" =~ ^(http.+)/([^/]+)/([^/]+)$ ]]; then
    domain="${BASH_REMATCH[1]}"
    section1="${BASH_REMATCH[2]}"
    section2="${BASH_REMATCH[3]}"
fi

yum --help &> /dev/null

if [ $? -eq 0 ]
then 
    #set variables for Centos
    package="wget unzip httpd"
    svc="httpd"
    
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
    
    echo "########################################"
    echo "List the server root directory"
    echo "########################################"
    ls $rootLoc
    echo
else
    #set variables for Centos
    package="wget unzip apache2"
    svc="apache2"
    #installing Dependencies
    echo "########################################"
    echo "Installing Packages"
    echo "########################################"
    sudo apt update
    sudo apt install $package -y > /dev/null
    echo
    
    #start and enable apache2 services
    echo "########################################"
    echo "Start & enable apache2 service"
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
    echo "Restarting apache2 services "
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
    
    echo "########################################"
    echo "List the server root directory"
    echo "########################################"
    ls $rootLoc
    echo
fi

    
