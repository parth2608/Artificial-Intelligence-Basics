function [y] = ELU(alpha,x)
    for i=1:length(x)
        if x(i) < 0 then
            y(i) = alpha * (%e^x(i) - 1)
        else
            y(i) = x(i)
        end;
    end;
endfunction
