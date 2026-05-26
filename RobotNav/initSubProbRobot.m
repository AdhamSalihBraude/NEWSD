function [population,idealpoint,NSubProblems,SubProblems,innovation_record,TopologyTracker] = initSubProbRobot(PopSize,ObjNum,NSubProblems,vector_connected_input_nodes,number_input_nodes,number_output_nodes,Arena,Robot)
idealpoint = 1e-6*ones(1,ObjNum);
SubProblems = init_weights(NSubProblems, ObjNum);
NSubProblems = size(SubProblems,2);
[population,innovation_record] = init_individualRobotNav(PopSize,vector_connected_input_nodes,number_input_nodes,number_output_nodes,ObjNum);
%topology traking
TopologyTracker(1).ID = 1;
TopologyTracker(1).nodes = population(1).nodegenes; %node ID; type
TopologyTracker(1).connections = population(1).connectiongenes;% connction from , connction to
TopologyTracker(1).gen = 0;
TopologyTracker(1).number_individuals = length(population);
TopologyTracker(1).protected = 1;

population = RobotNavcalcfit(population, Robot, Arena,0);
idealpoint = update_idealpoint(idealpoint,population);
population = ScoreAssigment(SubProblems,population,idealpoint,0);
end