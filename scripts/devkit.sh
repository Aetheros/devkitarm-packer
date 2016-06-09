#!/bin/bash
cd /home/vagrant/
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
./devkitARMupdate.pl
cat <<EOF > /home/vagrant/.profile
if [ -d '/home/vagrant/devkitPro' ] ; then
	DEVKITPRO = 'home/vagrant/devkitPro'
	DEVKITARM = '$DEVKITPRO/devkitARM'
fi
EOF

rm *.tar.bz2