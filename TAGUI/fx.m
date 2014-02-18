 function fxprice = fx(tick)


% Get EUR/tick price from European central website, input tick as
% a string. 
%
% For example fx('usd')
%
% USD United States Dollar ----- GBP Great British Pound
% JPY Japanese Yen ------------- HUF Hungarian forint
% BGN Bulgarian Lev ------------ LTL Lithuanian litas
% CZK Czech Koruna ------------- LVL Latvian Lats
% DKK Danish Krone ------------- PLN Polish zloty
% RON New Romanian leu --------- AUD Australian Dollar 
% SEK Swedish krona ------------ BRL Brasilian real
% CHF Swiss franc -------------- CAD Canadian Dollar
% NOR Norwegian krone ---------- CNY Chinese yuan remnibi
% HRK Croatian kuna ------------ HKD Hong Kong Dollar
% RUB Russian rouble ----------- IDR Indonesian rupiah
% TRY Turkish lira ------------- ILS Israeli shekel
% INR Indian Rupee ------------- PHP Philippine peso
% KRW South Korean won --------- SGD Singaporean Dollar
% MXN Mexican peso ------------- THB Thai baht
% MYR Malaysian ringgit -------- ZAR South African rand
% NZD New Zealand dollar -------

url_string = 'http://www.ecb.int/stats/exchange/eurofxref/html/';
url_string = strcat(url_string, tick,'.xml'   );



% Open a connection to the URL and retrieve data into a buffer
buffer      = java.io.BufferedReader(...
              java.io.InputStreamReader(...
              openStream(...
              java.net.URL(url_string))));

       
zz = 1;          
target1 = ' OBS_VALUE="';
target2 = '" OBS_STATUS';
index = 1;

while zz
    
    mm = char(readLine(buffer));
    zz = isempty(strfind(mm,target1));
        
end
c = strsplit(mm, {target1,target2});
data = c(2);
fxprice(index) = str2num(str2mat(data));

index = index+1;


while zz == 0 
    
    mm = char(readLine(buffer));
    zz = isempty(strfind(mm,target1));
    c = strsplit(mm, {target1,target2});
    if zz == 0
        data = c(2);
        fxprice(index) = str2num(str2mat(data));
        index = index+1;
    end
    
end
fxprice = fxprice';