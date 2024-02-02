function varargout=DemoLeastTreeEx(varargin)

MTree=[0	7	inf	inf	inf	1
       inf	0	4	inf	1	inf
       inf	inf	0	inf	inf	inf
       inf	2	5	0	inf	inf
       inf	inf	inf	3	0	inf
       inf	5	inf	2	7	0]

[lWeight,ETree]=LeastTreeEx(MTree,1,3)