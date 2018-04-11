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

%---------------------------------------------------------------
% IEC RATIO METHOD
R1I=c2h2/c2h4;  
R2I=ch4/h2;
R3I=c2h4/c2h6;
if R1I<0.5
    if (R2I>=0.2 & R2I<1)
        if R3I<1
          STATE_IEC=1;
         elseif (R3I>=1 &R3I<=3)
          STATE_IEC=7;
        else
            STATE_IEC=10;        
        end
    elseif R2I<0.2
           if R3I<1
             STATE_IEC=3;
            elseif R3I>=3
             STATE_IEC=6;
           else
               STATE_IEC=5;
           end
    else
          if R3I<1
              STATE_IEC=8;
          elseif (R3I>=1 & R3I<=3)
              STATE_IEC=9;
          else
              STATE_IEC=10;
          end
    end
elseif (R1I>=0.5 & R1I<=3)
    if R2I<0.2
        if R3I<1
            STATE_IEC=4;
        elseif R3I>=3
            STATE_IEC=6;
        else
            STATE_IEC=5;
        end
    elseif R2I>1
        if R3I>3
            STATE_IEC=6;
        else
            STATE_IEC=5;
        end
    else
        if R3I>=3
            STATE_IEC=6;
        else
            STATE_IEC=5;
        end          
    end
elseif (R1I>3 & R1I<100)
       if (R2I<3)
           if (R3I>=1 & R3I<=3) 
               STATE_IEC=5;
           else
               STATE_IEC=6;
           end
       else           
           if R3I<1
            STATE_IEC=8;
           elseif (R3I>=1 & R3I<=3)
            STATE_IEC=9;
           else
            STATE_IEC=10;   
        end
       end
else
    STATE_IEC=6;         
end    

%---------------------------------------------------------------

if STATE_IEC==1      % IEC TYPE
    FAULT_IEC=0;
elseif STATE_IEC==5   
   FAULT_IEC=2;
elseif STATE_IEC==6
    FAULT_IEC=3;
elseif STATE_IEC==7 | STATE_IEC==8 
    FAULT_IEC=4;
elseif STATE_IEC==9
    FAULT_IEC=5;
elseif STATE_IEC==10
    FAULT_IEC=6;
elseif STATE_IEC==3 | STATE_IEC==4
   FAULT_IEC=1;
elseif STATE_IEC==2
    FAULT_IEC=7;
else
end

Diagnosis = FAULT_IEC;
