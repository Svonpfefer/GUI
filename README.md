GUI
===

Matlab

The folder contains my Technical Analysis coursework where I wrote a matlab gui to count the number of elliot waves in a price series.
The Gui can import FX data, and stock data from either matlab or yahoo finance. 
The Gui also has a zig-zag component, where the price series is filtered for changes greater then a certain amount. 


TAgui.m is the actual GUI file.
Elliots.m estimates the number of elliot waves in the price series
bootsclosegui.m calculates the number of elliot waves in a bootstrapped series.
fx.m retrieves fx data from the ecb
getdata.m retrieves data using Matlab's retrieve command and cleans the data to remove all zero volume days.
zigzaggui.m filters the data depending on the filter % .
