function [SubProblems,NEWpopulation] = updateSubProblemsFix(SubProblems,population, old_pop ,idealpoint)
NSubProblems = length(SubProblems);
if NSubProblems == 1
    for index_individual = 1 : length(population)
        population(index_individual).SubProbelmsScore = te(SubProblems.weight, population(index_individual).Trainfitness./idealpoint);
    end
else
    %% Calculate the Score for each subproblem
    for i = 1 : NSubProblems
        for index_individual = 1 : length(population)
%             population(index_individual).SubProbelmsScore(i) = te(SubProblems(i).weight, population(index_individual).Fit, idealpoint);
                        population(index_individual).SubProbelmsScore(i) = teNorm(SubProblems(i).weight, population(index_individual).Trainfitness./idealpoint);
            if ~isempty(old_pop)
%                 old_pop(index_individual).SubProbelmsScore(i) = te(SubProblems(i).weight, old_pop(index_individual).Fit, idealpoint);
                                old_pop(index_individual).SubProbelmsScore(i) = teNorm(SubProblems(i).weight, old_pop(index_individual).Trainfitness./idealpoint);
            end
            %            population(index_individual).SubProbelmsScore(i) = -1*SubProblems(i).weight* [population(index_individual).Trainfitness]';
            %            population(index_individual).SubProbelmsScore(i) = -1*SubProblems(i).weight* [population(index_individual).TrainfitnessNorm]';
        end
    end
end
Glob = [population,old_pop];
F = [];


for i = 1 : NSubProblems
    score = [];
    for j = 1 : length(Glob)
        score(j) = Glob(j).SubProbelmsScore(i);
    end
    [~,IndexBestScore] = min(score);
    NEWpopulation(i) = Glob(IndexBestScore);
end


end








function gte = te(Lmbda, F, Z)
gte = max((Lmbda+0.00001*(Lmbda==0)).*abs(F - Z));
end

function gte = teNorm(Lmbda, F)

panelty = 1/((10*sum((Lmbda>0).*(F==0))+1));
Fc = panelty.*F;

gte = max((Lmbda+0.00001*(Lmbda==0)).*abs(Fc - ones(size(Fc))));

end
