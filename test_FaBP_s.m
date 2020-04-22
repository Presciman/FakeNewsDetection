function [m,v,cm,prec,rec,f1,ml,vl,cml,precl,recl,f1l,specl,spec]=test_FaBP_s(C,maxnn,it,label3,pl)
[A,~] = generateNewsgraph(C,maxnn); %   [newsGraph,linknews]  %generate the other matrix and run the same sample.
%save('adjMatrix_liar.mat','-v7.3','A');
disp('nngraph generated');
%exit;
for j=1:it
   % indxfile=t;
   % indxfile=strcat(indxfile,'_',num2str(j),'_tt',num2str(h));
    [label,idxnl,lbl]= createSampleLabel3(label3,pl);% remove _bal
%    whos A;
%    whos label
    size(idxnl)
    size(lbl)
    size(A)
    size(label)
    res=FaBP(A,label);
    disp('*******FaBP done **************');
    labelId=label3;
    labelId(labelId==1) =2;
    labelId(labelId==0) =1;
    [m(j),v(j)]=purity(labelId,res);
    labelIdl= labelId(idxnl);
    resl=res(idxnl);
   % save(strcat('labelsPredicted_',int2str(j),'.mat'),'-v7.3','labelId','idxnl','res');
    [ml(j),vl(j)]=purity(labelIdl,resl);
    disp('******** pass test***********'); 
    cml=confusionmat(labelIdl,resl);
    if (nnz(resl)==length(labelIdl))
        precl(j)=(cml(1,1)/(cml(1,1)+cml(2,1)));%disp('pass');
        recl(j)=(cml(1,1)/(cml(1,1)+cml(1,2)));
	specl(j)=(cml(2,2)/(cml(2,2)+cml(2,1)));
    else
        precl(j)=(cml(2,2)/(cml(2,2)+cml(3,2)));
        recl(j)=(cml(2,2)/(cml(2,2)+cml(2,3)));
	specl(j)=(cml(3,3)/(cml(3,3)+cml(3,2)));
    end
    
    cm=confusionmat(labelId,res); %disp('pass');cm
    if (nnz(res)==length(labelId))
        prec(j)=(cm(1,1)/(cm(1,1)+cm(2,1)));%disp('pass');
        rec(j)=(cm(1,1)/(cm(1,1)+cm(1,2)));
	spec(j)=(cm(2,2)/(cm(2,2)+cm(2,1)));
    else
        prec(j)=(cm(2,2)/(cm(2,2)+cm(3,2)));
        rec(j)=(cm(2,2)/(cm(2,2)+cm(2,3)));
	spec(j)=(cm(3,3)/(cm(3,3)+cm(3,2)));
    end
    f1(j)=2*((prec(j)*rec(j))/(prec(j)+rec(j)));
    f1l(j)=2*((precl(j)*recl(j))/(precl(j)+recl(j)));
end
end

