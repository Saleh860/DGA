%At the beginning of this script:
%gas concentration ratios are stored in array "ratios"
%they can also be individually accessible through the following variables
%    h2=ratios(1); ch4=ratios(2); c2h6=ratios(3); c2h4=ratios(4); 
%    c2h2=ratios(5);


%At the end of this script:
%The calculated fault diagnosis code must be stored in variable Diagnosis

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
elseif R3<=29 && R3>=4  R2<=85
    Diagnosis=3; 

else
    Diagnosis=7;
end

