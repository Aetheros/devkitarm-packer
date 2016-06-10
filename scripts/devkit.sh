#!/bin/bash
apt-get install -y git mercurial subversion vim curl wget screen automake autoconf libtool cmake

echo "export DEVKITPRO=/home/vagrant/devkitPro" >> ~/.bashrc
echo "export DEVKITARM=/home/vagrant/devkitPro/devkitARM" >> ~/.bashrc
echo "export PATH=$PATH:/home/vagrant/devkitPro/devkitARM/bin" >> ~/.bashrc
source ~/.bashrc


cat <<EOF > /usr/bin/update-devkit
#!/bin/bash

mkdir -p /opt/devkit/
cd /opt/devkit/
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
./devkitARMupdate.pl

echo "removing updater script to prevent accidental execution"

rm devkitARMupdate.pl
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
if ![ -d /home/vagrant/sf2dlib ]; then
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

/usr/bin/update-devkit
/usr/bin/update-portlibs
/usr/bin/update-sflibs

echo "chowning all files in vagrant folder"

chown -R vagrant:vagrant /home/vagrant/