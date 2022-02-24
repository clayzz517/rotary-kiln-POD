function [All_Image] = Image2RGB(ImageFolderPath,ImageForm,ImageSize)
SamplePath = ImageFolderPath;  %存储图像的路径
fileExt = strcat('*.',ImageForm);  %待读取图像的后缀名
%获取所有路径
files = dir(fullfile(SamplePath,fileExt)); 
len1 = size(files,1);
%遍历路径下每一幅图像
for i=1:len1
   fileName = strcat(SamplePath,files(i).name); 
   image = imread(fileName);
   image = imresize(image,ImageSize);
   All_Image(:,:,:,i) = image;
end
