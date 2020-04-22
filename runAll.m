function runAll()
   Rs=[10,15,20];
   nns=[1,4,7,10,13,20,30,50,80,100];
   for i=1:length(Rs)
        R = Rs(i);
        for j=1:length(nns)
            nn = nns(j);
            fnd('result',R,nn,10,0.10,10);
        end
   end
end
