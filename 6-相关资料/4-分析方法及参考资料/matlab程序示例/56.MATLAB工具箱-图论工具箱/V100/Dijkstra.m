function final=Dijkstra(A,x,y) 
% Dijkstra's Shortest Path 
% final=Dijkstra(A,x,y) 
% Description: returns the shortest path from x to y given adjacency 
% matrix A. Utilizes Dijkstra's shortest path algorithm. 
% A = adjacency matrix of the graph (includes point x and y) 
% x = intial node 
% y = terminal node 
% IN = set of nodes whose shortest path from x is known 
% z,p = temporary nodes 
% d = vector of lengths from initial point. i.e. d(p) = x to p 
% s = vector of the previous node on a shortest path for any node 
% Author: Josh Eads 
% Date: 1/23/2006 

%modify A so that lengths of 0 are invalid (-1) 
A(find(A == 0)) = NaN; 
%initialize IN to include only x 
IN = x; 
%initialize s 
s = zeros(1,length(A)); 
%initialize d & d(x) (distance to self) 
d = zeros(1,length(A)); 
d(x) = 0; 
%loop through all the nodes in A 
for z = 1:length(A) 
%don't calculate values already in IN 
%if ~(find(IN == z)) 
if ~isWithin(IN, z) 
%grab the distance from x to z from A (-1 denotes unreachable) 
d(z) = A(x,z); 
%set the previous node to x 
s(z) = x; 
end 
end 
%process nodes into IN 
%while y isn't in set IN 
%while ~(find(IN == y)) 
while ~isWithin(IN, y) 
tempMin = []; 
%add the node not in IN with the minimum distance into IN 
for z = 1:length(A) 
%if z isn't in IN 
%if ~(find(IN == z)) 
if ~isWithin(IN, z) 
tempMin = [tempMin, d(z)]; 
end 
end 
%find the minimum value from tempMin 
p = min(tempMin); 
%find the minimum distance nodes 
search = find(d == p); 
%cycle through all the minimum distance nodes until one not in IN is 
%found 
for i = 1:length(search) 
search = find(d == p); 
%store in p if the node isn't in IN 
if( ~isWithin(IN, search(i)) ) 
p = search(i); 
break; 
end 
end 
%add node p into IN 
IN = [IN, p]; 
%recompute d for all non-IN nodes, and adjust s 
for z = 1:length(A) 
%if z isn't in IN 
%if ~(find(IN == z)) 
if ~isWithin(IN, z) 
oldDistance = d(z); 
%if the new path is shorter for z, update d(z) 
d(z) = min(d(z), d(p) + A(p,z)); 
%if the new and old distances don't match, update s(z) 
if ~(d(z) == oldDistance) 
s(z) = p; 
end 
end 
end 
end 
%write the shortest path to final 
final = y; 
z = y; 
while (z == x) == 0 
final = [final, s(z)]; 
z = s(z); 
end 
final=fliplr(final); 

function truth = isWithin(source, search) 
% isWithin Function 
% source = matrix to search through 
% search = item to search for 
% returns - true if search is within source 

truth = 0; 
for i = 1:length(source) 
if(source(i) == search) 
truth = 1; 
end 
end
