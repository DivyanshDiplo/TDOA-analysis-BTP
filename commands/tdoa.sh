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
ssh alarm@192.168.137.50 "/home/alarm/librtlsdr-2freq/build/src/rtl_sdr -f $freq1 -h $freq2 -n $num_samples 1_test.dat" &

# Pi 2 (192.168.137.55) -> Saves to 2_test.dat
ssh alarm@192.168.137.55 "/home/alarm/librtlsdr-2freq/build/src/rtl_sdr -f $freq1 -h $freq2 -n $num_samples 2_test.dat" &

# Pi 3 (192.168.137.3) -> Saves to 3_test.dat [NEW]
ssh alarm@192.168.137.3  "/home/alarm/librtlsdr-2freq/build/src/rtl_sdr -f $freq1 -h $freq2 -n $num_samples 3_test.dat" &

# Wait ensures the script pauses here until ALL background SSH commands finish
wait

echo "Data capture finished on all devices."
echo "--------------------------------------"
echo "Copy received data to the master"

# Copy files back to the Windows PC
scp alarm@192.168.137.50:/home/alarm/1_test.dat "$DEST_DIR"
scp alarm@192.168.137.55:/home/alarm/2_test.dat "$DEST_DIR"
scp alarm@192.168.137.3:/home/alarm/3_test.dat  "$DEST_DIR"

echo "All files transferred successfully."
