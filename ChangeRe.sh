#!/bin/bash
ls -d1 Run_*/ | xargs -n 1 bash -c 'sed -i -e "s/.*\(.0  50.0\)/$0.0  \1/" ./$1Code_Input/PROPERTIES' $1

