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

touch /usr/bin/update-devkit.sh
chmod a+x /usr/bin/update-devkit.sh
cat <<EOF > /usr/bin/update-devkit.sh
#!/bin/bash
echo 'updating devkit'
cd /home/vagrant/
./devkitARMupdate.pl

echo 'removing downloaded files'
rm *.tar.bz2
EOF

