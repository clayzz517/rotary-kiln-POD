function [ans] = IsStretch(ImageData)
gray_data = rgb2gray(ImageData);
district_Bottom_left = gray_data(1069 : 1078 , 2 : 11);
ave_Bottom_left = mean(district_Bottom_left(:));
district_upper_right = gray_data(3 : 12 , 1909 : 1918);
ave_upper_right = mean(district_upper_right(:));
district_Bottom_right = gray_data(1068 : 1077 , 1906 : 1915);
ave_Bottom_right = mean(district_Bottom_right(:));
if(ave_Bottom_left < 30 & ave_Bottom_right < 20 & ave_upper_right < 20)
    ans = 0;
else
    ans = 1;
end;