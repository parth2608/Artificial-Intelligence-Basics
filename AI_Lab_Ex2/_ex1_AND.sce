x1 = [0 0 1 1];
x2 = [0 1 0 1];
/*or i=1:length(x1_AND_x2)
    if x1_AND_x2(i) then
        c(i) = 1;
    else
        c(i) = 0;
    end
end
*/
c = bitand(x1,x2);
scatter(x1, x2, 200, c, "fill");
