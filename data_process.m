clc;
 clear;
 load('C:\Users\86138\Desktop\MATLAB.mat')
 R_para_normal = R_para_normal';
R_para_over = R_para_over';
R_para_under = R_para_under';
G_para_normal = G_para_normal';
G_para_over = G_para_over';
G_para_under = G_para_under';
B_para_normal = B_para_normal';
B_para_over = B_para_over';
B_para_under = B_para_under';


R_normal_train = R_para_normal(1:270,:);
R_normal_test = R_para_normal(271:end,:);
G_normal_train = G_para_normal(1:270,:);
G_normal_test = G_para_normal(271:end,:);
B_normal_train = B_para_normal(1:270,:);
B_normal_test = B_para_normal(271:end,:);
R_under_train = R_para_under(1:270,:);
R_under_test = R_para_under(271:end,:);
G_under_train = G_para_under(1:270,:);
G_under_test = G_para_under(271:end,:);
B_under_train = B_para_under(1:270,:);
B_under_test = B_para_under(271:end,:);
R_over_train = R_para_over(1:270,:);
R_over_test = R_para_over(271:end,:);
G_over_train = G_para_over(1:270,:);
G_over_test = G_para_over(271:end,:);
B_over_train = B_para_over(1:270,:);
B_over_test = B_para_over(271:end,:);

train_label_n = linspace(1, 1, 270)';
train_label_o = linspace(2, 2, 270)';
train_label_v = linspace(3, 3, 270)';
train_label_order = [train_label_n ; train_label_o ; train_label_v]; 

test_label_n = linspace(1, 1, 30)';
test_label_o = linspace(2, 2, 30)';
test_label_v = linspace(3, 3, 30)';
test_label = [test_label_n ; test_label_o ; test_label_v]; 

train_normal = cat(2, R_normal_train, G_normal_train, B_normal_train);
train_over = cat(2, R_over_train, G_over_train, B_over_train);
train_under = cat(2, R_under_train, G_under_train, B_under_train);
train_data_order = cat(1, train_normal, train_over, train_under);
r = randperm(size(train_data_order,1));
train_data = train_data_order(r, :);
train_label = train_label_order(r, :);

test_normal = cat(2, R_normal_test, G_normal_test, B_normal_test);
test_over = cat(2, R_over_test, G_over_test, B_over_test);
test_under = cat(2, R_under_test, G_under_test, B_under_test);
test_data = cat(1, test_normal, test_over, test_under);


