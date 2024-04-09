function problem = chooseProblemSingle(Name,TrainingPer)


if TrainingPer>1
    TrainingPer = TrainingPer/100;
end
nFold = round(1/(1-TrainingPer),0);
switch Name
    case 'BT'
        load BT.mat
        Problem.Name = 'BT';
        [Problem.datasetSize,Problem.InputSize] = size(BTIn);
        Problem.classNum = 6;
        [BTOut,Index] = sort(BTOut);
        BTIn = BTIn(Index,:);
        inputValues = BTIn;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,BTOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'BTS'
        load BTS.mat
        Problem.Name = 'BTS';
        [Problem.datasetSize,Problem.InputSize] = size(BTInS);
        
        Problem.classNum = 6;
        [BTOut,Index] = sort(BTOut);
        BTInS = BTInS(Index,:);
        inputValues = BTInS;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,BTOut(i)) = 1;
        end
        
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'lymph'
        load lymph.mat
        Problem.Name = 'lymph';
        [Problem.datasetSize,Problem.InputSize] = size(lymphIn);
        
        Problem.classNum = 4;
        inputValues = lymphIn;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,lymphOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'lymphS'
        load lymphS.mat
        Problem.Name = 'lymphS';
        [Problem.datasetSize,Problem.InputSize] = size(lymphInS);
        
        Problem.classNum = 4;
        inputValues = lymphInS;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,lymphOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'vehicle'
        load vehicle.mat
        Problem.Name = 'vehicle';
        [Problem.datasetSize,Problem.InputSize] = size(vecIn);
        
        Problem.classNum = 4;
        [vecOut,Index] = sort(vecOut);
        vecIn = vecIn(Index,:);
        inputValues = vecIn;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,vecOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'vehicleS'
        load vehicleS.mat
        Problem.Name = 'vehicleS';
        [Problem.datasetSize,Problem.InputSize] = size(vecInS);
        
        Problem.classNum = 4;
        [vecOut,Index] = sort(vecOut);
        vecInS = vecInS(Index,:);
        inputValues = vecInS;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,vecOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'irisS'
        load irisS.mat
        Problem.Name = 'irisS';
        [Problem.datasetSize,Problem.InputSize] = size(irisInS);
        
        Problem.classNum = 3;
        [irisOut,Index] = sort(irisOut);
        irisInS = irisInS(Index,:);
        inputValues = irisInS;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,irisOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'iris'
        load iris.mat
        Problem.Name = 'iris';
        [Problem.datasetSize,Problem.InputSize] = size(irisIn);
        
        Problem.classNum = 3;
        [irisOut,Index] = sort(irisOut);
        irisIn = irisIn(Index,:);
        inputValues = irisIn;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,irisOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'wine'
        load wine.mat
        Problem.Name = 'wine';
        [Problem.datasetSize,Problem.InputSize] = size(wineIn);
        
        Problem.classNum = 3;
        inputValues = wineIn;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,wineOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'wineS'
        load wineS.mat
        Problem.Name = 'wineS';
        [Problem.datasetSize,Problem.InputSize] = size(wineInS);
        
        Problem.classNum = 3;
        inputValues = wineInS;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,wineOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'seed'
        load seed.mat
        Problem.Name = 'seed';
        [Problem.datasetSize,Problem.InputSize] = size(seedIn);
        
        Problem.classNum = 3;
        inputValues = seedIn;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,seedOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    case 'seedS'
        load seedS.mat
        Problem.Name = 'seedS';
        [Problem.datasetSize,Problem.InputSize] = size(seedInS);
        
        Problem.classNum = 3;
        inputValues = seedInS;
        outputValues = zeros(Problem.datasetSize,Problem.classNum);
        for i = 1 : Problem.datasetSize
            outputValues(i,seedOut(i)) = 1;
        end
        for i = 1 : Problem.classNum
             classIndex(i).Index = find(outputValues(:,i) == 1);
        end
        Problem.OutputSize = size(outputValues,2);
    otherwise
        Problem = 0;
end

Problem.inputTraining = [];
Problem.outputTraining = [];
Problem.inputTesting = [];
Problem.outputTesting = [];
iFold = 1;
SampleIndex = randperm(size(outputValues,1));
for i = 1 : length(classIndex)
    problem(i) = Problem;
    outputValuesInClass = outputValues(:,i);
    for index = 1 : length(SampleIndex)
        ForTrain = SampleIndex(index);
        if iFold == nFold
            problem(i).inputTesting  = [problem(i).inputTesting ;inputValues(ForTrain,:)];
            problem(i).outputTesting = [problem(i).outputTesting; outputValuesInClass(ForTrain,:)];
            iFold = 1;
        else
            problem(i).inputTraining  = [problem(i).inputTraining ;inputValues(ForTrain,:)];
            problem(i).outputTraining = [problem(i).outputTraining; outputValuesInClass(ForTrain,:)];
            iFold = iFold + 1;
        end
    end
end
end