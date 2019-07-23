clear; clc;  
predict=(0:1/100:1);            %生成预测阈值  
ground_truth=randi([0,1],1,101);%生成0-1随机向量  
result=roc(predict,ground_truth);  
disp(result);


