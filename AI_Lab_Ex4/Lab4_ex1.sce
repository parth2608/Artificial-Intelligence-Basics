 X = [1, 2, 3, 4, 5];
 Y = [10, 40, 50, 78, 83];
[a, b] = reglin(X, Y);
mprintf("Value of a = %f \n Value of b = %f \n", a, b);
figure(1);
scatter(X, Y, 'red');
plot(X, a*X + b, 'blue');
