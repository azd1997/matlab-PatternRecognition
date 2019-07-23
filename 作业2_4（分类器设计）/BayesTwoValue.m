function Result=BayesTwoValue(data)

clc;
load template pattern;

%���������
sum = 0;
pw = []; %P(wi)---�������

for i = 1:10
    sum = sum+pattern(1,i).num;
end
for i = 1:10
    pw(i) = pattern(1,i).num/sum;
end

%������������
p=[];
pxw=[]; %P(x|wi)---����������

for i = 1:10             
    for j = 1:25
        sum = 0;
        for k = 1:pattern(1,i).num
            if pattern(1,i).feature(j,k)>0.1    %��i���k����Ʒ�ĵ�j������ֵ
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

%��������
sum = 0;
pwx = [];   %P(wi|x)---�������

for i = 1:10
    sum = sum+pw(i)*pxw(i);
end

for i = 1:10
    pwx(i) = pw(i)*pxw(i)/sum;
end

[maxval,maxpos] = max(pwx);
%����������maxval��maxpos��maxval������¼A��ÿ�е����ֵ��maxpos������¼ÿ�����ֵ���кš�
Result= maxpos-1;         %maxpos�ķ�Χ��1-10������������ӦΪ0-9�����Լ�1

end

