function [words,words_rev]=findcooc1(idx ,text,textF,k)
    i=idx-k;
    j=idx+k;
    if idx == 1 
         words= text((idx+1):(j));
         words_rev = flip(words);
    else
        if idx == size(text,1)
            disp(size(text,1))
            disp(i);
            words = text((i):(idx-1));
            words_rev = flip(words);
        else
            if ((j) > textF)
                if ((i)<1)
                    words= horzcat(text(1:(idx-1)),text((idx+1):end));
                    words_rev = flip(words);
                else
                	words= horzcat(text((i):(idx-1)),text((idx+1):end));
                    words_rev = flip(words);
                end
            else
                if ((i) < 1)
                    words= horzcat(text(1:(idx-1)),text((idx+1):(j)));
                    words_rev = flip(words);
                else 
                    words= horzcat(text((i):(idx-1)),text((idx+1):(j)));
                    words_rev = flip(words);
                end
            end
        end
    end  
end
