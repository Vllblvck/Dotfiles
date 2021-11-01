#/bin/bash

REMOTE="google_drive"
SOURCES=("$HOME/Documents/DigitalGarden/" "$HOME/next-cloud/Passwords.kdbx")
DESTINATIONS=("DigitalGarden/" "Documents/")

if [[ "${#SOURCES[@]}" -ne "${#DESTINATIONS[@]}" ]]
then
  echo "Number of SOURCES and DESTINATIONS is not equal"
  exit 1
fi

for i in "${!SOURCES[@]}"
do
  rclone copy "${SOURCES[i]}" "$REMOTE":"${DESTINATIONS[i]}" -P
done
