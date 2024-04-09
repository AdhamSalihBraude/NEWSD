%% Code for :
%% Adham Salih, and Amiram Moshaiov Modified Decomposition Framework and Algorithm
%% for Many-objective Topology and Weight Evolution
%% of Neural Networks (NEWS/D)


%------------------------------- References --------------------------------
% Kenneth O. Stanley, and Risto Miikkulainen. "Evolving neural networks
% through augmenting topologies." Evolutionary Computation 10, no. 2 (2002):
% 99-127. % Coding by Christian Mayr (matlab_neat@web.de)
%---------------------------------------------------------------------------
% Zhang, Qingfu, and Hui Li. "MOEA/D: A multiobjective evolutionary
% algorithm based on decomposition." IEEE Transactions on evolutionary
% computation 11.6 (2007): 712-731.
%--------------------------------------------------------------------------
%"Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
clc
clear
clf
close all
GenCounter = 1;
MaxTopologies = 10; % MAX_NT
protectGen = 10; % gen_TM
NSubProblems = 80; % K
MaxGen = 100; % maximal number of generations
PopSize = 100; % N
ObjNum = 3; % number of objectives
nEP = PopSize; % The size of the external population
addpath('CommonFunc')
rng('shuffle')
TotalRuns = 1;
RunIdx = 1;
%crossover param.
crossover.percentage=0.8; %percentage governs the way in which new population will be composed from old population.  exception: species with just one individual can only use mutation
crossover.probability_interspecies=0.2 ; %if crossover has been selected, this probability governs the intra/interspecies parent composition being used for the
crossover.probability_multipoint=0.6; %standard-crossover in which matching connection genes are inherited randomly from both parents. In the (1-crossover.probability_multipoint) cases, weights of the new connection genes are the mean of the corresponding parent genes
crossover.SBXprop = [0.8,0.1]; %first is the probability second is the distibution
ForSave(1).EP = [];
%mutation Param
mutation.probability_add_node=0.3;
mutation.probability_add_connection=0.3;
mutation.probability_recurrency=0.0; %if we are in add_connection_mutation, this governs if a recurrent connection is allowed. Note: this will only activate if the random connection is a recurrent one, otherwise the connection is simply accepted. If no possible non-recurrent connections exist for the current node genes, then for e.g. a probability of 0.1, 9 times out of 10 no connection is added.
mutation.probability_mutate_weight=0.6;
mutation.weight_cap=5; % weights will be restricted from -mutation.weight_cap to mutation.weight_cap
mutation.weight_range=2; % random distribution with width mutation.weight_range, centered on 0. mutation range of 5 will give random distribution from -2.5 to 2.5
mutation.probability_gene_reenabled=0.25; % Probability of a connection gene being reenabled in offspring if it was inherited disabled
mutation.pol = [0.2,15];
mutation.adaptiverate = [mutation.weight_range,0.2]; %step = a1*exp(-a2*gen)
% define a structure named Problem that contains the needed parameters for
% the solved problem here an example of regression is provided
f1 = @(x) sin(x);
f2 = @(x) 0.5*x;
f3 = @(x) sqrt(x);
Problem.Inputs =  0.1:0.05:0.9;

Problem.Outputs = [f1(Problem.Inputs);f2(Problem.Inputs);f3(Problem.Inputs)];
figure(200)
plot(Problem.Inputs,Problem.Outputs(1,:),Problem.Inputs,Problem.Outputs(2,:),Problem.Inputs,Problem.Outputs(3,:))


while RunIdx < TotalRuns + 1
    % first generation

    best = [];
    Nt = [];

    %parameters initial population
    number_input_nodes = 1;
    number_output_nodes = 3;
    vector_connected_input_nodes=1:number_input_nodes; % Try other initial topologies (not fully connected)

    [population,idealpoint,NSubProblems,SubProblems,innovation_record,TopologyTracker] = initSubProb(PopSize,ObjNum,NSubProblems,vector_connected_input_nodes,number_input_nodes,number_output_nodes,Problem);
    EP = [];
    EP = updateEP(EP,population,nEP);
    GenCounter = 1;


    %% Gen Loop
    IPoverGen = [];
    PS = [];
    F = [];
    for index = 1 : length(EP)
        F(index,:) = EP(index).Obj;
    end
    figure(1)
    plot3(F(:,1),F(:,2),F(:,3),'o')
    grid on
    for GenCounter = 1 : MaxGen
        %% update Topology protection Status
        Ntopologies = 1;
        IT = [];
        for Topologyindex = 1 : length(TopologyTracker)
            if TopologyTracker(Topologyindex).number_individuals ~= 0
                Ntopologies = Ntopologies + 1;
                IT = [IT,TopologyTracker(Topologyindex).ID];
            end
            if (GenCounter - TopologyTracker(Topologyindex).gen < protectGen && TopologyTracker(Topologyindex).gen ~= 0)
                TopologyTracker(Topologyindex).protected = 1;
            else
                TopologyTracker(Topologyindex).protected = 0;
            end
        end
        Ntop(GenCounter).IT = IT;
        E = eliteSet(population,NSubProblems);
        SI = selection(population,PopSize-length([E,PS]));
        matingPool = [SI,PS,E];
        if Ntopologies < MaxTopologies
            [Newindividuals,innovation_record,TopologyTracker] = reproduceTopologies(crossover ,mutation, TopologyTracker ,innovation_record, GenCounter,matingPool,PopSize,MaxTopologies);
        else
            Newindividuals  = reproduceWeights(crossover, mutation, GenCounter, matingPool, PopSize);
        end
        Newindividuals = EvaluatePopulation(Newindividuals, Problem);
        idealpoint = update_idealpoint(idealpoint,Newindividuals);
        IPoverGen = [IPoverGen;idealpoint];
        % update the scores
        Newindividuals = ScoreAssigment(SubProblems,Newindividuals,idealpoint,GenCounter/MaxGen);
        PS = protectedSet([Newindividuals,population],TopologyTracker,idealpoint);
        PS = ScoreAssigment(SubProblems,PS,idealpoint,GenCounter/MaxGen);
        E = ScoreAssigment(SubProblems,E,idealpoint,GenCounter/MaxGen);
        [population,TopologyTracker] = updatePopulation(Newindividuals,E,PS,TopologyTracker,NSubProblems);
        EP = updateEP(EP,Newindividuals,nEP);
        F = [];
        for index = 1 : length(EP)
            F(index,:) = EP(index).Obj;
        end
        figure(100)
        plot3(F(:,1),F(:,2),F(:,3),'o')
        grid on
        title(num2str(GenCounter))
        drawnow
        plotSolutions(EP,Problem) 

    end
    RunIdx = RunIdx + 1;
end