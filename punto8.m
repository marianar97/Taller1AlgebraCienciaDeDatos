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
    distanceJaccard(i)=(a)/(a+b+c) ;
    distancePearson(i)= (a*d-b*c)/sqrt((a+c)*(b+d)*(a+b)*(c+d));
end

% Pearson indicator
[pearsonFarValues,personFarIndex]=maxk(distancePearson,10);
[pearsonCloseValues,personCloseIndex]=mink(distancePearson,10);
pearsonFarDiff = ([personFarIndex(:),pearsonFarValues(:)]);
pearsonCloseDiff = ([personCloseIndex(:),pearsonCloseValues(:)]);

% Dice indicator
[diceFarValues,diceFarIndex]=maxk(distanceDice,10);
[diceCloseValues,diceCloseIndex]=mink(distanceDice,10);
diceFarDiff = ([diceFarIndex(:),diceFarValues(:)]);
diceCloseDiff = ([diceCloseIndex(:),diceCloseValues(:)]);

% Jaccard indicator
[jaccardFarValues,jaccardFarIndex]=maxk(distanceJaccard,10);
[jaccardCloseValues,jaccardCloseIndex]=mink(distanceJaccard,10);
jaccardFarDiff = ([jaccardFarIndex(:),jaccardFarValues(:)]);
jaccardCloseDiff = ([jaccardCloseIndex(:),jaccardCloseValues(:)]);