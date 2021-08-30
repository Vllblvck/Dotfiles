#!/bin/bash

dunstMsgId="696969"
hours=0
minutes=0
seconds=0

while getopts :h:m:s: option; do
  case "${option}" in
    h ) hours=${OPTARG} ;;
    m ) minutes=${OPTARG} ;;
    s ) seconds=${OPTARG} ;;
    \? ) echo "Usage: [-h] number [-m] number [-s] number" ;;
    : ) echo "Invalid option: $OPTARG requires a number" ;;
  esac
done

timeLeft=$(($hours * 3600 + $minutes * 60 + $seconds))
while [[ $timeLeft -gt 0 ]]; do
  clear
  timeLeft=$(($timeLeft - 1))
  hoursLeft=$(($timeLeft / 3600))
  minutesLeft=$(($timeLeft % 3600 / 60))
  secondsLeft=$(($timeLeft % 60))
  echo "  $hoursLeft h  $minutesLeft m  $secondsLeft s"
  sleep 1
done

echo "  TIME IS UP!!!"
