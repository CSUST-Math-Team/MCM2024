function Graph = GraphReverseLinks(Graph)
% Reverses directions of all links in the graph
%
% Receives:
%   Graph       -   Graph Struct    -   the graph loaded with GraphLoad
%
% Returns:
%   Graph       -   Graph Struct    -   the graph loaded with GraphLoad without duplicate links
%
% See Also:
%       GraphLoad, GraphRemoveDuplicateLinks, GraphMakeUndirected
%
% Created:
%   Lev Muchnik    17/03/2005, Tel.: 972-054-4326496


error(nargchk(1,1,nargin));
error(nargoutchk(0,1,nargout));

Graph.Data = [Graph.Data(:,2) Graph.Data(:,1) Graph.Data(:,3)];

