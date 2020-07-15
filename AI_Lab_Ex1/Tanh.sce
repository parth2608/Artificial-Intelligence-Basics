function [y] = Tanh(x)
    minus_two_x = -2*ones(1,length(x)) .* x
    a = ones(length(x)) - (%e^(minus_two_x))
    b = ones(length(x)) + (%e^(minus_two_x))
    y = a ./ b
endfunction
