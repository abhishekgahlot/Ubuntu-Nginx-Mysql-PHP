#!/bin/bash
if sudo apt-get -y install python-software-properties && sudo add-apt-repository -y ppa:nginx/stable && sudo apt-get update && sudo apt-get -y install nginx && sudo service nginx start
then
  echo "Nginx Stable version Installed and is Running."
else
  echo "Problem with Packages"
fi

#this is to change nginx root directory
if sed -i 's/root \/usr\/share\/nginx\/html;/root \/home\/www;/g' /etc/nginx/sites-available/default && sed -i 's/index index.html index.htm;/index index.html index.htm index.php;/g' /etc/nginx/sites-available/default 
then
  echo "Nginx default server directory changed to /home/www"
else
  echo "Could not change nginx default server directory"
fi

#Installing PHP
if add-apt-repository -y ppa:ondrej/php5 && apt-get -y update && apt-get install -y php5-fpm php5-mcrypt php5-cli
then
  echo "PHP Installed"
else
  echo "Not able to Install PHP"
fi

#Uncomment Few Lines from Virtual Host
if wget "https://raw.github.com/AbhishekGahlot/Ubuntu-Nginx-Mysql-PHP/master/regex_abhishek.py" && python regex_abhishek.py && service nginx restart && mkdir /home/www
then
	echo "PHP is now working with nginx. Create php file in /home/www and execute in browser"
else
	echo "Problem fetching file, You will have to configure virtual host manually"	
fi
