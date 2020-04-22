function [A, linknews] = generateNewsgraph(C,n_neighbors)
    Mdl = KDTreeSearcher(C);
	nn=knnsearch(Mdl,C,'k',n_neighbors+1);
    disp('knnsearch done!');
    linknews = knnInd(nn); %function to generate links
    disp('knnInd!');
    newsGraph= digraph(linknews(:,1),linknews(:,2));
    A = adjacency(newsGraph); % no symmetric matrix
    A=A+A';
    A=spones(A); %symmetric
end

