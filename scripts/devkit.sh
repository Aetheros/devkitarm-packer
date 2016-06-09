#!/bin/bash
cd /home/vagrant/
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
./devkitARMupdate.pl
cat <<EOF >> /home/vagrant/.profile
if [ -d '/home/vagrant/devkitPro' ] ; then
	DEVKITPRO = 'home/vagrant/devkitPro'
	DEVKITARM = '$DEVKITPRO/devkitARM'
	export DEVKITPRO=$DEVKITPRO
	export DEVKITARM=$DEVKITARM
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

while getopts ":-:" opt; do
    case ${opt} in
		-)
			case "${OPTARG}" in
				keep-files)
					echo "Keeping downloaded files"
					exit 0
					;;
				*) 
					echo "Invaild option: -$optarg. Proceeding to remove downloaded files!" >&2
					;;
			esac
		\?)
			echo "Invaild option: -$optarg. Proceeding to remove downloaded files!" >&2
			;;
	esac
done
echo 'removing downloaded files'
rm *.tar.bz2
EOF