echo "Начинаю процесс установки"

echo -ne '\n' | sudo add-apt-repository ppa:daniestevez/gr-satellites
echo -ne '\n' | sudo add-apt-repository ppa:gnuradio/gnuradio-releases

sudo apt-get update

echo "Установка необходимых для GNURadio библиотек"
sudo apt-get install git python3-pip libboost-all-dev swig libcppunit-dev libfftw3-dev alsa-utils doxygen cmake libusb-1.0-0-dev libgsl-dev osspd -y

sudo pip3 install --upgrade pip -y

sudo pip3 install mako numpy Cheetah3 -y

echo "Установка GNURadio самой новой версии"
sudo apt-get install gnuradio -y python3-packaging -y

echo "Установка gr-satellites"
sudo apt-get install gr-satellites

echo "Установка драйверов и библиотке для RTL SDR"
sudo apt-get install rtl-sdr -y

sudo apt-get install libusb-1.0-0-dev -y
cd ~
git clone https://github.com/steve-m/librtlsdr.git
cd librtlsdr
mkdir build
cd build/
cmake ../
make
sudo make install
sudo ldconfig

echo "Установка gr-osmosdr"
sudo apt-get install gr-osmosdr -y

echo "Дополнительные библиотеки"
sudo apt-get install automake -y
cd ~
git clone https://github.com/jgaeddert/liquid-dsp.git
cd liquid-dsp
./bootstrap.sh
./configure
make
sudo make install
sudo ldconfig

echo "Библиотеки и драйвера для Lime SDR"
cd ~
sudo apt-get install gr-limesdr -y
sudo apt install limesuite liblimesuite-dev limesuite-udev soapysdr-module-lms7 -y

echo "Настройка конфига для RTL SDR"
cd /etc
cd modprobe.d
sudo touch blacklist-dvb.conf
echo "blacklist dvb_usb_rtl28xxu
blacklist rtl2832
blacklist rtl2830" blacklist-dvb.conf
