function zz=crear_zz(f,a,b,n)
l=size(f,2);
for i=1:l/n
    tem=0.0;
    for k=1:2^n-1
        temp=k;
		for t=1:n
            k_bit(t)=mod(temp,2);	
			temp=(temp-mod(temp,2))/2;
        end
		min=100000.0;
		max=-100000.0;
		tag=0;
		for j=1:n
			tem=exp(a(j)+b(j)*f((j-1)*l/n+i));
			if k_bit(j)==1
				if tem<min
                   min=tem;
                end
            else
                tag=1;						
				if tem>max
                   max=tem;
                end
            end
        end%for j=1:n end
        if tag==0
           max=0.0;
        end
        if (min-max)>0.0
            zz((i-1)*(2^n-1)+k)=min-max;
        else
            zz((i-1)*(2^n-1)+k)=0.0;
        end
    end
end