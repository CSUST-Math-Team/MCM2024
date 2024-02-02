function [Circles CirclesHistogram] = mexCirclesOfDegree(Graph)
% For the specified node in graph, the function returns a list of ALL
% shortes circles which are from degree of the minmum shortest circle to the 
% maximum shortest circle 
% Receives:
%       Graph       -   Graph Struct			-   the graph loaded with GraphLoad
%
%
% Returns:
%		Circles		- struct	-  a struct which contains all the circles of each degree 
%		CirclesHistogram	- array	-  (optional) Contains number of shortest circles initiated of each length. 
%  
% Example:
%	Graph = GraphLoad('E:\Projects\Evolution\Results\Evolution103._0_0\Evolution103.83.Graph');
%	[A  B]=  mexCirclesOfDegree(Graph)
%
% See Also:
%       mexGraphAllNodeShortestPasses
% remarks:
%     the algorithem is based on the MST its check all the nodes so its O(n*E*log(E)) 
%Created:																							
%	Royi Itzhak 20/6/2005 
%   toyi_its@yahoo.com
% based on Lev Muchnik Graph Tool box
		
