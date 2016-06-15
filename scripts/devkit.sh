#!/bin/bash
apt-get install -y git mercurial subversion vim curl wget screen automake autoconf libtool cmake autogen

echo "export DEVKITPRO=/home/vagrant/devkitPro" >> ~/.bashrc
echo "export DEVKITARM=/home/vagrant/devkitPro/devkitARM" >> ~/.bashrc
echo "export PATH=$PATH:/home/vagrant/devkitPro/devkitARM/bin" >> ~/.bashrc
source ~/.bashrc

export DEVKITPRO=/home/vagrant/devkitPro
export DEVKITARM=/home/vagrant/devkitPro/devkitARM
export PATH=$PATH:/home/vagrant/devkitPro/devkitARM/bin

cat <<EOF > /usr/bin/update-devkit
#!/bin/bash

if [ "\$USER" = "root" ]
then
	echo "Please do not run this script as root!"
	exit
fi

mkdir -p /home/vagrant/devkitupdate
cd /home/vagrant/devkitupdate
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
rm -rf /home/vagrant/devkitupdate

echo "removing updater script to prevent accidental execution"

rm devkitARMupdate.pl

git clone https://github.com/smealum/ctrulib.git
cd ctrulib
git reset --hard #2810c4d3a
cd libctru 
make install
rm -rf ctrulib

git clone --recursive https://github.com/Kingcom/armips.git
cd armips
cmake ./
make
mv armips ~/devkitpro/devkitARM/bin
cd ..
rm -rf armips

mkdir bin2c
cd bin2c
curl -L http://astronautlevel.webege.com/bin2c.c -o bin2c.c
gcc bin2c.c -o bin2c
mv bin2c ~/devkitpro/devkitARM/bin
cd ..
rm -r bin2c

git clone --recursive https://github.com/profi200/Project_CTR.git
cd Project_CTR/makerom
make
mv makerom ~/devkitpro/devkitARM/bin
cd ../..
rm -rf Project_CTR

git clone --recursive https://github.com/fincs/picasso.git
cd picasso
./autogen.sh
./configure
make
mv picasso ~/devkitpro/devkitARM/bin
cd ../
rm -rf picasso

git clone --recursive https://github.com/Steveice10/citrus.git
cd citrus
make install
cd ../
rm -rf citrus

git clone --recursive https://github.com/fincs/citro3d.git
cd citro3d
make install
cd ../
rm -rf citro3d

git clone --recursive https://github.com/Steveice10/bannertool.git
cd bannertool
make install
cd ..
rm -rf bannertool

EOF


cat <<EOF > /usr/bin/update-portlibs
#!/bin/bash

cd /home/vagrant/
git clone "https://github.com/devkitPro/3ds_portlibs.git"
cd "3ds_portlibs"
git pull
make clean
make zlib
make install-zlib
make freetype 
make libexif 
make libjpeg-turbo 
make libpng
make libconfig
make jansson
make libxmp-lite
make sqlite
make tinyxml2
make install

EOF

cat <<EOF > /usr/bin/update-sflibs
#!/bin/bash

mkdir -p /home/vagrant/sflibs/
cd /home/vagrant/sflibs/
if ! [ -d '/home/vagrant/sf2dlib' ]; then
	git clone https://github.com/xerpi/sf2dlib.git
	git clone https://github.com/xerpi/sftdlib.git
	git clone https://github.com/xerpi/sfillib.git
fi

cd sf2dlib/
git pull
cd libsf2d

make clean all install

cd ../../sftdlib
git pull
cd libsftd

make clean all install

cd ../../sfillib
git pull
cd libsfil

make clean all install
EOF

chmod a+x /usr/bin/update-devkit /usr/bin/update-portlibs /usr/bin/update-sflibs


mkdir -p /home/vagrant/devkitupdate
cd /home/vagrant/devkitupdate
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
./devkitARMupdate.pl

echo "removing updater script to prevent accidental execution"

rm -rf /home/vagrant/devkitupdate

git clone https://github.com/smealum/ctrulib.git
cd ctrulib
git reset --hard #2810c4d3a
cd libctru 
make install
rm -rf ctrulib

git clone --recursive https://github.com/Kingcom/armips.git
cd armips
cmake ./
make
mv armips ~/devkitpro/devkitARM/bin
cd ..
rm -rf armips

mkdir bin2c
cd bin2c
curl -L http://astronautlevel.webege.com/bin2c.c -o bin2c.c
gcc bin2c.c -o bin2c
mv bin2c ~/devkitpro/devkitARM/bin
cd ..
rm -r bin2c

git clone --recursive https://github.com/profi200/Project_CTR.git
cd Project_CTR/makerom
make
mv makerom ~/devkitpro/devkitARM/bin
cd ../..
rm -rf Project_CTR

git clone --recursive https://github.com/fincs/picasso.git
cd picasso
./autogen.sh
./configure
make
mv picasso ~/devkitpro/devkitARM/bin
cd ../
rm -rf picasso

git clone --recursive https://github.com/Steveice10/citrus.git
cd citrus
make install
cd ../
rm -rf citrus

git clone --recursive https://github.com/fincs/citro3d.git
cd citro3d
make install
cd ../
rm -rf citro3d

git clone --recursive https://github.com/Steveice10/bannertool.git
cd bannertool
make install
cd ..
rm -rf bannertool

cd /home/vagrant/
git clone "https://github.com/devkitPro/3ds_portlibs.git"
cd "3ds_portlibs"
git pull
make clean
make zlib
make install-zlib
make freetype 
make libexif 
make libjpeg-turbo 
make libpng
make libconfig
make jansson
make libxmp-lite
make sqlite
make tinyxml2
make install
cd ..

mkdir -p /home/vagrant/sflibs/
cd /home/vagrant/sflibs/
if ! [ -d '/home/vagrant/sf2dlib' ]; then
	git clone https://github.com/xerpi/sf2dlib.git
	git clone https://github.com/xerpi/sftdlib.git
	git clone https://github.com/xerpi/sfillib.git
fi

cd sf2dlib/
git pull
cd libsf2d

make clean all install

cd ../../sftdlib
git pull
cd libsftd

make clean all install

cd ../../sfillib
git pull
cd libsfil

make clean all install

echo "chowning all files in vagrant folder"


cd /home/vagrant/

chown -R vagrant:vagrant /home/vagrant/