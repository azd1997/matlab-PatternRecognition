function [y1,y2]=pcapro(data)

load template pattern;

mixedsig=[];
sum1=0;
for i=1:10
    sum1=sum1+pattern(1,i).num; %sum1Ϊ������Ʒ��������
    mixedsig=[mixedsig pattern(1,i).feature]; %������Ʒ���������ļ���
end

[Dim, NumofSampl]=size(mixedsig);    %Dim���ص���������NumofSampl���ص�������
dsig_cov=cov(mixedsig');

[pc,latent,tspuare]=pcacov(dsig_cov);
temp=0;
con=0;
m=0;

sum2=sum(latent);   %Э���������������ֵ�ĺ�
for i=1:25
    if con<0.9
        temp=temp+latent(i);
        con=temp/sum2;  %�ۻ�������
        m=m+1;
    else
        break;  %����forѭ��
    end
end
%disp(m);

pc(:,m+1:25)=[];%�����ɷ���Ϊ0
%disp(size(pc));
%disp(size(data));
x=data'*pc;
y=mixedsig'*pc;
y1=y';
y2=x';
end






















    