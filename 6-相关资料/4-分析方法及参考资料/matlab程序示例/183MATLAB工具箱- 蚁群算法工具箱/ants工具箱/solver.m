function [dy,dx,mark,carry] = solver(nain,food,ants,scent)
%SOLVER The ant brain.
%   
%  INPUTS: (all 5x5 matrices, the ant is located at the center)
%  main  -- anthills (1), impassable regions (-1), and open space (0)
%  food  -- number of sugar cubes
%  ant   -- number of ants (always be at least 1 at (3,3))
%  scent -- strength of chemical scent (decreases by one each time interval)
% 
%  OUTPUTS: (all scalars)
%  dy    -- delta in rows (-1 is up, 0 no move, 1 is down)
%  dx    -- delta in columns (-1 is left, 0 no move, 1 is right)
%  mark  -- scent left by the ant, any integer between 0 and 100
%  carry -- logical indicating if the ant will carry one unit of food or not

dy = 0;
dx = 0;
mark = 0;
carry = logical(0);