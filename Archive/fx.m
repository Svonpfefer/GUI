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

% Build URL string ( this will be the website matlab will go to fetch the 
% data.
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
% Look for (below) in the buffer: 
% <Obs TIME_PERIOD="1999-01-04" OBS_VALUE="1.1789" OBS_STATUS="A" OBS_CONF="F"/>
while zz
    
    mm = char(readLine(buffer));
    zz = isempty(strfind(mm,target1));       
end
% Split the string into three parts:
% Part 1:  <Obs TIME_PERIOD="1999-01-04" OBS_VALUE="
% Part 2: 1.1789
% Part 3: OBS_STATUS="A" OBS_CONF="F"/>
c = strsplit(mm, {target1,target2});
% The value is in the second string
data = c(2);
% Convert a string into a number.
fxprice(index) = str2num(str2mat(data));

index = index+1;

% continue to read every line in the buffer until there is are no more 
% values of the fx.
while zz == 0 
    
    mm = char(readLine(buffer));
    zz = isempty(strfind(mm,target1));
    c = strsplit(mm, {target1,target2});
    if zz == 0 % If zz == 0, then in the buffer there isn't target1 or target 2: No more values of the FX.
        data = c(2);
        fxprice(index) = str2num(str2mat(data));
        index = index+1;
    end
    
end
fxprice = fxprice';