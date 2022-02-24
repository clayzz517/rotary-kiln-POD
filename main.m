clc;
clear all;

% Video2Image('D:\mat_data\flame\normal.mp4','D:\mat_data\flame_normal\','flame',1,60,[1080,1920]);
All_Image = Image2RGB('C:\Users\86138\Desktop\10\','jpg',[1080,1920]);
All_Image = double(All_Image);

[h w m n] = size(All_Image); % h w m n 表示图片的高度、宽度、RGB维数、图片个数
% imshow(All_Image(:,:,:,1))
image_R = All_Image(:,:,1,:); %取出图片中R通道的像素值
image_R = reshape(image_R,h*w,n);
image_R = image_R./255;
image_G = All_Image(:,:,2,:); %取出图片中G通道的像素值
image_G = reshape(image_G,h*w,n);
image_B = All_Image(:,:,3,:); %取出图片中B通道的像素值
image_B = reshape(image_B,h*w,n);
size(image_R);
R_rank = rank(image_R);

R_cov = image_R'*image_R; %求得RGB的X'X
G_cov = image_G'*image_G;
B_cov = image_B'*image_B;

R_rank = rank(R_cov); %求得对应协方差矩阵的秩
G_rank = rank(G_cov);
B_rank = rank(B_cov);

[R_eigvec,R_eigval] = eig(R_cov); %求得协方差矩阵的特征值和特征向量
[G_eigvec,G_eigval] = eig(G_cov);
[B_eigvec,B_eigval] = eig(B_cov);

% 计算模态
    R_mode = 1/sqrt(R_eigval(n,n))*image_R*R_eigvec(:,n);
    
    G_mode = 1/sqrt(G_eigval(n,n))*image_G*G_eigvec(:,n);
   
    B_mode = 1/sqrt(B_eigval(n,n))*image_B*B_eigvec(:,n);
    

    %计算系数
    for j = 1:R_rank
        R_para(j) = sum(image_R(:,n).*R_mode(j));
    end
    for j = 1:G_rank
        G_para(j) = sum(image_G(:,n).*G_mode(j));
    end
    for j = 1:B_rank
        B_para(j) = sum(image_B(:,n).*B_mode(j));
    end



figure(50);
plot3(R_para,G_para,B_para);
grid on;hold on;
comet3(R_para,G_para,B_para,0.1);
