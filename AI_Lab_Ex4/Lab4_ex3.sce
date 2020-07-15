 clear;
 X = [1, 2, 3, 4, 5];
 Y = [10, 40, 50, 78, 83];
 alpha = 0.01;
 iter = 5000;
 m = length(X);
 rand('seed',0);
 a(1) = rand(1);
 b(1) = rand(1);
 sum_a = 0;
 sum_b = 0;
 sum_ = 0;
 for i = 1:iter
     for j = 1:m
        H(j) = (a(i) * X(j)) + b(i);
        sum_ = sum_ + (H(j) - Y(j))**2;
        sum_b = sum_b + ( (a(i) * X(j)) + b(i) - Y(j) );
        sum_a = sum_a + ( ( (a(i) * X(j)) + b(i) - Y(j) ) * X(j) );
     end
    loss(i) = sum_ / (2*m);
    del_E__del_b(i) = sum_b * (1/m);
    del_E__del_a(i) = sum_a * (1/m);
    sum_ = 0;
    sum_a = 0;
    sum_b = 0;
    b(i+1) = b(i) - (alpha * del_E__del_b(i));
    a(i+1) = a(i) - (alpha * del_E__del_a(i));
 end
 a = a(1:iter);
 b = b(1:iter);
 mprintf("With Gradient Descent Algorithm, \nValue of a = %f and Value of b = %f\n", a(iter),b(iter));
 mprintf("Number of iterations = %f and alpha = %f \n", iter, alpha);
 [r_a r_b] = reglin(X,Y);
 mprintf("With reglin function, \nValue of a = %f and Value of b = %f\n", r_a, r_b);
 plot3d(a,b,loss);
 xlabel('a');
 ylabel('b');
 zlabel('cost');
// https://mccormickml.com/2014/03/04/gradient-descent-derivation/
