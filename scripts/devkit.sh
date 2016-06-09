#!/bin/bash

apt-get update
apt-get -y install make automake autoconf gcc 
cd /opt/
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
./devkitARMupdate.pl

echo "export DEVKITPRO=/opt/devkitPro" >> ~/.bashrc
echo "export DEVKITARM=/opt/devkitPro/devkitARM" >> ~/.bashrc
echo "export PATH=$PATH:/opt/devkitPro/devkitARM/bin" >> ~/.bashrc
source ~/.bashrc

rm *.tar.bz2
rm devkitARMupdate.pl

touch /usr/bin/update-devkit.sh
chmod a+x /usr/bin/update-devkit.sh
cat <<EOF > /usr/bin/update-devkit.sh
#!/bin/bash
if [ "\$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo 'updating devkit'
cd /opt/
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
./devkitARMupdate.pl

while getopts ":-:" opt; do
    case \${opt} in
		-)
			case "\${OPTARG}" in
				keep-files)
					echo "Keeping downloaded files in opt directory, you should move them out of there."
					exit 0
					;;
				*) 
					echo "Invaild option: -\$optarg. Proceeding to remove downloaded files!" >&2
					;;
			esac
		\?)
			echo "Invaild option: -\$optarg. Proceeding to remove downloaded files!" >&2
			;;
	esac
done
echo 'removing downloaded files'
rm *.tar.bz2
rm devkitARMupdate.pl
EOF