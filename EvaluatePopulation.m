function populationAfterEvaluation = EvaluatePopulation(population, problem)
%% write here the funtion that evaluates the population
% use the function:
% NetOuput = NetCalc(Ind,NetInput,ActFunc);
% Ind is the solution structure, ActFunc: 1-RelU 2-Sigmoid 3-Satlinear
Inputs = problem.Inputs;
Outputs = problem.Outputs;
Npoints = length(Inputs);
populationAfterEvaluation = population;
number_individuals = size(population,2);
for index_individual=1:number_individuals
    Ind = population(index_individual);
    Err = [0;0;0];
    for InputIndex = 1 : Npoints
        Input = Inputs(:,InputIndex);
        NetOuput = NetCalc(Ind,Input,2)';
        Err = Err + (Outputs(:,InputIndex) - NetOuput).^2/Npoints;

    end


    populationAfterEvaluation(index_individual).Obj= Err'; % an example of sse
end
end

