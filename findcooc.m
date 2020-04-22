function [words_in,words_out]=findcooc(idx ,text,textF,k)
    %/ incoming is appear after w_i, order ->
    %/ outgoing is appear before w_i, order <-
    i=idx-k;
    j=idx+k;
    if idx == 1 
         %words= text((idx+1):(j));
         words_in = text((idx+1):(j));
         words_out = text((j):-1:(idx+1));
    else
        if idx == size(text,1)
            %words = text((i):(idx-1));
            %words_out = text((i):(idx-1));
            words_out = text((idx-1):-1:(i));
            words_in = text((i):(idx-1));
        else
            if ((j) > textF)
                if ((i)<1)
                    %words= horzcat(text(1:(idx-1)),text((idx+1):end));
                    %words_out = text(1:(idx-1)); ...
                    words_out = text((idx-1):-1:1); ...
                    words_in = text((idx+1):end);
                else
                	%words= horzcat(text((i):(idx-1)),text((idx+1):end));
                    %words_out = text((i):(idx-1)); ...
                    words_out = text((idx-1):-1:(i)); ...
                    words_in = text((idx+1):end);
                end
            else
                if ((i) < 1)
                    %words= horzcat(text(1:(idx-1)),text((idx+1):(j)));
                    %words_out = text(1:(idx-1)); ...
                    words_out = text((idx-1):-1:1); ...
                    words_in = text((idx+1):(j));
                else 
                    %words= horzcat(text((i):(idx-1)),text((idx+1):(j)));
                    %words_out = text((i):(idx-1)); ...
                    words_out = text((idx-1):-1:(i)); ...
                    words_in = text((idx+1):(j));
                end
            end
        end
    end  
end
%4/6: added words_in and words_out