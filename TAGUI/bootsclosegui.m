% Bootstrap the data time series and compute the number of elliot waves in
% the bootstrapped series.
% total: number of elliot waves in the data

function total = bootsclosegui(data, Nsims,k)
    
    returns = (data(2:end,:) - data(1:end-1,:)) ./data(1:end-1,:);
    sizecc = length(returns);

    
    % Create a matrix of uniformly distributed numbers form 1-length(data) 
    samples = ceil(rand(sizecc,Nsims)*sizecc);
    total = 0;
    
    for n = 1:Nsims
        
        
       newReturns = 1 + returns(samples(:,n));   
       newC = data(1) * cumprod(newReturns);
       HP = zigzaggui(newC,k);
       waves = Elliots(HP);           % From the turning points get the number of elliot waves
       total = total + waves;          % Used to sum up the total number of elliot waves in the bootstrapped series.
         
    end
 
   
    

end