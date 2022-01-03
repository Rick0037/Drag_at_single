This folder is about the feedback control at a single condiation
and do some law Re robust test in this folder.
the suimlation will start at tstart=500s,  finish at tend=750s. 
start compute cost at 600s


### Get start for single Re 

In single  learning we start the sumilation in 20 process, So we have 20 Run_$x   folder to run.

In this folder you can copy  and rename until 20 folders.

the way to start to the  sumulations 

1. Generate the population in xMLC External_evaluation_START.m
- Initialization;
- mlc=MLC('Pinball');
- mlc.generate_population;
- mlc.save_matlab('Gen0');

2. you need to change, accordingly to your case (Re) in Run\_1 (then a shell will modify the others):
- Code_Input: the Reynolds number in PROPERTIES, the Restart\_unsteady file corresponding to your Reynolds number;
- Control.m: Re (used to compute the drag and lift coefficients) and populationpath (l.71) corresponding to the LGPC save in folder Run_1 
- Sensor_feedback: Coe\_sensors.dat (the sensors information for previous times) and Sensor\_MLC.m for the noise level (C l.6)

3. and copy to other Run_x  folder. You can open a terminal    ./changeInput.sh

4. change the xMLC save name external file (for example 'Pinball53') population External\_evaluation\_CONTINUE.m External\_evaluation\_END.m 

5. open one octave in each Run_x folder to run      startSimu.m      finally open 20 octave to wait

6. start to run open a terminal    ./LGP.sh


### Get start for Re robust test
We reevaluate the best individuals from all Re optimization process in the 5 other Reynolds numbers (Re=30,...,120)

1. In this case, we only use one folder Run_30.
Record the best individual in each folder in dragtest.m  line 16 to line 21 
there is three parameter [the simulation number XX (PinballXX) ,  generation number , individual number] 
The individual number is found with the command: MLC.population(10).CreationOrder(1).
Like PInball53 run best individual is 10,7.  we can write [53,10,7].

2. open the ocatve run startSimu.m wait

3. run the dragtest.m it will call robustsumlit.m to change the Contolindiv.m to control.m 

4. It will auto generate figures for one law cost in five condition or five law comparsion.

## The following is explanation of the main scripts and functions used in the previous sections
### Some shell tools  

Here is the code for Bash Shell in varying learning condition.
    
    LGPC.sh      is the for the start LGPC learning in single Re.
    
    Evaluation_geni_$x .sh     is  for one generation's simulation 
    
    Run_multiple_Simulations.sh      is for one generations in several individual 

    Run_one_Simulation.sh       is for one individual learning simulate in several Re 

And other is change some smalll tools 

    changeInput.sh      when we change conditions in Run_1 readly copy to other folder.

    clearnOutput.sh   clearn each folder Code_Output  snapshot 

    ChangeRe.sh   change the Re In Code_Input/  
    
    ChangeTmax.sh change the Tmax in Run_one_Simulation.sh

    FastFT.m used the Fourier Transform  to analysis the  frequency in singnal.


### Some changes in xMLC  in single Re learning 

Some change at MATLAB xMLC file
    In MLC_tools/   path 
        1.change    External_build_matJ.m                 build cost value in '../PinballMF/OUTPUT/Costs', add the Re parameter
        2.change    External_evaluation_CONTINUE.m      for varying learning  External_evaluation_CONTINUE(gen,Re);
        3.change    External_evaluation_END.m                   for varying learning  External_evaluation_END(gen,Re);

    In Plants/  path
        1.change PInball_parameters.m       line58 :         ProblemParameters.EstimatePerformance = 'last';     used last
        2.change the cost function file    we add Re in function input. we used MLC/Plant/Cost_evaluation01/Cost_Function



### Data to Record

## Single Re condition Data
when we finish one whole Run, we will  save in Run_record/

1. mkdir a folder like mkdir Datarun43 

2. and copy the output file PInballMF/OUTPUT (force, sensor ) under Datarun43

3. copy the population like MLC/save_runs/PInball43 the whole pop

4. copy the parameter file in MLC/Plant/Pinball_parameters.m  for this Run.

## Robust test Data
when we finish robust test , we will  save in Run_record/

1. mkdir a folder like robust 

2. copy robust and rename the folder robust 0.5

3. copy the robust test configuration file Run_30/testdrag.m 


### Run_x    each  subfolder - Details

1. Code_Input       ./new_flowstate/   it include the new flow start state in Re=30,60,80,100,120 from natural flow in 500s 

2. Code_Source      x_m_v_t3.f  line381: add    call system('touch Covergent_Barrier')  when the law is not convergant we can find and in the Bash Shell  One_Simulation.sh line 29 we can skill this individual continue Run this generation and next gen

3. MatlabV3     for see flow field and movie,  nVortFiled(Ntint, Ntend) ,  VortField(Nt),  Vortmove(Ntint, Ntend) save as  .avi

4. Sensor_feedback    Sensor_MLC.m compute sensor coefficent in snapshot and give value in law calculate Cd, Cl, Cldelay.m

5. Sensor_feedback  Coe_sensors.dat, Coe_sensor_30.dat et al. each have a initial coefficent value in 450s-500s 
Coe_sensor.dat have seven line    Time        Cd        Cl        Cl delay       Cd noise      Cl noise   Cl delay noise
and in Sensor_MLC  line 6 C=0; means the noise level    line 141   line 155 the folumate to calculate add noise part.

6. V3            Visualization file used in Tecplot to show the vortex flow filed.

7. Choose_individual.sh   change gen ind be used in  Run_one_Simulation.sh


### Run_30 subfolder for the robutness test - Details

1. Controlindiv.m       load the special individual in MLC/save_runs    Controlindiv(folder,gen,ind);

2. robustsumlit.m      change the Re in different condition 

3. dragtest.m                configuration  file add best law        dragtest->robustsumit->Controlindiv



### How to change the noise 
In different noise level we can change Sensor_feedback/Sensor_MLC.m in line 6 C with the range 0 to 1



