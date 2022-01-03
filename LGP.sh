#!/bin/bash
# Finish the first population and to evaluation and evolution 
# need to change the pop in the external_evaluation_continue(gen,Re)
# and finish the external_evaluation_finish(gen,Re) 
# change the folder name before anything! 

Re=100
pop=1
MATLAB_PATH=/usr/local/MATLAB/R2016b/bin/

#maxpop is the final pop 
maxpop=10

while [ "$pop" != "$maxpop" ]
do
./Evaluation_geni_$pop.sh $Re
cd MLC/MLC_tools/
${MATLAB_PATH}/matlab -nodesktop -nosplash -r "	External_evaluation_CONTINUE($pop,$Re);"
cd ../../
	pop=$(($pop+1))
done

./Evaluation_geni_$pop.sh
cd MLC/MLC_tools/
${MATLAB_PATH}/matlab -nodesktop -nosplash -r "	External_evaluation_END($pop,$Re);"
