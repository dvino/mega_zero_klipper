#!/bin/sh

cd /home/danil/klipper_config/
git add --no-all . && git commit -m "$1" && git push && echo OK || echo "Somthing wrong"
