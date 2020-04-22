function fndR(fn)
    nns=[1,4,7,10,13,20,30,50,80,100];
    h=1;
    pl=[0.1];
    k=1;
    R=15;
    window = 10;
    load('./TTACP.mat');
    load('./label3.mat');
    res_in = X_in;
    res_out = X_out;
    for j=1:length(nns)
    	nn = nns(j);
    	filename=strcat(fn,'_binary');
        [avgl1(h),prec_avgl1(h),f1_avgl1(h),rec_avgl1(h)]= run_cp_FaBP_s2(res_in.u{3},nn,100,pl(k),label3);
        disp('In binary done!');
        file_name_in= strcat('./2TTA_TOTAL_in_R_',num2str(R),'_nn',num2str(nn),'_window',num2str(window),'.mat');
        save(file_name_in,'-v7.3','avgl1','prec_avgl1','f1_avgl1', 'rec_avgl1');
        
        filename=strcat(fn,'_binary');
        [avgl2(h),prec_avgl2(h),f1_avgl2(h),rec_avgl2(h)]= run_cp_FaBP_s2(res_out.u{3},nn,100,pl(k),label3);
        disp('In binary done!');
        file_name_out= strcat('./2TTA_TOTAL_out_R_',num2str(R),'_nn',num2str(nn),'_window',num2str(window),'.mat');
        save(file_name_out,'-v7.3','avgl2','prec_avgl2','f1_avgl2', 'rec_avgl2');
    end
    clear X;
    clear XX;
end