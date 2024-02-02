function Components = mexGraphConnectedComponents(Graph)
% Finds all strongly connected components in directed graph. 
% All Nodes belonging to the same cluster can be reached one from another. 
% That is: u and v belong to the same component if and only if there are paths (u,v) and (v,u).
% Only components larger then 1 are returned.
%
% Receives:
%   Graph			-   struct					-   Graph, created with GraphLoad
%
% Returns:
%	Components		-	cell array				-	List of strongly connected components (SCC). Each cell lists the nodes in the component.
%
% Algorithm:
%	Kosaraju's algorithm
%	
%
% References:
%	 Rao S. Kosaraju. Unpublished. 1978.
%    Alfred V. Aho, John E. Hopcroft, Jeffrey D. Ullman. The Design and Analysis of Computer Algorithms. Addison-Wesley, 1974.
%    Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein. Introduction to Algorithms, 2nd edition. The MIT Press, 2001. ISBN 0-262-03293-7.
%
%
% Example:
%
%
%
% See Also:
%	 GraphLoad
%
% Created:
%   Lev Muchnik    27/06/2006, Tel.: 972-054-4326496, lev@topspin.co.il
%
% Major Update:
%		Lev Muchnik, 05/07/2006
%		Dramatically optimized - factor of 8 in speed, even more for larger graphs. 
%		Memory requirements reduced
%		The function does not return components of size 1.

%{
Data = [ [1 2]; [ 2 3]; [3 4]; [4 3]; [5 1]; [2 5]; [5 6]; [2 6]; [6 7]; [7 6]; [3 7]; [7 8]; [4 8]; ];
Graph = ObjectCreateGraph(Data);
Components = mexGraphConnectedComponents(Graph);
%}