# Build and install the latest version of tor for debian-based systems

dpkg -l tor

apt install -y build-essential fakeroot devscripts
apt build-dep -y tor deb.torproject.org-keyring
mkdir ~/debian-packages; cd ~/debian-packages
apt source tor
cd tor-*
debuild -rfakeroot -uc -us
cd ..
dpkg -i tor_*.deb

dpkg -l tor
