function varargout=DemoLeastTree(varargin)

MTree=[0	1	15	inf	inf	2	16
       1	0	7	inf	3	10	inf
       15	7	0	5	inf	inf	inf
       inf	inf	5	0	4	inf	8
       inf	3	inf	4	0	9	inf
       2	10	inf	inf	9	0	6
       16	inf	inf	8	inf	6	0]

[lWeight,ETree]=LeastTree(MTree,2)