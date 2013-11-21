#!/bin/bash
if sudo apt-get -y install python-software-properties && sudo add-apt-repository -y ppa:nginx/stable && sudo apt-get update && sudo apt-get -y install nginx && sudo service nginx start
then
  nginx_info="Nginx Stable version Installed and is Running."
else
  nginx_info="Problem with Packages"
fi

#this is to change nginx root directory
if sed -i 's/root \/usr\/share\/nginx\/html;/root \/home\/www;/g' /etc/nginx/sites-available/default && sed -i 's/index index.html index.htm;/index index.html index.htm index.php;/g' /etc/nginx/sites-available/default 
then
  nginx_dir="Nginx default server directory changed to /home/www"
else
  nginx_dir="Could not change nginx default server directory"
fi

#Installing PHP
if add-apt-repository -y ppa:ondrej/php5 && apt-get -y update && apt-get install -y php5-fpm php5-mcrypt php5-cli
then
  php_info="PHP Installed"
else
  php_info="Not able to Install PHP"
fi

#Database Install
echo "What database do you want to Install, Type mysql for Mysql and mongo for MongoDB: "
read input
if [ "$input" == "mysql" ];
then
  printf "\nMysql is selected and installing.\n\n"
  sleep 0.9
  mysql_info="Mysql is installed with empty root password. You have to set it manually"
  export DEBIAN_FRONTEND=noninteractive
  apt-get -q -y install mysql-server mysql-client php5-mysql
elif [ "$input" == "mongo" ];
then
  printf "\n MongoDB Selected.\n\n"  
fi

#Uncomment Few Lines from Virtual Host
if wget "https://raw.github.com/AbhishekGahlot/Ubuntu-Nginx-Mysql-PHP/master/regex_abhishek.py" && python regex_abhishek.py && service nginx restart && mkdir /home/www
then
	final_info="PHP is now working with nginx. Create php file in /home/www and execute in browser"
	rm regex_abhishek.py
else
	final_info="Problem fetching file, You will have to configure virtual host manually"
fi

echo $nginx_info && echo $nginx_dir && echo $mysql_info && echo $php_info && echo $final_info
