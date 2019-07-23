function number1=Fish2class(pattern,testsample,p,q)
xmeans=zeros(2,25);
s=zeros(2,25,25);
sw=zeros(25,25);
swinv=zeros(25,25);
w=zeros(1,25);
difxmeans=zeros(1,25);
x=zeros(1,25);
m0=0;
m1=0;
y0=0;
num0= pattern(p).num;
num1= pattern(q).num;
mode0 = [];     %两类样品特征
mode1 = [];
 
for i=1:num0
    for j=1:1:25
        xmeans(1,j)=xmeans(1,j)+pattern(p).feature(j,i);
        mode0(i,j)=pattern(p).feature(j,i);
    end
end
for i=1:num1
    for j=1:1:25
        xmeans(2,j)=xmeans(2,j)+pattern(q).feature(j,i);
        mode1(i,j)=pattern(q).feature(j,i);
    end
end
 
for i=1:25
    xmeans(1,i)=xmeans(1,i)/num0;
    xmeans(2,i)=xmeans(2,i)/num1;
end
 
for i=1:1:25
    for j=1:1:25
        s0=0;
        s1=0;
        for k=1:num0
            s0=s0+(mode0(k,i)-xmeans(1,i))*(mode0(k,j)-xmeans(1,j));
        end
        s0=s0/(num0-1);
        s(1,i,j)=s0;
        for k=1:num1
            s1=s1+(mode1(k,i)-xmeans(2,i))*(mode1(k,j)-xmeans(2,j));
        end
         s1=s1/(num1-1); 
         s(2,i,j)=s1;
    end
end
%****************************
%求类间离散度矩阵
for i=1:25
    for j=1:25
        sw(i,j)=s(1,i,j)+s(2,i,j);
    end
end
%********************************
%求sw的逆
swinv=pinv(sw);
%********************************
for i=1:25
    difxmeans(i)=xmeans(1,i)-xmeans(2,i);
end
for i=1:25
    w=(difxmeans)*swinv;%列向量
end
for i=1:num0
    m0=m0+w*mode0(i,:)';
end
for i=1:num1
    m1=m1+w*mode1(i,:)';
end
m0=m0/num0;
m1=m1/num1;
y0=(num0*m0+num1*m1)/(num0+num1);
 
for i=1:25
    x(i)=testsample(i);
end
    y=w*x';
   if y>y0
       number1=p;
   else
       number1=q;
   end
end