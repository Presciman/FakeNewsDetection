function fnd4All()
    load('./wxwxn_4D.mat');
    load('./wxwxnF_4D.mat');
    load('./label3_4D.mat');
    wxwxn_4D = wxwxn_4d;
    wxwxnF_4D = wxwxnF_4d;
    disp('both tensor loaded!');
    pl=[0.10];
	Rs=[10,15,20];
    h=1;
	nns=[1,4,7,10,13,20,30,50,80,100];
	for i=1:length(Rs)
        R = Rs(i);
        if R == 15
            load('./TTACP4D.mat');
            disp('Decomposition loaded!');
        else
            X_n=cp_als(wxwxn_4D,R);
            X_F=cp_als(wxwxnF_4D,R);
            file_name_tta = strcat('./TTACP4D_R_',num2str(R),'.mat');
            save(file_name_tta,'-v7.3','X_n','X_F');
        end
        
        for j=1:length(nns)
            nn = nns(j);
            [avgl_binary(h),prec_avgl_binary(h),f1_avgl_binary(h),rec_avgl_binary(h)]= run_cp_FaBP_s2(X_n.u{3},nn,100,pl(1),label3);
            [avglF(h),prec_avglF(h),f1_avglF(h),rec_avglF(h)]= run_cp_FaBP_s2(X_F.u{3},nn,100,pl(1),label3);
            file_name1= strcat('./4D_TTA_TOTAL_wxwxn__R',num2str(R),'_nn',num2str(nn),'.mat');
            save(file_name1,'-v7.3','avgl_binary','prec_avgl_binary','f1_avgl_binary', 'rec_avgl_binary');
            file_name2= strcat('./4D_TTA_TOTAL_wxwxnF__R',num2str(R),'_nn',num2str(nn),'.mat');
            save(file_name2,'-v7.3','avglF','prec_avglF','f1_avglF', 'rec_avglF');
        end
        clear X_n X_F;
	end
end