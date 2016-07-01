prestaShopFile=prestashop_1.6.1.6.zip

echo "Actualizando la lista de paquetes..."
sudo apt-get -qq update

sudo apt-get install -y software-properties-common python-software-properties python-pycurl

#sudo apt-get update

sudo add-apt-repository -y ppa:ondrej/php
sudo add-apt-repository -y ppa:ondrej/apache2
sudo apt-get -qq update

#deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main 
#deb-src http://ppa.launchpad.net/ondrej/php/ubuntu trusty main 

#sudo apt-get update

echo ">>>> Instalando Apache 2"
sudo apt-get install -y apache2


# export DEBIAN_FRONTEND=noninteractive


echo ">>>> Instalando PHP 5.6"
echo "-------------------------------"
sudo apt-get install -y -qq wget php5.6
echo ">>>> Instalando libapache2-mod-php5.6"
sudo apt-get install -y -qq libapache2-mod-php5.6
echo ">>>> Instalando librería GD"
sudo apt-get install -y -qq php5.6-gd
echo ">>>> Instalando el servidor MySQL"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password prestashop'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password prestashop'
sudo apt-get install -y -qq mysql-server-5.5
sudo apt-get install -y php5.6-xml
sudo apt-get install -y php5.6-mcrypt
sudo apt-get install -y php5.6-mbstring
sudo apt-get install -y php5.6-mysql

sudo a2enmod rewrite

rm -rf /var/www/html

ln -fs /vagrant /var/www/html

sudo service apache2 restart

# 
cd /home/vagrant

# Download PrestaShop
echo "Descargando PrestaShop"
echo "----------------------"
wget https://download.prestashop.com/download/old/$prestaShopFile --no-verbose

# Install PrestaShop
echo "Instalando PrestaShop"
echo "---------------------"
sudo apt-get install -y unzip
cd /var/www/html
unzip -qq /home/vagrant/$prestaShopFile
#mv prestashop/* .
#rm Install_PrestaShop.html

# Create database

mysql -uroot -pprestashop -e 'create database prestashop'
