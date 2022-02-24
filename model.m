clc;
clear all;
% 加载训练好的模型
load('C:\Users\86138\Desktop\B.mat')
% 设置图片文件夹
pt = 'C:\Users\86138\Desktop\flame\f (';
ext = ').JPG';
nms_temp = 1;
% 依次循环读取图片并计算分类
while(true)
    
    i = 1;
    
    for k = nms_temp:1:nms_temp + 4 % 每次读取五张图片的RGB值
        nm = num2str(k);
        addr = [pt, nm, ext];
        image = imread(addr);
        All_Image(:, :, :, i) = image;
        i = i + 1;
    end
    
    All_Image = double(All_Image); %转化成double格式
    [h w m n] = size(All_Image); % h w m n 表示图片的高度、宽度、RGB维数、图片个数
    image_R = All_Image(:,:,1,:); %取出图片中R通道的像素值
    image_R = reshape(image_R,h*w,n);
    image_G = All_Image(:,:,2,:); %取出图片中G通道的像素值
    image_G = reshape(image_G,h*w,n);
    image_B = All_Image(:,:,3,:); %取出图片中B通道的像素值
    image_B = reshape(image_B,h*w,n);
 
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
  
    
    test_data = cat(2, R_para', G_para', B_para'); % 合成分类器输入数据，其中n代表取最后模态即主模态系数
    predict_label = predict(B,test_data);
    predict_label = cell2mat(predict_label);
    predict_label = str2num(predict_label); % 判断火焰状态，其中1代表正常，2代表过火，3代表弱火
    predict_val = mode(predict_label); %取众数作为预测结果
    if (nms_temp < 40)      %图片标签已知
        test_label = 1;
        if predict_val == 1
        fprintf('判断状态为 正常 ，火焰燃烧状态状态为 正常\n');
        elseif predict_val == 2
        fprintf('判断状态为 过火 ，火焰燃烧状态状态为 正常\n');
        elseif predict_val == 3
        fprintf('判断状态为 弱火 ，火焰燃烧状态状态为 正常\n');
        end
    elseif (nms_temp < 80)
        test_label = 3;
        if predict_val == 1
        fprintf('判断状态为 正常 ，火焰燃烧状态状态为 弱火\n');
        elseif predict_val == 2
        fprintf('判断状态为 过火 ，火焰燃烧状态状态为 弱火\n');
        elseif predict_val == 3
        fprintf('判断状态为 弱火 ，火焰燃烧状态状态为 弱火\n');
        end
    elseif (nms_temp < 120)
        test_label = 2;
        if predict_val == 1
        fprintf('判断状态为 正常 ，火焰燃烧状态状态为 过火\n');
        elseif predict_val == 2
        fprintf('判断状态为 过火 ，火焰燃烧状态状态为 过火\n');
        elseif predict_val == 3
        fprintf('判断状态为 弱火 ，火焰燃烧状态状态为 过火\n');
        end
    end

    
    
    nms_temp = nms_temp + 5;
    
    if(nms_temp > 120)
        nms_temp = 1;
    end
end
    