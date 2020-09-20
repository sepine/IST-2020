clc
clear
addpath('.\liblinear\');

data1 = xlsread('codec.xlsx');
data2 = xlsread('collections.xlsx');
data3 = xlsread('io.xlsx');
data4 = xlsread('jsoup.xlsx');
data5 = xlsread('jsqlparser.xlsx');
data6 = xlsread('mango.xlsx');
data7 = xlsread('ormlite.xlsx');

data = cell(1,7);
data{1,1} = data1;
data{1,2} = data2;
data{1,3} = data3;
data{1,4} = data4;
data{1,5} = data5;
data{1,6} = data6;
data{1,7} = data7;

ttt = 0;
Performance = [];
for i = 1:7
    for j = 1:7
        i
        j
        if i~=j
            target = [];
            source = [];
            target = cell2mat(data(1,i));
            source = cell2mat(data(1,j));
            Performance(1 + ttt * 1, :) = calculate(source, target);
            ttt = ttt+1;
        end
    end
end
size(Performance)
xlswrite('IST_2020.xlsx',Performance);