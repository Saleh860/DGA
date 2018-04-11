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

load('ANN_1.mat', 'net')
  DATA(1)=ppms(1)/92600; % NORMALIZATION OF INPUT DATA
  DATA(2)=ppms(2)/64064;
  DATA(3)=ppms(3)/72128;
  DATA(4)=ppms(4)/95650;
  DATA(5)=ppms(5)/57000;
  IN=[DATA(1) DATA(2) DATA(3) DATA(4) DATA(5)];
  I=IN';  % Input  
  O1=round(sim(net,I));   
  O1=O1'; 
   if O1(1,:)==[0 0 1];
       DIG=1;
    elseif O1(1,:)==[0 1 0];
       DIG=2;
    elseif O1(1,:)==[0 1 1];
       DIG=3;
    elseif O1(1,:)==[1 0 0];
       DIG=4; 
    elseif O1(1,:)==[1 0 1];
       DIG=5;
    elseif O1(1,:)==[1 1 0];
       DIG=6;    
    else
       DIG=7;
   end
 
   Diagnosis = DIG;
   