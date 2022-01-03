#!/bin/bash

## Change Tmax in Code_Input/CONTROL and Control.m for each Run_*
ls -d1 Run_*/ | xargs -n 1 bash -c 'sed -i -e "s/.*\(Tmax\)/$0         \1/" ./$1Code_Input/CONTROL; sed -i -e "s/\(while T < \).*/\1$0/" ./$1Control.m; sed -i -e "s+\(Tmax=\).*+\1$0+" ./$1save_for_movie.sh' $1

## Change Tmax in the script that launches one simulation
sed -i -e "s/\(Cost_Function_MLC(\$1,\$2,\$3,400,\).*/\1$1);\"/" Run_one_Simulation.sh


### Change in the extraction script
#sed -i -e "s/\(tend = \).*/\1$1;/" LGP/Distance2BT2/Extract_sensor_signal.m
