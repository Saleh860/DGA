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

    ppms(1)=ppms(1)/(sum(ppms((1:5))));
    ppms(2)=ppms(2)/(sum(ppms((1:5))));
    ppms(3)=ppms(3)/(sum(ppms((1:5))));
    ppms(4)=ppms(4)/(sum(ppms((1:5))));
    ppms(5)=ppms(5)/(sum(ppms((1:5))));

    MEAN_STD_PD_AR_TH_D1_D2_T1_T2_T3_323         % MEAN AND STD

    N_T1_F=0;     N_T2_F=0;   N_T3_F=0; N_D1_F=0;     N_D2_F=0;   N_PD_F=0;
           
           X=ppms(1:5);           
           
           N_PD=mvnpdf(X,PD(1,(1:5)),PD(2,(1:5)))/mvnpdf(X,PD(1,(6:10)),PD(2,(6:10))); 
           N_AR=mvnpdf(X,AR(1,(1:5)),AR(2,(1:5)))/mvnpdf(X,AR(1,(6:10)),AR(2,(6:10))); 
           N_TH=mvnpdf(X,TH(1,(1:5)),TH(2,(1:5)))/mvnpdf(X,TH(1,(6:10)),TH(2,(6:10)));
           N_PD_F=N_PD/(N_PD+N_AR+N_TH);
           N_AR_F=N_AR/(N_PD+N_AR+N_TH);
           N_TH_F=N_TH/(N_PD+N_AR+N_TH);
           
           F_T=max([N_PD_F     N_AR_F   N_TH_F]);
           
           if F_T==N_AR_F 
               N_D1=mvnpdf(X,D1(1,(1:5)),D1(2,(1:5)))/mvnpdf(X,D1(1,(6:10)),D1(2,(6:10))); 
               N_D2=mvnpdf(X,D2(1,(1:5)),D2(2,(1:5)))/mvnpdf(X,D2(1,(6:10)),D2(2,(6:10))); 
               N_D1_F=N_D1/(N_D1+N_D2);
               N_D2_F=N_D2/(N_D1+N_D2);

               F_T=max([N_D1_F     N_D2_F]);

           elseif F_T==N_TH_F 
               N_T1=mvnpdf(X,T1(1,(1:5)),T1(2,(1:5)))/mvnpdf(X,T1(1,(6:10)),T1(2,(6:10))); 
               N_T2=mvnpdf(X,T2(1,(1:5)),T2(2,(1:5)))/mvnpdf(X,T2(1,(6:10)),T2(2,(6:10))); 
               N_T3=mvnpdf(X,T3(1,(1:5)),T3(2,(1:5)))/mvnpdf(X,T3(1,(6:10)),T3(2,(6:10))); 
               N_T1_F=N_T1/(N_T1+N_T2+N_T3);
               N_T2_F=N_T2/(N_T1+N_T2+N_T3);
               N_T3_F=N_T3/(N_T1+N_T2+N_T3);
           
               F_T=max([N_T1_F     N_T2_F   N_T3_F]);
                
          else
               F_T=N_PD_F;
          end
                                 
          if F_T==N_PD_F 
               DIG=1;
               
          elseif F_T==N_D1_F 
               DIG=2;
               
          elseif F_T==N_D2_F 
               DIG=3;
          elseif F_T==N_T1_F 
               DIG=4;
         
          elseif F_T==N_T2_F 
               DIG=5;
          elseif F_T==N_T3_F 
               DIG=6;           
          else  
               DIG=7;
          end 
          
       Diagnosis = DIG;
