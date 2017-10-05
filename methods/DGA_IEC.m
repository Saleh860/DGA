
    R2=ch4/h2;
    R3=c2h4/c2h6;
    R1=c2h2/c2h4;
    if R1<0.1
        R1C=0;
    elseif R1<=3 & R1>=0.1
        R1C=1;
   elseif R1>3
        R1C=2;
    end  
  if R2<0.1
        R2C=1;
    elseif R2>=0.1 & R2<=1
        R2C=0;
   elseif R2>1
        R2C=2;
  end 
     if R3<1
        R3C=0;
    elseif R3>=1 & R3<=3
        R3C=1;
   elseif R3>3
        R3C=2;
    end 
    
    %1
    if R1C==0 & R2C==0 & R3C==0 
        NO_OF_STATE=1;
    %3
    elseif R1C==0 & R2C==1 & R3C==0 
        NO_OF_STATE=3;
    %4
    elseif R1C==1  & R2C==1 & R3C==0 
        NO_OF_STATE=3;
    %5
   elseif R1C==2 & R2C==0 & (R3C==1 | R3C==2) 
        NO_OF_STATE=10;
    elseif R1C==1 & R2C==0 & R3C==1  
        NO_OF_STATE=10;
    %6
    elseif R1C==1 & R2C==0 & R3C==2 
        NO_OF_STATE=12;
    %7
    elseif R1C==0 & R2C==0 & R3C==1 
        NO_OF_STATE=4;
    %8
    elseif R1C==0 & R2C==2 & R3C==0 
        NO_OF_STATE=4;
    %9
    elseif R1C==0 & R2C==2 & R3C==1 
        NO_OF_STATE=7;
    %10
    elseif R1C==0 & R2C==2 & R3C==2
        NO_OF_STATE=9;
       else 
        NO_OF_STATE=2; 
    end
    
    if NO_OF_STATE==1
       Diagnosis=0;
    elseif NO_OF_STATE==2
       Diagnosis=7;
    elseif NO_OF_STATE==3
       Diagnosis=1;
    elseif NO_OF_STATE==4
       Diagnosis=4;
    elseif NO_OF_STATE==5
       Diagnosis=4;
    elseif NO_OF_STATE==6
       Diagnosis=4;
    elseif NO_OF_STATE==7
       Diagnosis=5;
    elseif NO_OF_STATE==8
       Diagnosis=5;
    elseif NO_OF_STATE==9
       Diagnosis=6;
    elseif NO_OF_STATE==10
       Diagnosis=2;
    elseif NO_OF_STATE==11
       Diagnosis=3;
    elseif NO_OF_STATE==12
       Diagnosis=3;
    elseif NO_OF_STATE==13
       Diagnosis=1;
    else
       Diagnosis=0;
    end 

   