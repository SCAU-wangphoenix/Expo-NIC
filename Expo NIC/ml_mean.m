function mean = ml_mean(data)
%Calculate the maximum likelihood estimation of the mean

%Written by Christiaan M. van der Walt
%Meraka Institute
%More resources available at http://www.patternrecognition.co.za

%Reference:
%C.M. van der Walt and E. Barnard,“Data characteristics that determine classifier perfromance”, in Proceedings
%of the Sixteenth Annual Symposium of the Pattern Recognition Association of South Africa,  pp.160-165, 2006. 
%Available [Online] http://www.patternrecognition.co.za

n = size(data,1);
d = size(data,2)-1;

mean = sum(data(:,1:d))./n;