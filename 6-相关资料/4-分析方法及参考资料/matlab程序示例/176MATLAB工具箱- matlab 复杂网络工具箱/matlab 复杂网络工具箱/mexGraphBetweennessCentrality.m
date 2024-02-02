function [BetweennessCentrality, Nodes] = mexGraphBetweennessCentrality(Graph,Nodes,Direction,ShowProgress)
% Computes betweenneess centrality of each node. 
%   
% Receives:
%   Graph		-   Graph Struct        -    the graph loaded with GraphLoad
%   SourceNodes -	array of double     -    (optional) nodes, from which passes start. Default: [] (all nodes).
%	Direction	-	string				-	(optional) Either 'direct','inverse' or 'both'. Case insensitive. The incoming or outgoing links are 
%											followed as a function of this parameter. Default: 'direct'
%	ShowProgress-	boolean				-	(optional) Causes the function to print progress messages in MatLab command prompt. Usefull for following the 
%											function progress and fine-tunning the function and it sparameters. Default: 1 (true)
%   
% Returns:
%   BetweenneessCentrality  -   array of double -   Betweenneess Centrality for each node.
%   Nodes                   -   array of double -   (optional)List of all nodes for which betweennessn centrality is computed
%
% Algorithm:
%   http://www.boost.org/libs/graph/doc/betweenness_centrality.html
%	Make sure the graph is passed through the 'mexGraphSqueeze' funtions so that the nodes are enumerated continuesly, without skipping numbers.
%
% Example:
%	[BetweennessCentrality, Nodes] = mexGraphBetweennessCentrality(DLLGraph,[],'direct',0);
%
% See Also:
%       mexGraphAllNodeShortestPasses
%		mexGraphSqueeze
%
% Created:
%	Lev Muchnik    18/03/2005, Tel.: 972-054-4326496
%
% Major Changes:
% Lev Muchnik    02/07/05 (Venice, Italy), Tel.: 972-054-4326496
%	ShowProgress parameter is added to the function prototype.
%	The 'Direction' parameter is documented.
%	'Example' section is added to the documentation.
