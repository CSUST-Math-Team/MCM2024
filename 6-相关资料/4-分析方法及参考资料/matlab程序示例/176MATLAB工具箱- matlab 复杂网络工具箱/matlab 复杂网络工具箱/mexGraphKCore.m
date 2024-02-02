/****************************************************************************
function Graph = mexGraphKCore(Graph,K,Direction)
% Returns the k-core of the supplied graph in which every node has at least K neighbours.
%
% Receive:
%	Graph		-	Graph Struct	-	Struct created with ObjectCreateGraph function (probanly called by GraphLoad).
%	K			-	integer, >0		-	The minimal degree of each node of the resultant graph.
%	Direction	-	string			-	(optional) Either 'direct','inverse' or 'both'. Case insensitive. The incoming or outgoing links are 
%										followed as a function of this parameter. Default: 'direct'
% Returns: 
%	Graph		-	Graph Struct	-	The graph, consisting only of the nodes with degree equal or higher then K. The function re-enumerates 
%										the node IDs with mexGraphSqueeze function.
% 
% See Also:
%	ObjectCreateGraph , GraphLoad, mexGraphSqueeze
%																										
%Created:																							
%	Lev Muchnik,	29/01/05
%	lev@topspin.co.il, +972-54-326496																							
%  
%
%

****************************************************************************/
