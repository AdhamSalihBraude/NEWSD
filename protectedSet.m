function PS = protectedSet(population,TopologyTracker,idealpoint)
PS = [];
for Topologyindex = 1 : length(TopologyTracker)
    if TopologyTracker(Topologyindex).number_individuals ~= 0 && TopologyTracker(Topologyindex).protected == 1
        TopologyInds = population([population.TID] == TopologyTracker(Topologyindex).ID);
        TopologyFitI = sum(TopologyInds(1).Obj./idealpoint);
        I = 1;
        for i = 2 : length(TopologyInds)
            TopologyFit = mean(TopologyInds(i).Obj./idealpoint);
            if TopologyFitI > TopologyFit
                I = i;
                TopologyFitI = TopologyFit;
            end
        end
        PS = [PS,TopologyInds(I)];
    end
end