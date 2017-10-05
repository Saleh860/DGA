  load('ANN_1.mat', 'net')
  DATA(1)=ratios(1)/92600; % NORMALIZATION OF INPUT DATA
  DATA(2)=ratios(2)/64064;
  DATA(3)=ratios(3)/72128;
  DATA(4)=ratios(4)/95650;
  DATA(5)=ratios(5)/57000;
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
   