clear
importedImage = imread('image.jpg');
img = rgb2gray(importedImage);
img=  double(img)/double(255);
n = 0;
kd1=0;
kd2=0;
kinf=0;
kfro=0;
while n<1000+1
    dif = 1-(3-((3*n)/(n+1)));
    newImage = img * dif;
    if n<=10 || n==1000
        imshow(newImage);
        pause(0.1);
    end
    n=n+1;
end

n=0;
while n<200000 && kfro==0
    
    dif = 1-(3-((3*n)/(n+1)));
    newImage = img * dif;
    
    norm1 = norm(newImage-img,1);
    norm2 = norm(newImage-img,2);
    norminf = norm(newImage-img,'inf');
    normfro = norm(newImage-img,'fro');
    
    if(kd1==0 && norm1<0.01) %191422
        kd1=n;
    end
    
    if(kd2==0 && norm2<0.01) %140138
        kd2=n;
    end
    
    if(kinf==0 && norminf<0.01) %188971
        kinf=n;
    end
    
    if(kfro==0 && normfro<0.01) %153065
        kfro=n;
    end
    n=n+1;
    
end