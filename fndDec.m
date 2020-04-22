function fndDec(fn,R,nn)
window = 10
cd tensor_toolbox_2.6
addpath(pwd)
cd met
addpath(pwd)
cd ..
cd ..
%{
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
%}
%/load('datasetNews.mat');
%debugging mode:

%//load('datasetNews.mat');

%filename='./equal.csv';
%filename='./uni.csv';
%fakeJoinnew=readtable(filename,'Delimiter',',');
%load('datasetNews.mat');
%fakeJoinnew=news;
%label3=fakeJoinnew.label3;
%XX=cell(1,100);
%{
pl=[0.1];
for k=1:length(pl)
for h=1:1
%}
%load(strcat ('./Matrices/newsTagsMatrix',num2str(h),'.mat'));
%fakeJoinnew=tagsHtmlDomain;
%fakeJoinnew=news;

%/debugging mode:
%fakeJoinnew=news;

%Ystring=cellfun(@strsplit,cellstr(fakeJoinnew.textT),'UniformOutput',false);
%/[uniqueWords,dictionary,~,~,wordsNews] = createDictionary(fakeJoinnew.textT);%Ystring);
%/save('./onetime4all4D.mat','-v7.3','uniqueWords','dictionary','wordsNews');
%{
load('./onetime4all4D.mat');
Ystring=wordsNews;
%}
%/for i=1:size(fakeJoinnew,1)
  %/fakeJoinnew.textF(i)=length(wordsNews{i});
%/end
%Use if the dictionatyMap has not been generated before
%/indices = 1:length(dictionary);
%/dictionaryMap = containers.Map(dictionary, indices);
%/save('./title_dictionary_4D.mat','-v7.3','dictionaryMap');
%{
load('./title_dictionary_4D.mat'); 
disp('dictionaryMap finished');
tic
%set cell that contains news content, length, binary label.
textT=Ystring;
textF=fakeJoinnew.textF;
label3=fakeJoinnew.label3;
%save('./label3_4D.mat','-v7.3','label3');
%load('./label3_4D.mat');
%clear news; %remove dataset
%window=5;
%reate co-occurrence indicesi
%size(uniqueWords)
[nnews,ldic]=createwwnDiskSize(uniqueWords,textT,textF,dictionaryMap,window);
%[wxwxn,wxwxnF,wxwxnL] = buildCoocTensor(nnews,ldic);
[wxwxn_4d,wxwxnF_4d] = buildCoocTensor(nnews,ldic);
save('./wxwxn_4D.mat','-v7.3','wxwxn_4d');
save('./wxwxnF_4D.mat','-v7.3','wxwxnF_4d');
%}
load('./wxwxn_4D.mat');
load('./wxwxnF_4D.mat');
wxwxn_4D = wxwxn_4d;
wxwxnF_4D = wxwxnF_4d;
%load('co-occurrence_news.mat');
%load(strcat('/home/sabda005/themadone/source/CP_Matrix/wxwxn/wxwxn',num2str(h)));
disp('tensor done!')
%R=10;
%nn=10;
%tensor decomposition
%load ('Title.mat');

X_n=cp_als(wxwxn_4D,R);
X_F=cp_als(wxwxnF_4D,R);
%save('./TTA63k.mat','-v7.3','X','wxwxnFs');
file_name_tta = strcat('./TTACP4D')
save('./TTACP4D.mat','-v7.3','X_n','X_F');
%XX{h}=X;
%load('TTA_total.mat');
filename=strcat(fn,'_binary');
[avgl_binary(h),prec_avgl_binary(h),f1_avgl_binary(h),rec_avgl_binary(h)]= run_cp_FaBP_s2(X_n.u{3},nn,100,pl(k),label3);
[avglF(h),prec_avglF(h),f1_avglF(h),rec_avglF(h)]= run_cp_FaBP_s2(X_F.u{3},nn,100,pl(k),label3);
%run_cp_FaBP_s(X.U{3},nn,it,pl,label3,filename,indxfile);
%disp('binary done!');
disp('Decomposition done!');
%save(strcat('./TTA_TS/TTA_',num2str(pl(k)*100),'.mat'),'-v7.3','XX');
clear X_n X_F;
clear XX;
  % avgl = mean(avgl);
   % prec_avgl = mean(prec_avgl);
   % f1_avgl = mean(f1_avgl);
   % rec_avgl = mean(rec_avgl);
    file_name1= strcat('./4D_TTA_TOTAL_wxwxn__R',num2str(R),'_nn',num2str(nn),'.mat');
    save(file_name1,'-v7.3','avgl_binary','prec_avgl_binary','f1_avgl_binary', 'rec_avgl_binary');
    file_name2= strcat('./4D_TTA_TOTAL_wxwxnF__R',num2str(R),'_nn',num2str(nn),'.mat');
    save(file_name2,'-v7.3','avglF','prec_avglF','f1_avglF', 'rec_avglF');
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
