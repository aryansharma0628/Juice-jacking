#!/bin/bash

# Check if a device is connected
adb_device=$(adb devices | grep "device$")
if [ -z "$adb_device" ]; then
  echo "No device connected. Please connect your Android device with ADB enabled."
  exit 1
fi

# Create a directory to store the pulled files
backup_dir="sdcard_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p $backup_dir

# Check if SD card is mounted
sd_card_path=$(adb shell "echo \$EXTERNAL_STORAGE")
if [ -z "$sd_card_path" ]; then
  echo "No SD card found or unable to access the SD card."
  exit 1
fi

# Pull all files from the SD card
echo "Pulling all files from the SD card at $sd_card_path..."
adb pull "$sd_card_path/" "$backup_dir/"

# Check if the pull was successful
if [ $? -eq 0 ]; then
  echo "All files pulled successfully to $backup_dir."
else
  echo "Failed to pull files from the SD card."
fi
