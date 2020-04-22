function fndDemo(fn,R,nn,it,pl,window)
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
mkdir Demo;
%/load('datasetNews.mat');
%debugging mode:
load('datasetSmall.mat');
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
fakeJoinnew=news2;
%Ystring=cellfun(@strsplit,cellstr(fakeJoinnew.textT),'UniformOutput',false);
[uniqueWords,dictionary,~,~,wordsNews] = createDictionary(fakeJoinnew.textT);%Ystring);
cd Demo
save('./Demoonetime4allNew.mat','-v7.3','uniqueWords','dictionary','wordsNews');
cd ..
%load('./onetime4allNew.mat');
Ystring=wordsNews;
%/for i=1:size(fakeJoinnew,1)
  %/fakeJoinnew.textF(i)=length(wordsNews{i});
%/end
%Use if the dictionatyMap has not been generated before
indices = 1:length(dictionary);
dictionaryMap = containers.Map(dictionary, indices);
cd Demo
save('./Demotitle_dictionary_1.mat','-v7.3','dictionaryMap');
cd ..
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
%[wxwxn_in,wxwxn_out,wxwxnF_in,wxwxnF_out,wxwxnL_in,wxwxnL_out] = buildCoocTensor(nnews,ldic);
[wxwxn_4D,wxwxnF_4D] = buildCoocTensor(nnews,ldic);
cd Demo
%save('./DemowxwxnFIn.mat','-v7.3','wxwxnF_in');
%save('./DemowxwxnFOut.mat','-v7.3','wxwxnF_out');
%save('./DemowxwxnIn.mat','-v7.3','wxwxn_in');
%save('./DemowxwxnOut.mat','-v7.3','wxwxn_out');
save('./Demowxwxn_4D.mat','-v7.3','wxwxn_4D');
save('./DemowxwxnF_4D.mat','-v7.3','wxwxnF_4D');
cd ..
%load('./wxwxnFMean.mat');
%load('./TTA_total.mat');
%load('co-occurrence_news.mat');
%load(strcat('/home/sabda005/themadone/source/CP_Matrix/wxwxn/wxwxn',num2str(h)));
disp('tensor done!')
%R=10;
%nn=10;
%tensor decomposition
%load ('Title.mat');
%CX = tester_cmtf('modes',{[1 2 3],[4 5 3],[6 7 3]},'size',[ldic ldic 2*nnews ldic ldic nnews],'R',R,'lambdas',{[1 1 1],[1 1 1], [1 1 1]},'flag_sparse', [0 0 0]);
X_n=cp_als(wxwxn_4D,R);
X_F=cp_als(wxwxnF_4D,R);
%save('./TTA63k.mat','-v7.3','X','wxwxnFs');
cd Demo
save('./DemoTTACP.mat','-v7.3','X_n','X_F');
cd ..
%XX{h}=X;
%load('TTA_total.mat');
filename=strcat(fn,'_binary');
[avgl1(h),prec_avgl1(h),f1_avgl1(h),rec_avgl1(h)]= run_cp_FaBP_s2(X_n.u{3},nn,100,pl(k),label3);
[avgl2(h),prec_avgl2(h),f1_avgl2(h),rec_avgl2(h)]= run_cp_FaBP_s2(X_F.u{3},nn,100,pl(k),label3);
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
   cd Demo
    file_name1= strcat('./DemoInAndOut_TTA_TOTAL_in__R',num2str(R),'_nn',num2str(nn),'.mat');
    save(file_name1,'-v7.3','avgl1','prec_avgl1','f1_avgl1', 'rec_avgl1');
    file_name2= strcat('./DemoInAndOut_TTA_TOTAL_out__R',num2str(R),'_nn',num2str(nn),'.mat');
    save(file_name2,'-v7.3','avgl2','prec_avgl2','f1_avgl2', 'rec_avgl2');
   cd ..
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
