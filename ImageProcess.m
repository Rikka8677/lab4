clc;
clear all;
close all;
img = double(imread('pic.jpg'));

zoom_in = [4 0 0;0 4 0; 0 0 1];    	  
zoom_out = [1/9 0 0;0 1/9 0;0 0 1];  

x = -1:0.2:1; 
h = 1.5*abs(x).^3-2.5*abs(x).^2+1;

Zoom_out = affine(img,zoom_out);

Zoom_in = affine(img,zoom_in);
Zoom_in = interpolation(Zoom_in,h,0.6);

imwrite(uint8(Zoom_out),"pic_zoomout.jpg");
imwrite(uint8(Zoom_in),"pic_zoomin.jpg");
figure
imshow(uint8(img));
figure
imshow(uint8(Zoom_in));
figure
imshow(uint8(Zoom_out));

function out = interpolation(in, I,brightness)
    for i=1:3
        for j=1:size(in,1)
            temp(j,:,i) = conv(in(j,:,i),I); 
        end
    end
    for i=1:3
        for j=1:size(in,2)
            out(:,j,i) = brightness*conv(temp(:,j,i),I); 
        end
    end  
end

function out = affine(in,T)
      temp=zeros(1,1,3) ; 
   for i = 1:size(in,1)
        for j = 1:size(in,2)
            moved = [i, j, 1]*T;
            x = round(moved(1));
            y = round(moved(2));
            temp(x+1,y+1,:) = in(i,j,:);
        end
    end
 out=temp;
end
            
