function numSamples = saveSample( num, data )
%SAVESAMPLE 此处显示有关此函数的摘要
%   此处显示详细说明
%  num为正确的数字标签， data为特征列向量； numSamples为标签下的样本量 

load template pattern;
switch num
    case 0 
        %disp(pattern(1,1).feature(1:25,pattern(1,1).num));
        %disp(data);
        if ~isequal(pattern(1,1).feature(1:25,pattern(1,1).num),data)  %避免存入重复样本
            %disp('没有重复');
            pattern(1,1).num=pattern(1,1).num+1;
            pattern(1,1).feature(:,pattern(1,1).num)=data;
            numSamples = pattern(1,1).num;
        else
            numSamples = -1;
        end
    case 1 
        if ~isequal(pattern(1,2).feature(1:25,pattern(1,2).num),data)  
            pattern(1,2).num=pattern(1,2).num+1;
            pattern(1,2).feature(:,pattern(1,2).num)=data;
            numSamples = pattern(1,2).num;
        else
            numSamples = -1;
        end
    case 2 
        if ~isequal(pattern(1,3).feature(1:25,pattern(1,3).num),data)  
            pattern(1,3).num=pattern(1,3).num+1;
            pattern(1,3).feature(:,pattern(1,3).num)=data;
            numSamples = pattern(1,3).num;
        else
            numSamples = -1;
        end
    case 3 
        if ~isequal(pattern(1,4).feature(1:25,pattern(1,4).num),data)  
            pattern(1,4).num=pattern(1,4).num+1;
            pattern(1,4).feature(:,pattern(1,4).num)=data;
            numSamples = pattern(1,4).num;
        else
            numSamples = -1;
        end
    case 4 
        if ~isequal(pattern(1,5).feature(1:25,pattern(1,5).num),data)  
            pattern(1,5).num=pattern(1,5).num+1;
            pattern(1,5).feature(:,pattern(1,5).num)=data;
            numSamples = pattern(1,5).num;
        else
            numSamples = -1;
        end
    case 5 
        if ~isequal(pattern(1,6).feature(1:25,pattern(1,6).num),data)  
            pattern(1,6).num=pattern(1,6).num+1;
            pattern(1,6).feature(:,pattern(1,6).num)=data;
            numSamples = pattern(1,6).num;
        else
            numSamples = -1;
        end
    case 6 
        if ~isequal(pattern(1,7).feature(1:25,pattern(1,7).num),data)  
            pattern(1,7).num=pattern(1,7).num+1;
            pattern(1,7).feature(:,pattern(1,7).num)=data;
            numSamples = pattern(1,2).num;
        else
            numSamples = -1;
        end
    case 7 
        if ~isequal(pattern(1,8).feature(1:25,pattern(1,8).num),data)  
            pattern(1,8).num=pattern(1,8).num+1;
            pattern(1,8).feature(:,pattern(1,8).num)=data;
            numSamples = pattern(1,8).num;
        else
            numSamples = -1;
        end
    case 8 
        if ~isequal(pattern(1,9).feature(1:25,pattern(1,9).num),data) 
            pattern(1,9).num=pattern(1,9).num+1;
            pattern(1,9).feature(:,pattern(1,9).num)=data;
            numSamples = pattern(1,9).num;
        else
            numSamples = -1;
        end
    case 9 
        if ~isequal(pattern(1,10).feature(1:25,pattern(1,10).num),data) 
            pattern(1,10).num=pattern(1,10).num+1;
            pattern(1,10).feature(:,pattern(1,10).num)=data;
            numSamples = pattern(1,10).num;
        else
            numSamples = -1;
        end
    otherwise
        numSamples = -1;    %异常
     
end

save template pattern; 

end

