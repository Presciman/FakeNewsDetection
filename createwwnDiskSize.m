function [nnews,ldic]=createwwnDiskSize(uniqueWords,text,textF,dictionaryMap,k)
mkdir IndicesTemp_TTA_inout;
nnews = size(text,1) %number of news
ldic= double(dictionaryMap.Count);
%get 10% of dataset size 
s=floor(nnews*0.1);
c=s;
aux=s;
%subIndNews=cell(1,c);
subIndNews_in=cell(1,c);
subIndNews_out=cell(1,c);
%valsNews=cell(1,c);
valsNews_in=cell(1,c);
valsNews_out=cell(1,c);
g=1;
size(uniqueWords)
for i=1:nnews
    %nnews
    %disp(i);
    uw=uniqueWords{i};
    subInd = cell(1,length(uw));
    subInd_in=cell(1,length(uw));
    subInd_out=cell(1,length(uw));
    vals_in=cell(1,length(uw));
    vals_out=cell(1,length(uw));
    l=1;
    for j=1:length(uw)
        idxlist=find(strcmp(text{i},uw(j)));
        lidxlist=length(idxlist);
        %/co_oclist -> co_oclist_in, co_oclist_out
        %co_oclist=cell(1,lidxlist);
        co_oclist_in = cell(1,lidxlist);
        co_oclist_out = cell(1,lidxlist);
        if lidxlist==1
            %[co_oclist{1,1}] = findcooc(idxlist,text{i},textF(i),k);
            [co_oclist_in{1,1},co_oclist_out{1,1}] = findcooc1(idxlist,text{i},textF(i),k);
        else
            for h=1:lidxlist
                
                %[co_oclist{1,h}]=findcooc(idxlist(h),text{i},textF(i),k);
                [co_oclist_in{1,h},co_oclist_out{1,h}]=findcooc1(idxlist(h),text{i},textF(i),k);
                
            end
        end
        %co_oclist = horzcat(co_oclist{:});
        co_oclist_in = horzcat(co_oclist_in{:});
        co_oclist_out = horzcat(co_oclist_out{:});
        %[uniqueCooc,~,idxCooc] = unique(co_oclist);
        [uniqueCooc_in,~,idxCooc_in] = unique(co_oclist_in);
        [uniqueCooc_out,~,idxCooc_out] = unique(co_oclist_out);
        %lwords = length(co_oclist);
        lwords_in = length(co_oclist_in);
        lwords_out = length(co_oclist_out);
        %luwords = length(uniqueCooc);
        luwords_in = length(uniqueCooc_in);
        luwords_out = length(uniqueCooc_out);
        %/fabs=accumarray(idxCooc,1);
        %/ fabs is a 1*10 array for window=5
        if ~isempty(uniqueCooc_in)
            idx_in=cell2mat(values(dictionaryMap,uniqueCooc_in));
            iduw = dictionaryMap(uw{j});
            indx_in=ones(1,length(idx_in))';
            %subInd_in{l}=[(indx_in*iduw) idx_in' (i*indx_in)];
            subInd_in{l}=[(indx_in*iduw) idx_in' (i*indx_in) (1*indx_in)];
            val_in = 1:lwords_in';
            if(luwords_in == lwords_in)
                dists_in = accumarray(idxCooc_in, val_in);
            end
            if(luwords_in < lwords_in)
                %/ @(x) min({x})
                %/ @(x) mean({x})
                %/dists = accumarray(idxCooc, val,[],@(x) {x});
                dists_in = accumarray(idxCooc_in, val_in,[],@mean);
            end
            %/vals{l} = dist_list{1,h};
            vals_in{l} = dists_in;
        end
        if ~isempty(uniqueCooc_out)
            idx_out=cell2mat(values(dictionaryMap,uniqueCooc_out));
            iduw = dictionaryMap(uw{j});
            indx_out=ones(1,length(idx_out))';
            size_indx_out = length(indx_out);
            order_out(1:size_indx_out) = 2;
            subInd_out{l}=[(indx_out*iduw) idx_out' (i*indx_out) (2*indx_out)];
            val_out = 1:lwords_out';
            if(luwords_out == lwords_out)
                dists_out = accumarray(idxCooc_out, val_out);
            end
            if(luwords_out < lwords_out)
                %/ @(x) min({x})
                %/ @(x) mean({x})
                %/dists = accumarray(idxCooc, val,[],@(x) {x});
                dists_out = accumarray(idxCooc_out, val_out,[],@mean);
            end
            %/vals{l} = dist_list{1,h};
            vals_out{l} = dists_out;
        end
        l=l+1;
        %clear idx co_oclist uniqueCooc idxCooc fabs indx;
        clear idx_in idx_out co_oclist_in co_oclist_out uniqueCooc_in uniqueCooc_out idxCooc_in idxCooc_out indx_in indx_out;
        %clear lidxlist;
    end
    %subIndNews{1,g}=vertcat(subInd{:});
    subIndNews_in{1,g}=vertcat(subInd_in{:});
    subIndNews_out{1,g}=vertcat(subInd_out{:});
    %valsNews{1,g}=vertcat(vals{:});
    valsNews_in{1,g}=vertcat(vals_in{:});
    valsNews_out{1,g}=vertcat(vals_out{:});
    clear subInd;
    clear vals;
    g=g+1;
    if i == aux
        %subIndNews=vertcat(subIndNews{:});
        subIndNews_in=vertcat(subIndNews_in{:});
        subIndNews_out=vertcat(subIndNews_out{:});
        %valsNews=vertcat(valsNews{:});
        valsNews_in=vertcat(valsNews_in{:});
        valsNews_out=vertcat(valsNews_out{:});
        file_name= strcat('./IndicesTemp_TTA_inout/subIndNewsVals_', num2str(i),'.mat');
        save(file_name,'-v7.3','subIndNews_in','subIndNews_out','valsNews_in','valsNews_out');
        clear subIndNews_in subIndNews_out;
        clear valsNews_in valsNews_out;
        %subIndNews=cell(1,c); 
        subIndNews_in=cell(1,c); 
        subIndNews_out=cell(1,c); 
        %valsNews=cell(1,c);
        valsNews_in=cell(1,c);
        valsNews_out=cell(1,c);
        g=1;
        aux=aux+c;
    end
end
%subIndNews=vertcat(subIndNews{:});
subIndNews_in=vertcat(subIndNews_in{:}); 
subIndNews_out=vertcat(subIndNews_out{:}); 
valsNews_in=vertcat(valsNews_in{:});
valsNews_out=vertcat(valsNews_out{:});
file_name= strcat('./IndicesTemp_TTA_inout/subIndNewsVals_', num2str(nnews),'.mat');
save(file_name,'-v7.3','subIndNews_in','subIndNews_out','valsNews_in','valsNews_out');
end

%4/6 form the matrix (convert from the original array to Matrix)