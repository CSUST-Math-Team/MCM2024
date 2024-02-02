function Graph = mexGraphGeneratePoissonRandomGraph(N,p)
% Creates Erdos and Renyi directed graph of N nodes with probability p to have edge between every 2 nodes.
%
% Receives:
%	N			-	integer	-	Number of nodes in the graph.
%	p			-	floating point	-	Probability (0<=p<=1) for every couple of nodes to have edge connecting them
%
% Returns:
%   Graph		-   Graph Struct			-   the graph in the format, identical to the one, loaded with GraphLoad
%
% Algorithm:
%	"The structure and function of complex networks", Newman; Overview: Section 3,Section 4, Deatails: Section 4.1 
%
% See Also:
%	GraphGenerate*, ObjectCreateGraph
%
% Remarks:
%   To generate poissonian graph of N nodes and average degree <k>, call the function with p = <k>/(N-1)
%   N = 300; k = 4; p=k/(N-1); Graph = mexGraphGeneratePoissonRandomGraph(N,p);
%
%Created:																							
%	Lev Muchnik,	09/04/2005
%	lev@topspin.co.il, +972-54-326496			

