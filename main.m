clc;
clear;
close all;

%% Problem Definition

[Data,data,Name_matfile,x,y] = Read_input();
[q,qind] = mapminmax(y);
if Name_matfile ==1
    
    train = Data(:,1:125973);
    test = Data(:,125974:end);
    train = train';
    test = test';
    
elseif Name_matfile ==12
    train = Data(:,1:4435);
    test = Data(:,4436:end);
    train = train';
    test = test';
    
else
    Data = Data';
    [r,c] = size(Data);
    TR = floor(0.7 * r);
    numTr = randperm(r,TR);
    train = Data(numTr,:);
    Data(numTr,:) = [];
    test = Data;
end

MaxRun = 20;
classification_acc = zeros(1,MaxRun);
num_feature = zeros(1,MaxRun);

for Run = 1:MaxRun
    [classification_acc(Run), num_feature(Run) ] = BMTLBO(train,test);
end

ACC = mean(classification_acc);
NumFea = mean (num_feature);

disp([' The Mean Of Best Testing Costs = ' num2str(ACC)]);
disp([' The Mean Of The Number Of Selected Feature = ' num2str(NumFea)]);


