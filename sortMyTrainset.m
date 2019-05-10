function [sortedData,numImages,index ] = sortMyTrainset( images, labels )
%SORTMYTRAINSET 整理导入的数据集中数据与标签，返回各类别数组等相关信息。
length_labels = length(labels);

data0 = [];data1 = [];data2 = [];data3 = [];data4 = [];
data5 = [];data6 = [];data7 = [];data8 = [];data9 = [];
for i = length_labels : -1 : 1
    switch(labels(i))   %遍历标签数组，进行switch匹配
        case 0
            data0 = [data0, images(:,i)] ;
        case 1
            data1 = [data1, images(:,i)];
        case 2
            data2 = [data2, images(:,i)];
        case 3
            data3 = [data3, images(:,i)];
        case 4
            data4 = [data4, images(:,i)];
        case 5
            data5 = [data5, images(:,i)];
        case 6
            data6 = [data6, images(:,i)];
        case 7
            data7 = [data7, images(:,i)];
        case 8
            data8 = [data8, images(:,i)];
        case 9
            data9 = [data9, images(:,i)];
    end
end

[~, c0]=size(data0);
[~, c1]=size(data1);
[~, c2]=size(data2);
[~, c3]=size(data3);
[~, c4]=size(data4);
[~, c5]=size(data5);
[~, c6]=size(data6);
[~, c7]=size(data7);
[~, c8]=size(data8);
[~, c9]=size(data9);
numImages = [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9];
sortedData = [data0, data1, data2,data3, data4,data5,data6, data7,data8,data9];
%如何取用数据：
%如取data3，则先a = c0+c1+c2; b=a+c3; data3 = sortedData(:,a+1:b);  

%数据索引可以直接根据得到的各类别长度写出，如index = 1，index2 = 5924, ....
%也可以通过下面计算
%计算各类目下数据个数索引
index = zeros(10,2);
for i = 1:10
    for i1 = 1:i
        index(i,2) = index(i,2) + numImages(i1);
    end
    index(i,1) = index(i,2)+1 - numImages(i);
end


