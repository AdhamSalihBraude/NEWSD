%% NetCalc
%NETCALC - calculates the ANN output for a given input
%Needs to be optimized, ActFunc: 1-RelU 2-Sigmoid other-None
%cuurently is an immlitation according to the NEAT's Code, need to be
%improved
function output = NetCalcRob(Ind,Input,ActFunc)
nodegenes = Ind.nodegenes;
connectiongenes = Ind.connectiongenes;
OutputSize = sum(nodegenes(2,:)==2);
number_input_nodes = length(Input);
no_change_threshold=1e-3; %threshold to judge if state of a node has changed significantly since last iteration
number_nodes=length(nodegenes);
number_connections=length(connectiongenes);
% set node input steps for first timestep
nodegenes(3,number_input_nodes+1:number_nodes) = 0; %set all node input states to zero
%nodegenes(3,number_input_nodes+1) = 1; %bias node input state set to 1
nodegenes(3,1:number_input_nodes) = Input; %node input states of the two input nodes are consecutively set to the XOR input pattern
%set node output states for first timestep (depending on input states)
nodegenes(4,1:number_input_nodes) = nodegenes(3,1:number_input_nodes);
if ActFunc == 1
    nodegenes(4,number_input_nodes+1:number_nodes) = ReLU(nodegenes(3,number_input_nodes+1:number_nodes));
elseif ActFunc == 2
    nodegenes(4,number_input_nodes+1:number_nodes) = 1./(1 + exp(-4.9*nodegenes(3,number_input_nodes+1:number_nodes)));
elseif ActFunc == 3
    X = nodegenes(3,number_input_nodes+1:number_nodes);
    X(X>1) = 1;
    X(X<-1) = -1;
    nodegenes(4,number_input_nodes+1:number_nodes) = X;
else
    nodegenes(4,number_input_nodes+1:number_nodes) = (nodegenes(3,number_input_nodes+1:number_nodes));
end
no_change_count = 0;
index_loop = 0;
while (no_change_count<number_nodes) && index_loop<3*number_connections
    index_loop = index_loop + 1;
    vector_node_state = nodegenes(4,:);
    for index_connections = 1 : number_connections
        if connectiongenes(5,index_connections)==1 %Check if Connection is enabled
            %read relevant contents of connection gene (ID of Node where connection starts, ID of Node where it ends, and connection weight)
            ID_connection_from_node = connectiongenes(2,index_connections);
            ID_connection_to_node = connectiongenes(3,index_connections);
            connection_weight = connectiongenes(4,index_connections);
            %map node ID's (as extracted from single connection genes above) to index of corresponding node in node genes matrix
            index_connection_from_node = nodegenes(1,:)==ID_connection_from_node;
            index_connection_to_node = find(nodegenes(1,:)==ID_connection_to_node);
            nodegenes(3,index_connection_to_node) = nodegenes(3,index_connection_to_node)+nodegenes(4,index_connection_from_node)*connection_weight; %take output state of connection_from node, multiply with weight, add to input state of connection_to node
        end
    end
    %pass on node input states to outputs for next timestep
    if ActFunc == 1
        nodegenes(4,number_input_nodes+1:number_nodes) = ReLU(nodegenes(3,number_input_nodes+1:number_nodes));
    elseif ActFunc == 2
        nodegenes(4,number_input_nodes+1:number_nodes) = 1./(1 + exp(-4.9*nodegenes(3,number_input_nodes+1:number_nodes)));
    elseif ActFunc == 3
        X = nodegenes(3,number_input_nodes+1:number_nodes);
        X(X>1) = 1;
        X(X<-1) = -1;
        nodegenes(4,number_input_nodes+1:number_nodes) = X;
    else
        nodegenes(4,number_input_nodes+1:number_nodes) = nodegenes(3,number_input_nodes+1:number_nodes);
    end
    
    %Re-initialize node input states for next timestep
    nodegenes(3,number_input_nodes+1:number_nodes) = 0; %set all output and hidden node input states to zero
    no_change_count = sum(abs(nodegenes(4,:)-vector_node_state)<no_change_threshold); %check for alle nodes where the node output state has changed by less than no_change_threshold since last iteration through all the connection genes
end
if index_loop >= 3*number_connections
    output = zeros(size(nodegenes(4,number_input_nodes+1 : number_input_nodes+1 + OutputSize-1)));
else
    output = nodegenes(4,number_input_nodes+1 : number_input_nodes+1 + OutputSize-1);
end
end