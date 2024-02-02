function Graph = GraphCreateRandomGraph(NumberOfNodes,DistributionX,DistributionY)
% Generates a graph of given size and with the given node's degree distribution.
%
% Receives:
%   NumberOfNodes   -   integer, scalar -   approximate number of nodes in Graph
%   DistributionX   -   integers, vector-   list of degrees. 
%   DistributionY   -   floats, vector  -   list of probabilities to have node approprieate degree
%                                           must have the same number of elements as 'DistributionX'
%                                           Must not be normalized 
%
% Returns:
%   Graph           -   struct, graph   -   Object created with ObjectGraphCreate an d containing the 
%                                           desired graph
% Example:
%   Graph = GraphCreateRandomGraph(1000,[1 : 200],[1 : 200].^-2);
% 
% See Also:
%	 GraphLoad
%
% Created:
%   Lev Muchnik    09/03/2006, Tel.: 972-054-4326496, lev@topspin.co.il, Boston, MA
x
error(nargchk(3,3,nargin));
error(nargoutchk(0,1,nargout));

DistributionY = round(DistributionY./sum(DistributionY)*NumberOfNodes);
NumberOfNodes = sum(DistributionY);

SourceNodes = zeros(sum(DistributionY.*DistributionX));
LastIndex = 1;
for i = 1 : numel(DistributionX)
    
end

Graph = NumberOfNodes;