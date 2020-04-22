function [dataset,ids]= createSampleNews(filename)
    T = readtable(filename,'Delimiter',',','FileEncoding','UTF-8');
    T.textT = cellfun(@strsplit, T.textT, 'UniformOutput', false);
    idxReal = find(T.label3==1);
    indicesFake = find(T.label3==0);
    lf=length(indicesFake);
    %% sample
    indices = randsample(length(idxReal),lf);
    indicesReal = idxReal(indices);
    idataset = vertcat(T(indicesFake,:),T(indicesReal,:));
    idx = randperm((2*lf));
    dataset=idataset(idx,:); 
    ids=dataset.ids;
    %save('./datasets/dataset.mat','dataset');
end
