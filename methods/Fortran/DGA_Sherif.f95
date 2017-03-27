	dimension h2(1100),ch4(1100),c2h6(1100),c2h4(1100),c2h2(1100),out(1100), agree(1100),r1(1100),r2(1100),r5(1100),r7(1100)
    dimension h2p(1100),ch4p(1100),c2h6p(1100),c2h4p(1100),c2h2p(1100),sum(1100),diag(1100), r3(1100),r4(1100),r6(1100)	
	open(5,file='e:/test/data403_20.txt')	
	OPEN(6,FILE='e:/test/dga_403_20.xls')
  	OPEN(7,FILE='e:/test/dga_403_r_20.xls') 
	mm=403
	do 200 i=1,mm
    read(5,*)h2(i), ch4(i), c2h6(i), c2h4(i), c2h2(i), out(i)
    IF(h2(i).EQ.0.OR.ch4(i).EQ.0.OR.c2h6(i).EQ.0.OR.c2h4(i).EQ.0.OR.c2h2(i).EQ.0) go to 220
      go to 230
 220  h2(i)=0.001
      ch4(i)=0.001
      c2h6(i)=0.001
      c2h4(i)=0.001
      c2h2(i)=0.001
 230   sum(i)=h2(i)+ch4(i)+c2h6(i)+c2h4(i)+c2h2(i)
    h2p(i)=h2(i)/sum(i)*100
    ch4p(i)=ch4(i)/sum(i)*100
    c2h6p(i)=c2h6(i)/sum(i)*100
    c2h4p(i)=c2h4(i)/sum(i)*100
    c2h2p(i)=c2h2(i)/sum(i)*100
    r1(i)=c2h2p(i)/h2p(i)
    r2(i)=c2h2p(i)/ch4p(i)
    r3(i)=c2h2p(i)/c2h6p(i)
    r4(i)=c2h4p(i)/h2p(i)
   	r5(i)=c2h4p(i)/ch4p(i)
    r6(i)=r4(i)+r5(i)
    r7(i)=c2h4p(i)/c2h6p(i)
    
   if(h2p(i)>=30.and.h2p(i)<=98.and.ch4p(i)<=18.and.c2h6p(i)<=66.and.c2h4p(i)<=13.and.c2h2p(i)<=2.5) go to 10 !PD
	if(h2p(i)>=10.and.h2p(i)<=96.and.(ch4p(i)<=14.5).and.c2h6p(i)<=42.and.c2h4p(i)<=15.and.c2h2p(i)<=40)go to 70   !D1
	if(h2p(i)<=61.and.ch4p(i)<=40.and.c2h6p(i)<=70.and.c2h4p(i)<=35.and.c2h2p(i)<=80) go to 90        !D2
    if (h2p(i)<=50.and.ch4p(i)<=80.and.c2h6p(i)<=100.and.c2h4p(i)<=40.and.c2h2p(i)<=4) go to 120      !T1
      if (h2p(i)<=25.and.ch4p(i)<=83.and.c2h6p(i)>=4.and.c2h6p(i)<=90.and.c2h4p(i)>=10.and.c2h4p(i)<=70.and.c2h2p(i)<=2) go to 140 !T2
        if (h2p(i)<=35.and.ch4p(i)<=50.and.c2h6p(i)<=20.and.c2h4p(i)>=30.and.c2h4p(i)<=100.and.c2h2p(i)<=12) go to 160 !T3
          diag(i)=7
        go to 170
 10 	if (h2p(i)>=10.and.h2p(i)<=96.and.(ch4p(i)<=14.5).and.c2h6p(i)<=42.and.c2h4p(i)<=15.and.c2h2p(i)<=40) go to 20  !D1
  		
         if (h2p(i)<=61.and.ch4p(i)<=40.and.c2h6p(i)<=70.and.c2h4p(i)<=35.and.c2h2p(i)<=80) go to 30  !D2
        
           if (h2p(i)<=50.and.ch4p(i)<=80.and.c2h6p(i)<=100.and.c2h4p(i)<=40.and.c2h2p(i)<=4) go to 40  !T1
            
    if (h2p(i)<=25.and.ch4p(i)<=83.and.c2h6p(i)>=4.and.c2h6p(i)<=90.and.c2h4p(i)>=10.and.c2h4p(i)<=70.and.c2h2p(i)<=2) go to 50 !T2
			
                if (h2p(i)<=35.and.ch4p(i)<=50.and.c2h6p(i)<=20.and.c2h4p(i)>=30.and.c2h4p(i)<=100.and.c2h2p(i)<=12) go to 51 !T3
                  diag(i)=1
                go to 170
 20 		if(r2(i).ge.0.2) go to 3
 			diag(i)=1
            go to 170
 3			diag=2           
			go to 170
 30 		if(r2(i).ge.0.2) go to 4
 			diag(i)=1
			go to 170
 4          diag=3
 			go to 170 
 40  		if(r4(i).gt.0.16)go to 11
 			diag(i)=1
            go to 170
 11			diag(i)=4           
			go to 170
 50  		if(r4(i).gt.0.16)go to 12
 			diag(i)=1
            go to 170
 12			diag(i)=5 
			go to 170
51  		if(r4(i).gt.0.16)go to 13
 			diag(i)=1
            go to 170
 13			diag(i)=6 
			go to 170            
 70			if (h2p(i)<=61.and.ch4p(i)<=40.and.c2h6p(i)<=70.and.c2h4p(i)<=35.and.c2h2p(i)<=80) go to 80   !D2
            if (h2p(i)<=50.and.ch4p(i)<=80.and.c2h6p(i)<=100.and.c2h4p(i)<=40.and.c2h2p(i)<=4) go to 81  !T1
      if (h2p(i)<=25.and.ch4p(i)<=83.and.c2h6p(i)>=4.and.c2h6p(i)<=90.and.c2h4p(i)>=10.and.c2h4p(i)<=70.and.c2h2p(i)<=2) go to 82 !T2
            if (h2p(i)<=35.and.ch4p(i)<=50.and.c2h6p(i)<=20.and.c2h4p(i)>=30.and.c2h4p(i)<=100.and.c2h2p(i)<=12) go to 83 !T3
                  diag(i)=2
            go to 170
 80 		if(r1(i).ge.2) go to 6
 			diag(i)=2
            go to 170
 6			diag(i)=3           
            go to 170
81			if(r1(i).lt.0.1) go to 14
			diag(i)=2
            go to 170
 14			diag(i)=4
			go to 170
82			if(r3(i).lt.0.1) go to 15
			diag(i)=2
            go to 170
 15			diag(i)=5
			go to 170
83			if(r4(i).gt.0.7) go to 16
			diag(i)=2
            go to 170
 16			diag(i)=6
			go to 170            
 90 		if(h2p(i)<=50.and.ch4p(i)<=80.and.c2h6p(i)<=100.and.c2h4p(i)<=40.and.c2h2p(i)<=4) go to 100  !T1
  if (h2p(i)<=25.and.ch4p(i)<=83.and.c2h6p(i)>=4.and.c2h6p(i)<=90.and.c2h4p(i)>=10.and.c2h4p(i)<=70.and.c2h2p(i)<=2) go to 101 !T2 
            if(h2p(i)<=35.and.ch4p(i)<=50.and.c2h6p(i)<=20.and.c2h4p(i)>=30.and.c2h4p(i)<=100.and.c2h2p(i)<=12) go to 110!T3
              diag(i)=3
              go to 170
 100 		if(r3(i).le.0.14) go to 7	
 				diag(i)=3
                go to 170
 7				diag(i)=4               
              go to 170
 101 		if(r2(i).lt.0.1) go to 17	
 			diag(i)=3
            go to 170
 17			diag(i)=5           
              go to 170
 110        if(r4(i).gt.1.8) go to 18	
 			diag(i)=3
            go to 170
 18			diag(i)=6           
              go to 170             
 120 if (h2p(i)<=25.and.ch4p(i)<=83.and.c2h6p(i)>=4.and.c2h6p(i)<=90.and.c2h4p(i)>=10.and.c2h4p(i)<=70.and.c2h2p(i)<=2) go to 130 !T2
 if (h2p(i)<=35.and.ch4p(i)<=50.and.c2h6p(i)<=20.and.c2h4p(i)>=30.and.c2h4p(i)<=100.and.c2h2p(i)<=12) go to 131  !T3
              diag(i)=4
              go to 170
 130 		if(r6(i).ge.5.0) go to 8	
 			diag(i)=4
              go to 170
 8			diag=5
 			go to 170 
 131 		if(r7(i).ge.0.8) go to 19	
 			diag(i)=4
              go to 170
 19			diag=6
 			go to 170                       
 140 	if (h2p(i)<=35.and.ch4p(i)<=50.and.c2h6p(i)<=20.and.c2h4p(i)>=30.and.c2h4p(i)<=100.and.c2h2p(i)<=12) go to 150  !T3
              diag(i)=5
              go to 170
 150 		if(r7(i).gt.4) go to 9
  			diag(i)=5
              go to 170
 9			diag(i)=6
            go to 170
 160 			diag(i)=6
 170 		if(diag(i).eq.out(i)) go to 180
          if(diag(i).gt.10) go to 190
            agree(i)=0
            go to 210 
 190		agree(i)=0.5
 			go to 210
 180           agree(i)=1
 210      write(6,2)out(i),h2p(i),ch4p(i),c2h6p(i),c2h4p(i),c2h2p(i),diag(i),agree(i) 
          2 format(10(2x,f13.5))
          write(7,5)out(i),r1(i),r2(i), r3(i),r4(i),r5(i),r6(i),r7(i),diag(i),agree(i)
 5 			format(10(2x,f13.5))
 200		continue
          stop
              end
              
    
	
        
         