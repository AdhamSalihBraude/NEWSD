function [SubProblems,NEWpopulation,TopologyTracker] = updateSubProblems(SubProblems,population, old_pop ,idealpoint,TopologyTracker,Gen_ratio)
NSubProblems = length(SubProblems);
%% del unfeasble solutions
for indIndex = 1 : length(population)
    if sum(isnan(population(indIndex).Obj)) > 0
        population(indIndex).Obj = -inf*ones(size(population(indIndex).Obj));
    end
end
%%
if NSubProblems == 1
    for index_individual = 1 : length(population)
        population(index_individual).SubProbelmsScore = teNormNav(SubProblems.weight, population(index_individual).Obj./idealpoint);
    end
else
    %% Calculate the Score for each subproblem
    for i = 1 : NSubProblems
        for index_individual = 1 : length(population)
            if Gen_ratio < 0.5
                population(index_individual).SubProbelmsScore(i) = teNormNav(SubProblems(i).weight, population(index_individual).Obj./idealpoint);
                if ~isempty(old_pop)
                    old_pop(index_individual).SubProbelmsScore(i) = teNormNav(SubProblems(i).weight, old_pop(index_individual).Obj./idealpoint);
                end
            else
                population(index_individual).SubProbelmsScore(i) = teNorm(SubProblems(i).weight, population(index_individual).Obj./idealpoint);
                if ~isempty(old_pop)
                    old_pop(index_individual).SubProbelmsScore(i) = teNorm(SubProblems(i).weight, old_pop(index_individual).Obj./idealpoint);
                end
            end
        end
    end
end
NEWpopulation = population;
%% Protect innnovations and elitism
% find the indexes of the best/worst individuals
Newscore = [];
oldscore = [];
BestScoreNEW = [];
IndexBestScoreNEW = [];
WorstScoreNEW = [];
IndexworstScoreNEW = [];
BestScoreold = [];
IndexBestScoreold = [];
if ~isempty(old_pop)
    for i = 1 : NSubProblems
        for index_individual = 1 : length(population)
            Newscore(i,index_individual) = population(index_individual).SubProbelmsScore(i);
            oldscore(i,index_individual) = old_pop(index_individual).SubProbelmsScore(i);
            
        end
        [BestScoreNEW(i),IndexBestScoreNEW(i)] = min(Newscore(i,:));
        [WorstScoreNEW(i),IndexworstScoreNEW(i)] = max(Newscore(i,:));
        
        [BestScoreold(i),IndexBestScoreold(i)] = min(oldscore(i,:));
        
    end
    
    %        replace the ind
    for i = 1 : NSubProblems
        if BestScoreold(i) <= BestScoreNEW(i)
            potToreplace = randi(length(NEWpopulation));
            while (sum(IndexBestScoreNEW == potToreplace) > 0)
                potToreplace = randi(length(NEWpopulation));
                
            end
            NEWpopulation(potToreplace) = old_pop(IndexBestScoreold(i));
            IndexBestScoreNEW(i) = potToreplace;
            
        end
    end
    
    %update the best ind
    clear score IndexBestScore BestScore
    old_pop = [old_pop,population];
    for i = 1 : NSubProblems
        for index_individual = 1 : length(NEWpopulation)
            score(i,index_individual) = NEWpopulation(index_individual).SubProbelmsScore(i);
        end
        [BestScore(i),IndexBestScore(i)] = min(score(i,:));
    end
    for index_topology = 1 : length(TopologyTracker)
        if (TopologyTracker(index_topology).protected == 1 && (sum([NEWpopulation(:).TID]==index_topology) == 0)) && (sum([old_pop(:).TID]==index_topology) >0)
            indsFromTopology = old_pop([old_pop(:).TID]==index_topology);
            clear X;
            for indexX = 1 : length(indsFromTopology)
                X(indexX) = sum(indsFromTopology(indexX).SubProbelmsScore);
            end
            [~,Ix] = min(X);
            selected = indsFromTopology(Ix);
            %selected = indsFromTopology(randi(length(indsFromTopology)));
            potToreplace = randi(length(NEWpopulation));
            while(sum(IndexBestScore == potToreplace)) ~= 0
                potToreplace = randi(length(NEWpopulation));
            end
            NEWpopulation(potToreplace) = selected;
        end
        
    end
    
    for index_topology=1:size(TopologyTracker,2)
        TopologyTracker(index_topology).number_individuals=sum([NEWpopulation(:).TID]==index_topology);
    end
end
end
function gte = te(Lmbda, F, Z)
gte = max((Lmbda+0.00001*(Lmbda==0)).*abs(F - Z));
end

function gte = teNorm(Lmbda, F)
gte = max((Lmbda+0.00001*(Lmbda==0)).*abs(F - ones(size(F))));
end
function gte = teNormNav(Lmbda, F)
panelty = 1/((10*sum((Lmbda>0).*(F==0))+1));
Fc = panelty.*F;
gte = max((Lmbda+0.00001*(Lmbda==0)).*abs(Fc - ones(size(Fc))));
end
