function Result=BayesLeastError(data)
clc;
load template pattern;

%将数字特征转化为0、1两个数值表示
for i=1:10
    for j=1:25
        for k=1:pattern(1,i).num
            if pattern(1,i).feature(j,k)>0.1
               pattern(1,i).feature(j,k)=1;
            else
                pattern(1,i).feature(j,k)=0;
            end
        end
    end
end


[pc_template,pc_data]=pcapro(data);  %主成分分析
temp=0;
for i=1:10
    pattern(1,i).feature=pc_template(:,temp+1:temp+pattern(1,i).num);
    temp=temp+pattern(1,i).num;
end

%求协方差矩阵、协方差矩阵的逆矩阵、协方差矩阵的行列式
s_cov=[];
s_inv=[];
s_det=[];
for i=1:10
    s_cov(i).data=cov(pattern(1,i).feature');
    s_inv(i).data=inv(s_cov(i).data);
    s_det(i)=det(s_cov(i).data);
end

%求先验概率
sum=0;
pw=[];  %P(wi)---先验概率
for i=1:10
    sum=sum+pattern(1,i).num;
end
for i=1:10
    pw(i)=pattern(1,i).num/sum;
end


%求判别函数
h=[];   %h()---差别函数
mean_data=[];    %mean_data---每类样品特征向量的均值
for i=1:10
    mean_data(i).data=mean(pattern(1,i).feature')';
end

%判别函数
for i=1:10
   h(i)=(pc_data-mean_data(i).data)'*s_inv(i).data*(pc_data-mean_data(i).data)...
        *(-0.5)+log(pw(i))+log(abs(s_det(i)))*(-0.5);   %此处省略了log2Π，它是常数，求最值不影响
end

[maxval,maxpos]=max(h);
Result=maxpos-1;
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    