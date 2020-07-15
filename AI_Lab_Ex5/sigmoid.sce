function [y] = sigmoid(x)
    y = ones(1,length(x))./(1 + (%e^(-x)));
endfunction
