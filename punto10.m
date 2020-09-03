clear
importedImage = imread('image10.jpg');
img = rgb2gray(importedImage);
img=  double(img)/double(255);

kd1=0;
kd2=0;
kinf=0;
kfro=0;

for n=1:2000
    dif = 1-(3-((3*n)/(n+1)));
    newImage = img * dif;
    if n<=10 || n==1000
        
        imshow(newImage);
        pause(0.1);
        
    end
    if( norm(img-newImage,1)<0.01)
        kd1=n;
    end
    if( norm(img-newImage,2)<0.01)
        kd2=n;
    end
    if( norm(img-newImage,1)<0.01)
        kinf=n;
    end
    if( norm(img-newImage,1)<0.01)
        kfro=n;
    end
    nmi=norm(img-newImage,1);
    disp([n, nmi, nmi<double(0.01)]); 
end