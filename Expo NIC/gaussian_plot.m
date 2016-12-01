function a=gaussian()
clf
grid on
x = 0:0.001:1;
y=x;
h=plot(x,y,'k');
text(0.8,0.9,'L','FontSize',12);
hold on;
f1=0;
f2=-1:0.001:1;
plot(f1,f2);
text(0.05,0.9,'f2','FontSize',12);

hold on;
f2=0;
f1=-1:0.001:1;
plot(f1,f2);
text(0.9,0.05,'f1','FontSize',12);
hold on;
%above
for i=-5.5:1:5.5
    for f1=-0.8:0.2:0.8
    i=0.1*exp(-f1^2)+0.9*exp(-f2^2);
    fun1=@(f1,f2)(0.1*exp(-f1^2)+0.9*exp(-f2^2)-i);
    ezplot(fun1,[-10,10],[-10,10]);
    colormap([0 0 1]);
    %plot(f1,f2);
    hold on;
    end
      
end
