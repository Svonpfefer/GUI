% Retrieve adjusted high, low, open and close prices for a certain ticker
% from a certain time period.

% INPUTS
% ticker:  ticker of data you want to retrieve.
% start:   start of time series retrieved
% finish:  end of time series retrieve

% OUTPUTS
% HIGH: adjusted high price for splits and dividents.
% LOW: adjusted low price for splits and dividents.
% OPEN: adjusted open price for splits and dividents.
% CLOSE: adjusted close price for splits and dividents.


function [HIGH,LOW,OPEN,CLOSE] = getdata(ticker,start, finish)

% fetch data from yahoo
rawdata   = fetch(yahoo,{ticker},start,finish,'d');

% Row    Name
% 1         Date
% 2         Open
% 3         High
% 4         Low
% 5         Close
% 6         Volume
% 7         Adjusted Close   



% Remove holidays from the data (assuming that those are dates when volumes
% trades are 0).

volume    = rawdata(end:-1:1,6);

rawTime   = rawdata(end:-1:1,1);
rawTime = rawTime(volume ~= 0);

OPENvar   = rawdata(end:-1:1,2);
OPENvar = OPENvar(volume ~= 0);

HIGHvar   = rawdata(end:-1:1,3);
HIGHvar = HIGHvar(volume ~= 0);

LOWvar    = rawdata(end:-1:1,4);
LOWvar = LOWvar(volume ~= 0);

CLOSEvar  = rawdata(end:-1:1,5);
CLOSEvar = CLOSEvar(volume ~= 0);

adj_close = rawdata(end:-1:1,7);
adj_close = adj_close(volume ~= 0);

volume    = volume(volume ~= 0);


% Adjust OPEN, HIGH, LOW, CLOSE for splits and dividents.
OPEN = OPENvar  .* adj_close ./ CLOSEvar;
HIGH = HIGHvar  .* adj_close ./ CLOSEvar;
LOW = LOWvar  .* adj_close ./ CLOSEvar;
CLOSE = CLOSEvar  .* adj_close ./ CLOSEvar;


end