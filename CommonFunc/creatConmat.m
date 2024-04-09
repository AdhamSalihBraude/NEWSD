function conmatrix = creatConmat(NG,CG)
conMat = zeros(length(NG)+1);
conMat(2:end,1) = NG(1,:);
conMat(1,2:end) = NG(1,:);
for i = 1:length(CG)
    from = CG(2,i);
    to = CG(3,i);
     conMat(find(conMat(:,1)==from),find(conMat(1,:)==to)) = CG(5,i);
end
conmatrix = conMat(2:end,2:end);
end