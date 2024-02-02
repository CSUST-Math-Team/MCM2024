function C = mexGraphClusteringCoefficient(Graph,Nodes,Direction)
% Computes the clustering coefficient for any of the supplied nodes of the Graph.
% By deffinition (Collective dynamics of �small-world� networks Duncan J. Watts* & Steven H. Strogatz), 
% the clusterung coefficient Ck of the node k is the ratio of neigbours of the node k, connected between them.
% Strogatz: The clustering coefficient C(p) is defined as follows. Suppose that a vertex v has kv neighbours; then at most kv?kv 21?=2 edges can exist
% between them (this occurs when every neighbour of v is connected to every other neighbour of v). Let Cv denote the fraction of these allowable edges that actually
% exist. Define C as the average of Cv over all v.
%
% Receives:	
%	Graph		-	Graph Struct	-	Struct created with ObjectCreateGraph function (probanly called by GraphLoad).
%	NodeIDs		-	vector of indeces	-	(optional) List the ID of the node for whitch the coefficient is computed.
%										If Nodes is an empty matrix, all graph nodes are used. 	Default: [] 
%	Direction	-	string			-	(optional) Either 'direct', 'inverse' or 'both'. Case insensitive. The incoming or outgoing links are 
%										followed as a function of this parameter. Default: 'direct'
%
%
%
% Returns: 
%	Ck			-	structure - the structure, containing detailed clustering information about the supplied graph
% 			Field Name							-		Field Type					-	Detailes
%				NodeIDs									-		array	of integers 	- 	Lists IDs of nodes for which the processing was done.
%				NodeDegrees							-		array of integers		-	 	For each node, Degree of each node (see Direction)
%				NodeNeighboursLinks			-		array of integer		-		For each node, Number of links between it's neighbors
%				NodeClusteringCoefficient-	array of double			-		For each node, the clustering coefficient: NodeNeighboursLinks/NodeDegrees/(NodeDegrees+1)
%				Ck											-		array of double			-		For each node degree, an average clustering coefficient of all nodes having this degree
%				k												-		array of integers		-		Degrees used in Ck.
%				C												-		double							-		Average clustering coefficient of all nodes, having their degree > 1.
%
%
%
% Algorithm:
%       D. J. Watts and S. H. Strogatz. Collective dynamics of 'small-world' networks, Nature, 393:440-442 (1998)
%
% See Also:
%	ObjectCreateGraph , GraphLoad
%																										
%Created:																							
%	Lev Muchnik,	14/06/04 (Bonn),15/06/04 (train Cologne->Bielefeld)
%	lev@topspin.co.il, +972-54-326496																							
%
% Major Update,
%		Lev Muchnik,
%		lev@topspin.co.il, +972-54-326496																							
% 	The function now returns a struct containing detailed information about clustering coefficient
%
%% Major Update,
%		Lev Muchnik, 10/04/2005
%		lev@topspin.co.il, +972-54-326496																							
% 	The function now accepts 'both' as direction
%
% Major Update,
%		Lev Muchnik, 11/04/2005
%		lev@topspin.co.il, +972-54-326496																							
% 	Dramatically Optimized. >300,000 WWW sites are processed in ~7secs against >140 secs before!
%
% Major Update,
%		Lev Muchnik, 14/12/2005
%     Normalization of the CC corrected due to the bug reported by Tom Erez. The **wrong** normalization was Ki(Ki+1) instead of Ki(Ki-1)
