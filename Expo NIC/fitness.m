%Two Class Linear Classifier 
%Based on Fishers Linear discriminant (Least Squares error estimation)

%Written by C.M. van der Walt
%Meraka Institute, CSIR
%Available from http://www.patternrecognition.co.za

%Reference:
%C.M. van der Walt and E. Barnard,“Data characteristics that determine classifier perfromance?, in Proceedings
%of the Sixteenth Annual Symposium of the Pattern Recognition Association of South Africa,  pp.160-165, 2006. 
%Available [Online] http://www.patternrecognition.co.za
function acr=fitness(data,C)

N = size(data,1);
d = size(data,2)-1;

for cln=1:C
    nidx{cln} = find(data(:,d+1)== cln);
    Xn = data(nidx{cln},1:d);%data for class cln
    n{cln} = length(nidx{cln});
    %class mean
    m{cln}=sum(Xn)./(n{cln});
    Xnprod{cln} = Xn'*Xn;
end

%sample mean
Msum = 0;
for cln=1:C
    Msum = Msum + n{cln}*m{cln}; 
end
M = Msum/N;

%The common covariance matrix
Sw = 1/N*(Xnprod{1}+Xnprod{2}-n{1}*m{1}*m{1}' - n{2}*m{2}*m{2}');
Swinv = inv(Sw);
p1 = n{1}/N;
p2 = n{2}/N;
d2 = (m{1}'-m{2}')'*inv(Sw)*(m{1}'-m{2}');
thr = ((p2-p1)/2)*((1+p1*p2*d2)/(p1*p2));   
acc = 0;
M;
mm=Swinv*(m{1}'-m{2}');
TP=0;
TN=0;
FP=0;
FN=0;

acc1=0;
TP=0;
TN=0;
FP=0;
FN=0;
for itr=1:size(data,1)
    x = data(itr,1:d);
    dect(itr) = (Swinv*(m{1}'-m{2}'))'*(x'-M');
   
    if dect(itr) < thr
        cl_lab(itr)=2;
    else
        cl_lab(itr)=1;
    end
    if cl_lab(itr) == data(itr,d+1)
        acc1 = acc1+1;
        if data(itr,d+1)==1
             TP=TP+1;
        else
            TN=TN+1;
        end
    else
        if data(itr,d+1)==1
            FP=FP+1;
        else
            FN=FN+1;
        end
    end%if
end%for   
tr_sensitivity=TP/(TP+FP);
tr_specificity=TN/(TN+FN);
tr_accuracy=acc1/size(data,1);

acr(1)= tr_accuracy;
acr(2)=tr_sensitivity;
acr(3)= tr_specificity;
  
  
  