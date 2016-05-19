% Find the turning points using a zig zag procedure.
% HIGH: High price of asset's time series
% LOW: Low price of asset's time series
% OPEN: Open price of asset's time series
% CLOSE: Close price of asset's time series
% flagplot: if 0: do not plot candles, of 1 do.


function [HP] =  zigzagalt(CLOSE)
global K

% Number      State
%   1         Bear
%   2         Bull
%   3         Unsure


% Initialise the high and low value for zig-zag
initialC = CLOSE(1);
% State of time series.
flag = 0;
% Initalise State matrix for speed
State  = repmat(ones * (1:length(CLOSE))',1,2);
% At the start of the series we don't whether we're in a bull or bear
% market
State(1,1) = 0;
blob = 1;
SIS = 1;

for n = 2:length(CLOSE)
    
    
    % these two if loops are used to find the initial state of the market
    if CLOSE(n) >= (initialC * (1+K))
        flag = 2;
    end
    
    if CLOSE(n) <= (initialC * (1-K))
        flag = 1;
    end

    % depending on the state of the market
    switch flag
        case 0 % Don't know if bull or bear market
            State(n) = flag;
            % Do nothing.
        case 1  %We're in a Bear market
            State(n) = flag;
            
            if State(n) ~= State(n-1) % Turning points are updated when the market goes from bull to bear market.

                HP(blob,1) = initialC;       % Save the highest price when the market was in bull.      
                HP(blob,2) = SIS;
                blob = blob+1;
            end
            
            if CLOSE(n) <= initialC % If asset's price goes lower during bear market update the local low and high
                SIS = n;
                initialC = CLOSE(n);
           
            end
            
        case 2 %We're in a Bull market
            State(n) = flag;
            
            if State(n) ~= State(n-1) % Turning points are updated when the market goes from bear to bull market.
                
                 HP(blob,1) = initialC;         % Save the highest value when the market was in bull.
                 HP(blob,2) = SIS;
                 blob = blob+1;
            end

             if CLOSE(n) >= initialC % If asset's value goes higher during bull market update the local low and high
                SIS = n;
                initialC = CLOSE(n); 
             end
    end

    
end

%   The following is used at the end of the series to consider the lowest or
%   highest asset's value at the end of market 
switch flag
    case 1
        HP(blob,1) = initialC;
        HP(blob,2) = SIS;

        
    case 2 
        HP(blob,1) = initialC;
        HP(blob,2) = SIS;
end
    

end