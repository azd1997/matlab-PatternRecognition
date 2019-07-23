function Result=BayesTwoValue(data)

clc;
load template pattern;

%求先验概率
sum = 0;
pw = []; %P(wi)---先验概率

for i = 1:10
    sum = sum+pattern(1,i).num;
end
for i = 1:10
    pw(i) = pattern(1,i).num/sum;
end

%求类条件概率
p=[];
pxw=[]; %P(x|wi)---类条件概率

for i = 1:10             
    for j = 1:25
        sum = 0;
        for k = 1:pattern(1,i).num
            if pattern(1,i).feature(j,k)>0.1    %第i类第k个样品的第j个特征值
                sum = sum+1;
            end
        end
        p(j,i) = (sum+1)/(pattern(1,i).num+2);  
    end
end

for i = 1:10
    sum = 1;
    for j = 1:25
        if data(j)>0.1
            sum = sum*p(j,i);
        else
            sum = sum*(1-p(j,i));
        end
    end
    pxw(i) = sum;
end

%求后验概率
sum = 0;
pwx = [];   %P(wi|x)---后验概率

for i = 1:10
    sum = sum+pw(i)*pxw(i);
end

for i = 1:10
    pwx(i) = pw(i)*pxw(i)/sum;
end

[maxval,maxpos] = max(pwx);
%返回行向量maxval和maxpos，maxval向量记录A的每列的最大值，maxpos向量记录每列最大值的行号。
Result= maxpos-1;         %maxpos的范围是1-10，可是数字类应为0-9，所以减1

end

