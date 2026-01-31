-- title:  cat at home
-- author: QKboy
-- desc:   Sweeping robot have to clean the room and stay away from cat
-- script: lua
t=0
vx=0
vy=0
bx=0
by=0
mapX=240
Horizontal=false
vertical=false
robot={x=100,
      vx=0,
      y=60,
						vy=0,
						anim=256,
						flip=0,
			   up=false,
						down=false,
						left=false,
						right=false
						}					
wait={x=0,y=0,t=0}						
cat={x=180,y=80,anim=291,
     vx=0,vy=0,flip=0,
					upmove=true,downmove=true,
     leftmove=true,rightmove=true}	
runningTime=350					
caughtTime=0
pointA={x=20,y=133}
pointB={x=54,y=224}
pointC={x=-17,y=90}		
pointD={x=-23,y=227}								
--collide
leftmove=true
rightmove=true
upmove=true
downmove=true
solids={[5]=true,[16]=true,[0]=true,
        [13]=true,[32]=true,[28]=true,
								[29]=true,[72]=true,	[83]=true}
catSolids={[5]=true,[16]=true,[0]=true}
------------       					
fnt={ SOFAx=100,SOFAy=15,
				 	PLANTx=85,PLANTy=25
     }						
read={x=-152,y=180,t=0,
      anim=166,anim2=168}						
door={x=8,y=-34}
toliet={x=14,
     y=262,
					t=0,
					anim=14
    }	
bathroom={ax=0,ay=305,aanim=161,
          bx=0,by=335,banim=192,
									}	
bed={x=180,y=190,t=0,sleep=0,
     anim=48}	
clothespress={x=98,y=180,
     w=3,
					h=3,
     anim=52       
       }			
kitchen={anim=96,x=-152,y=32, 
         wx=-104,wy=48,
         anim2=129  
        }																													
fridge={x=-40,y=15,anim=60}	
washfood={x=-152,y=64,anim=132}
balcony={x=250,y=0,t=0,c=140,
         anim1=120,anim2=104}
rubbish={x1=180,x2=60,x3=220,x4=20,x5=30,
         x6=90,x7=5,x8=160,x9=250,x10=220,
         y1=109,y2=80,y3=40,y4=120,y5=30,
         y6=90,y7=90,y8=70,y9=120,y10=100,
								
					  		x11=-40,x12=-80,x13=-60,x14=-135,
									x15=-100,x16=-130,x17=-95,x18=-35,
         y11=140,y12=100,y13=40,y14=140,
									y15=120,y16=70,y17=65,y18=75,
         
									
									x19=15,x20=25,
									y19=190,y20=230,
									
		x21=-50,x22=-80,x23=-145,x24=-135,x25=-120,
		x26=-70,x27=80,x28=120,x29=90,x30=105,
  y21=250,y22=240,y23=222,y24=260,y25=350,
		y26=370,y27=250,y28=240,y29=290,y30=280,
									
									x31=160,x32=185,
									x33=220,x34=45,
									x35=-110,
									y31=270,y32=265,
									y33=295,y34=360,
									y35=370,
							-----------------------
									anim1=492,anim2=488,
									anim3=490,anim4=494,
									anim5=494,anim6=494,
									anim7=492,anim8=488,
									anim9=488,anim10=494,
									
									anim11=492,anim12=494,
									anim13=490,anim14=494,
									anim15=488,anim16=488,
									anim17=494,anim18=488,
									
									anim19=488,anim20=494,
									
									anim21=488,anim22=494,
									anim23=490,anim24=494,
									anim25=494,anim26=490,
									anim27=492,anim28=488,
									anim29=490,anim30=494,
									anim31=488,anim32=494,
									anim33=492,anim34=490,
									anim35=488,
									-----------------------
									clean1=0,clean2=0,
									clean3=0,clean4=0,
									clean5=0,clean6=0,
									clean7=0,clean8=0,
									clean9=0,clean10=0,
									
									clean11=0,clean12=0,
									clean13=0,clean14=0,
									clean15=0,clean16=0,
									clean17=0,clean18=0,
									
									clean19=0,clean20=0,
									
									clean21=0,clean22=0,
									clean23=0,clean24=0,
									clean25=0,clean26=0,
									clean27=0,clean28=0,
									clean29=0,clean30=0,
									clean31=0,clean32=0,
									clean33=0,clean34=0,
									clean35=0
         }
beCaught=false						
pause=false			
result={lose=false}		
score=9			
roadblock={anim1=202, anim2=204,
           x1=-40,y1=70,x2=-40,y2=100,
											anim3=234,anim4=236,
											x3=0,y3=150,x4=30,y4=150,
											t=0}	
level={t1=0,t2=0,t3=0,num=1}	
cooking={x=-126,y=17,anim=134
         }		
state=0
st=0				
voiceTime=0.5		
t2=0	
function TIC()
 checkStart()
 checkState()
end
function checkStart()
 if state==0 and btn(6)then
		state=1	
 end
end
function checkState()
  if state==0 then
		menu()
		end
		if state==1 then
		start()
		end
end
function checkReset()
	 if state==1 and btn(4)then
	  reset(0)
		elseif t2%80//40==0 then
				print("Press(A)to restart",69,60,10,0,1)
				print("Press(A)to restart",71,60,10,0,1)
		 	print("Press(A)to restart",70,59,10,0,1)
   	print("Press(A)to restart",70,61,10,0,1)
	 		print("Press(A)to restart",70,60,15,0,1)	 
	 end
end
function menu()
  if st==1 then
   music(1)
		end
  st=st+1
  map(0,544//8)
  spr(494,0,95,5,2,0,0,2,2)
		spr(488,40,105,5,2,0,0,2,2)
		spr(490,120,102,5,2,0,0,2,2)
	 spr(494,80,102,5,2,0,0,2,2)
	 spr(494,160,105,5,2,1,0,2,2)
		spr(488,210,95,5,2,0,0,2,2)
		
		spr(494,-15,50,5,2,0,0,2,2)
		spr(492,20,65,5,2,0,0,2,2)
		spr(488,60,68,5,2,1,0,2,2)
		spr(488,145,70,5,2,0,0,2,2)
	 spr(492,180,60,5,2,1,0,2,2)
	 spr(494,220,50,5,2,0,0,2,2)
		
  spr(robot.anim,robot.x-10,robot.y+5,5,3,0,0,2,2)
	 spr(cat.anim,robot.x-20,robot.y-10,5,3,0,0,3,2) 		
		print("CAT AT HOME",20,22,10,0,3)
	 print("CAT AT HOME",20,18,10,0,3)
	 print("CAT AT HOME",22,20,10,0,3)
	 print("CAT AT HOME",18,20,10,0,3)
	 print("CAT AT HOME",20,20,0,0,3)
		if st<=100 then
			print("Clean the room",70,42,10,0,1) 
		elseif st<=300 then
 		print("Keep away from the cat!",55,42,10,0,1)
		end
		if st%80//40==0  and st>300 then
 		print("Press(X)to start",69,42,10,0,1)
			print("Press(X)to start",71,42,10,0,1)
	 	print("Press(X)to start",70,41,10,0,1)
  	print("Press(X)to start",70,43,10,0,1)
	 	print("Press(X)to start",70,42,15,0,1)
	 end
		 
  cat.anim=291
		robot.anim=256+st%20//10*2	
		robot.x=99+st%20//10
end
function start()
  voice()
  printmap()
  background()
 	garbage()
 	robotMove()
  collide()
 	catAI()
		sprPlayer()
 	cleaning()
 	frontground()
 	block()
  Level()
 	Result()
 	text()
		if level.t1==1 then
	 	music(0)
		end
end
function sprPlayer()
 if beCaught==true then
	 st=st+1
 end

 if cat.y-by>=robot.y and beCaught==false then
  spr(robot.anim,robot.x+st%20//10,robot.y,5,2,robot.flip,0,2,2)
  spr(cat.anim,cat.x-bx,cat.y-by,5,2,cat.flip,0,3,2)
 elseif cat.y-by<robot.y and beCaught==false then
	 spr(cat.anim,cat.x-bx,cat.y-by,5,2,cat.flip,0,3,2)
  spr(robot.anim,robot.x+st%20//10,robot.y,5,2,robot.flip,0,2,2)
 elseif beCaught==true then
	 spr(robot.anim,robot.x+st%20//10,robot.y,5,2,robot.flip,0,2,2)
  spr(cat.anim,cat.x-bx,cat.y-by,5,2,cat.flip,0,3,2)
	end
end
function Level()
 if level.num==1 then
	 runningTime=350
	elseif level.num==2 then
		runningTime=350
	elseif level.num==3 then
		runningTime=350
 end
 if level.num==1 and level.t1<100 then
	  level.t1=level.t1+1
   print("STARt",70,52,10,0,3)
	  print("STARt",70,48,10,0,3)
	  print("STARt",72,50,10,0,3)
	  print("STARt",68,50,10,0,3)
	  print("STARt",70,50,15,0,3)
	elseif level.num==1 and level.t1>=100 then
	  t=t+1		
	end
	if level.num==2 and level.t2<50 then
	  level.t2=level.t2+1
		 cat.vx=0
			cat.vy=0
	  pause=true
	elseif level.num==2 and level.t2<150 then
	  level.t2=level.t2+1
			cat.vx=0
			cat.vy=0
			if mapX>=150 then
 			mapX=mapX-2
				bx=bx-2
				robot.x=robot.x+2
			end
			if by>20 then
			 by=by-1
				robot.y=robot.y+1
			elseif by<20 then
			 robot.y=robot.y-1
			 by=by+1
			end
	elseif level.num==2 and level.t2<200 then
		 level.t2=level.t2+1
			cat.vx=0
			cat.vy=0
			roadblock.t=roadblock.t+1
			if roadblock.t<25 then
				roadblock.anim1=454+roadblock.t%25//5*2
	 	 roadblock.anim2=454+roadblock.t%25//5*2
			end
	elseif level.num==2 and level.t2<250 then
			roadblock.x1=-1000000
			cat.vx=0
			cat.vy=0
			roadblock.t=0
			if robot.x>100 then
 			mapX=mapX+10
				bx=bx+10
				robot.x=robot.x-10
			end
			if robot.y<60 then
			 robot.y=robot.y+1
				by=by-1
			elseif robot.y>60 then
			 robot.y=robot.y-1
				by=by+1
			end
			level.t2=level.t2+1
	elseif	level.num==2 and level.t2>=250	then
   pause=false	
	  t=t+1 
			
	end
	if level.num==3 and level.t3<50 then
	  level.t3=level.t3+1
		 cat.vx=0
			cat.vy=0
	  pause=true
	elseif level.num==3 and level.t3<150 then
		 level.t3=level.t3+1
			cat.vx=0
			cat.vy=0
	  if	bx<-70 then
			 mapX=mapX+1
				bx=bx+1
				robot.x=robot.x-1
			end
		 if by<70 then
			 robot.y=robot.y-1
			 by=by+1
			end
	elseif level.num==3 and level.t3<200 then
	 level.t3=level.t3+1
		cat.vx=0
		cat.vy=0
		roadblock.t=roadblock.t+1
		if roadblock.t<25 then
			roadblock.anim3=454+roadblock.t%25//5*2
		 roadblock.anim4=454+roadblock.t%25//5*2
		end
	elseif level.num==3 and level.t3<250 then
			roadblock.y3=1000000
			cat.vx=0
			cat.vy=0
			roadblock.t=0
			if robot.x<100 then
 			mapX=mapX-2
				bx=bx-2
				robot.x=robot.x+2
			end
			if robot.y<60 then
			 robot.y=robot.y+2
				by=by-2
			end
			level.t3=level.t3+1
	elseif	level.num==3 and level.t3>=250	then
   pause=false	
	  t=t+1 			
 end
end
function garbage()
 if rubbish.clean1==0 then
 spr(rubbish.anim1,rubbish.x1-bx,rubbish.y1-by,5,1,0,0,2,2)
 end
	if rubbish.clean2==0 then
 spr(rubbish.anim2,rubbish.x2-bx,rubbish.y2-by,5,1,0,0,2,2)
 end
	if rubbish.clean3==0 then
	spr(rubbish.anim3,rubbish.x3-bx,rubbish.y3-by,5,1,0,0,2,2)
 end
 if rubbish.clean4==0 then
	spr(rubbish.anim4,rubbish.x4-bx,rubbish.y4-by,5,1,0,0,2,2)	
 end
 if rubbish.clean5==0 then
	spr(rubbish.anim5,rubbish.x5-bx,rubbish.y5-by,5,1,0,0,2,2)
 end
 if rubbish.clean6==0 then
 spr(rubbish.anim6,rubbish.x6-bx,rubbish.y6-by,5,1,0,0,2,2)
 end
 if rubbish.clean7==0 then
	spr(rubbish.anim7,rubbish.x7-bx,rubbish.y7-by,5,1,0,0,2,2)
 end
 if rubbish.clean8==0 then
	spr(rubbish.anim8,rubbish.x8-bx,rubbish.y8-by,5,1,0,0,2,2)	
 end
 if rubbish.clean9==0 then
 spr(rubbish.anim9,rubbish.x9-bx,rubbish.y9-by,5,1,0,0,2,2)
 end
	if rubbish.clean10==0 then
	spr(rubbish.anim10,rubbish.x10-bx,rubbish.y10-by,5,1,0,0,2,2)
 end
-----------------------------
 if rubbish.clean11==0 then
	spr(rubbish.anim11,rubbish.x11-bx,rubbish.y11-by,5,1,0,0,2,2)
 end
 if rubbish.clean12==0 then
	spr(rubbish.anim12,rubbish.x12-bx,rubbish.y12-by,5,1,0,0,2,2)
 end
	if rubbish.clean13==0 then
	spr(rubbish.anim13,rubbish.x13-bx,rubbish.y13-by,5,1,0,0,2,2)
 end
	if rubbish.clean14==0 then
	spr(rubbish.anim14,rubbish.x14-bx,rubbish.y14-by,5,1,0,0,2,2)
 end
 if rubbish.clean15==0 then
	spr(rubbish.anim15,rubbish.x15-bx,rubbish.y15-by,5,1,0,0,2,2)
 end
	if rubbish.clean16==0 then
	spr(rubbish.anim16,rubbish.x16-bx,rubbish.y16-by,5,1,0,0,2,2)
 end
 if rubbish.clean17==0 then
	spr(rubbish.anim17,rubbish.x17-bx,rubbish.y17-by,5,1,0,0,2,2)
 end
	if rubbish.clean18==0 then
	spr(rubbish.anim18,rubbish.x18-bx,rubbish.y18-by,5,1,0,0,2,2)
 end
-----------------------
	if rubbish.clean19==0 then
	spr(rubbish.anim19,rubbish.x19-bx,rubbish.y19-by,5,1,0,0,2,2)
 end
	if rubbish.clean20==0 then
	spr(rubbish.anim20,rubbish.x20-bx,rubbish.y20-by,5,1,0,0,2,2)
 end
-------------------
 if rubbish.clean21==0 then
 spr(rubbish.anim21,rubbish.x21-bx,rubbish.y21-by,5,1,0,0,2,2)
 end
	if rubbish.clean22==0 then
 spr(rubbish.anim22,rubbish.x22-bx,rubbish.y22-by,5,1,0,0,2,2)
 end
	if rubbish.clean23==0 then
	spr(rubbish.anim23,rubbish.x23-bx,rubbish.y23-by,5,1,0,0,2,2)
 end
 if rubbish.clean24==0 then
	spr(rubbish.anim24,rubbish.x24-bx,rubbish.y24-by,5,1,0,0,2,2)	
 end
 if rubbish.clean25==0 then
	spr(rubbish.anim25,rubbish.x25-bx,rubbish.y25-by,5,1,0,0,2,2)
 end
 if rubbish.clean26==0 then
 spr(rubbish.anim26,rubbish.x26-bx,rubbish.y26-by,5,1,0,0,2,2)
 end
 if rubbish.clean27==0 then
	spr(rubbish.anim27,rubbish.x27-bx,rubbish.y27-by,5,1,0,0,2,2)
 end
 if rubbish.clean28==0 then
	spr(rubbish.anim28,rubbish.x28-bx,rubbish.y28-by,5,1,0,0,2,2)	
 end
 if rubbish.clean29==0 then
 spr(rubbish.anim29,rubbish.x29-bx,rubbish.y29-by,5,1,0,0,2,2)
 end
	if rubbish.clean30==0 then
	spr(rubbish.anim30,rubbish.x30-bx,rubbish.y30-by,5,1,0,0,2,2)
 end
	 if rubbish.clean31==0 then
 spr(rubbish.anim31,rubbish.x31-bx,rubbish.y31-by,5,1,0,0,2,2)
 end
	if rubbish.clean32==0 then
 spr(rubbish.anim32,rubbish.x32-bx,rubbish.y32-by,5,1,0,0,2,2)
 end
	if rubbish.clean33==0 then
	spr(rubbish.anim33,rubbish.x33-bx,rubbish.y33-by,5,1,0,0,2,2)
 end
 if rubbish.clean34==0 then
	spr(rubbish.anim34,rubbish.x34-bx,rubbish.y34-by,5,1,0,0,2,2)	
 end
	if rubbish.clean35==0 then
	spr(rubbish.anim35,rubbish.x35-bx,rubbish.y35-by,5,1,0,0,2,2)	
 end
end
function text()
 print("Garbage:",175,3,10)
	print(35-score,225,3,11)
end
function printmap()
 	map(0+mapX//8,0+by//8,31,18,8*(bx//8)-bx,8*(by//8)-by)
end
function isSolid(x,y)
 return solids[mget((x)//8,(y)//8)]
end
function catisSolid(x,y)
 return catSolids[mget((x)//8,(y)//8)]
end
function collide()
  if catisSolid(cat.x+3+240,cat.y+22) or
	catisSolid(cat.x+3+240,cat.y+26)
	then
	 cat.leftmove=false
	else
		cat.leftmove=true
	end
	if catisSolid(cat.x+44+240,cat.y+22) or
	catisSolid(cat.x+44+240,cat.y+26)
	then
	 cat.rightmove=false
	else
		cat.rightmove=true
	end
	if catisSolid(cat.x+5+240,cat.y+20) or
	 catisSolid(cat.x+42+240,cat.y+20)
	then
	 cat.upmove=false
	else
		cat.upmove=true
	end
	if catisSolid(cat.x+5+240,cat.y+28) or
	 catisSolid(cat.x+42+240,cat.y+28)
	then
	 cat.downmove=false
	else
		cat.downmove=true
	end
----------------------------------
 if isSolid(robot.x+1+mapX,robot.y+8+by) or
	   isSolid(robot.x+5+mapX,robot.y+8+by)or
			 isSolid(robot.x+10+mapX,robot.y+8+by)or	   
			 isSolid(robot.x+15+mapX,robot.y+8+by)or
			 isSolid(robot.x+20+mapX,robot.y+8+by)or
			 isSolid(robot.x+25+mapX,robot.y+8+by)or
			 isSolid(robot.x+30+mapX,robot.y+8+by)
	then
		upmove=false
	else
		upmove=true
	end
	if isSolid(robot.x+1+mapX,robot.y+27+by)or
    isSolid(robot.x+5+mapX,robot.y+27+by)or
				isSolid(robot.x+10+mapX,robot.y+27+by)or
    isSolid(robot.x+15+mapX,robot.y+27+by)or
    isSolid(robot.x+20+mapX,robot.y+27+by)or
			 isSolid(robot.x+25+mapX,robot.y+27+by)or
    isSolid(robot.x+30+mapX,robot.y+27+by)or
   	(robot.y>roadblock.y3-by-20)    
	then
		downmove=false
	else
		downmove=true
	end
	if isSolid(robot.x-1+mapX,robot.y+9+by)or
   isSolid(robot.x-1+mapX,robot.y+26+by)or
		robot.x<roadblock.x1-bx+30
	then
		leftmove=false
	else
		leftmove=true
	end
	if isSolid(robot.x+32+mapX,robot.y+9+by)or
	 isSolid(robot.x+32+mapX,robot.y+26+by)
	then
		rightmove=false
	else
		rightmove=true
	end
end
function block()
  spr(roadblock.anim1,roadblock.x1-bx,roadblock.y1-by,0,2,0,0,2,2)
	 spr(roadblock.anim2,roadblock.x2-bx,roadblock.y2-by,0,2,0,0,2,2)
		
  spr(roadblock.anim3,roadblock.x3-bx,roadblock.y3-by,0,2,0,0,2,2) 
  spr(roadblock.anim4,roadblock.x4-bx,roadblock.y4-by,0,2,0,0,2,2)  
end
function Result()
  
  score=rubbish.clean1+rubbish.clean2+
		      rubbish.clean3+rubbish.clean4+
								rubbish.clean5+rubbish.clean6+
								rubbish.clean7+rubbish.clean8+
								rubbish.clean9+rubbish.clean10+
								rubbish.clean11+rubbish.clean12+
		      rubbish.clean13+rubbish.clean14+
								rubbish.clean15+rubbish.clean16+
								rubbish.clean17+rubbish.clean18+
								rubbish.clean19+rubbish.clean20+
								rubbish.clean21+rubbish.clean22+
		      rubbish.clean23+rubbish.clean24+
								rubbish.clean25+rubbish.clean26+
								rubbish.clean27+rubbish.clean28+
								rubbish.clean29+rubbish.clean30+
								rubbish.clean31+rubbish.clean32+
		      rubbish.clean33+rubbish.clean34+
								rubbish.clean35
  if((cat.x-bx<robot.x and
		 robot.x-cat.x+bx<=15)or
			  (cat.x-bx>robot.x and
		 cat.x-bx-robot.x<=15))
		and ((cat.y-by<robot.y and
		 robot.y-cat.y+by<=15)or(
			cat.y-by>robot.y and
			cat.y-by-robot.y<=5))
		then
		 beCaught=true
		end
		if beCaught==true then
		 caughtTime=caughtTime+1
		end
		if score<35 and caughtTime>=50 then
	 		print("YOU ARE CAUGHT",35,42,10,0,2)
	   print("YOU ARE CAUGHT",35,38,10,0,2)
	   print("YOU ARE CAUGHT",37,40,10,0,2)
	   print("YOU ARE CAUGHT",33,40,10,0,2)
	   print("YOU ARE CAUGHT",35,40,15,0,2)
	 		t2=t2+1
				checkReset()
		end
		if score==35 then
		 print("CONGRATULATIONS",30,42,10,0,2)
	  print("CONGRATULATIONS",30,38,10,0,2)
   print("CONGRATULATIONS",32,40,10,0,2)
	  print("CONGRATULATIONS",28,40,10,0,2)
	  print("CONGRATULATIONS",30,40,15,0,2)
   t2=t2+1
	 	checkReset()
		end
	 if score==10 then
		 level.num=2
		end
		if score==18 then
		 level.num=3
		end
end
function voice()
 if voiceTime<score then	
  sfx(2,50,15,3,15,0)
		voiceTime=voiceTime+1
	end
end
function cleaning()
  if robot.x<rubbish.x1-bx and
		  rubbish.x1-bx-robot.x<=20
		and robot.y<rubbish.y1-by and
		  rubbish.y1-by-robot.y<=20
	 then
	   rubbish.clean1=1
  end
		
		if robot.x<rubbish.x2-bx and
		  rubbish.x2-bx-robot.x<=20
		and robot.y<rubbish.y2-by and
		  rubbish.y2-by-robot.y<=20
	 then
	   rubbish.clean2=1
  end
	
	 if robot.x<rubbish.x3-bx and
		  rubbish.x3-bx-robot.x<=20
		and robot.y<rubbish.y3-by and
		  rubbish.y3-by-robot.y<=20
	 then
	   rubbish.clean3=1
  end
		
		if robot.x<rubbish.x4-bx and
		  rubbish.x4-bx-robot.x<=20
		and robot.y<rubbish.y4-by and
		  rubbish.y4-by-robot.y<=20
	 then
	   rubbish.clean4=1
  end
		
		if robot.x<rubbish.x5-bx and
		  rubbish.x5-bx-robot.x<=20
		and robot.y<rubbish.y5-by and
		  rubbish.y5-by-robot.y<=20
	 then
	   rubbish.clean5=1
  end
		
		if robot.x<rubbish.x6-bx and
		  rubbish.x6-bx-robot.x<=20
		and robot.y<rubbish.y6-by and
		  rubbish.y6-by-robot.y<=20
	 then
	   rubbish.clean6=1
  end

  if robot.x<rubbish.x7-bx and
		  rubbish.x7-bx-robot.x<=20
		and robot.y<rubbish.y7-by and
		  rubbish.y7-by-robot.y<=20
	 then
	   rubbish.clean7=1
  end
		
		if robot.x<rubbish.x8-bx and
		  rubbish.x8-bx-robot.x<=20
		and robot.y<rubbish.y8-by and
		  rubbish.y8-by-robot.y<=20
	 then
	   rubbish.clean8=1
  end
		
		if robot.x<rubbish.x9-bx and
		  rubbish.x9-bx-robot.x<=20
		and robot.y<rubbish.y9-by and
		  rubbish.y9-by-robot.y<=20
	 then
	   rubbish.clean9=1
  end
		
		if robot.x<rubbish.x10-bx and
		  rubbish.x10-bx-robot.x<=20
		and robot.y<rubbish.y10-by and
		  rubbish.y10-by-robot.y<=20
	 then
	   rubbish.clean10=1
  end
----------------------
  if robot.x<rubbish.x11-bx and
		  rubbish.x11-bx-robot.x<=20
		and robot.y<rubbish.y11-by and
		  rubbish.y11-by-robot.y<=20
	 then
	   rubbish.clean11=1
  end
		
		if robot.x<rubbish.x12-bx and
		  rubbish.x12-bx-robot.x<=20
		and robot.y<rubbish.y12-by and
		  rubbish.y12-by-robot.y<=20
	 then
	   rubbish.clean12=1
  end
	
	 if robot.x<rubbish.x13-bx and
		  rubbish.x13-bx-robot.x<=20
		and robot.y<rubbish.y13-by and
		  rubbish.y13-by-robot.y<=20
	 then
	   rubbish.clean13=1
  end
		
		if robot.x<rubbish.x14-bx and
		  rubbish.x14-bx-robot.x<=20
		and robot.y<rubbish.y14-by and
		  rubbish.y14-by-robot.y<=20
	 then
	   rubbish.clean14=1
  end
		
		if robot.x<rubbish.x15-bx and
		  rubbish.x15-bx-robot.x<=20
		and robot.y<rubbish.y15-by and
		  rubbish.y15-by-robot.y<=20
	 then
	   rubbish.clean15=1
  end
		
		if robot.x<rubbish.x16-bx and
		  rubbish.x16-bx-robot.x<=20
		and robot.y<rubbish.y16-by and
		  rubbish.y16-by-robot.y<=20
	 then
	   rubbish.clean16=1
  end

  if robot.x<rubbish.x17-bx and
		  rubbish.x17-bx-robot.x<=20
		and robot.y<rubbish.y17-by and
		  rubbish.y17-by-robot.y<=20
	 then
	   rubbish.clean17=1
  end
		
		if robot.x<rubbish.x18-bx and
		  rubbish.x18-bx-robot.x<=20
		and robot.y<rubbish.y18-by and
		  rubbish.y18-by-robot.y<=20
	 then
	   rubbish.clean18=1
  end	
	---------------------------------------
		if robot.x<rubbish.x19-bx and
		  rubbish.x19-bx-robot.x<=20
		and robot.y<rubbish.y19-by and
		  rubbish.y19-by-robot.y<=20
	 then
	   rubbish.clean19=1
  end
		
		if robot.x<rubbish.x20-bx and
		  rubbish.x20-bx-robot.x<=20
		and robot.y<rubbish.y20-by and
		  rubbish.y20-by-robot.y<=20
	 then
	   rubbish.clean20=1
  end	
--------------------------------------
  if robot.x<rubbish.x21-bx and
		  rubbish.x21-bx-robot.x<=20
		and robot.y<rubbish.y21-by and
		  rubbish.y21-by-robot.y<=20
	 then
	   rubbish.clean21=1
  end
		
		if robot.x<rubbish.x22-bx and
		  rubbish.x22-bx-robot.x<=20
		and robot.y<rubbish.y22-by and
		  rubbish.y22-by-robot.y<=20
	 then
	   rubbish.clean22=1
  end
	
	 if robot.x<rubbish.x23-bx and
		  rubbish.x23-bx-robot.x<=20
		and robot.y<rubbish.y23-by and
		  rubbish.y23-by-robot.y<=20
	 then
	   rubbish.clean23=1
  end
		
		if robot.x<rubbish.x24-bx and
		  rubbish.x24-bx-robot.x<=20
		and robot.y<rubbish.y24-by and
		  rubbish.y24-by-robot.y<=20
	 then
	   rubbish.clean24=1
  end
		
		if robot.x<rubbish.x25-bx and
		  rubbish.x25-bx-robot.x<=20
		and robot.y<rubbish.y25-by and
		  rubbish.y25-by-robot.y<=20
	 then
	   rubbish.clean25=1
  end
		
		if robot.x<rubbish.x26-bx and
		  rubbish.x26-bx-robot.x<=20
		and robot.y<rubbish.y26-by and
		  rubbish.y26-by-robot.y<=20
	 then
	   rubbish.clean26=1
  end

  if robot.x<rubbish.x27-bx and
		  rubbish.x27-bx-robot.x<=20
		and robot.y<rubbish.y27-by and
		  rubbish.y27-by-robot.y<=20
	 then
	   rubbish.clean27=1
  end
		
		if robot.x<rubbish.x28-bx and
		  rubbish.x28-bx-robot.x<=20
		and robot.y<rubbish.y28-by and
		  rubbish.y28-by-robot.y<=20
	 then
	   rubbish.clean28=1
  end
		
		if robot.x<rubbish.x29-bx and
		  rubbish.x29-bx-robot.x<=20
		and robot.y<rubbish.y29-by and
		  rubbish.y29-by-robot.y<=20
	 then
	   rubbish.clean29=1
  end
		
		if robot.x<rubbish.x30-bx and
		  rubbish.x30-bx-robot.x<=20
		and robot.y<rubbish.y30-by and
		  rubbish.y30-by-robot.y<=20
	 then
	   rubbish.clean30=1
  end

  if robot.x<rubbish.x31-bx and
		  rubbish.x31-bx-robot.x<=20
		and robot.y<rubbish.y31-by and
		  rubbish.y31-by-robot.y<=20
	 then
	   rubbish.clean31=1
  end
		
		if robot.x<rubbish.x32-bx and
		  rubbish.x32-bx-robot.x<=20
		and robot.y<rubbish.y32-by and
		  rubbish.y32-by-robot.y<=20
	 then
	   rubbish.clean32=1
  end
	
	 if robot.x<rubbish.x33-bx and
		  rubbish.x33-bx-robot.x<=20
		and robot.y<rubbish.y33-by and
		  rubbish.y33-by-robot.y<=20
	 then
	   rubbish.clean33=1
  end
		
		if robot.x<rubbish.x34-bx and
		  rubbish.x34-bx-robot.x<=20
		and robot.y<rubbish.y34-by and
		  rubbish.y34-by-robot.y<=20
	 then
	   rubbish.clean34=1
  end
		if robot.x<rubbish.x35-bx and
		  rubbish.x35-bx-robot.x<=20
		and robot.y<rubbish.y35-by and
		  rubbish.y35-by-robot.y<=20
	 then
	   rubbish.clean35=1
  end
end
function robotMove()
if pause==false then	
 if vertical==true then 
		if robot.up==true then
		 robot.anim=268+t%20//10*2
			if upmove==true then
			 by=by+vy
			end
		elseif	robot.down==true then
		 robot.anim=264+t%20//10*2
			if downmove==true then
			 by=by+vy
			end
		end
	end	
	if Horizontal==true then	
		if robot.left==true then
		 robot.anim=256+t%20//10*2
			if leftmove==true then
		 	bx=bx+vx
		  mapX=mapX+vx
			end
		elseif robot.right==true then
		 robot.anim=256+t%20//10*2
			if rightmove==true then
	 		bx=bx+vx
		  mapX=mapX+vx
			end
		end
	end	
if beCaught==false then
 if btn(0) then
	   vertical=true
				Horizontal=false
				vy=-1
				robot.up=true
			 robot.down=false
	elseif btn(1) then	
	   vertical=true
				Horizontal=false
				vy=1		
				robot.down=true
			 robot.up=false
	end		
	if btn(2)then
	   Horizontal=true
				vertical=false
				robot.flip=0
				vx=-1
				robot.left=true
				robot.right=false
	elseif btn(3)then
	   Horizontal=true
				vertical=false
				robot.flip=1
				vx=1
				robot.left=false
				robot.right=true
 end
end
end
-- spr(robot.anim,robot.x,robot.y,5,2,robot.flip,0,2,2)
end
function catAI()
if pause==false then
 if beCaught==false then
    cat.x=cat.x+cat.vx
  		cat.y=cat.y+cat.vy
  if (cat.y<150 and cat.x<-17)and (robot.y+by>133 or robot.x+bx>-17)
		then
 	  gotopoint(-17-bx,90-by)
				cat.flip=1
 	elseif(cat.y<150 and cat.x>-17)and(robot.y+by<133 and robot.x+bx<-17)  
		then
    gotopoint(-17-bx,90-by)
 	elseif cat.y<133 and robot.y+by>133
		then
		 if cat.x<pointC.x then
			  gotopoint(pointC.x-bx,pointC.y-by)
			else
			  gotopoint(pointA.x-bx,pointA.y-by)
			end
		elseif cat.y>133 and robot.y+by>133
		and robot.x+bx>pointB.x and cat.x<pointB.x
		then
			 gotopoint(pointB.x-bx,pointB.y-by)
		elseif cat.y>133 and robot.y+by>133
		and  robot.x+bx<pointB.x and cat.x>pointB.x 
		then	
			 gotopoint(pointB.x-bx,pointB.y-by)
		elseif cat.y>133 and robot.y+by>133
		and robot.x+bx<pointD.x and cat.x>pointD.x 
		then
			 gotopoint(pointD.x-bx,pointD.y-by)
		elseif cat.y>133 and robot.y+by>133
		and robot.x+bx>pointD.x and cat.x<pointD.x 
		then
		  gotopoint(pointD.x-bx,pointD.y-by)		
		else
   if wait.t<250 then
   	wait.t=wait.t+1
  	 cat.vx=0
	  	cat.vy=0
   	setDown()
  	elseif wait.t<runningTime then
  	 wait.t=wait.t+1
  	 gotopoint(robot.x-10,robot.y-10)
  	elseif	wait.t>=runningTime then
	   wait.t=0
	  	wait.x=robot.x
	  	wait.y=robot.y
  	end
	 end	
	else
	 cat.x=robot.x-10+bx+st%20//10
 	cat.y=robot.y-10+by	
 	cat.anim=291
	end
end
-- spr(cat.anim,cat.x-bx,cat.y-by,5,2,cat.flip,0,3,2)
end
function setDown()
 if cat.flip==0 then
	 if robot.x<cat.x-bx then
		 cat.anim=288
		else
		 cat.anim=291
		end
	elseif cat.flip==1 then
	 if robot.x<cat.x-bx then
		 cat.anim=291
		else
		 cat.anim=288
		end
	end
end
function gotopoint(px,py)
 if cat.y-by>py then
	  catUp()
	-- cat.vy=-1
		 cat.anim=320+t%30//10*3
		if cat.x-bx>px then
		 catLeft()
	--  cat.vx=-1
			cat.flip=0
	 elseif cat.x-bx<px then
		 catRight()
	--  cat.vx=1
			cat.flip=1
		else	
	  cat.vx=0
			cat.flip=1
	 end
	elseif cat.y-by<py then
	 catDown()
--	 cat.vy=1
		cat.anim=320+t%30//10*3
		if cat.x-bx>px then
		 catLeft()
--	  cat.vx=-1
			cat.flip=0
	 elseif cat.x-bx<px then
		 catRight() 
	 -- cat.vx=1
			cat.flip=1
		else
			cat.vx=0
			cat.flip=0
	 end
	elseif	cat.y-by==py then
	 cat.vy=0
		if cat.x-bx>px then
		 catLeft()
	--  cat.vx=-1
			cat.flip=0
			cat.anim=320+t%30//10*3
	 elseif cat.x-bx<px then
		 catRight()
	 -- cat.vx=1
			cat.flip=1
			cat.anim=320+t%30//10*3
		elseif cat.x-bx==px
  then
		 cat.vx=0
			setDown()
	 end
	end			
end

function catUp()
 if cat.upmove==true then
	 cat.vy=-1
	else
	 cat.vy=0	
	end
end
function catDown()
 if cat.downmove==true then
	 cat.vy=1
	else	
	 cat.vy=0	
	end
end
function catLeft()
 if cat.leftmove==true then
	 cat.vx=-1
	else
	 cat.vx=0	
	end
end
function catRight()
 if cat.rightmove==true then
	 cat.vx=1
	else
	 cat.vx=0		
	end
end
function frontground()
--balconycloth
 for i=0,balcony.c do
  spr(balcony.anim1,balcony.x-bx,balcony.y-by+i,0,2,0,0,2,1)
 end
 	spr(balcony.anim2,balcony.x-bx,balcony.y-by+40,0,2,0,0,2,2)
  spr(balcony.anim2,balcony.x-bx,balcony.y-by+60,0,2,0,0,2,2)
  spr(balcony.anim2,balcony.x-bx,balcony.y-by+70,0,2,0,0,2,2)
  spr(106,balcony.x-bx,balcony.y-by+40,0,2,0,0,2,2)
  spr(108,balcony.x-bx,balcony.y-by+60,0,2,0,0,2,2)
  spr(110,balcony.x-bx,balcony.y-by+70,0,2,0,0,2,2)
 
--bathroomB
 spr(bathroom.banim,bathroom.bx-bx,bathroom.by-by,0,3,0,0,2,2)
 spr(bathroom.banim,bathroom.bx-bx+16,bathroom.by-by,0,3,0,0,2,2)
	spr(bathroom.banim+1,bathroom.bx-bx+40,bathroom.by-by,0,3,0,0,1,2)
 spr(bathroom.banim+2,bathroom.bx-bx,bathroom.by-by+12,0,3,0,0,1,2)
	----TV-----
	spr(163,93-bx,120-by,2,2,0,0,3,2)
	spr(163,140-bx,120-by,2,2,1,0,3,2)
		--tolietdoorup
	spr(244,toliet.x-bx-22,toliet.y-by+8,7,2,0,0,1,1)
	spr(244,toliet.x-bx-12,toliet.y-by+8,0,2,0,0,1,1)
 spr(244,toliet.x-bx-6,toliet.y-by+8,0,2,0,0,1,1)
 spr(244,toliet.x-bx+10,toliet.y-by+8,0,2,0,0,1,1)
 spr(244,toliet.x-bx+26,toliet.y-by+8,0,2,0,0,1,1)
 spr(244,toliet.x-bx+34,toliet.y-by+8,0,2,0,0,1,1)
 spr(244,toliet.x-bx+39,toliet.y-by+8,7,2,0,0,1,1)

 spr(228,toliet.x-bx,toliet.y-by+11,0,2,0,0,1,1)
 spr(228,toliet.x-bx+6,toliet.y-by+11,0,2,0,0,1,1)
 spr(228,toliet.x-bx+16,toliet.y-by+11,0,2,0,0,1,1)
 spr(228,toliet.x-bx+26,toliet.y-by+11,0,2,0,0,1,1)
 spr(228,toliet.x-bx,toliet.y-by+10,0,2,0,0,1,1)
 spr(228,toliet.x-bx+6,toliet.y-by+10,0,2,0,0,1,1)
 spr(228,toliet.x-bx+16,toliet.y-by+10,0,2,0,0,1,1)
 spr(228,toliet.x-bx+26,toliet.y-by+10,0,2,0,0,1,1)

	--catroomdoorup
	spr(244,toliet.x-bx-22-150,toliet.y-by+16,7,2,0,0,1,1)
	spr(244,toliet.x-bx-12-152,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx-6-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+10-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+26-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+34-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+39-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+55-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+71-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+87-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+103-154,toliet.y-by+16,0,2,0,0,1,1)
 spr(244,toliet.x-bx+116-154,toliet.y-by+16,0,2,0,0,1,1)

 spr(228,toliet.x-bx-150-13,toliet.y-by+18,0,2,0,0,1,1)
 spr(228,toliet.x-bx-150+3,toliet.y-by+18,0,2,0,0,1,1)
 spr(228,toliet.x-bx-150+10,toliet.y-by+18,0,2,0,0,1,1)

 spr(228,toliet.x-bx-150-13,toliet.y-by+17,0,2,0,0,1,1)
	spr(228,toliet.x-bx-150+3,toliet.y-by+17,0,2,0,0,1,1)
 spr(228,toliet.x-bx-150+10,toliet.y-by+17,0,2,0,0,1,1)

--cooking
	spr(134+t%40//20*2,cooking.x-bx,cooking.y-by,0,2,0,0,2,2)
--washfood
 spr(washfood.anim+t%20//10,washfood.x-bx,washfood.y-by,0,2,0,0,1,2)
	
end
function background()
 --pet
 spr(226,177-bx,25-by,0,2,0,0,1,2)
	spr(226,190-bx-1,25-by,0,2,1,0,1,2)
	spr(40,(188-bx)+t%60//10,31-by,0,2,0,0,1,1)
	spr(40,(192-bx)-t%60//10,31-by,0,2,0,0,1,1)
--clothput
	spr(87,65-bx,14-by,0,2,0,0,1,3)
--SOFA
 spr(7,fnt.SOFAx-bx,fnt.SOFAy-by,0,3,0,0,2,2)
	spr(7,fnt.SOFAx+30-bx,fnt.SOFAy-by,0,3,1,0,2,2)
--PLANT	
	spr(9,fnt.PLANTx-bx-15,fnt.PLANTy-by+15,0,2,1,1,1,2)
--picture
 spr(229,-90-bx,295-by,0,2,0,0,2,2)
	spr(231,-50-bx,295-by,3,2,0,0,2,2)
--door 
 spr(1,door.x-bx,door.y-by,15,3,0,0,2,3)
--tolietdoor
 spr(toliet.anim,toliet.x-bx,toliet.y-by,15,3,1,0,2,3)
--glass
	spr(227,110-bx-30,clothespress.y-by-5,0,3,0,0,1,2)

--bed
 spr(bed.anim,bed.x-bx,bed.y-by,0,3,0,0,2,3)  
	spr(206,bed.x-bx+16,bed.y-by+30,0,2,0,0,2,2)

	--clothespress
	spr(clothespress.anim,clothespress.x-bx,clothespress.y-by,0,3,0,0,clothespress.w,clothespress.h)
-- kitchen
 spr(kitchen.anim,kitchen.x-bx,kitchen.y-by,8,2,0,0,5,2)
 spr(128,kitchen.x-bx,kitchen.y-by+32,0,2,0,0,1,4)
 spr(kitchen.anim2,kitchen.x-bx,kitchen.y-by-32,0,2,0,0,3,2)
 spr(kitchen.anim2,kitchen.x-bx+27,kitchen.y-by-32,0,2,1,0,3,2)
 spr(138,kitchen.x-bx+3,kitchen.y-by+88,4,2,0,0,2,2)
--bathroomA
 spr(bathroom.aanim,bathroom.ax-bx,bathroom.ay-by,0,3,0,0,1,2)
--readroom
 spr(200,-80-bx,182-by,0,3,0,0,2,2)
	spr(143,-120-bx,220-by,0,3,1,1,1,2)
	spr(read.anim2,read.x-bx+10,read.y-by+40,0,2,0,0,2,2)
	spr(read.anim,read.x-bx,read.y-by,8,3,0,0,2,2)
--fridge
 spr(fridge.anim,fridge.x-bx,fridge.y-by,0,2,0,0,2,3)
--catroom
 spr(195,-85-bx,340-by,0,2,0,0,3,2)
 spr(141,-35-bx,315-by,0,3,0,0,1,3)
	spr(170,-152-bx,294-by,0,3,0,0,2,2)
	spr(174,-150-bx,360-by,0,2,0,0,2,2)
end

