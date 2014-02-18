clear all
close all
clc

D2 = datestr(now,1);
horizon = 10*360;
Workday = datewrkdy(D2,-horizon, 0);
D1 = datestr(Workday);
ticker = '%5EFTSE';
failfetch = 0;
failweb = 0;
global K

% If you can't run either fetch or the other file, change the name of fileID
% to the name of data file you want to import (NB: make sure there's just
% the CLOSE price

fileID = 'ftse1.xlsx';



K = 0.05;

    try fetch(yahoo,ticker,D1,D2);
    catch err
        failfetch = 1;
        disp('you can''t use the fetch command')
        
    end
    
    
  if failfetch  
    try get_hist_stock_data(ticker,D1,D2);
    catch err
        failweb = 1;
        disp('you can''t acces the internet')
    end
  end
    
    flag = 1;
  
    if failfetch
        if failweb
            CLOSE = xlsread('fileID');
        else
            [HIGH,LOW,OPEN,CLOSE] = get_hist_stock_data(ticker,D1,D2);
        end
        
    else
         [HIGH,LOW,OPEN,CLOSE] = getdata(ticker,D1, D2);
        
    end
    
 
    
    
  
% Compute the turning points in the series and plot it.
    HP =  zigzagalt(CLOSE);
    if flag 
        figure(1)
        hold on
        plot(CLOSE)
        plot(HP(1:end,2),HP(1:end,1),'r-o')
        hold off

    end
    % Get the number of elliot waves in the series
    [Ellis,b] = Elliots(HP);



% 
% % Bootstraping series and output the results
Nsims = 1000;
simulatedelliots = bootsclose(CLOSE, Nsims);
avg = simulatedelliots / Nsims; % average the number of elliot waves observed in the bootstrapped series.
sprintf('The number of elliot waves is %i',Ellis)
sprintf('The number of bootstrapped elliot waves is %6.3f',avg)
 
 


 