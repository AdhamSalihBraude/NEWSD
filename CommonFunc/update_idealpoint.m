function idealpoint = update_idealpoint(idealpoint,population)
fitnessvec = nan(size(population,2),length(idealpoint));
for i = 1:size(population,2)
    fitnessvec(i,:) = population(i).Obj;
end
idealpoint = min([idealpoint;fitnessvec],[],1);

end