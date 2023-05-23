function [Data,data,Name_matfile,x,y]=Read_input()

mynumber = input('\nEnter a number to choose a Data set:');
switch mynumber
    case 1
        disp ('Nsl-kdd Data');
        train = load ('dataset/Train+pak.txt');
        test = load ('dataset/Test+pak.txt');
        Data = [train
            test];
        Data = Data';
        
        
        x = Data(:,1:end);
        y = Data(end,:);
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1)-1;
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 1;
        
    case 2
        disp ('PHISHING Data');
        Data = load('dataset/PHISHING.txt');
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        d = find(y==-1);
        y(d) = y(d)+3;
        
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 2;
        
        
    case 3
        disp ('ionosphere Data');
        Data = load('dataset/ionosphere.data');
        
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        %         d = find(y=='g');
        %         y(d) = 1;
        %         d2 = find(y=='b');
        %         y(d2) = 2;
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        
        Name_matfile = 3;
        
    case 4
        
        disp ('card Data');
        Data = load('dataset/card.txt');
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        
        Name_matfile = 4;
        
    case 5
        disp ('spambase Data');
        Data = load('dataset/spambase.data');
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        k = find(y==0);
        y(k) = 2;
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        
        
        
        Name_matfile = 5;
        
    case 6
        disp ('heart Data');
        Data = load('dataset/heart.txt');
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        
        Name_matfile = 6;
        
    case 7
        disp ('lymphography Data');
        Data = load('dataset/lymphography.data');
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        
        Name_matfile = 7;
        
    case 8
        disp ('SPECT Data');
        Data1 = load('dataset/SPECT.train');
        Data2 = load('dataset/SPECT.test');
        Data = [Data1
            Data2];
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        k = find(y==0);
        y(k) = 2;
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        
        Name_matfile = 8;
        
    case 9
        disp ('vote Data');
        Data = load('dataset/vote.data');
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        k = find(y==0);
        y(k) = 2;
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 9;
        
    case 10
        disp ('australian Data');
        Data = load('dataset/australian.dat');
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        k = find(y==0);
        y(k) = 2;
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 10;
        
    case 11
        disp ('dermatology Data');
        Data = load('dataset/dermatology.data');
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 11;
        
        
    case 12
        disp ('Satellite Data');
        Data1 = load('dataset/sat.trn');
        Data2 = load('dataset/sat.tst');
        
        Data = [Data1
            Data2];
        
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 12;
        
    case 13
        disp ('waveform Data');
        Data = load('dataset/waveform.data');
        
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        k = find(y==0);
        y(k) = 3;
        
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 13;
        
    case 14
        disp ('sonar Data');
        Data = load('dataset/sonar.all-data');
        
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 14;
        
    case 15
        disp ('Biodegradable Data');
        Data = load('dataset/biodeg.txt');
        
        Data = Data';
        x = Data(:,1:end);
        y = Data(end,:);
        
        data.x=x;
        data.t=y;
        
        data.nx=size(x,1);
        data.nt=size(y,1);
        data.nSample=size(x,2);
        Name_matfile = 15;
        
        
        
    otherwise
        error('only fourteen Daraset');
end
end

