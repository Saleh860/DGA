%Input:
%------
%The input is the gas concentrations stored in a vector named 'ppms' 
%and stored again in the following nine variables:
%h2=ppms(1);ch4=ppms(2);c2h6=ppms(3);c2h4=ppms(4);c2h2=ppms(5);
%co=ppms(6);co2=ppms(7);n2=ppms(8);o2=ppms(9);
%Note that unused gas concentrations take the value -1

% Analysis
%---------
% Implement your fault diagnosis method here 

%Output:
%-------
% set 'Diagnosis' variable to a number between 0 and 7 representing the 
% fault code resulting from your analysis method 
% {0=NF,1=PD,2=D1,3=D2,4=T1,5=T2,6=T3,7=UD}
Diagnosis=7;

   