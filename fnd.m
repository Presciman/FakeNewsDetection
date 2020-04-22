function fnd(fn,R,nn,it,pl,window)
cd tensor_toolbox_2.6
addpath(pwd)
cd met
addpath(pwd)
cd ..
cd ..
cd poblano_toolbox-master
cd poblano_toolbox-master
addpath(pwd)
cd ..
cd ..
cd CMTF_Toolbox_v1_1
cd CMTF_Toolbox_v1_1
addpath(pwd)
cd ..
cd ..
%/load('datasetNews.mat');
%debugging mode:
load('datasetNews.mat');
%filename='./equal.csv';
%filename='./uni.csv';
%fakeJoinnew=readtable(filename,'Delimiter',',');
%load('datasetNews.mat');
%fakeJoinnew=news;
%label3=fakeJoinnew.label3;
%XX=cell(1,100);
pl=[0.1];
for k=1:length(pl)
for h=1:1
%load(strcat ('./Matrices/newsTagsMatrix',num2str(h),'.mat'));
%fakeJoinnew=tagsHtmlDomain;
%fakeJoinnew=news;
%/debugging mode:
fakeJoinnew=news;
%Ystring=cellfun(@strsplit,cellstr(fakeJoinnew.textT),'UniformOutput',false);
[uniqueWords,dictionary,~,~,wordsNews] = createDictionary(fakeJoinnew.textT);%Ystring);
save('./onetime4allNew.mat','-v7.3','uniqueWords','dictionary','wordsNews');
%load('./onetime4allNew.mat');
Ystring=wordsNews;
%/for i=1:size(fakeJoinnew,1)
  %/fakeJoinnew.textF(i)=length(wordsNews{i});
%/end
%Use if the dictionatyMap has not been generated before
indices = 1:length(dictionary);
dictionaryMap = containers.Map(dictionary, indices);
save('./title_dictionary_1.mat','-v7.3','dictionaryMap');
%load('./title_dictionary_1.mat');
disp('dictionaryMap finished');
tic
%set cell that contains news content, length, binary label.
textT=Ystring;
textF=fakeJoinnew.textF;
label3=fakeJoinnew.label3;
%clear news; %remove dataset
%window=5;
%reate co-occurrence indicesi
%size(uniqueWords)
[nnews,ldic]=createwwnDiskSize(uniqueWords,textT,textF,dictionaryMap,window);
%[wxwxn,wxwxnF,wxwxnL] = buildCoocTensor(nnews,ldic);
[wxwxn_in,wxwxn_out,wxwxnF_in,wxwxnF_out,wxwxnL_in,wxwxnL_out] = buildCoocTensor(nnews,ldic);
save('./wxwxnFIn.mat','-v7.3','wxwxnF_in');
save('./wxwxnFOut.mat','-v7.3','wxwxnF_out');
save('./wxwxnIn.mat','-v7.3','wxwxn_in');
save('./wxwxnOut.mat','-v7.3','wxwxn_out');
%load('./wxwxnFMean.mat');
%load('./TTA_total.mat');
%load('co-occurrence_news.mat');
%load(strcat('/home/sabda005/themadone/source/CP_Matrix/wxwxn/wxwxn',num2str(h)));
disp('tensor done!')
%R=10;
%nn=10;
%tensor decomposition
%load ('Title.mat');

X_in=cp_als(wxwxnF_in,R);
X_out=cp_als(wxwxnF_out,R);
%save('./TTA63k.mat','-v7.3','X','wxwxnFs');
save('./TTACP.mat','-v7.3','X_in','X_out');
%XX{h}=X;
%load('TTA_total.mat');
filename=strcat(fn,'_binary');
[avgl1(h),prec_avgl1(h),f1_avgl1(h),rec_avgl1(h)]= run_cp_FaBP_s2(X_in.u{3},nn,100,pl(k),label3);
[avgl2(h),prec_avgl2(h),f1_avgl2(h),rec_avgl2(h)]= run_cp_FaBP_s2(X_out.u{3},nn,100,pl(k),label3);
%run_cp_FaBP_s(X.U{3},nn,it,pl,label3,filename,indxfile);
%disp('binary done!');
disp('Decomposition done!');
%save(strcat('./TTA_TS/TTA_',num2str(pl(k)*100),'.mat'),'-v7.3','XX');
clear X_in X_out;
clear XX;
  % avgl = mean(avgl);
   % prec_avgl = mean(prec_avgl);
   % f1_avgl = mean(f1_avgl);
   % rec_avgl = mean(rec_avgl);
    file_name1= strcat('./InAndOut_TTA_TOTAL_in__R',num2str(R),'_nn',num2str(nn),'.mat');
    save(file_name1,'-v7.3','avgl1','prec_avgl1','f1_avgl1', 'rec_avgl1');
    file_name2= strcat('./InAndOut_TTA_TOTAL_out__R',num2str(R),'_nn',num2str(nn),'.mat');
    save(file_name2,'-v7.3','avgl2','prec_avgl2','f1_avgl2', 'rec_avgl2');
%X=cp_als(wxwxnF,R);
%filename=strcat(fn,'_freq');
%run_cp_FaBP_s(X.U{3},nn,it,pl,label3,filename,indxfile);
%clear X;
%disp('freq done!');
%X=cp_als(wxwxnL,R);
%filename=strcat(fn,'_log');
%run_cp_FaBP_s(X.U{3},nn,it,pl,label3,filename,indxfile);
%disp('log done!');
end
toc
end
