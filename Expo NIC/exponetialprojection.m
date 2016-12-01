function a=expo()
clf
grid on
x = 0:0.01:6;
y=x;
h=plot(x,y,'r');
text(6.2,6,'L','FontSize',12);
hold on;

f1=0;
f2=0:0.01:6;
plot(f1,f2,'k');
text(0.25,6.3,'f2','FontSize',12);
hold on;

f2=0;
f1=0:0.01:6;
plot(f1,f2,'k');
text(6.2,0.25,'f1','FontSize',12);
hold on;

for i=0:5:50
    fun1=@(x,y)(5*exp(x)-2*exp(y)-i);
    fun2=@(x,y)(4*exp(y)-exp(x)-i);
    h1=ezplot(fun1,[-6,6],[log(i/3),6]);
    set(h1, 'Color', 'b');
    h2=ezplot(fun2,[log(i/3),6],[-6,6]);    
    set(h2, 'Color', 'k');
    hold on;
  %  h1=ezplot(fun1,[-6,6],[-6,log(i/3)]);
 %   set(h1, 'Color', 'k');
  %  h2=ezplot(fun2,[-6,6],[-6,log(i/3)]);    
  %  set(h2, 'Color', 'b');   
 %   hold on;
   
    end
end
