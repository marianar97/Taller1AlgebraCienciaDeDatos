clear all
% data import 
importedData = importdata('portfolio100.txt');
data = importedData(:,2:end);
myMean = mean(data,2);

% dimesions
[fdata,cdata] = size(data);
[fmean,cmean] = size(myMean);

% mean binary array
for i=1:fmean
    if myMean(i,1)>0
        binaryArray(i) = 1;
    else
        binaryArray(i) = 0;
    end
end

% data binary matrix
for i=1:fdata
    for j=1:cdata
        if data(i,j)>0
            binaryMatrix(i,j) = 1;
        else
            binaryMatrix(i,j) = 0;
        end
    end
end

for i=1:cdata
    
    mcon = confusionmat(binaryArray,binaryMatrix(:,i));
    d = mcon(1,1);
    c = mcon(1,2);
    b = mcon(2,1);
    a = mcon(2,2);
    
    distanceDice(i)= (2*a)/(2*a+b+c);
    distanceJaccard(i)= (a)/(a+b+c);
    distancePearson(i)= (a*d-b*c)/sqrt((a+c)*(b+d)*(a+b)*(c+d));
end

% Pearson indicator
PPearsonMostEqual = prctile(distancePearson,90);
IPearsonMostEqual = find(distancePearson > PPearsonMostEqual);

PPearsonLeastEqual = prctile(distancePearson,10);
IPearsonLeastEqual = find(distancePearson < PPearsonLeastEqual);

% Dice indicator
PDiceMostEqual = prctile(distanceDice,90);
IDiceMostEqual = find(distanceDice > PDiceMostEqual);

PDiceLeastEqual = prctile(distanceDice,10);
IDiceLeastEqual = find(distanceDice < PDiceLeastEqual);

% Jaccard indicator
PJaccardMostEqual = prctile(distanceJaccard,90);
IJaccardMostEqual = find(distanceJaccard > PJaccardMostEqual);

PJaccardLeastEqual = prctile(distanceJaccard,10);
IJaccardLeastEqual = find(distanceJaccard < PJaccardLeastEqual);
