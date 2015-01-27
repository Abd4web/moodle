#!/bin/sh
set -e

if [ -e /.installed ]; then
	echo 'Already installed.'

else
	echo ''
	echo 'INSTALLING'
	echo '----------'

	apt-get -y install apparmor-utils php5-curl php5-xmlrpc
	aa-complain usr.sbin.mysqld

	mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default-original.conf
	ln -s /vagrant/server/000-default.conf /etc/apache2/sites-available/
	mv /etc/apache2/envvars /etc/apache2/envvars-original
	ln -s /vagrant/server/envvars /etc/apache2/
	mv /etc/php5/apache2/conf.d/20-xdebug.ini /etc/php5/apache2/conf.d/20-xdebug.ini-original
	ln -s /vagrant/server/20-xdebug.ini /etc/php5/apache2/conf.d/

	a2enmod rewrite
	php5enmod mcrypt
	service apache2 restart
	mysql -u root -e "create database moodle DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci";
	mysql -u root -e "GRANT ALL PRIVILEGES ON moodle.* TO 'root'@'%' WITH GRANT OPTION;"
	mv /etc/mysql/my.cnf /etc/mysql/my-original.cnf
	ln -s /vagrant/server/my.cnf /etc/mysql/
	service mysql restart
	crontab /vagrant/server/cron.txt
	# Add Google public key to apt
	#wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -

	# Add Google to the apt-get source list
	#echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

	# Update app-get
	#apt-get update

	# Install Java, Chrome, Xvfb, and unzip
	#apt-get -y install openjdk-7-jre google-chrome-stable xvfb unzip x11vnc fvwm xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic screen
	# apt-get -y install cabextract ttf-mscorefonts-installer

	#mkfontdir

	# Download and copy the ChromeDriver to /usr/local/bin
	#cd /tmp
	#wget "http://chromedriver.storage.googleapis.com/2.9/chromedriver_linux64.zip"
	#unzip chromedriver_linux64.zip
	#chmod 555 chromedriver
	#mv chromedriver /usr/local/bin
	#wget "https://selenium.googlecode.com/files/selenium-server-standalone-2.36.0.jar"
	#mv selenium-server-standalone-2.36.0.jar /usr/local/bin

	#sudo apt-get -y install python-software-properties software-properties-common python g++ make
	#sudo add-apt-repository -y ppa:chris-lea/node.js
	#sudo apt-get update
	#sudo apt-get -y install nodejs
	#sudo npm update -g
	#sudo npm install -g selenium-webdriver crypto isarray inherits node-inspector supervisor nodemon node-sass request mu2express

	#apt-get install rinetd
	#echo "192.168.50.10 5858 127.0.0.1 5858" >> /etc/rinetd.conf
	#service rinetd restart

	#echo "192.168.50.1 www.mstamlamer.com" >> /etc/hosts

	#cd /vagrant/banksNode
	#npm install -g

	# So that running `vagrant provision` doesn't redownload everything
	touch /.installed
fi


#echo "starting port forwarding"
#modprobe iptable_nat
#echo "1" > /proc/sys/net/ipv4/ip_forward
#iptables -A POSTROUTING -t nat -j MASQUERADE

#echo "Initializing X environment..."

# Start Xvfb, Chrome, and Selenium in the background
#export DISPLAY=:10

#echo "Starting Xvfb ..."
#Xvfb :10 -screen 0 1280x768x24 -ac &

#echo "sleeping 5 seconds"
#sleep 5

#echo "Starting x11vnc"
#x11vnc -ncache 10 -ncache_cr -nap -display :10 -nevershared -forever -o /var/log/x11vnc.log -bg

#echo "sleeping 5 seconds"
#sleep 5

#echo "Starting fvwm2"
#DISPLAY=:10 fvwm -f /vagrant/example.fvwm2rc &

#echo "Starting fluxbox..."
#DISPLAY=:10 fluxbox &

#echo "sleeping 5 seconds"
#sleep 5

#cd /vagrant/banksNode
#su vagrant -c "DISPLAY=:10 node app.js"

#echo "Starting Google Chrome as vagrant user ..."
#su vagrant -c "DISPLAY=:10 /usr/bin/google-chrome --remote-debugging-port=9222 &"

#echo "Forward port 5858 to debug node applications directly from phpstom"
#iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 5858 -j REDIRECT --to-ports 5858


#echo "Starting node-inspector"
#node-inspector &

#echo "Starting banks application in debug mode using node inspector..."
#cd /vagrant/banksNode
#export DISPLAY=:10
#echo "su vagrant -c \"DISPLAY=:10 node-debug app.js\""

# from another terminal for debugging in chrome
#ssh -X vagrant@127.0.0.1 -p 2222
#cd /vagrant/bankNode
#node-debug --cli app.js

#echo "Starting Selenium ..."
#cd /usr/local/bin
#nohup java -jar ./selenium-server-standalone-2.36.0.jar &
