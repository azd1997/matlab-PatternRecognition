function data=GetFeature(I)

[row,col]=find(I==0);                        %返回数字的上下左右的边界
I=I(min(row):max(row),min(col):max(col));    %截取手写数字图像，使其紧包含数字边界，不包含多余的空白
imwrite(I,'yourHandWriting.bmp','bmp');          %保存截取后的手写数字图像

[row,col]=size(I);
r=fix(row/5);  %为分25块做准备  fix向0靠近取整
c=fix(col/5);
sum=0;  %计算黑像素块数目
k=1;

data=[];
for i=1:r:5*r  %先从行开始计算 ex. r=10 1:10:50 遍历 1 11 21 31 41
    for j=1:c:5*c  %保持行不变，先计算列
        for m=i:i+r-1
            for n=j:j+c-1       % I(m,n)表示25块之一的这个位置的图片块
                if I(m,n)==0
                    sum=sum+1;  %每一块中的黑像素的数目  0表示黑，1表示白
                end
            end
        end
        data(k)=sum/(r*c);  %第k个特征分量，即第k块的黑像素率，k最大为25
        sum=0;
        k=k+1;
    end
end
data=data'; %将当前手写数字的特征向量由行向量变为列向量

end