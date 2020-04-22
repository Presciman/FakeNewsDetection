function fndContinue(fn,R,nn,it,pl,window)
    [wxwxn_4d,wxwxnF_4d] = buildCoocTensor(nnews,ldic);
    save('./wxwxn_4D.mat','-v7.3','wxwxn_4d');
    save('./wxwxnF_4D.mat','-v7.3','wxwxnF_4d');
    disp('tensor done!')
    X_n=cp_als(wxwxn_4d,R);
    X_F=cp_als(wxwxnF_4d,R);
    %save('./TTA63k.mat','-v7.3','X','wxwxnFs');
    save('./TTACP4D.mat','-v7.3','X_n','X_F');
    %XX{h}=X;
    %load('TTA_total.mat');
    filename=strcat(fn,'_binary');
    [avgl_binary(h),prec_avgl_binary(h),f1_avgl_binary(h),rec_avgl_binary(h)]= run_cp_FaBP_s2(X_n.u{3},nn,100,pl(k),label3);
    [avglF(h),prec_avglF(h),f1_avglF(h),rec_avglF(h)]= run_cp_FaBP_s2(X_F.u{3},nn,100,pl(k),label3);
    clear X_in X_out;
    clear XX;
    file_name1= strcat('./4D_TTA_TOTAL_wxwxn__R',num2str(R),'_nn',num2str(nn),'.mat');
    save(file_name1,'-v7.3','avgl_binary','prec_avgl_binary','f1_avgl_binary', 'rec_avgl_binary');
    file_name2= strcat('./4D_TTA_TOTAL_wxwxnF__R',num2str(R),'_nn',num2str(nn),'.mat');
    save(file_name2,'-v7.3','avglF','prec_avglF','f1_avglF', 'rec_avglF');
end