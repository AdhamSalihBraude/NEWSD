%% Multi class update fitness
function population_plus_fitnesses=MUcalcfit(population,problem,Inputs,Outputs)

method = problem(1).TrainObj;
Nvar = problem(1).Nvar;
Nobj =  problem(1).Nobj;
Npoints = problem(1).Npoints;
population_plus_fitnesses = population;
number_individuals = size(population,2);

forD1 = zeros(Npoints,Nobj,number_individuals);
forD2 = zeros(Npoints,Nobj,number_individuals);
for index_individual=1:number_individuals
    Ind = population(index_individual);
    parfor InputIndex = 1 : Npoints
        Input = Inputs(InputIndex,:);
        NetOuput = NetCalc(Ind,Input,2);
        Err = (Outputs(InputIndex,:) - NetOuput);
        forD1(InputIndex,:,index_individual) = -1*abs(Err);
        forD2(InputIndex,:,index_individual) = -1*(Err.*Err)/2;
    end
end
%% methods:
%'D'-direct (y-x)^2/2, 'Precision', 'Recall','Accuracy'
parfor index_individual = 1 :  number_individuals
    switch method
        case 'D1'
            population_plus_fitnesses(index_individual).Trainfitness = sum(forD1(:,:,index_individual),1)/Npoints;
        case 'D2'
            population_plus_fitnesses(index_individual).Trainfitness = sum(forD2(:,:,index_individual),1)/(2*Npoints);
    end
end
