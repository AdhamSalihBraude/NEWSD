%% TO DO : Write a desciption


%% Variables initialization
clc
clear
clf
close all
k = 1;
GenCounter = 1;
load('tempRun')
gen0 = GenCounter;
addpath('RobotNav')
addpath('CommonFunc')
stat = 31;
while k < stat + 1
    if gen0 == 1
        %crossover
        crossover.percentage=0.8; %percentage governs the way in which new population will be composed from old population.  exception: species with just one individual can only use mutation
        crossover.probability_interspecies=0.2 ; %if crossover has been selected, this probability governs the intra/interspecies parent composition being used for the
        crossover.probability_multipoint=0.6; %standard-crossover in which matching connection genes are inherited randomly from both parents. In the (1-crossover.probability_multipoint) cases, weights of the new connection genes are the mean of the corresponding parent genes
        crossover.SBXprop = [0.8,0.1]; %first is the probability second is the distibution
        ForSave(1).EP = [];
        %mutation
        mutation.probability_add_node=0.3;
        mutation.probability_add_connection=0.3;
        mutation.probability_recurrency=0.0; %if we are in add_connection_mutation, this governs if a recurrent connection is allowed. Note: this will only activate if the random connection is a recurrent one, otherwise the connection is simply accepted. If no possible non-recurrent connections exist for the current node genes, then for e.g. a probability of 0.1, 9 times out of 10 no connection is added.
        mutation.probability_mutate_weight=0.6;
        mutation.weight_cap=5; % weights will be restricted from -mutation.weight_cap to mutation.weight_cap
        mutation.weight_range=2; % random distribution with width mutation.weight_range, centered on 0. mutation range of 5 will give random distribution from -2.5 to 2.5
        mutation.probability_gene_reenabled=0.25; % Probability of a connection gene being reenabled in offspring if it was inherited disabled
        mutation.pol = [0.2,15];
        mutation.adaptiverate = [mutation.weight_range,0.2]; %step = a1*exp(-a2*gen)
        selectionMode = 'T3'; % 'R' for roulate selection per problems and 'T' for tur-selection
        ArenaType = [5 12 8 10 9 14];
        RobotType = 1;
        NumArenas = length(ArenaType);
        TestingArena = 2;
        pltrobot = 0;
        DoF = 3;
        best = [];
        Nt = [];
        rng('default')
        [Robot,RobotType] = RobotCharacteristics(RobotType); %1 for symm-sensing
        if isnan(RobotType)
            return
        end
        
        for ArenaIndex = 1 : NumArenas
            
            Arena(ArenaIndex) = SelectArena(ArenaType(ArenaIndex));
            
%             [RobotoutlineX,RobotoutlineY,SensorX,SensorY] = plotRobot(Arena(ArenaIndex).StartingPoint,Arena(ArenaIndex),Robot);
            
        end
%         for ArenaIndex = 1 : length(TestingArena)
%             
%             GeneralArena(ArenaIndex) = SelectArena(TestingArena(ArenaIndex));
% %             [RobotoutlineX,RobotoutlineY,SensorX,SensorY] = plotRobot(GeneralArena(ArenaIndex).StartingPoint,GeneralArena(ArenaIndex),Robot);
%         end
        figure()
        ComputerID = getenv('computername');
        MaxGen = 300;
        PopSize = 300;
        initialMaxTopologies = 50;
        finalMaxTopologies = 50;
        protectGen = 80;
        nEP = PopSize;
        ObjNum = NumArenas;
        %parameters initial population
        number_input_nodes = Robot.Sensors;%+ Robot.Motors;
        number_output_nodes = Robot.Motors;
        vector_connected_input_nodes=1:number_input_nodes; % Try other initial topologies (not fully connected)
        NSubProblems = 150;
        
        rng('shuffle')
        [population,idealpoint,NSubProblems,SubProblems,innovation_record,TopologyTracker] = initSubProbRobot(PopSize,ObjNum,NSubProblems,vector_connected_input_nodes,number_input_nodes,number_output_nodes,Arena,Robot);
        EP = [];
        EP = updateEP(EP,population,nEP);
        GenCounter = 1;
        pltrobot = 0;
        close all
    end
    for GenCounter = gen0 : MaxGen
        MaxTopologies = 50;
        old_pop = population;
        Ntopologies = 1;
        Iyoung = [];
        for Topologyindex = 1 : length(TopologyTracker)
            if TopologyTracker(Topologyindex).number_individuals ~= 0
                Ntopologies = Ntopologies + 1;
            end
            if GenCounter - TopologyTracker(Topologyindex).gen < protectGen && TopologyTracker(Topologyindex).gen ~= 0
                Iyoung = [Iyoung,Topologyindex];
                TopologyTracker(Topologyindex).protected = 1;
            else
                TopologyTracker(Topologyindex).protected = 0;
            end
        end
        mating_pool = selection(population,SubProblems,TopologyTracker,Iyoung,selectionMode);
        if Ntopologies < MaxTopologies
            [Newindividuals,innovation_record,TopologyTracker] = reproduceTopologies(crossover ,mutation, TopologyTracker ,innovation_record, GenCounter,mating_pool,PopSize,MaxTopologies);
        else
            Newindividuals  = reproduceWeights(crossover, mutation, GenCounter, mating_pool, PopSize);
        end
        Newindividuals = RobotNavcalcfit(Newindividuals, Robot, Arena,pltrobot);
        idealpoint = update_idealpoint(idealpoint,Newindividuals);
        [SubProblems,population,TopologyTracker] = updateSubProblems(SubProblems,Newindividuals,population,idealpoint,TopologyTracker);
        EP = updateEP(EP,Newindividuals,nEP);
        
        %         [~,EP,~] = updateSubProblems(SubProblems,EP,[],idealpoint,TopologyTracker);
        for index_topology=1:size(TopologyTracker,2)
            TopologyTracker(index_topology).number_individuals=sum([population(:).TID]==index_topology);
        end
        numberoftopologies = sum([TopologyTracker(:).number_individuals] ~= 0);
        if rem(GenCounter,50)==0
            disp([GenCounter,idealpoint])
        end
        
        save('tempRun')
    end
    ForSave.EP = EP;
    ForSave.Arena = Arena;
    ForSave.Robot = Robot;
    ForSave.TopologyTracker = TopologyTracker;
    ForSave.SubProblems = SubProblems;   
    ForSave.innovation_record = innovation_record;
    ForSave.MaxGen = MaxGen;
    ForSave.PopSize = PopSize;
    
    save(['NEWSDRobotNavConsRun',num2str(k)],'ForSave','-v7.3');
    k = k + 1;
end

