# TDOA Analysis using 3 Receivers

I have recreated the orignal work done by Mr. Stephan Schols. Look at this link for details
</href>https://panoradio-sdr.de/tdoa-transmitter-localization-with-rtl-sdrs/</href>


## Dependencies

#### In hardware you require

1) Raspberry Pi x3 (prefered pi 4 model B atleast 4GB ram for compatibility with the image file i have uploaded)
2) RTL-SDR dongle with antennas x3
3) A linux or windows device which will be the master (mine is windows)
4) Reference transmitter (i used a RF generator with an antenna)
5) SD cards x3 (atleast 60GB if you want to use my image file)

#### In software you require
Image file - https://drive.google.com/file/d/1xa8mWtndhKY6qkQ31XBF7CgiDpq9lKfB/view?usp=sharing

* **If you cant use this image file then download librtlsdr-2freq library on raspberry pi via** ```git clone https://github.com/DC9ST/librtlsdr-2freq – librtlsdr-2freq``` which i will explain in furthur slides
* </href>https://github.com/DC9ST/librtlsdr-2freq – librtlsdr-2freq</href>, the modified librtlsdr for switching frequencies during reception
* </href>https://github.com/DC9ST/rtl-sdr-data-read</href> – a matlab script for reading data recorded with the “rtl_sdr” command
* </href>https://github.com/DC9ST/tdoa-evaluation-rtlsdr</href> – Matlab/Octave scripts to perform multilateration with TDOA

## Operating raspberry pies
For turning on raspberry pies you need to first flash a micro SD-card with a compatible OS. Since raspberry pi does not have a secondary storage attached to it this micro sd-card acts as a secondary memory for the device
in windows you can just flash your sd card with raspbian os. There are plenty of resources on how to do it online. 

If you want to flash using my given image file use win32diskimager. write into the sd-card then open the file and create a .sh file if not there. then in config.sh replace ssid and password with your own wifi. Eject 
and connect the sd-card to raspberry pi

now connect power usb cable with raspberry pi and you are ready. Make sure 

## SSH connection with raspberry pi (windows users)
My raspberry pis cannot connect with institute wifi due to different security protocol therefore i used my laptop hotspot. This limits range to 1-2m but you can use wide network if available and only requires password for login

after connecting check their ip addresses

```

ssh-keygen -t ed25519 -C "WSL to Pi"
#replace ip with actuall ip. It should look something like 192.168.137.50

type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh alarm@ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
#will ask for password type alarm
```
now you can ssh into raspberry pies via

``` ssh alarm@ip ```

## Installation

In raspberry pi install the library
```git clone https://github.com/DC9ST/librtlsdr-2freq – librtlsdr-2freq``` 
and you are ready

Copy this code and create a tdoa.sh bash file and paste it there. Replace ip with raspberry pi ips
```
#!/bin/bash
echo "-------------------------------------"
if [ "$#" -ne 3 ]; then
  echo "parameters missing, call: <scriptname> freq1 freq2 num_samples"
  exit 1
fi

freq1="$1"
freq2="$2"
num_samples="$3"

# OUTPUT PATH: I converted your Windows path to a WSL-compatible format.
# If using Git Bash, change '/mnt/c/' to '/c/'.
DEST_DIR="/mnt/c/Users/Divyansh Kumar/Desktop/Collage stuff/BTP_Seshan_sir/scripts/recorded_data"

echo "Specified parameters: reference frequency: $freq1, measure frequency: $freq2, samples_per_freq: $num_samples"
echo "--------------------------------------"

echo "Login to PI Radios and capture data simultaneously"

# Pi 1 (192.168.137.50) -> Saves to 1_test.dat
ssh alarm@ip "/home/alarm/librtlsdr-2freq/build/src/rtl_sdr -f $freq1 -h $freq2 -n $num_samples 1_test.dat" &

# Pi 2 (192.168.137.55) -> Saves to 2_test.dat
ssh alarm@ip "/home/alarm/librtlsdr-2freq/build/src/rtl_sdr -f $freq1 -h $freq2 -n $num_samples 2_test.dat" &

# Pi 3 (192.168.137.3) -> Saves to 3_test.dat [NEW]
ssh alarm@ip  "/home/alarm/librtlsdr-2freq/build/src/rtl_sdr -f $freq1 -h $freq2 -n $num_samples 3_test.dat" &

# Wait ensures the script pauses here until ALL background SSH commands finish
wait

echo "Data capture finished on all devices."
echo "--------------------------------------"
echo "Copy received data to the master"

# Copy files back to the Windows PC
scp alarm@ip:/home/alarm/1_test.dat "$DEST_DIR"
scp alarm@ip:/home/alarm/2_test.dat "$DEST_DIR"
scp alarm@ip:/home/alarm/3_test.dat  "$DEST_DIR"

echo "All files transferred successfully."
```

save it and then run using
``` ./tdoa.sh freq1 freq2 1200000 ```

replace freq1 with unknown Tx freq and freq2 with reference Tx freq 

## Matlab script
run the main matlab file after installing it and run it
   
