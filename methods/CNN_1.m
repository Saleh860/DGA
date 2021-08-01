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

Diagnosis=CNN(ppms);

function Diagnosis=CNN(ppms)

  persistent CNN_245_NET_9_VAR_PER_LOG_ROG_NEW_10
  if isempty(CNN_245_NET_9_VAR_PER_LOG_ROG_NEW_10)
      load('CNN_245_NET_9_VAR_PER_LOG_ROG_NEW_10.mat','CNN_245_NET_9_VAR_PER_LOG_ROG_NEW_10');
  end
 
h2=ppms(1); ch4=ppms(2); c2h6=ppms(3); c2h4=ppms(4); c2h2=ppms(5);
sum1=h2+ch4+c2h6+c2h4+c2h2;
D=[h2/sum1*100 ch4/sum1*100  c2h6/sum1*100 c2h4/sum1*100 c2h2/sum1*100];
R1=D(3)/D(2);
R2=D(4)/D(3);
R3=D(5)/D(4);
R4=D(2)/D(1);
D11=[R1 R2 R3 R4];
D1=[D log(D11)];
X = D1;  % input
X=X';
XTest = permute(X,[1,3,4,2]); %{X X X X X X}; 

YPred = classify(CNN_245_NET_9_VAR_PER_LOG_ROG_NEW_10,XTest);  % Predicted samples

if YPred=='F1'
    Diagnosis=1;
elseif YPred=='F2'
    Diagnosis=2;
elseif YPred=='F3'
    Diagnosis=3;
elseif YPred=='F4'
    Diagnosis=4;    
elseif YPred=='F5'
    Diagnosis=5;
elseif YPred=='F6'
    Diagnosis=6;
else
    Diagnosis=7;
end
end