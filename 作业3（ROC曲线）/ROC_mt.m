S=rand(1,101);              %����predict����
t=rand(1,101);
T=[];
for i=1:101
    if t(i)<=0.50
        T(i)=0;
    else
        T(i)=1;
    end                        %����Truth
end

FPR=[];
TPR=[];

for j=1:101                    %����ÿһ��predict��Ϊ��ֵ
   Tp=0;
   Fn=0;
   Fp=0;
   Tn=0;
   d=Define(S(j),S);
   for k=1:101
       if T(k)==1&&d(k)==1
           Tp=Tp+1;
       elseif T(k)==1&&d(k)==0
           Fn=Fn+1;
       elseif T(k)==0&&d(k)==1
           Fp=Fp+1;
       elseif T(k)==0&&d(k)==0
           Tn=Tn+1;
       end     
   end
   FPR(j)=Fp/(Fp+Tn);               %����ÿһ����ֵ��Ӧ��TPR��FPR
   TPR(j)=Tp/(Tp+Fn);
end
FPR(102)=0;                        %����0,0��ֵ����
TPR(102)=0;
plot(FPR,TPR,'*')                   %����ͼ��

           
          
    