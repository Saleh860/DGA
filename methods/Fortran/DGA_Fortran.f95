!	dimension h2(1100),ch4(1100),c2h6(1100),c2h4(1100),c2h2(1100),out(1100), agree(1100),r1(1100),r2(1100),r5(1100),r7(1100)
!   dimension h2p(1100),ch4p(1100),c2h6p(1100),c2h4p(1100),c2h2p(1100),sum(1100),diag(1100), r3(1100),r4(1100),r6(1100)	
    
	open(5,file='ratios.txt')
    OPEN(6,FILE='diagnosis.txt')
    read(5,*)h2, ch4, c2h6, c2h4, c2h2
    IF(h2.EQ.0.OR.ch4.EQ.0.OR.c2h6.EQ.0.OR.c2h4.EQ.0.OR.c2h2.EQ.0) go to 220
      go to 230
 220  h2=0.001
      ch4=0.001
      c2h6=0.001
      c2h4=0.001
      c2h2=0.001
 230   sum=h2+ch4+c2h6+c2h4+c2h2
    h2p=h2/sum*100
    ch4p=ch4/sum*100
    c2h6p=c2h6/sum*100
    c2h4p=c2h4/sum*100
    c2h2p=c2h2/sum*100
    r1=c2h2p/h2p
    r2=c2h2p/ch4p
    r3=c2h2p/c2h6p
    r4=c2h4p/h2p
   	r5=c2h4p/ch4p
    r6=r4+r5
    r7=c2h4p/c2h6p
    
   if(h2p>=30.and.h2p<=98.and.ch4p<=18.and.c2h6p<=66.and.c2h4p<=13.and.c2h2p<=2.5) go to 10 !PD
	if(h2p>=10.and.h2p<=96.and.(ch4p<=14.5).and.c2h6p<=42.and.c2h4p<=15.and.c2h2p<=40)go to 70   !D1
	if(h2p<=61.and.ch4p<=40.and.c2h6p<=70.and.c2h4p<=35.and.c2h2p<=80) go to 90        !D2
    if (h2p<=50.and.ch4p<=80.and.c2h6p<=100.and.c2h4p<=40.and.c2h2p<=4) go to 120      !T1
      if (h2p<=25.and.ch4p<=83.and.c2h6p>=4.and.c2h6p<=90.and.c2h4p>=10.and.c2h4p<=70.and.c2h2p<=2) go to 140 !T2
        if (h2p<=35.and.ch4p<=50.and.c2h6p<=20.and.c2h4p>=30.and.c2h4p<=100.and.c2h2p<=12) go to 160 !T3
          diag=7
        go to 170
 10 	if (h2p>=10.and.h2p<=96.and.(ch4p<=14.5).and.c2h6p<=42.and.c2h4p<=15.and.c2h2p<=40) go to 20  !D1
  		
         if (h2p<=61.and.ch4p<=40.and.c2h6p<=70.and.c2h4p<=35.and.c2h2p<=80) go to 30  !D2
        
           if (h2p<=50.and.ch4p<=80.and.c2h6p<=100.and.c2h4p<=40.and.c2h2p<=4) go to 40  !T1
            
    if (h2p<=25.and.ch4p<=83.and.c2h6p>=4.and.c2h6p<=90.and.c2h4p>=10.and.c2h4p<=70.and.c2h2p<=2) go to 50 !T2
			
                if (h2p<=35.and.ch4p<=50.and.c2h6p<=20.and.c2h4p>=30.and.c2h4p<=100.and.c2h2p<=12) go to 51 !T3
                  diag=1
                go to 170
 20 		if(r2.ge.0.2) go to 3
 			diag=1
            go to 170
 3			diag=2           
			go to 170
 30 		if(r2.ge.0.2) go to 4
 			diag=1
			go to 170
 4          diag=3
 			go to 170 
 40  		if(r4.gt.0.16)go to 11
 			diag=1
            go to 170
 11			diag=4           
			go to 170
 50  		if(r4.gt.0.16)go to 12
 			diag=1
            go to 170
 12			diag=5 
			go to 170
51  		if(r4.gt.0.16)go to 13
 			diag=1
            go to 170
 13			diag=6 
			go to 170            
 70			if (h2p<=61.and.ch4p<=40.and.c2h6p<=70.and.c2h4p<=35.and.c2h2p<=80) go to 80   !D2
            if (h2p<=50.and.ch4p<=80.and.c2h6p<=100.and.c2h4p<=40.and.c2h2p<=4) go to 81  !T1
      if (h2p<=25.and.ch4p<=83.and.c2h6p>=4.and.c2h6p<=90.and.c2h4p>=10.and.c2h4p<=70.and.c2h2p<=2) go to 82 !T2
            if (h2p<=35.and.ch4p<=50.and.c2h6p<=20.and.c2h4p>=30.and.c2h4p<=100.and.c2h2p<=12) go to 83 !T3
                  diag=2
            go to 170
 80 		if(r1.ge.2) go to 6
 			diag=2
            go to 170
 6			diag=3           
            go to 170
81			if(r1.lt.0.1) go to 14
			diag=2
            go to 170
 14			diag=4
			go to 170
82			if(r3.lt.0.1) go to 15
			diag=2
            go to 170
 15			diag=5
			go to 170
83			if(r4.gt.0.7) go to 16
			diag=2
            go to 170
 16			diag=6
			go to 170            
 90 		if(h2p<=50.and.ch4p<=80.and.c2h6p<=100.and.c2h4p<=40.and.c2h2p<=4) go to 100  !T1
  if (h2p<=25.and.ch4p<=83.and.c2h6p>=4.and.c2h6p<=90.and.c2h4p>=10.and.c2h4p<=70.and.c2h2p<=2) go to 101 !T2 
            if(h2p<=35.and.ch4p<=50.and.c2h6p<=20.and.c2h4p>=30.and.c2h4p<=100.and.c2h2p<=12) go to 110!T3
              diag=3
              go to 170
 100 		if(r3.le.0.14) go to 7	
 				diag=3
                go to 170
 7				diag=4               
              go to 170
 101 		if(r2.lt.0.1) go to 17	
 			diag=3
            go to 170
 17			diag=5           
              go to 170
 110        if(r4.gt.1.8) go to 18	
 			diag=3
            go to 170
 18			diag=6           
              go to 170             
 120 if (h2p<=25.and.ch4p<=83.and.c2h6p>=4.and.c2h6p<=90.and.c2h4p>=10.and.c2h4p<=70.and.c2h2p<=2) go to 130 !T2
 if (h2p<=35.and.ch4p<=50.and.c2h6p<=20.and.c2h4p>=30.and.c2h4p<=100.and.c2h2p<=12) go to 131  !T3
              diag=4
              go to 170
 130 		if(r6.ge.5.0) go to 8	
 			diag=4
              go to 170
 8			diag=5
 			go to 170 
 131 		if(r7.ge.0.8) go to 19	
 			diag=4
              go to 170
 19			diag=6
 			go to 170                       
 140 	if (h2p<=35.and.ch4p<=50.and.c2h6p<=20.and.c2h4p>=30.and.c2h4p<=100.and.c2h2p<=12) go to 150  !T3
              diag=5
              go to 170
 150 		if(r7.gt.4) go to 9
  			diag=5
              go to 170
 9			diag=6
            go to 170
 160 			diag=6
 170 write(6,*)diag
     end
              
    
	
        
         
