function ff=draw(x)
da=load('test.txt');
l=size(da,1);
n=size(da,2)-1;
for i=1:n*l
    f(i)=da(i);   
end
for i=1:l
    y(i)=da(n*l+i);
end
for i=1:(2^n-1)
    u(i)=x(i);
end
for i=1:n
    a(i)=x(2^n-1+i);
    b(i)=x(2^n-1+n+i);
end
for i=1:(2^n-1)
    v(i)=x(2^n-1+2*n+i);
end
for i=1:n
    c(i)=x(2*(2^n-1)+2*n+i);
    d(i)=x(2*(2^n-1)+3*n+i);
end
y1=projection(f,u,a,b);
y2=projection(f,v,c,d);
for i=1:l
    if y(i)>=1
        plot(y1(i),y2(i),'b.');
    else
        plot(y1(i),y2(i),'r*');	
    end
    hold on;
end