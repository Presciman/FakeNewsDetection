function dataset= createDatasetTweets(filename,ids)
    T = readtable(filename,'Delimiter',',');
    disp('readtable done');
    idx = ismember(T.urls_ids,ids);
    disp('ismember done');
    dataset=(T(idx,:));
end
