clear;
ds_pima = csvRead("pima-indians-diabetes.csv",[],[], "double");

rand('seed',0);

/*
rand_arr = floor((size(ds_pima)(1)) * rand(1,230));
rand_arr = unique(rand_arr);
flag = 0;
ds_pima_train = zeros(size(ds_pima)(1) - length(rand_arr), size(ds_pima)(2));
ds_pima_test = zeros(length(rand_arr) - 1, size(ds_pima)(2));
train_index = 1;
test_index = 1;

for i=1:(size(ds_pima)(1))
    for j=1:length(rand_arr)
        if i == rand_arr(j) then
            flag = 1;
        end
    end
    if flag == 1 then
        ds_pima_test(test_index,:) = ds_pima(i,:);
        test_index = test_index + 1;
        flag = 0;
    else
        ds_pima_train(train_index,:) = ds_pima(i,:);
        train_index = train_index + 1;
    end
end
*/

[x, y] = ann_pat_shuffle(ds_pima(:,1:8)', ds_pima(:,9)');
ds_pima = [x' y']

for i=1:(size(ds_pima)(2) - 1)
    col_i = double(ds_pima(:,i) == 0);
    for j=1:(size(col_i)(1))
        if(col_i(j) == 1)
            then ds_pima(j,i) = %nan;
        end
    end
end

for i=1:(size(ds_pima)(2) - 1)
    col_i = double(isnan(ds_pima(:,i)));
    for j=1:(size(col_i)(1))
        if(col_i(j) == 1)
            then ds_pima(j,i) = nanmedian(ds_pima(:,i));
        end
    end
end


ds_pima_train = ds_pima(1:537,:);
ds_pima_test = ds_pima(538:768,:);
ds_pima_train_input = ds_pima_train(:,1:8);
ds_pima_train_output = ds_pima_train(:,9);
ds_pima_test_input = ds_pima_test(:,1:8);
ds_pima_test_output = ds_pima_test(:,9);

N = [8 10 1];
lp = [0.06 0];
W = ann_FF_init(N);
T = 36;
Q = ann_FF_Std_online(ds_pima_train_input', ds_pima_train_output', N, W, lp, T);
y_out = ann_FF_run(ds_pima_test_input', N, Q);
y_out_T = y_out';
y_out_T_rounded = round(10*y_out_T);
y_out_T_rounded_out = y_out_T_rounded > min(y_out_T_rounded);
y_out_T_rounded_out_bin = double(y_out_T_rounded_out);
mprintf("Accuracy of this Network = %f%% \n T = %d, lp(1) = %f \n",(100 * ( 1 - (ann_sum_of_sqr(y_out_T_rounded_out_bin,ds_pima_test_output)/size(y_out_T_rounded_out_bin)(1)))), T, lp(1));
