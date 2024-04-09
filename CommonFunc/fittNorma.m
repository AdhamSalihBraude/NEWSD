function population = fittNorma(population,idealpoint)
for i = 1 : length(population)
    population(i).TrainfitnessNorm = population(i).Trainfitness./idealpoint;
end
end