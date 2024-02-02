function [EXor,varargout]=CompareTree(ETree,ETree2,varargin)
%COMPARETREE  Compare Graph Tree for GraphTheory Toolbox
%  [EXor,varargout]=CompareTree(ETree,ETree2,varargin)
%  Copyright 2008-9-10 Tan KaiShuai Corporation
b=1+length(ETree);
ETree=sort(ETree);ETree2=sort(ETree2);
ind1=sub2ind([b,b],ETree(1,:),ETree(2,:));
ind2=sub2ind([b,b],ETree2(1,:),ETree2(2,:));
EXor=setxor(ind1,ind2);