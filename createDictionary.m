function [uniqueWords,dictionary,tf,n_tf,wordsNews] = createDictionary(wordsNews)
        % find words with length <= 40
        
       % idswords=cellfun(@(x)find(strlength(x)<=40 & strlength(x)>0),wordsNews,'UniformOutput',false);
        % remove words with lenght >40
        % wordsNews=cellfun(@(x,y) x(y),wordsNews,idswords,'UniformOutput',false);
        % unique words per news
        [uniqueWords,~,idxWord] = cellfun(@unique,wordsNews,'UniformOutput',false);
        uniqueWords = cellfun(@transpose,uniqueWords,'UniformOutput',false);
        ln=length(wordsNews);
        tf=cell(1,ln);
        n_tf=cell(1,ln);
        for i=1:ln
            tf{i}=accumarray(idxWord{i},1); % frequency abs. of words
            n_tf{i}=tf{i}/length(wordsNews{i}); 
        end

         uniqueWords(any(cellfun(@isempty,uniqueWords),2),:) = [];
         dictionary  = unique(cat(1, uniqueWords{:}))% corpus
         
%          dictionary
         
end
