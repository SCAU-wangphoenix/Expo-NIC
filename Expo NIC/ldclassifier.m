%Two Class Linear Classifier 
%Based on Fishers Linear discriminant (Least Squares error estimation)

%Written by C.M. van der Walt
%Meraka Institute, CSIR
%Available from http://www.patternrecognition.co.za

%Reference:
%C.M. van der Walt and E. Barnard,“Data characteristics that determine classifier perfromance?, in Proceedings
%of the Sixteenth Annual Symposium of the Pattern Recognition Association of South Africa,  pp.160-165, 2006. 
%Available [Online] http://www.patternrecognition.co.za
function acr=ldclassifier(data)
clear
close all;
%data = load('B5.txt');%('test100.txt');%('glass1.txt');%('id3.txt');%('australian.txt');%('iris.txt');%('B5.txt');
N = size(data,1);
d = size(data,2)-1;
if min(data(:,end)) == 0
    C = max(data(:,end))+1;
    data(:,end) = data(:,end)+1;
else
    C = max(data(:,end));    
end

%Split the data into folds
%find the indices of the classes
for idxitr=1:C
    idxs{idxitr} = find(data(:,d+1)==idxitr);
end%for
%find out how many the test/validation observations are 
%required from each class
for idxitr=1:C
    csize(idxitr) = length(idxs{idxitr})./10;
end%for

for critr=1:10%cross-validation
%extract one of 10 folds of the data
tempd = [];
for clitr=1:C
    t_tidx = idxs{clitr};%the indices of all samples of this class
    tidx = t_tidx(floor(csize(clitr)*(critr-1)+1):floor(critr*csize(clitr)));%the indices of the test samples to be used of this class
    %tidx = t_tidx(csize(clitr)*(critr-1)+1:critr*csize(clitr));%the indices of the test samples to be used of this class
    tempd = [tempd; data(tidx,:)];
end%for te
fold{critr} = tempd;
end%for critr

for cvn=1:10
ds = ones(1,10);%flags to mark training folds
ds(cvn) = 0;%0 is the testing fold
te_idx = cvn;
tr_idx = find(ds == 1);

data_tr = [];
for fitr=1:9
    data_tr = [data_tr; fold{tr_idx(fitr)}]; 
end
data_te = fold{te_idx};
    
for cln=1:C
    nidx{cln} = find(data_tr(:,d+1)== cln);
    Xn = data_tr(nidx{cln},1:d);%data for class cln
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
    
acc = 0;
for itr=1:size(data_te,1)
    x = data_te(itr,1:d);
    dect(itr) = (Swinv*(m{1}'-m{2}'))'*(x'-M');
    p1 = n{1}/N;
    p2 = n{2}/N;
    d2 = (m{1}'-m{2}')'*inv(Sw)*(m{1}'-m{2}');
    thr = ((p2-p1)/2)*((1+p1*p2*d2)/(p1*p2));
    if dect(itr) < thr
        cl_lab(itr)=2;
    else
        cl_lab(itr)=1;
    end
    if cl_lab(itr) == data_te(itr,d+1)
        acc = acc+1;
    end%if
end%for   
%acc
accuracy(cvn) = acc/size(data_te,1)*100;      
end%cvn

acr = sum(accuracy)/10