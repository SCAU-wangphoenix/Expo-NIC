function accu=classify(x,da,C)
%da=load(t);%('D:\phoenix\Matlab-7.2\My Fic\output one threshold of FIC to 1D using LDF\C1-10.txt');%('iris.txt');%('australian.txt');%('test100.txt');%('glass1.txt');%('id3.txt');%
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
%u(2^n-1)=1.0;
for i=1:n
    a(i)=x(2^n-1+i);
    b(i)=x(2^n-1+n+i);
  %  c(i)=x(2^n-1+2*n+i);
end
y1=projection(f,u,a,b,n);

for i=1:l
        data(i,1)=y1(i);
        data(i,2)=y(i);  
        y2(i)=0;
end
result=-1*fitness(data,C);
%accu=0.6*result(2)+0.4*result(3);
accu=result(1);


  


