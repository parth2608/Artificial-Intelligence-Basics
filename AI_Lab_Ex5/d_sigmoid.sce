function [d_y] = d_sigmoid(x)
    d_y = sigmoid(x) .* (1 - sigmoid(x));
endfunction
