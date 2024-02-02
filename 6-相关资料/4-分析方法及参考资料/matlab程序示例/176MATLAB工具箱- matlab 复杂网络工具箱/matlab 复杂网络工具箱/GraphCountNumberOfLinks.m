function NumberOfLinks = GraphCountNumberOfLinks(Graph)
% Returns the number of links in graph
%
% Receives:
%   Graph       -   Graph Struct                                -   the graph loaded with GraphLoad
%                      -    string                                            -    Name of file containing the graph
%
% Returns:
%   NumberOfLinks   -   integer                             -   number of links in  the graph
%
% See Also:
%       GraphLoad
%
% Created:
% Lev Muchnik    26/05/2004, Tel.: 972-054-4326496

error(nargchk(1,1,nargin));
error(nargoutchk(0,1,nargout));

try 
if ischar(Graph)
    Graph = GraphLoad(Graph);
end
    NumberOfLinks = size(Graph.Data,1);
catch
    NumberOfLinks   =   0;
end