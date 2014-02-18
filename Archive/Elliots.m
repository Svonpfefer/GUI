% Calculate the number of elliot waves depending on the turning points.


function [a,b] = Elliots(HP)

zz = HP(1,1) < HP(2,1);
b = (HP(1+zz:2:end-7,1) < HP(3+zz:2:end-5,1)) & (HP(3+zz:2:end-5,1) < HP(5+zz:2:end-3,1)) & ...
    (HP(5+zz:2:end-3,1) > HP(7+zz:2:end-1,1)) & (HP(6+zz:2:end-2,1) > HP(8+zz:2:end,1));
a = sum(b);