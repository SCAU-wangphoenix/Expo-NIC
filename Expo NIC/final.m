clear all;
tt=['D:\øÏ≈Ã\Research\Programming\Expo NIC\RS+INF\pima-expo-result20160303.txt.txt'];
Fid = fopen(tt, 'wt');

options = gaoptimset('PopulationSize',50,'StallTimeLimit',inf,'StallGenLimit',inf,'Generations',100);
t='D:\øÏ≈Ã\Research\Programming\Expo NIC\RS+INF\pima-5.txt';
da=load(t);
l=size(da,1);
n=size(da,2)-1;
index=2^n-1+2*n;
%%%%%%%%%%%%%%%%%
N = size(da,1);
d = size(da,2)-1;
if min(da(:,end)) == 0
    C = max(da(:,end))+1;
    da(:,end) = da(:,end)+1;
else
    C = max(da(:,end));    
end

%Split the data into folds
%find the indices of the classes
for idxitr=1:C
    idxs{idxitr} = find(da(:,d+1)==idxitr);
    t_tidx{idxitr}=idxs{idxitr};
end%for
%find out how many the test/validation observations are 
%required from each class
for idxitr=1:C
    csize(idxitr) = length(idxs{idxitr})./10;
end%for
temp_index=[];
for critr=1:10%cross-validation
%extract one of 10 folds of the data
tempd = [];

if critr==10%************************************************************
    for clitr=1:C
        tidx=t_tidx{clitr}(find(t_tidx{clitr}),:);
        tempd = [tempd; da(tidx,:)];
        temp_index=[temp_index,critr,clitr,length(tidx)];
        for kk=1:length(tidx)
            temp_index=[temp_index,tidx(kk)];
        end
    end
else%********************************************************************        
    for clitr=1:C
        tidx=[]; 
        endw=0;
        ok=0;     
        len=length(t_tidx{clitr});
        time=round(len/(11-critr));
        while ok==0              
            ind=ceil(length(t_tidx{clitr})*rand(1,1));           
            if t_tidx{clitr}(ind)==0
                endw=endw+0;          
            else                
                tidx=[tidx,t_tidx{clitr}(ind)];                
                t_tidx{clitr}(ind)=0;               
                t_tidx{clitr}=t_tidx{clitr}(find(t_tidx{clitr}),:);
                endw=endw+1;
            end                      
            if endw==time
                ok=1;
            end
            if len==0
                ok=1;
            end
        end
        temp_index=[temp_index,critr,clitr,length(tidx)];
        for kk=1:length(tidx)
            temp_index=[temp_index,tidx(kk)];
        end
        tempd = [tempd; da(tidx,:)];
    end%for te
end%********************************************************************
fold{critr} = tempd;
 end%for critr
 

fprintf(Fid,'temp_index=\n');
fprintf(Fid,'%f;',temp_index);
fprintf(Fid,'\n');

for cvn=1:10
clear data_tr;
clear data_te;
ds = ones(1,10);%flags to mark training folds
ds(cvn) = 0;%0 is the testing fold
te_idx = cvn;
tr_idx = find(ds == 1);

data_tr = [];
for fitr=1:9
    data_tr = [data_tr; fold{tr_idx(fitr)}]; 
end
data_te = fold{te_idx};
%Split the data into folds
%find the indices of the classes
%find out how many the test/validation observations are 
%required from each class
%%%%%%%%%%%%%%%%
%clear x;
fitfun=@(x)classify(x,data_tr,C);
[x,fval]=ga(fitfun,index,[],[],[],[],[],[],[],options);

%fprintf(Fid,'Fuzzy measure%f=\n',cvn);
%fprintf(Fid,'%f;',x);
clear f;
clear y;
clear y1;
clear data1;
l_tr=size(data_tr,1);

for i=1:n*l_tr
    f(i)=data_tr(i);   
end
for i=1:l_tr
    y(i)=data_tr(n*l_tr+i);
end

for i=1:(2^n-1)
    v(i)=x(i);
end
for i=1:n
    c(i)=x(2^n-1+i);
    d(i)=x(2^n-1+n+i);
 %   e(i)=x(2^n-1+2*n+i);
end
y1=projection(f,v,c,d,n);
for i=1:l_tr
        data1(i,1)=y1(i);
        data1(i,2)=y(i);
end
%%%%%%%%%%%%%%
clear f;
clear y;
clear y2;
clear data2;
l_te=size(data_te,1);

for i=1:n*l_te
    f(i)=data_te(i);   
end
for i=1:l_te
    y(i)=data_te(n*l_te+i);
end
y2=projection(f,v,c,d,n);

for i=1:l_te
        data2(i,1)=y2(i);
        data2(i,2)=y(i);
end
%%%%%%%%%%%%%%%%%%%%%%%%%
result=class_line(data1,data2,C);

%fprintf(Fid,'\n fold:%f\n classification line: y=%f x + %f; threshold=%f\n',cvn,result(7),result(8),result(9)); 
%fprintf(Fid,'\n testing data:\n');
%fprintf(Fid,'%f;',data_te);
%fprintf(Fid,'\n testing data:\n');
%fprintf(Fid,'%f;',data_tr);
%fprintf(Fid,'\n training_accuracy=%f\n training_sensitivity=%f\n training_specificity=%f\n testing_accuracy=%f\n testing_sensitivity=%f\n testing_specificity=%f\n',result(1),result(2),result(3),result(4),result(5),result(6));
tr_accuracy(cvn) = result(1);
tr_sensitivity(cvn)=result(2);
tr_specificity(cvn)=result(3);
te_accuracy(cvn) = result(4);
te_sensitivity(cvn)=result(5);
te_specificity(cvn)=result(6);
end

acr_tr= sum(tr_accuracy)/10;
sen_tr=sum(tr_sensitivity)/10;
spe_tr=sum(tr_specificity)/10;
acr_te= sum(te_accuracy)/10;
sen_te=sum(te_sensitivity)/10;
spe_te=sum(te_specificity)/10;

%fprintf(Fid,' \n \ntraining_accuracy=%f\n  testing_accuracy=%f\n ',acr_tr,acr_te);
fprintf(Fid,' \n \ntraining_accuracy=%f\n training_sensitivity=%f\n training_specificity=%f\n testing_accuracy=%f\n testing_sensitivity=%f\n testing_specificity=%f\n',acr_tr,sen_tr,spe_tr,acr_te,sen_te,spe_te);


fclose(Fid);