function [y] = Leaky_ReLU(alpha,x)
    for i=1:length(x)
        if x(i) < 0 then
            y(i) = alpha*x(i)
        else
            y(i) = x(i)
        end;
    end;
endfunction
