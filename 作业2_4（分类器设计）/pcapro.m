function [y1,y2]=pcapro(data)

load template pattern;

mixedsig=[];
sum1=0;
for i=1:10
    sum1=sum1+pattern(1,i).num; %sum1为所有样品类别的总数
    mixedsig=[mixedsig pattern(1,i).feature]; %所有样品特征向量的集合
end

[Dim, NumofSampl]=size(mixedsig);    %Dim返回的是行数，NumofSampl返回的是列数
dsig_cov=cov(mixedsig');

[pc,latent,tspuare]=pcacov(dsig_cov);
temp=0;
con=0;
m=0;

sum2=sum(latent);   %协方差矩阵所有特征值的和
for i=1:25
    if con<0.9
        temp=temp+latent(i);
        con=temp/sum2;  %累积贡献率
        m=m+1;
    else
        break;  %跳出for循环
    end
end
%disp(m);

pc(:,m+1:25)=[];%非主成分则为0
%disp(size(pc));
%disp(size(data));
x=data'*pc;
y=mixedsig'*pc;
y1=y';
y2=x';
end






















    