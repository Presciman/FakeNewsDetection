function [avgl,prec_avgl,f1_avgl, rec_avgl]= run_cp_FaBP_s2(C,maxnn,it,pl,label3)
[m,v,~,prec,rec,f1,~,vl,~,precl,recl,f1l,specl,spec]=test_FaBP_s(C,maxnn,it,label3,pl);
disp('FaBP done!');
spec_avg=mean(spec);
prec_avg=mean(prec);
rec_avg=mean(rec);
f1_avg=mean(f1);
avg=mean(v);
vvar = var(v,1); %normalized by N
sd=std(v,1);
prec_avgl=mean(precl);
rec_avgl=mean(recl);
spec_avgl=mean(specl);
f1_avgl=mean(f1l);
avgl=mean(vl);
vvarl = var(vl,1); %normalized by N
sdl=std(vl,1);
%disp('****** results ***********');
%disp(strcat('pl: ',num2str(pl),' acc: ',num2str(avgl)));

%file_name= strcat('./test_FaBP_',filename,'_nn',num2str(maxnn),'_it',num2str(it),'_pl',num2str(pl*100),'.mat');
clear C maxnn it pl label3 filename;
%save(file_name,'-v7.3');
%disp('save done!');
end

