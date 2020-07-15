function [y] = sigmoid(x)
    y = ones(1,length(x))./(1 + (%e^(-x)));
endfunction

function [d_y] = d_sigmoid(x)
    d_y = sigmoid(x) .* (1 - sigmoid(x));
endfunction

function [y] = ReLU(x)
    y = max(x,0);
endfunction

function [d_y] = d_ReLU(x)
    d_y = double(x >= 0);
endfunction

activation_func_1 = ReLU;
d_activation_func_1 = d_ReLU;
activation_func_2 = sigmoid;
d_activation_func_2 = d_sigmoid;

ds = fscanfMat('/Users/rutvik1999/OneDrive/AI Lab/AI_Lab_Ex5/seeds_dataset.txt');
col8 = ds(:,8) == 1;
col9 = ds(:,8) == 2;
col10 = ds(:,8) == 3;
alpha = 0.01;
ds_norm = [];
for i = 1:7
    ds_norm = [ds_norm, ds(:,i)/max(ds(:,i))];
end
ds_norm = [ds_norm col8 col9 col10];
rand('seed',0);
[x, y] = ann_pat_shuffle(ds_norm(:,1:7)', ds_norm(:,8:10)');
ds_norm = [x' y'];
N = [7 7 3];
W1 = rand(N(1),N(2));
W2 = rand(N(2),N(3));

train_input = ds_norm(1:150,1:7);
train_output = ds_norm(1:150,8:10);
test_input = ds_norm(151:210,1:7);
test_output = ds_norm(151:210, 8:10);
Error = [];

iter = 50;
for z = 1:iter
    NN_output_out_i = [];
    for i = 1:150
        NN_layer1_net = (train_input(i,:) * W1)';
        NN_layer1_out = activation_func_1(NN_layer1_net')';
        NN_output_net = W2' * NN_layer1_out;
        NN_output_out = activation_func_2(NN_output_net')';
        W2_new_d_E = [];
        E_o__d__net_o = [];
        for j = 1:3
             E_o__d__net_o_ = (NN_output_out - train_output(j,:)')(j) * d_activation_func_2(NN_output_net')'; //E_o1__d__net_o is derivative of Error in NN_output_out wrt NN_output_n
             E_o__d__net_o = [E_o__d__net_o E_o__d__net_o_];
             W2_new_d_E = [W2_new_d_E (E_o__d__net_o(j) .* NN_layer1_out)];
        end
        
        W2_new = W2 - (alpha .* W2_new_d_E);
        E_tot__d__out_h = sum((E_o__d__net_o) * W2', 1);
        W1_new_d_E = [];
        E_tot__d__layer1_net = (E_tot__d__out_h * d_activation_func_1(NN_layer1_net')')';
        for j = 1:N(2)
             W1_new_d_E = [W1_new_d_E (train_input(j,:)' .* E_tot__d__layer1_net)];
        end
        W1_new = W1 - (alpha .* W1_new_d_E);
        W1 = W1_new;
        W2 = W2_new; 
        NN_output_out_i  = [NN_output_out_i NN_output_out];
    end
    Error = [Error; 0.5*(sum((NN_output_out_i' - train_output).^2))];
end

disp('NN created. Testing with Test set');
test_result = zeros(1,3);
for i = 1:60
        NN_layer1_net_test = test_input(i,:) * W1;
        NN_layer1_out_test = activation_func_1(NN_layer1_net_test);
        NN_output_net_test = NN_layer1_out_test * W2;
        NN_output_out_test = activation_func_2(NN_output_net_test);
        test_result(i,:) = NN_output_out_test;
end
test_result_bin = zeros(size(test_result)(1), size(test_result)(2));
for i=1:size(test_result)(1)
    test_result_bin(i,:) = test_result(i,:) == max(test_result(i,:));
end

test_accuracy = sum(double(sum(double(test_result_bin == test_output), 'c') == 3))/size(test_output)(1);
disp('  Test Result  |  Desired Output');
disp([test_result_bin test_output]);
mprintf("\n Test Accuracy = %f%%",test_accuracy * 100);
plot(1:iter, Error');
xlabel('Iteration');
ylabel('Error');
title('Error vs. Iteration Plot');


