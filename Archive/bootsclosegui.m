% Bootstrap the data time series and compute the number of elliot waves in
% the bootstrapped series.
% total: number of elliot waves in the data

function [total CI] = bootsclosegui(data, Nsims,k)
    
    returns = (data(2:end,:) - data(1:end-1,:)) ./data(1:end-1,:);
    sizecc = length(returns);

    
    % Create a matrix of uniformly distributed numbers form 1 to length(data) 
    samples = ceil(rand(sizecc,Nsims)*sizecc);  % for the bootstrap series
    total = 0;
    
    for n = 1:Nsims
        
        
       newReturns = 1 + returns(samples(:,n));  % Construct bootstrap return series.   
       newC = data(1) * cumprod(newReturns);    % Construct bootstrap price series.
       HP = zigzaggui(newC,k);                  % Get the number of turning points
       waves = Elliots(HP);                     % From the turning points get the number of elliot waves
       total = total + waves;                   % Used to sum up the total number of elliot waves in the bootstrapped series.
       count(n) = waves;                        % Get the number of elliot waves per bootstrap 

   
    end
 
    avg = mean(count);
    dev = std(count);
    alpha = 0.95; % confidence interval parameter
    CI = avg + norminv(0.5+alpha/2)*dev/sqrt(Nsims)*[-1 1]; % approximate 100*alpha% confidence interval  
    

end