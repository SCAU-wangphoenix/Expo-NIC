function ycap=projection(f,u,a,b,n)
zz=crear_zz(f,a,b,n);
l=size(f,2);
for i=1:l/n
	sum1=0.0;
	for j=1:2^n-1
		sum1=sum1+zz((i-1)*(2^n-1)+j)*u(j);
    end
	ycap(i)=sum1;
end
