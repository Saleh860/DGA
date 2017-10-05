
    t=h2+ch4+c2h2+c2h6+c2h4;
   
    pr1=h2/t;
  
    P1=pr1*100;
   
    pr2=ch4/t;
    
    P2=pr2*100;
   
    pr3=c2h6/t;
    
    P3=pr3*100;
   
    pr4=c2h4/t;
  
    P4=pr4*100;
   
    pr5=c2h2/t;
    
    P5=pr5*100;
    
    if P1>=55 & P5<= 1 
        key=1;
   
    elseif  P5>=7 & P5<=50 & P4>=10 & P4<=58 & P3<=6  
        key=3;
    
    elseif    (P5>=5 & P3<=9) | (P5>50) 
        key=2;
    
    elseif ( P4<=100  & P3>=1 & P4>=23 & P5<=5 & P2<=35 & P2>=5  ) | (P4>68)
        key=6;
    
    elseif  ( P4<=68  & P3<=32 & P3>=4.6 & P4>=10 & P5<=1.05  & P2<=55.22 & P2>=1.7  ) | (P2>40)
        key=5; 
    
    elseif  P3>=0.01
        key=4;
    
    else 
         key=7;
    end
    
    Diagnosis=key;

    