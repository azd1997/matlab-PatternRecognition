clear; clc;  
predict=(0:1/100:1);            %����Ԥ����ֵ  
ground_truth=randi([0,1],1,101);%����0-1�������  
result=roc(predict,ground_truth);  
disp(result);


