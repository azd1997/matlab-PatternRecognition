load template pattern
sum=0;
total=0;
for i=1:10
    total=pattern(1,i).num+total;
end
accu=[];
%disp(size(pattern(1,1).feature(1:25,1)));
for i=1:10
    sum=0;
    %disp(size(pattern(1,1).feature(1:25,1)));
    for j=1:pattern(1,i).num
        %disp(size(pattern(1,i).feature(1:25,j)));
        Result=BayesLeastError(pattern(1,i).feature(1:25,j));
        if Result == i-1
            sum=sum+1;
        end
    end
    accu(i)=sum/pattern(1,i).num*100;
end

sum=0;
for i=1:10
    for j=1:pattern(1,i).num
        %disp(pattern(1,i).feature(1:25,j));
        Result=BayesLeastError(pattern(1,i).feature(1:25,j));
        if Result == i-1
            sum=sum+1;
        end
    end
end
accuracy=sum/total*100;
plot([0,9],[accuracy,accuracy]);
hold on
plot(0:9,accu);
