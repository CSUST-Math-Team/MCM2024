function NumberOfNodes = GraphCountNumberOfNodes(Graph)
% Returns the number of nodes in graph
%
% Receives:
%   Graph       -   Graph Struct                                -   the graph loaded with GraphLoad
%                      -    string                                            -    Name of file containing the graph
%
% Returns:
%   NumberOfNodes   -   integer                             -   number of nodes in  the graph
%
% See Also:
%       GraphLoad, GraphCountNumberOfLinks
%
% Created:
% Lev Muchnik    26/05/2004, Tel.: 972-054-4326496
%
% Major Changes:
% Lev Muchnik    06/05/2005, Tel.: 972-054-4326496
%	A bug corrected:
% NumberOfNodes =  numel(unique(Graph.Data(:)));
% is replaced with:
% NumberOfNodes =  numel(unique(Graph.Data(:,1:2)));

error(nargchk(1,1,nargin));
error(nargoutchk(0,1,nargout));

try 
    if ischar(Graph)
        Graph = GraphLoad(Graph);
    end
    NumberOfNodes =  numel(GraphNodeIDs(Graph));
catch
    NumberOfNodes   =   0;
end