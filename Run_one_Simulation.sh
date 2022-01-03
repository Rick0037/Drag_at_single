#!/bin/bash
# first argument is the number of the 'Run_' folder that will run the simulation
# second argument is the generation to evaluate
# third argument is the individual to evaluate

MATLAB_PATH=/usr/local/MATLAB/R2016b/bin/

## Go to good run folder
cd Run_$1/
# Restart
rm Code_Output/* #Clean before the simulation
# cp Code_Output_Init/* Code_Output/ #CP the first time steps

## Initialization
./Choose_individual.sh $2 $3 #cycle set_type number_set

## Run
rm -f Evaluate_Barrier
touch Evaluate_Barrier
${MATLAB_PATH}/matlab -nodesktop -nosplash -r "Control;"
#./UNS3 

if [ -f "Covergent_Barrier" ];then
# pkill UNS3
rm -f Covergent_Barrier
fi

## Compute cost function
cd ../MLC/Plant/Pinball/Cost_evaluation01/ 
${MATLAB_PATH}/matlab -nodesktop -nosplash -r "Cost_Function($4,$1,$2,$3,600,750);"

## Save sensors and restart
cd ../../../..
mv Run_$1/Sensor_feedback/Coe_sensors.dat $WORKDIR PinballMF/OUTPUT/SS/${4}Set${2}_${3}sensors.dat
cp Run_$1/Sensor_feedback/Coe_sensors_${4}.dat Run_$1/Sensor_feedback/Coe_sensors.dat
cp Forces_Data/${4}Gen${2}Ind${3}.mat $WORKDIR PinballMF/OUTPUT/Forces_Data/
cp Costs/${4}Gen${2}Ind${3}.dat $WORKDIR PinballMF/OUTPUT/Costs/
