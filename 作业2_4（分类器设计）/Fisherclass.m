function number=Fisherclass(testsample)
load template pattern
fishnum=zeros(1,10);
number=1;
 
for i=1:10
    for j=1:i
        number1=Fish2class(pattern,testsample,i,j);
        fishnum(number1)=fishnum(number1)+1;
    end
end
 
maxval=fishnum(1);
 
for i=2:10
    if fishnum(i)>maxval
        maxval=fishnum(i);
        number=i;
    end
end
number=number-1;