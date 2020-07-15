function [y] = sigmoid(x, alpha)
    y = ones(1,length(x))./(1 + (%e^(-x))*alpha);
endfunction
