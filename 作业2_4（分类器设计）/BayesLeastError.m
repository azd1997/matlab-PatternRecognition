function Result=BayesLeastError(data)
clc;
load template pattern;

%����������ת��Ϊ0��1������ֵ��ʾ
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


[pc_template,pc_data]=pcapro(data);  %���ɷַ���
temp=0;
for i=1:10
    pattern(1,i).feature=pc_template(:,temp+1:temp+pattern(1,i).num);
    temp=temp+pattern(1,i).num;
end

%��Э�������Э�������������Э������������ʽ
s_cov=[];
s_inv=[];
s_det=[];
for i=1:10
    s_cov(i).data=cov(pattern(1,i).feature');
    s_inv(i).data=inv(s_cov(i).data);
    s_det(i)=det(s_cov(i).data);
end

%���������
sum=0;
pw=[];  %P(wi)---�������
for i=1:10
    sum=sum+pattern(1,i).num;
end
for i=1:10
    pw(i)=pattern(1,i).num/sum;
end


%���б���
h=[];   %h()---�����
mean_data=[];    %mean_data---ÿ����Ʒ���������ľ�ֵ
for i=1:10
    mean_data(i).data=mean(pattern(1,i).feature')';
end

%�б���
for i=1:10
   h(i)=(pc_data-mean_data(i).data)'*s_inv(i).data*(pc_data-mean_data(i).data)...
        *(-0.5)+log(pw(i))+log(abs(s_det(i)))*(-0.5);   %�˴�ʡ����log2�������ǳ���������ֵ��Ӱ��
end

[maxval,maxpos]=max(h);
Result=maxpos-1;
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    