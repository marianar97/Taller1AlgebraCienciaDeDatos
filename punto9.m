
importedData = importdata('portfolio100.txt');
data = importedData(:,2:end);

myActiveMean = mean(data);
[fdata,cdata] = size(data);

[factive, cactive] = size(myActiveMean);

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

for i=1:cactive
    if myActiveMean(1,i)>0
        binaryActiveArray(i) = 1;
    else
        binaryActiveArray(i) = 0;
    end
end

for i=1:fdata
    
    mcon = confusionmat(binaryActiveArray,binaryMatrix(i,:));
    a = mcon(1,1);
    b = mcon(1,2);
    c = mcon(2,1);
    d = mcon(2,2);
   
    distanceActiveJaccard(i)= (a)/(a+b+c);
end
PActive = prctile(distanceActiveJaccard,90);
IActive = find(distanceActiveJaccard > PActive);

outliers = importedData(IActive,1);
disp(outliers);

plot(importedData(:,1),distanceActiveJaccard,'o')
hold on
plot(importedData(IActive,1), distanceActiveJaccard(IActive),'or')