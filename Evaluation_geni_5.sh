#!/bin/bash
#PBS -N Geni_1
#PBS -l nodes=1:ppn=8,mem=8gb
#PBS -l walltime=24:00:00
#PBS -o my_job_i_1.out
#PBS -e my_job_i_1.err	
#PBS -V


#**************************************************************************************
#-------------------------------Variables globales-------------------------------------
GEN_NO=5
Re=$1
MAIN_DIRECTORY=${PBS_O_HOME}PinballMF//Pinball_MLC//
OUTPUT_DIRECTORY=${WORKDIR}PinballMF/OUTPUT/
SUBMISSION_DIRECTORY=${PBS_O_HOME}PinballMF//Submission/

#--------------------------------------------------------------------------------------
#**************************************************************************************


#**************************************************************************************
#-------------------------------On se place dans le TMPDIR-----------------------------

#**************************************************************************************
#-------------------------Transfert des données pour le calcul-------------------------

cp -r ${MAIN_DIRECTORY}/* ./ 

#--------------------------------------------------------------------------------------
#**************************************************************************************


#**************************************************************************************
#---------------------------------------Traitements------------------------------------
#PARAMETERS
./ChangeRe.sh $Re #Re (100)
./ChangeTmax.sh 750 



#EVALUATION
#cd ..
./Run_multiple_Simulations.sh 1 $GEN_NO 1 5 $Re &
./Run_multiple_Simulations.sh 2 $GEN_NO 6 10 $Re &
./Run_multiple_Simulations.sh 3 $GEN_NO 11 15 $Re & 
./Run_multiple_Simulations.sh 4 $GEN_NO 16 20 $Re &
./Run_multiple_Simulations.sh 5 $GEN_NO 21 25 $Re &
./Run_multiple_Simulations.sh 6 $GEN_NO 26 30 $Re &
./Run_multiple_Simulations.sh 7 $GEN_NO 31 35 $Re &
./Run_multiple_Simulations.sh 8 $GEN_NO 36 40 $Re &
./Run_multiple_Simulations.sh 9 $GEN_NO 41 45 $Re &
./Run_multiple_Simulations.sh 10 $GEN_NO 46 50 $Re &
./Run_multiple_Simulations.sh 11 $GEN_NO 51 55 $Re &
./Run_multiple_Simulations.sh 12 $GEN_NO 56 60 $Re &
./Run_multiple_Simulations.sh 13 $GEN_NO 61 65 $Re &
./Run_multiple_Simulations.sh 14 $GEN_NO 66 70 $Re &
./Run_multiple_Simulations.sh 15 $GEN_NO 71 75 $Re &
./Run_multiple_Simulations.sh 16 $GEN_NO 76 80 $Re &
./Run_multiple_Simulations.sh 17 $GEN_NO 81 85 $Re &
./Run_multiple_Simulations.sh 18 $GEN_NO 86 90 $Re &
./Run_multiple_Simulations.sh 19 $GEN_NO 91 95 $Re &
./Run_multiple_Simulations.sh 20 $GEN_NO 96 100 $Re &

wait

#--------------------------------------------------------------------------------------
#**************************************************************************************
