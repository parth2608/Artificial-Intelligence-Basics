clear;
ds_iris = csvRead("Iris.csv",[],[], "string");
ds_iris_no_header = ds_iris(2:151 , 1:6);
ds_iris_hotcode = [ds_iris_no_header string(zeros(150,1)) string(zeros(150,1)) string(zeros(150,1))];
col7 = ds_iris_hotcode(:,6) == 'Iris-setosa';
col8 = ds_iris_hotcode(:,6) == 'Iris-versicolor';
col9 = ds_iris_hotcode(:,6) == 'Iris-virginica';
ds_iris_hotcode(:,7) = string(double(col7));
ds_iris_hotcode(:,8) = string(double(col8));
ds_iris_hotcode(:,9) = string(double(col9));
ds_iris_hotcode_reduced = ds_iris_hotcode(:,[2:5,7:9]); //remove index and flower name
ds_iris_hotcode_reduced_double = strtod(ds_iris_hotcode_reduced); //str to double

rand('seed',0);
/*
rand_arr = floor(151 * rand(1,45));
rand_arr = unique(rand_arr);
flag = 0;
ds_iris_train = zeros(size(ds_iris_hotcode_reduced_double)(1) - length(rand_arr), size(ds_iris_hotcode_reduced_double)(2));
ds_iris_test = zeros(length(rand_arr) - 1, size(ds_iris_hotcode_reduced_double)(2));
train_index = 1;
test_index = 1;

for i=1:150
    for j=1:length(rand_arr)
        if i == rand_arr(j) then
            flag = 1;
        end
    end
    if flag == 1 then
        ds_iris_test(test_index,:) = ds_iris_hotcode_reduced_double(i,:);
        test_index = test_index + 1;
        flag = 0;
    else
        ds_iris_train(train_index,:) = ds_iris_hotcode_reduced_double(i,:);
        train_index = train_index + 1;
    end
end
*/
[x, y] = ann_pat_shuffle(ds_iris_hotcode_reduced_double(:,1:4)', ds_iris_hotcode_reduced_double(:,5:7)');
ds_iris_hotcode_reduced_double = [x' y']
ds_iris_train = ds_iris_hotcode_reduced_double(1:120,:);
ds_iris_test = ds_iris_hotcode_reduced_double(1:150,:);

ds_iris_train_input = ds_iris_train(:,1:4);
ds_iris_train_output = ds_iris_train(:,5:7);
ds_iris_test_input = ds_iris_test(:,1:4);
ds_iris_test_output = ds_iris_test(:,5:7);

N = [4 4 3];
T = 50;
W = ann_FF_init(N);
lp = [0.2 0];
Q = ann_FF_Std_online(ds_iris_train_input', ds_iris_train_output', N, W, lp, T);
y_out = ann_FF_run(ds_iris_test_input', N, Q);
y_out_T = y_out'
y_out_T_bin = zeros(size(y_out_T)(1), size(y_out_T)(2));
for i=1:size(y_out_T)(1)
    y_out_T_bin(i,:) = y_out_T(i,:) == max(y_out_T(i,:));
end
mprintf("Accuracy of this Network = %f%% \n T = %d, lp(1) = %f \n",(100 * ( 1 - (ann_sum_of_sqr(y_out_T_bin,ds_iris_test_output)/size(y_out_T_bin)(1)))), T, lp(1));
