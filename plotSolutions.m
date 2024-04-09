function plotSolutions(EP,Problem)
F = [];
Inputs = Problem.Inputs;
Outputs = Problem.Outputs;
Npoints = length(Inputs);
for index = 1 : length(EP)
    F(index,:) = EP(index).Obj;
end
[minF,I] = min(F,[],1);

for n = 1 : length(I)
    figure(1)
    subplot(length(I),1,n)
    Ind = EP(I(n));
    NetOuput = nan(size(Outputs));
    for InputIndex = 1 : Npoints
        Input = Inputs(:,InputIndex);
        NetOuput(:,InputIndex) = NetCalc(Ind,Input,2)';
    end
    plot(Inputs,NetOuput(n,:),'-.',Inputs,Outputs(n,:),'-x')
    grid on
end

[M,Idx] = min(sum(F,2)) ;
    figure(length(I)+1)
    Ind = EP(Idx);
    NetOuput = nan(size(Outputs));
    for InputIndex = 1 : Npoints
        Input = Inputs(:,InputIndex);
        NetOuput(:,InputIndex) = NetCalc(Ind,Input,2)';
    end
    plot(Inputs,NetOuput,'-.',Inputs,Outputs,'-x')
    grid on
    drawnow
end