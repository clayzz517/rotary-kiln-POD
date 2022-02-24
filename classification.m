 clc;
 clear;
 load('C:\Users\86138\Desktop\TRAIN.mat')
 B = TreeBagger(3,train_data,train_label);
 predict_label = predict(B,test_data);
 predict_label = cell2mat(predict_label);
 predict_label = str2num(predict_label);
 accuracy = length(find(predict_label == test_label))/length(test_label)*100