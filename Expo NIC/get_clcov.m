function clcov = get_clcov(data)
%Calculates the maximum likelihood estimations of the class covariances

%Written by Christiaan M. van der Walt
%Meraka Institute
%More resources available at http://www.patternrecognition.co.za

%Reference:
%C.M. van der Walt and E. Barnard,“Data characteristics that determine classifier perfromance”, in Proceedings
%of the Sixteenth Annual Symposium of the Pattern Recognition Association of South Africa,  pp.160-165, 2006. 
%Available [Online] http://www.patternrecognition.co.za

novar = size(data,2)-1;
obsno = size(data,1);
if min(data(:,novar+1)) == 0 %if class labels start at 0
    data(:,novar+1) = data(:,novar+1)+1;
end%if
noclass = max(data(:,novar+1));

for itr=1:noclass
    idx = find(data(:,novar+1)==itr);    
    clcov{itr} = ml_cov(data(idx,:)); 
end%for

