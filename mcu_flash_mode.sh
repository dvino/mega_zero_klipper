#!/bin/bash
echo 6 > /sys/class/gpio/export
echo 7 > /sys/class/gpio/export
sleep 0.5

echo out > /sys/class/gpio/gpio6/direction
echo out > /sys/class/gpio/gpio7/direction

echo 0 > /sys/class/gpio/gpio6/value

echo 0 > /sys/class/gpio/gpio7/value
sleep 0.5
echo 1 > /sys/class/gpio/gpio7/value
sleep 2

mount /home/danil/mnt

