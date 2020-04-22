function [label,idxnl,labelInd] = createSampleLabel3(label3,plabel) % idxnl indices which have not labels
  % lnews=size(table2array(indxfile),1);%(news(1:500,:),1);
   lnews=size(label3,1);
    k = ceil(plabel*lnews);
   % indices=table2array(indxfile);
    % news.label3+1;%label3(1:500,:) +1;
   % for i=1:size(indices,1)
    % labelInd(i)=label3(indices{i});
   % end
   % labelInd=label3(indices);   
    labelInd=label3;
    labelInd(labelInd==0) =-1;

    %labelInd(labelInd==1) =0.5;
    %pseudopriors:
    %real news =1
    %fake news =-1
    [y,idx] = datasample(labelInd,k,'Replace',false);%Randomly sample from data, with or without replacement
    % returns an index vector indicating which values datasample sampled from data.
    %If data is a vector, y = data(idx).
    %If data is a matrix, y = data(idx,:).
   % load(indxfile);
    label = zeros(lnews,1);
    label(idx')=y;
    idxnl=find(label==0);
end
