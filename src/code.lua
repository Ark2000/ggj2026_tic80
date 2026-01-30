-- title:  Intern security guard
-- author: Your Name
-- desc:   2D像素悬疑解谜游戏
-- script: lua

local state,selected,maxUnlocked,menuOpts,t="MENU",1,1,{"New Game","Continue","How to Play","Credits"},0
local states={}



function states.MENU()
	if btnp(0,10,6)then selected=math.max(1,selected-1)end
	if btnp(1,10,6)then selected=math.min(#menuOpts,selected+1)end
	if btnp(4)then
		if selected==1 then state="GAME"
		elseif selected==2 then state="LEVEL_SELECT"
		elseif selected==3 then state="HOWTO"
		elseif selected==4 then state="CREDITS" end
	end
	cls(0) print("INTERN SECURITY GUARD",30,30,15,false,2)
	for i,opt in ipairs(menuOpts)do
		local y=70+i*15 local c=i==selected and 15 or 6
		print((i==selected and"> "or"  ")..opt,80,y,c)
	end
	if math.floor(t/30)%2==0 then print("_",75,70+selected*15,15) end
end

function states.LEVEL_SELECT()
	if btnp(4)then state="GAME" elseif btnp(5)then state="MENU" end
	cls(0) print("SELECT LEVEL",60,30,15,false,2) print("Press X to go back",50,100,6)
end

function states.HOWTO()
	if btnp(4)or btnp(5)then state="MENU" end
	cls(0) print("HOW TO PLAY",60,20,15,false,2)
	print("WASD/Arrows: Move",20,50,6) print("N: Attack",20,60,6)
	print("M: Search/Interact",20,70,6) print("ESC: Menu",20,80,6)
end

function states.CREDITS()
	if btnp(4)or btnp(5)then state="MENU" end
	cls(0) print("CREDITS",80,30,15,false,2) print("Made with TIC-80",50,70,6)
end

function states.GAME()
	cls(0) print("GAME START",70,60,15,false,2)
	if btnp(5)then state="MENU" end
end

function TIC()
	if states[state]then
		states[state]()
	else
		cls(0) print("ERROR: Unknown state: "..state,10,60,8)
		print("Returning to menu...",10,70,6)
		if btnp(4)then state="MENU" end
	end
end
