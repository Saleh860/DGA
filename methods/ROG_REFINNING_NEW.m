
% ROGER 4 RATIO MODIFIED NEW
R1=ch4/h2;  
R2=c2h6/ch4;
R3=c2h4/c2h6;
R4=c2h2/c2h4;

if (R1>=0.1 & R1<1) 
    if R2<1
         if R3<1 
            if R4<0.5       
             STATE_ROGER=1;   
            else
             STATE_ROGER=10;
            end
        else
            if (R3>=1 & R3<=3.5)
              if R4<0.5                  %  if R4<0.5
               STATE_ROGER=7;
              else
               STATE_ROGER=11;
             end
        else
          if R4>1
               STATE_ROGER=12;
          elseif (R4>=0.5 & R4<=1)
             STATE_ROGER=10;
          else
             STATE_ROGER=9;    
          end      
        end
      end
    else
       if R3<1 
        if R4<0.5
           STATE_ROGER=6;
        elseif R4>1
          STATE_ROGER=12;
        elseif (R4>=0.5 & R4<=1)
          STATE_ROGER=10;
        else
          STATE_ROGER=9;    
        end
      else
        if R4>1
           STATE_ROGER=12;
             elseif (R4>=0.5 & R4<=1)
        STATE_ROGER=10;
       else
        STATE_ROGER=9;
        end
       end        
    end 
elseif R1<0.1 
    if R2<3
        if R3<1
            if R4<0.5
               STATE_ROGER=3; 
            else
                STATE_ROGER=13; 
            end
        else
            if R4>1
              STATE_ROGER=12;
             elseif (R4>=0.5 & R4<=1)
              STATE_ROGER=10;
            else
             STATE_ROGER=9;
            end    
        end
    else 
          if R4>1
              STATE_ROGER=12;
             elseif (R4>=0.5 & R4<=1)
              STATE_ROGER=10;
            else
             STATE_ROGER=9;
          end
    end

elseif (R1>=1 & R1<=5.5)    
    if R2<1
        if (R3>=1 & R3<=3.5)       %  (R3>=1 & R3<=3)
            if R4<0.5                %    if R4<0.5
            STATE_ROGER=8;
            else
            if R4>1
              STATE_ROGER=12;
             elseif (R4>=0.5 & R4<=1)
              STATE_ROGER=10;
              else
             STATE_ROGER=9;
             end    
            end    
        else
           if R3>3
               if R4<0.5 
                   STATE_ROGER=9;
               else
                if R4>1
                   STATE_ROGER=12;
                 elseif (R4>=0.5 & R4<=1)
                   STATE_ROGER=10;
                else
                  STATE_ROGER=9;
                end   
               end
           else
                STATE_ROGER=4;  
            end
        end
    else
        if R3<1
            if R4<0.5
                STATE_ROGER=5;
            else
                if R4>1
                   STATE_ROGER=12;
                 elseif (R4>=0.5 & R4<=1)
                   STATE_ROGER=10;
                else
                  STATE_ROGER=9;
                end   
            end
        else
                if R4>1
                   STATE_ROGER=12;
                 elseif (R4>=0.5 & R4<=1)
                   STATE_ROGER=10;
                else
                  STATE_ROGER=9;
                end   
        end        
    end
elseif R1>5.5 
    if R2<1
       if R3<1
            if R4<0.5
              STATE_ROGER=4;      
             else
              if R4>1
                   STATE_ROGER=12;
                 elseif (R4>=0.5 & R4<=1)
                   STATE_ROGER=10;
                else
                  STATE_ROGER=9;
                end   
          end    
       else 
                 if R4>1
                   STATE_ROGER=12;
                 elseif (R4>=0.5 & R4<=1)
                   STATE_ROGER=10;
                else
                  STATE_ROGER=9;
                end   
       end
    else
        if R3<1
            if R4<0.5
            STATE_ROGER=5;        
             else
              if R4>1
                   STATE_ROGER=12;
                 elseif (R4>=0.5 & R4<=1)
                   STATE_ROGER=10;
                else
                  STATE_ROGER=9;
              end   
            end
        else
                if R4>1
                   STATE_ROGER=12;
                 elseif (R4>=0.5 & R4<=1)
                   STATE_ROGER=10;
                else
                  STATE_ROGER=9;
                end  
        end
    end
else
    STATE_ROGER=8;
end

if STATE_ROGER==1      % ROGER TYPE
    FAULT_ROGER=0;
elseif STATE_ROGER==10   
   FAULT_ROGER=2;
elseif STATE_ROGER==12 | STATE_ROGER==11 
    FAULT_ROGER=3;
elseif STATE_ROGER>=4 & STATE_ROGER<=6
    FAULT_ROGER=4;
elseif STATE_ROGER==7 | STATE_ROGER==8
    FAULT_ROGER=5;
elseif STATE_ROGER==9
    FAULT_ROGER=6;
elseif STATE_ROGER==3 | STATE_ROGER==13
   FAULT_ROGER=1;
elseif STATE_ROGER==2
    FAULT_ROGER=7;
else
end

Diagnosis = FAULT_ROGER;
