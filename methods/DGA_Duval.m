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

R1=(ch4/(ch4+c2h4+c2h2))*100 ;
R2=(c2h4/(ch4+c2h4+c2h2))*100 ;
R3=(c2h2/(ch4+c2h4+c2h2))*100 ;

if R1>=98 && R2<=2  && R3<=2
   Diagnosis=1;
elseif R3<=4 && R2>=20 && R2<=50 && R1<=80  && R1>=46
 Diagnosis=5;
elseif R3<=4  && R2<=20 && R1>=76  && R1<=98
    Diagnosis=4;
elseif R3>=0 && R2<=23
  Diagnosis=2;
 elseif R3<=15 && R2>=50 && R1<=50
  Diagnosis=6;
elseif  R3<=79  && R3>=13 && R2<=77
  Diagnosis=3;
elseif R3<=29 && R3>=4 && R2<=85
    Diagnosis=3; 

else
    Diagnosis=7;
end

