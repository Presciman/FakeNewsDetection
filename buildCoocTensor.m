function [wxwxn_4d,wxwxnF_4d] =buildCoocTensor(nnews,ldic)
myFolder = './IndicesTemp_TTA_inout/';
filePattern = fullfile(myFolder, 'subIndNewsVals_*.mat');
matFiles = dir(filePattern);
subInd_in = cell( length(matFiles),1);
subInd_out = cell( length(matFiles),1);
vals_in = cell( length(matFiles),1);
vals_out = cell( length(matFiles),1);
valslog_in = cell( length(matFiles),1);
valslog_out = cell( length(matFiles),1);
for k = 1:length(matFiles)
  baseFileName = matFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Reading %s\n', baseFileName);
  load(fullFileName);
  subInd_in{k,1}=subIndNews_in;
  subInd_out{k,1}=subIndNews_out;
  vals_in{k,1}=valsNews_in; %remove log
  vals_out{k,1}=valsNews_out;
  
  valslog_in{k,1}=log(valsNews_in);
  valslog_out{k,1}=log(valsNews_out);
  clear subIndNews_in subIndNews_out;
  clear valsNews_in valsNews_out;
end
tic
subInd_in=vertcat(subInd_in{:});
subInd_out=vertcat(subInd_out{:});
%subInd_in and subInd_out has the same length here.
%size = ceil(length(subInd_in)/2);
%subInd = [subInd_in(1:size,1:4);subInd_out(1:size,1:4)];
%if (length(subInd) > length(subInd_in))
    %subInd = subInd(1:length(subInd_in),1:4);
%end
subInd = [subInd_in;subInd_out];
vals_in=vertcat(vals_in{:});
vals_out=vertcat(vals_out{:});
vals = [vals_in;vals_out];
valslog_in=vertcat(valslog_in{:});
valslog_out=vertcat(valslog_out{:});
disp('concatenation finished');
toc
tic
%add 1 column
%tensor4 = sptensor(subInd,vals,[2,ldic,ldic,nnews]);
wxwxn_4d = sptensor(subInd,1,[ldic,ldic,nnews,2]);
wxwxnF_4d = sptensor(subInd,vals,[ldic,ldic,nnews,2]);
%wxwxn_in=sptensor(subInd_in,1,[ldic,ldic,nnews]);
%wxwxn_out=sptensor(subInd_out,1,[ldic,ldic,nnews]);
%wxwxnF_in=sptensor(subInd_in,vals_in,[ldic,ldic,nnews]);
%wxwxnF_out=sptensor(subInd_out,vals_out,[ldic,ldic,nnews]);
%wxwxnL_in=sptensor(subInd_in,valslog_in,[ldic,ldic,nnews]);
%wxwxnL_out=sptensor(subInd_out,valslog_out,[ldic,ldic,nnews]);
rmdir('IndicesTemp_TTA_inout', 's');
disp('sptensor finished');
end
