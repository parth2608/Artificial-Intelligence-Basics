 X = [1, 2, 3, 4, 5];
 Y = [10, 40, 50, 78, 83];
 m = length(X);
 sum_ = 0;
 loss_i = 1;
 for a = 1:0.01:100
     for i = 1:m
         H(i) = a * X(i);
         sum_ = sum_ + (H(i) - Y(i))**2;
     end
     loss(loss_i) = sum_ / (2*m);
     loss_i = loss_i + 1;
     sum_ = 0;
 end
 mprintf("Minimum value of loss = %f \nFor a = %f", min(loss),1 +  0.01 * find(loss == min(loss)));
 plot((1:0.01:100)', loss);
 xlabel('a');
 ylabel('loss');
