function cov = ml_cov(data)
%Calculate the maximum likelihood estimation of the covariance
%matrix 

%Written by Christiaan M. van der Walt
%Meraka Institute
%More resources available at http://www.patternrecognition.co.za

%Reference:
%C.M. van der Walt and E. Barnard,“Data characteristics that determine classifier perfromance”, in Proceedings
%of the Sixteenth Annual Symposium of the Pattern Recognition Association of South Africa,  pp.160-165, 2006. 
%Available [Online] http://www.patternrecognition.co.za

n = size(data,1);
d = size(data,2)-1;%the last column is the class label

mean = ml_mean(data);
rmean = repmat(mean,n,1);%repeat the mean n times 

%sq = (data(:,1:d)-rmean).*(data(:,1:d)-rmean); 
datamm = (data(:,1:d)-rmean);
datammt = datamm';
sq = datammt*datamm;

cov = sq./n;
%save