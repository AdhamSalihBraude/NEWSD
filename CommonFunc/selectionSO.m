function mating_pool = selectionSO(population,SubProblems,EP,Iyoung,mode)
nsubProblems = length(SubProblems);
switch mode
    case 'T1'
        %% Stage I protected the inovation
        mating_pool = [];
        if ~isempty(Iyoung)
            for index = 1 : length(population)
                if sum(population(index).TID == Iyoung) > 0 && Iyoung(1) ~= 1
                    mating_pool = [mating_pool, population(index)]; %just copied
                end
            end
        end
        %% Stage II tur
        for j = 1 : length(population)
            score(:,j) =  population(j).SubProbelmsScore;
        end
        copied = [];
        for i = 1 : length(SubProblems)
            ScoreSub = score(i,:);
            [~,Ibest] = min(ScoreSub);
            if sum(copied == Ibest)>0
                mating_pool = [mating_pool, population(Ibest)];
                copied = [copied,Ibest]; %added 25.10.2018
            end
        end
        if length(mating_pool) >= length(population)
            disp('%%%%%%%%%%%%%%%%% Error in selection%%%%%%%%%%%%%%%');
        else
            for k = length(mating_pool) + 1 : length(population)
                I = randperm(length(population),2);
                if sum(population(I(1)).SubProbelmsScore) > sum(population(I(2)).SubProbelmsScore)
                    mating_pool = [mating_pool, population(I(2))];
                else
                    mating_pool = [mating_pool, population(I(1))];
                end
            end
        end
    case 'R1'
        %% Stage I protected the inovation
        mating_pool = [];
        if ~isempty(Iyoung)
            for index = 1 : length(population)
                if sum(population(index).TID == Iyoung) > 0 && Iyoung(1) ~= 1
                    mating_pool = [mating_pool, population(index)]; %just copied
                end
            end
        end
        
        %% Stage II elitist+stochastic slection
        
        for IndexProblem = 1 : nsubProblems
            SubSore = [];
            for IndexInd = 1 : length(population)
                SubSore = [SubSore;population(IndexInd).SubProbelmsScore(IndexProblem)];
            end
            [~,Rank] = sort(SubSore,'descend');
            SubScoreRank(Rank) = [1:length(Rank)]/sum(Rank);
            for IndexInd = 1 : length(population)
                if IndexInd == 1
                    minrng = 0;
                    maxrng = SubScoreRank(IndexInd);
                    
                else
                    minrng = roulette(IndexProblem).Maxrang(IndexInd-1);
                    maxrng = minrng + SubScoreRank(IndexInd);
                end
                
                roulette(IndexProblem).Minrang(IndexInd) = minrng;
                roulette(IndexProblem).Maxrang(IndexInd) = maxrng;
            end
        end
        while length(mating_pool) < length(population)
            for IndexProblem = 1 : nsubProblems
                rnd = rand();
                index = find(roulette(IndexProblem).Minrang <= rnd & roulette(IndexProblem).Maxrang >= rnd);
                if length(index) > 1
                    index = index(1);
                end
                mating_pool = [mating_pool, population(index)];
                if length(mating_pool) > length(population)
                    break
                end
            end
        end
    case 'R2'
        %% Stage I protected the inovation
        mating_pool = [];
        if ~isempty(Iyoung)
            for index = 1 : length(population)
                if sum(population(index).TID == Iyoung) > 0 && Iyoung(1) ~= 1
                    mating_pool = [mating_pool, population(index)]; %just copied
                end
            end
        end
        
        %% Stage II elitist+stochastic slection
        for j = 1 : length(population)
            score(:,j) =  population(j).SubProbelmsScore;
        end
        copied = [];
        for i = 1 : length(SubProblems)
            ScoreSub = score(i,:);
            [~,Ibest] = min(ScoreSub);
            if sum(copied == Ibest)>0
                mating_pool = [mating_pool, population(Ibest)];
                copied = [copied,Ibest]; %added 25.10.2018
            end
        end
        nsubProblems = length(SubProblems);
        for IndexProblem = 1 : nsubProblems
            SubSore = [];
            for IndexInd = 1 : length(population)
                SubSore = [SubSore;population(IndexInd).SubProbelmsScore(IndexProblem)];
            end
            [~,Rank] = sort(SubSore,'descend');
            SubScoreRank(Rank) = [1:length(Rank)]/sum(Rank);
            for IndexInd = 1 : length(population)
                if IndexInd == 1
                    minrng = 0;
                    maxrng = SubScoreRank(IndexInd);
                    
                else
                    minrng = roulette(IndexProblem).Maxrang(IndexInd-1);
                    maxrng = minrng + SubScoreRank(IndexInd);
                end
                
                roulette(IndexProblem).Minrang(IndexInd) = minrng;
                roulette(IndexProblem).Maxrang(IndexInd) = maxrng;
            end
        end
        while length(mating_pool) < length(population)
            IndexProblem = randi(nsubProblems);
            rnd = rand();
            index = find(roulette(IndexProblem).Minrang <= rnd & roulette(IndexProblem).Maxrang >= rnd);
            if length(index) > 1
                index = index(1);
            end
            mating_pool = [mating_pool, population(index)];
            if length(mating_pool) > length(population)
                break
            end
            
        end
    case 'T2'
        %% Stage I protected the inovation
        mating_pool = [];
        if ~isempty(Iyoung)
            for index = 1 : length(population)
                if sum(population(index).TID == Iyoung) > 0 && Iyoung(1) ~= 1
                    mating_pool = [mating_pool, population(index)]; %just copied
                end
            end
        end
        
        %% Stage II elitist+stochastic slection
        for j = 1 : length(population)
            score(:,j) =  population(j).SubProbelmsScore;
        end
        
        
        while length(mating_pool) < length(population)
            IndexProblem = randi(nsubProblems);
            IndexFirst = randi(length(population));
            IndexSecond = randi(length(population));
            if population(IndexFirst).SubProbelmsScore(IndexProblem) <  population(IndexSecond).SubProbelmsScore(IndexProblem)
                
                index = IndexFirst;
            else
                index = IndexSecond;
            end
            mating_pool = [mating_pool, population(index)];
            if length(mating_pool) >= length(population)
                break
            end
            
        end
    otherwise
        %% Stage I protected the inovation
        mating_pool = [];
        if ~isempty(Iyoung)
            for index = 1 : length(population)
                if sum(population(index).TID == Iyoung) > 0 && Iyoung(1) ~= 1
                    mating_pool = [mating_pool, population(index)]; %just copied
                end
            end
        end
        
        %% Stage II elitist+stochastic slection
        for j = 1 : length(population)
            score(:,j) =  population(j).SubProbelmsScore;
        end
        copied = [];
        for i = 1 : length(SubProblems)
            ScoreSub = score(i,:);
            [~,Ibest] = min(ScoreSub);
            if sum(copied == Ibest)==0
                mating_pool = [mating_pool, population(Ibest)];
                copied = [copied,Ibest]; %added 25.10.2018
            end
        end
        
        while length(mating_pool) < length(population)
            IndexProblem = randi(nsubProblems);
            IndexFirst = randi(length(population));
            IndexSecond = randi(length(population));
            if population(IndexFirst).SubProbelmsScore(IndexProblem) <  population(IndexSecond).SubProbelmsScore(IndexProblem)
                
                index = IndexFirst;
            else
                index = IndexSecond;
            end
            mating_pool = [mating_pool, population(index)];
            if length(mating_pool)-1 == length(population)
                break
            end
            
        end
        mating_pool = [mating_pool,EP];
end
end
