function DIG_IEC_MOD=DGA_IEC_MODIFIED(data)

h2=data(1);  % Gas Concentrations  
ch4=data(2);  
c2h6=data(3); 
c2h4=data(4); 
c2h2=data(5); 
ACT=data(6);

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
    DIG_IEC_MOD=0;
elseif STATE_IEC==5   
   DIG_IEC_MOD=2;
elseif STATE_IEC==6
    DIG_IEC_MOD=3;
elseif STATE_IEC==7 | STATE_IEC==8 
    DIG_IEC_MOD=4;
elseif STATE_IEC==9
    DIG_IEC_MOD=5;
elseif STATE_IEC==10
    DIG_IEC_MOD=6;
elseif STATE_IEC==3 | STATE_IEC==4
   DIG_IEC_MOD=1;
elseif STATE_IEC==2
    DIG_IEC_MOD=7;
end

end