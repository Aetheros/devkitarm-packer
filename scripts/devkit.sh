#!/bin/bash
cd ~
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
./devkitARMupdate.pl

echo "export DEVKITPRO=/home/vagrant/devkitPro" >> ~/.bashrc
echo "export DEVKITARM=/home/vagrant/devkitPro/devkitARM" >> ~/.bashrc
echo "export PATH=$PATH:/home/vagrant/devkitPro/devkitARM/bin" >> ~/.bashrc
source ~/.bashrc

rm *.tar.bz2
rm devkitARMupdate.pl

touch /usr/bin/update-devkit.sh
chmod a+x /usr/bin/update-devkit.sh
cat <<EOF > /usr/bin/update-devkit.sh
#!/bin/bash
echo 'updating devkit'
cd ~
wget http://jaist.dl.sourceforge.net/project/devkitpro/Automated%20Installer/devkitARMupdate.pl
chmod a+x devkitARMupdate.pl
./devkitARMupdate.pl

while getopts ":-:" opt; do
    case \${opt} in
		-)
			case "\${OPTARG}" in
				keep-files)
					echo "Keeping downloaded files in home directory, you should move them out of there."
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