function [Graph, varargout] = mexGraphSqueeze(Graph)
% Renumbers the graph nodes so that they are numbered by consecutive numbers. This is assumed for many of the Graph  toolbox functions
%
% Receive:
%		Graph	-	Graph Struct	-	Struct created with ObjectCreateGraph function (probanly called by GraphLoad.
%
% Returns: 
%		Graph	-	Graph Struct		-	The same graph with node numbers re-enumerated
%		LUT		-	Nx2 of integers	-	(optional)  Look up table of the size Nx2 (N - number of nodes in the graph) with the 
%															order in which the node's numbering was changed. Can be used for corresponding ordering 
%															of other node parameters.
%
% Remarks:
%  The function may crash if only some of the nodes are indexed. 
% 
% See Also:
%		ObjectCreateGraph , GraphLoad
%																	
%									
%Created:																							
%	Lev Muchnik,	04/06/04 (Cologne University)
%	lev@topspin.co.il, +972-54-326496																							
%Major Update:  
%	Lev Muchnik,	12/02/05
%	The function also supports Index field of Graphs, maintaining agreement between node index and name.
%
%	Lev Muchnik,	21/02/2005
%	Index can contain unlinked nodes and the squeeze operation re-enumerates them properly.
%
%	Lev Muchnik,	07/08/2005
%	LUT parameter added.
%	The function is also applied to all properties (Graph.Index.Properties.Values field).
