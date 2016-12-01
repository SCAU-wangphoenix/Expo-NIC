function a=draw(y1,y2,y)
clf;
l=size(y,1);
for i=1:l
    if y(i)=1
        plot(y1(i),y2(i),'b.');
    else
        plot(y1(i),y2(i),'r*');	
    end
    hold on;
end
    