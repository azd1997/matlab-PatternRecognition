function [max_hi, label_x] = eiger_Bayes_min_error(img, trainset, trainset_length,index)
%EIGER_BAYES1 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
N = 60000;  % Ҳ������sum(trainset_length)
Pw = zeros(10,1);  %������ʼ���Ԥ����,P(wi)=Ni/N
% P = zeros(10, 784);    % Pj(wi)  (wi�࣬��j�������������ÿ��ͼƬ784�����ص�Ҷ�ֵ��Ϊ����)
% PXw = zeros(10,1);  %����������P��X|wi��
% PwX = zeros(10,1);  % �������P��wi|X��

X_ = zeros(784,10);  %����ͼƬ������ƽ��ֵ�����ļ���
S = zeros(784,7840);  %����Э�������ļ���
Sr = zeros(784,7840);   %����Э����������ļ���
detS = zeros(10,1);   %����Э������������ʽ�ļ���

H = zeros(10,1);   %������б���ֵ�ļ���

%% 1. ���ÿһ����д���ֵ�������ֵ
for i = 1 : 10
    for k = 1 : 784
        trainset_i = trainset(:, index(i,1):index(i,2));
        X_(k,i) = sum( trainset_i(k, :) );
    end
end

%% 2.��ÿһ���Э��������漰����ʽ
for i = 1:10
    trainset_i = trainset(:, index(i,1):index(i,2));     
    cov_i = cov(trainset_i');  % cov����m*n�������n*nЭ�������
    S(:,(i-1)*784+1 : i*784) = cov_i;
    Sr(:,(i-1)*784+1 : i*784) = inv(cov_i);
    detS(i,1) = det(cov_i);
end

%% 3.��ÿһ���������ʣ����ƣ�
for i = 1:10
    Pw(i) = trainset_length(i) / N;
end

%% 4.���������б���ֵ
%������ͼƬ��������imgӦΪ�С�
for i = 1:10
    delta_X = zeros(length(img),1);
    for j = 1:length(img)
        delta_X(j) = img(j) - X_(j,i);
    end
    %delta_X = img - X_(:,i);  %������
    Sri = Sr(:,(i-1)*784+1 : i*784);
    Pwi = Pw(i);
    detSi = detS(i,1);
    H(i,1) = -0.5 * delta_X' * Sri * delta_X + ln( Pwi ) - 0.5*ln( detSi );
end

%% 5.�Ƚ��б���ֵ��ȷ������
[max_hi, max_hi_index] = max(H);
label_x = max_hi_index - 1;




