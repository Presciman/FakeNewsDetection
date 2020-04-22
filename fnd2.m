function fnd2(textT,label3,fn,R,nn,it,pl,window)

[uniqueWords,dictionary,~,~,wordsNews] = createDictionary(textT);
textT=wordsNews;
for i=1:length(textT)
    textF(i)=length(wordsNews{i});
end
%Use if the dictionatyMap has not been generated before
indices = 1:length(dictionary);
dictionaryMap = containers.Map(dictionary, indices);
%save('dictionaryMapList.mat','-v7.3','dictionaryMap');
disp('dictionaryMap finished');
tic

%create co-occurrence indices
[nnews,ldic]=createwwnDiskSize(uniqueWords,textT,textF,dictionaryMap,window);
[wxwxn,wxwxnF,wxwxnL] = buildCoocTensor(nnews,ldic);
%save('co-occurrence_newds.mat','-v7.3','wxwxn','wxwxnF','wxwxnL');
disp('tensor done!')

X=cp_als(wxwxn,R);
filename=strcat(fn,'_binary');
run_cp_FaBP_s(X.U{3},nn,it,pl,label3,filename);
clear X;
disp('binary done!');
X=cp_als(wxwxnF,R);
filename=strcat(fn,'_freq');
run_cp_FaBP_s(X.U{3},nn,it,pl,label3,filename);
clear X;
disp('freq done!');
X=cp_als(wxwxnL,R);
filename=strcat(fn,'_log');
run_cp_FaBP_s(X.U{3},nn,it,pl,label3,filename);
disp('log done!');
end

