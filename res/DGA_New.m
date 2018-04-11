%Input:
%------
%The input is the gas concentrations 
%stored in variables named: h2, ch4, 
%c2h6,  c2h4,  c2h2, co, co2, n2, o2
%and vector:  ppms(1:9) respectively. 
%Unused gases are given the value -1

% Analysis
%---------
% Implement your method here 

%Output:
%-------
%Set variable Diagnosis to 0,1, ...,7
%based on the diagnosed fault code, 
%0=NF,1=PD,2=D1,3=D2,4=T1,5=T2,6=T3,7=UD