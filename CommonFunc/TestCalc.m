%% Multi class update fitness
function population_plus_fitnesses=TestCalc(population,problem)
method = problem.TrainObj;
population_plus_fitnesses=population;
number_individuals=size(population,2);
InputsNum =  size(problem.inputTesting,1);
Inputs = problem.inputTesting;
Outputs = problem.outputTesting;
NumOut = size(Outputs,2);
DataFromEv = nan(number_individuals,InputsNum);
if NumOut > 1
    [~,OutputsforDisc] = max(Outputs,[],2);
else
    OutputsforDisc = Outputs;
end
N = sum(Outputs,1);
for index_individual=1:number_individuals
    Ind = population(index_individual);
    parfor InputIndex = 1 : InputsNum
        Input = Inputs(InputIndex,:);
        
        if NumOut > 1
            if min(char(method) == 'D') > 0
                NetOuput = NetCalc(Ind,Input,2);
                [~,NetClass] = max(NetOuput);
            else
                NetOuput = NetCalc(Ind,Input,1);
                [~,NetClass] = max(NetOuput);
            end
        else
            NetOuput = NetCalc(Ind,Input,2);
            NetClass = NetOuput>0.5;
        end
        DataFromEv(index_individual,InputIndex) = NetClass;
    end
end
%% methods:
%'D'-direct (y-x)^2/2, 'Precision', 'Recall','Accuracy'
parfor index_individual = 1 :  number_individuals
    TP = zeros(1,NumOut);
    TN = zeros(1,NumOut);
    FP = zeros(1,NumOut);
    FN = zeros(1,NumOut);
    for classindex = 1 : NumOut
        TP(1,classindex) = sum(DataFromEv(index_individual,:) == classindex & classindex == OutputsforDisc');
        FP(1,classindex) = sum(DataFromEv(index_individual,:) == classindex & classindex ~= OutputsforDisc');
        TN(1,classindex) = sum(DataFromEv(index_individual,:) ~= classindex & classindex ~= OutputsforDisc');
        FN(1,classindex) = sum(DataFromEv(index_individual,:) ~= classindex & classindex == OutputsforDisc');
    end
    population_plus_fitnesses(index_individual).Testfitness = 100*(TP+TN)/InputsNum;
end

