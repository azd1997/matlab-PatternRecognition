function data=GetFeature(I)

[row,col]=find(I==0);                        %�������ֵ��������ҵı߽�
I=I(min(row):max(row),min(col):max(col));    %��ȡ��д����ͼ��ʹ����������ֱ߽磬����������Ŀհ�
imwrite(I,'yourHandWriting.bmp','bmp');          %�����ȡ�����д����ͼ��

[row,col]=size(I);
r=fix(row/5);  %Ϊ��25����׼��  fix��0����ȡ��
c=fix(col/5);
sum=0;  %��������ؿ���Ŀ
k=1;

data=[];
for i=1:r:5*r  %�ȴ��п�ʼ���� ex. r=10 1:10:50 ���� 1 11 21 31 41
    for j=1:c:5*c  %�����в��䣬�ȼ�����
        for m=i:i+r-1
            for n=j:j+c-1       % I(m,n)��ʾ25��֮һ�����λ�õ�ͼƬ��
                if I(m,n)==0
                    sum=sum+1;  %ÿһ���еĺ����ص���Ŀ  0��ʾ�ڣ�1��ʾ��
                end
            end
        end
        data(k)=sum/(r*c);  %��k����������������k��ĺ������ʣ�k���Ϊ25
        sum=0;
        k=k+1;
    end
end
data=data'; %����ǰ��д���ֵ�������������������Ϊ������

end