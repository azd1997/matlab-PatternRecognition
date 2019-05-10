function [max_hi, label_x] = eiger_Bayes_min_error(img, trainset, trainset_length,index)
%EIGER_BAYES1 此处显示有关此函数的摘要
%   此处显示详细说明
N = 60000;  % 也可以用sum(trainset_length)
Pw = zeros(10,1);  %先验概率集合预定义,P(wi)=Ni/N
% P = zeros(10, 784);    % Pj(wi)  (wi类，第j个特征，这里把每幅图片784个像素点灰度值作为特征)
% PXw = zeros(10,1);  %类条件概率P（X|wi）
% PwX = zeros(10,1);  % 后验概率P（wi|X）

X_ = zeros(784,10);  %各类图片的特征平均值向量的集合
S = zeros(784,7840);  %各类协方差矩阵的集合
Sr = zeros(784,7840);   %各类协方差矩阵的逆的集合
detS = zeros(10,1);   %各类协方差矩阵的行列式的集合

H = zeros(10,1);   %各类的判别函数值的集合

%% 1. 求出每一类手写数字的特征均值
for i = 1 : 10
    for k = 1 : 784
        trainset_i = trainset(:, index(i,1):index(i,2));
        X_(k,i) = sum( trainset_i(k, :) );
    end
end

%% 2.求每一类的协方差矩阵、逆及行列式
for i = 1:10
    trainset_i = trainset(:, index(i,1):index(i,2));     
    cov_i = cov(trainset_i');  % cov输入m*n矩阵，输出n*n协方差矩阵
    S(:,(i-1)*784+1 : i*784) = cov_i;
    Sr(:,(i-1)*784+1 : i*784) = inv(cov_i);
    detS(i,1) = det(cov_i);
end

%% 3.求每一类的先验概率（近似）
for i = 1:10
    Pw(i) = trainset_length(i) / N;
end

%% 4.计算各类的判别函数值
%待分类图片特征向量img应为列。
for i = 1:10
    delta_X = zeros(length(img),1);
    for j = 1:length(img)
        delta_X(j) = img(j) - X_(j,i);
    end
    %delta_X = img - X_(:,i);  %列向量
    Sri = Sr(:,(i-1)*784+1 : i*784);
    Pwi = Pw(i);
    detSi = detS(i,1);
    H(i,1) = -0.5 * delta_X' * Sri * delta_X + ln( Pwi ) - 0.5*ln( detSi );
end

%% 5.比较判别函数值，确定分类
[max_hi, max_hi_index] = max(H);
label_x = max_hi_index - 1;




