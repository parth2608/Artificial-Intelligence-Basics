theta=0;
x1=0:1
x2=0:1
function a()
    x1=0:1
    x2=0:1
    theta=0;//threshold
    for b=-3:0.5:3
        for w1=-5:5
            for w2=-5:5
                if ((w1*1+w2*1+b > theta) & (w1*1+w2*0+b < theta) & (w1*0+w2*1+b < theta) & (w1*0+w2*0+b < theta)) then
                    disp("w1 : "+string(w1) + "   w2 : "+string(w2)+ " are the weights for bias "+string(b));
                    W1=w1;
                    W2=w2;
                    B=b;
                end
            end
        end
    end
    subplot(311);
    x2=(theta-B-(W1*x1))/W2;
    plot(x1,x2)
    for x1=0:1
        for x2=0:1
            if (W1*x1+W2*x2+B>theta) then
                plot(x1,x2,"*r");
            else
                plot(x1,x2,"*b")
            end
        end
    end
endfunction
disp("For AND GATE:");
figure(1);
a();

function o()
    x1=0:1
    x2=0:1
    theta=0;//threshold
    for b=-2:0.5:2
        for w1=-5:5
            for w2=-5:5
                if ((w1*1+w2*1+b > theta) & (w1*1+w2*0+b > theta) & (w1*0+w2*1+b > theta) & (w1*0+w2*0+b < theta)) then
                    disp("w1 : "+string(w1) + "   w2 : "+string(w2)+ " are the weights for bias "+string(b));
                    W1=w1;
                    W2=w2;
                    B=b;
                end
            end
        end
    end
    subplot(312);
    x2=(theta-B-(W1*x1))/W2;
    plot(x1,x2)
    for x1=0:1
        for x2=0:1
            if (W1*x1+W2*x2+B>=theta) then
                plot(x1,x2,"*r");
            else
                plot(x1,x2,"*b")
            end
        end
    end
endfunction
disp("For OR GATE:");
o();

function n()
    x1=0:1
    x2=0:1
    theta=0;//threshold
    for b=-1:0.5:1
        for w1=-5:5
            for w2=-5:5
                if ((w1*1+w2*1+b > theta) & (w1*0+w2*0+b < theta)) then
                    disp("w1 : "+string(w1) + "   w2 : "+string(w2)+ " are the weights for bias "+string(b));
                    W1=w1;
                    W2=w2;
                    B=b;
                end
            end
        end
    end
    subplot(313);
    x2=(theta-B-(W1*x1))/W2;
    plot(x1,x2)
    for x1=0:1
        x2=x1
            if (W1*x1+W2*x2+B>=theta) then
                plot(x1,x2,"*r");
            else
                plot(x1,x2,"*r")
            end
        end
endfunction
disp("For NOT GATE:");
n();

