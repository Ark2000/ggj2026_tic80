--@region MISC
KEY_UP=0;KEY_DOWN=1;KEY_LEFT=2;KEY_RIGHT=3;KEY_A=4;KEY_B=5;KEY_X=6;KEY_Y=7;
t=0
game_state="game"
debug_mode=true
keyp_state={prev={},curr={},frame=-1}
--keyp
function keyp(k)
  if keyp_state.frame ~= t then
    keyp_state.frame = t
    keyp_state.prev = keyp_state.curr
    keyp_state.curr = {}
  end
  if keyp_state.curr[k] == nil then
    keyp_state.curr[k] = key(k)
  end
  return keyp_state.curr[k] and not (keyp_state.prev and keyp_state.prev[k])
end
-- Glitch效果
glitch={shake=0,d=4,
update=function(self)
	if self.shake>0 then
		poke(0x3FF9+1,math.random(-self.d,self.d))
		self.shake=self.shake-1
		if self.shake==0 then memset(0x3FF9,0,2) end
	end
end,
play=function(self,num)
  self.shake=num
end}
--camera
W,H = 240,136 -- screen width/height
bdd = 50 -- scroll bounding distance
cam_speed = 0.1 -- camera movement speed
-- scroll bounding box 
minx,miny = bdd,bdd
maxx,maxy = W-bdd,H-bdd
cam={x=0,y=0,tx=0,ty=0} --camera
function camxy(x,y) return x-cam.x, y-cam.y end
function sprw(id,x,y,colorkey,scale,flip,rotate,w,h) local sx, sy = camxy(x,y) spr(id,sx,sy,colorkey,scale,flip,rotate,w,h) end
function rectbw(x,y,w,h,c) local sx, sy = camxy(x,y) rectb(sx,sy,w,h,c) end
function printw(str,x,y,c,fixed,scale,small) local sx, sy = camxy(x,y) print(str,sx,sy,c,fixed,scale,small) end
function mapdrw()--draw map according to camera coordinates
    map(
        cam.x//8, cam.y//8, -- source tiles
        31, 18, -- destination pixels
        -(cam.x%8),-(cam.y%8) -- smoothing modulo
    )
end
function rebound(step) -- recompute boundings
  bdd = bdd + step -- change bounding from step
  minx,miny = bdd,bdd
  maxx,maxy = W-bdd,H-bdd
end
function lerp(a, b, t) return a + (b - a) * t end
function update_camera(x,y,sz)
  if y-cam.ty < miny then
    cam.ty = y - miny
  end
  if y-cam.ty > maxy-sz then
    cam.ty = y - (maxy - sz)
  end
  if x-cam.tx < minx then
    cam.tx = x - minx
  end
  if x-cam.tx > maxx-sz then
    cam.tx = x - (maxx - sz)
  end
  cam.x = lerp(cam.x, cam.tx, cam_speed)
  cam.y = lerp(cam.y, cam.ty, cam_speed)
 -- shrink/grow boundary distance to screen limit
 if btnp(6) and bdd > 0 then rebound(-5) end
 if btnp(7) and bdd < 50 then rebound(5) end 
end
--@endregion

--@region Entity System
entities={
  list={},
  next_id=0,
  pairs_prev={},
  add=function(self, e)
    e.alive = (e.alive ~= false)
    e.z = e.z or 0
    if not e._cid then
      self.next_id = self.next_id + 1
      e._cid = self.next_id
    end
    self.list[#self.list+1] = e
    if e.init then e:init() end
    return e
  end,
  remove=function(self, e)
    for i=#self.list,1,-1 do
      if self.list[i] == e then
        table.remove(self.list, i)
        return
      end
    end
  end,
  update=function(self)
    for i=#self.list,1,-1 do
      local e = self.list[i]
      if not e.alive then
        table.remove(self.list, i)
      elseif e.update then
        e:update()
      end
    end
  end,
  draw=function(self)
    table.sort(self.list, function(a,b) return (a.z or 0) < (b.z or 0) end)
    for i=1,#self.list do
      local e = self.list[i]
      if e.draw then e:draw() end
      if debug_mode then 
        rectbw(e.x,e.y,e.w,e.h,5)
        if e.use_hurtbox then
          rectbw(e.x+e.hx,e.y+e.hy,e.hw,e.hh,7)
        end
      end
    end
  end,
  collide=function(self)
    local pairs_cur = {}
    for i=1,#self.list-1 do
      local a = self.list[i]
      if a.w and a.h then
        for j=i+1,#self.list do
          local b = self.list[j]
          if b.w and b.h then
            local boxa = get_collide_box(a)
            local boxb = get_collide_box(b)
            if check_collision(boxa, boxb) then
              if not a._cid then
                self.next_id = self.next_id + 1
                a._cid = self.next_id
              end
              if not b._cid then
                self.next_id = self.next_id + 1
                b._cid = self.next_id
              end
              local ida, idb = a._cid, b._cid
              if ida > idb then ida, idb = idb, ida end
              local key = ida..":"..idb
              if not pairs_cur[key] then
                pairs_cur[key] = {a=a,b=b}
                if not self.pairs_prev[key] then
                  trace("on_collide_start", a, b)
                  if a.on_collide_start then a:on_collide_start(b) end
                  if b.on_collide_start then b:on_collide_start(a) end
                end
              end
              if a.on_collide then a:on_collide(b) end
              if b.on_collide then b:on_collide(a) end
            end
          end
        end
      end
    end
    for key,prev in pairs(self.pairs_prev) do
      if not pairs_cur[key] then
        local a, b = prev.a, prev.b
        if a.on_collide_end then a:on_collide_end(b) end
        if b.on_collide_end then b:on_collide_end(a) end
      end
    end
    self.pairs_prev = pairs_cur
  end
}

function get_hurtbox(e)
  if e.hx and e.hy and e.hw and e.hh then
    return {x=e.x+e.hx,y=e.y+e.hy,w=e.hw,h=e.hh}
  end
  return {x=e.x,y=e.y,w=e.w,h=e.h}
end

function get_collide_box(e)
  if e.use_hurtbox then
    return get_hurtbox(e)
  end
  return {x=e.x,y=e.y,w=e.w,h=e.h}
end

function timer_id(e, name)
  return name..":"..tostring(e._cid or e)
end

function is_timed(e, name)
  return get_timer(timer_id(e, name)) ~= nil
end

function set_invuln(e, frames)
  local f = frames or 0
  if f <= 0 then return end
  local id = timer_id(e, "invuln")
  remove_timer(id)
  add_timer(id, function() end, f, 1)
end

function set_stun(e, frames)
  local f = frames or 0
  if f <= 0 then return end
  local id = timer_id(e, "stun")
  remove_timer(id)
  add_timer(id, function() end, f, 1)
end

function apply_hurt(e, dmg, stun_frames)
  if is_timed(e, "invuln") then return end
  e.hp = e.hp - (dmg or 0)
  if e.hp <= 0 then
    if e.on_death then e:on_death() else e.alive = false end
  end
  if stun_frames and stun_frames > 0 then
    set_stun(e, stun_frames)
  end
  set_invuln(e, e.invuln_time or 0)
end

function is_wall(x, y)
  local tx, ty = x // 8, y // 8
  local id = mget(tx, ty)
  return fget(id, 0)
end

-- wall check
function can_move(nx, ny, size,padding)
  -- size 是角色的像素宽度（如16）
  -- 检查角点+边中点，避免被小墙体卡进
  local x0 = nx + padding
  local y0 = ny + padding
  local x1 = nx + size - padding
  local y1 = ny + size - padding
  local xm = (x0 + x1) // 2
  local ym = (y0 + y1) // 2
  if is_wall(x0, y0) or is_wall(x1, y0) or
     is_wall(x0, y1) or is_wall(x1, y1) or
     is_wall(xm, y0) or is_wall(xm, y1) or
     is_wall(x0, ym) or is_wall(x1, ym) then
    return false
  end
  return true
end

-- aabb check
function check_collision(a, b)
  -- a, b 为包含 x, y, w, h 的对象
  return a.x < b.x + b.w and
         a.x + a.w > b.x and
         a.y < b.y + b.h and
         a.y + a.h > b.y
end
--@endregion

--@region Timers
subtitles={list={}}
timers={list={},by_id={}}
function add_timer(idstr, callback, delay, times)
  if not idstr then return end
  if timers.by_id[idstr] then remove_timer(idstr) end
  local d = delay or 1
  if d < 1 then d = 1 end
  local t = {
    id=idstr,
    cb=callback,
    delay=d,
    remaining=d,
    times=(times == nil) and 1 or times
  }
  timers.list[#timers.list+1] = t
  timers.by_id[idstr] = t
  if t.times <= 0 then
    remove_timer(idstr)
  end
  return t
end
function remove_timer(idstr)
  local t = timers.by_id[idstr]
  if not t then return end
  for i=#timers.list,1,-1 do
    if timers.list[i] == t then
      table.remove(timers.list, i)
      break
    end
  end
  timers.by_id[idstr] = nil
end
function get_timer(idstr)
  return timers.by_id[idstr]
end
function update_timers()
  for i=#timers.list,1,-1 do
    local t = timers.list[i]
    t.remaining = t.remaining - 1
    if t.remaining <= 0 then
      if t.cb then t.cb() end
      t.times = t.times - 1
      if t.times <= 0 then
        remove_timer(t.id)
      else
        t.remaining = t.delay
      end
    end
  end
end

--timer测试
-- add_timer("test", function()
--   trace("test"..t)
-- end, 10, 99999)
--@endregion

--@region Subtitles
function split_lines(s)
  local lines={}
  for line in (s.."\n"):gmatch("(.-)\n") do
    lines[#lines+1]=line
  end
  return lines
end
function subtitle(text,bgcolor,duration)
  local lines = split_lines(text or "")
  local line_h = 6
  local line_gap = 1
  local pad = 2
  local h = #lines * line_h + math.max(#lines-1,0) * line_gap + pad*2
  local life = duration or 120
  subtitles.list[#subtitles.list+1] = {
    text=text or "",
    lines=lines,
    bgcolor=bgcolor or 0,
    ttl=life,
    life=life,
    h=h,
    age=0,
    y=H
  }
end
function update_subtitles()
  for i=#subtitles.list,1,-1 do
    local s = subtitles.list[i]
    s.ttl = s.ttl - 1
    s.age = s.age + 1
    if s.ttl <= 0 then
      table.remove(subtitles.list, i)
    end
  end
end
function draw_subtitles()
  local y = H
  local gap = 2
  for i=1,#subtitles.list do
    local s = subtitles.list[i]
    local target_y = y - s.h
    local k = math.min(s.age/8,1)
    local exit = 0
    if s.ttl < 8 then exit = (8 - s.ttl) / 8 end
    local offset = (1-k)*6 + exit*6
    local target = target_y + offset
    if s.y == nil then s.y = target + 6 end
    s.y = lerp(s.y, target, 0.25)
    rect(0,s.y,W,s.h,s.bgcolor)
    local ty = s.y + 2
    for j=1,#s.lines do
      print(s.lines[j],2,ty,15)
      ty = ty + 6 + 1
    end
    y = target_y - gap
  end
end
--@endregion

--@region Player
plr=entities:add({
  x=10*8,y=30*8,w=16,h=16,z=1,spd=1,accel=0.4,drag=0.4,vx=0,vy=0,anim_t=0,facing=1,hp=9999,use_hurtbox=true,
  backpack={},
  interact_objs={},
  hx=4,hy=6,hw=8,hh=8,
  atk_state="idle",atk_t=0,atk_hit=12,atk_recover=12,invuln_time=60,
  hurt=function(self, dmg, stun_frames)
    apply_hurt(self, dmg, stun_frames)
    if self.hp < 0 then game_state = "gameover" end
  end,
  add_item=function(self, item_name, item_cnt)
    self.backpack[item_name] = (self.backpack[item_name] or 0) + item_cnt
    subtitle("GET: "..item_name.." x"..item_cnt,6,120)
  end,
  update=function(self)
    if is_timed(self, "stun") then return end
    if self.atk_state == "attack" then
      self.atk_t = self.atk_t + 1
      if self.atk_t == self.atk_hit then
        local hit_w, hit_h = 8, 16
        local hx = self.x + (self.facing == 1 and self.w or -hit_w)
        local hy = self.y
        add_hitbox(hx,hy,hit_w,hit_h,1,1,self, function(hitbox)
          sprw(26,hx,hy,10,1,(self.facing == -1) and 1 or 0,0,1,2)
        end)
      end
      if self.atk_t >= self.atk_hit + self.atk_recover then
        self.atk_state = "idle"
        self.atk_t = 0
      end
      return
    end
    local dx, dy = 0, 0
    local padding=self.padding or 4
    if btn(KEY_UP) then dy=dy-1 end
    if btn(KEY_DOWN) then dy=dy+1 end
    if btn(KEY_LEFT) then dx=dx-1; self.facing=-1 end
    if btn(KEY_RIGHT) then dx=dx+1; self.facing=1 end
    if dx ~= 0 and dy ~= 0 then
      dx = dx * 0.7071
      dy = dy * 0.7071
    end
    if dx ~= 0 or dy ~= 0 then
      self.vx = self.vx + dx * self.accel
      self.vy = self.vy + dy * self.accel
    else
      self.vx = self.vx * self.drag
      self.vy = self.vy * self.drag
      if math.abs(self.vx) < 0.01 then self.vx = 0 end
      if math.abs(self.vy) < 0.01 then self.vy = 0 end
    end
    local speed = math.sqrt(self.vx*self.vx + self.vy*self.vy)
    if speed > self.spd then
      local s = self.spd / speed
      self.vx = self.vx * s
      self.vy = self.vy * s
    end
    local nx = self.x + self.vx
    local ny = self.y + self.vy
    local moved = false
    -- 先尝试X轴，再尝试Y轴，避免对角卡墙
    if nx ~= self.x and can_move(nx, self.y, self.w,padding) then
      self.x = nx
      moved = true
    end
    if ny ~= self.y and can_move(self.x, ny, self.w,padding) then
      self.y = ny
      moved = true
    end
    if moved then
      self.anim_t = self.anim_t + 1
    else
      self.anim_t = 0
    end
    if btnp(KEY_A) then
      self.atk_state = "attack"
      self.atk_t = 0
    end
    if self.interact_objs[1] then
      if btnp(KEY_B) then
        self.interact_objs[1]:on_interact(self)
      end
    end

  end,
  draw=function(self)
    if is_timed(self, "invuln") and (t//2)%2 == 0 then return end
    local id = 16
    if self.atk_state == "attack" then
      if self.atk_t < self.atk_hit then
        id = 20
      else
        id = 24
      end
    elseif self.anim_t > 0 then
      local frames = {18,20,22}
      id = frames[(self.anim_t//6)%#frames + 1]
    end
    local flip = (self.facing == -1) and 1 or 0
    sprw(id,self.x,self.y,10,1,flip,0,2,2)
    if self.interact_objs[1] then
      printw("INTERACT", self.x, self.y - 10, 11)
    end
  end,
  on_interact_start=function(self, other)
    self.interact_objs[#self.interact_objs+1] = other
  end,
  on_interact_end=function(self, other)
    for i=1,#self.interact_objs do
      if self.interact_objs[i] == other then
        table.remove(self.interact_objs, i)
        break
      end
    end
  end,
})
--@endregion

--@region hitbox
function add_hitbox(x,y,w,h,life,damage,owner,drawfunc)
  return entities:add({
    x=x,y=y,w=w,h=h,z=10,life=life or 1,damage=damage or 1,owner=owner,
    update=function(self)
      self.life = self.life - 1
      if self.life < 0 then self.alive = false end
    end,
    draw=function(self)
      if drawfunc then drawfunc(self) end
    end,
    on_collide_start=function(self, other)
      if other ~= self.owner and other.hurt then
        other:hurt(self.damage)
      end
    end
  })
end
--@endregion

--@region Traps
function add_trap(x,y,opts)
  opts = opts or {}
  return entities:add({
    x=x,y=y,w=opts.w or 8,h=opts.h or 8,z=opts.z or 0,
    use_hurtbox=true,
    hx=3,hy=3,hw=2,hh=2,
    charges=opts.charges or 3,
    dmg=opts.dmg or 1,
    stun_time=opts.stun_time or 30,
    on_collide_start=function(self, other)
      if self.charges <= 0 then return end
      local hb = get_hurtbox(other)
      if check_collision(self, hb) then
        if other.hurt then other:hurt(self.dmg, self.stun_time) end
      end
      self.charges = self.charges - 1
      if self.charges <= 0 then self.alive = false end
    end,
  })
end

function add_trap_1(x,y,opts)
  local e = add_trap(x,y,opts)
  e.draw=function(self)
    sprw(5,self.x,self.y,10,1,0,0,1,1)
  end
  e.charges = 1
  return e
end

function add_trap_2(x,y,opts)
  local e = add_trap(x,y,opts)
  e.draw=function(self)
    sprw(6,self.x,self.y,10,1,0,0,1,1)
  end
  e.charges = 999
  return e
end

--@endregion

--@region Rats (NPC)
function add_rat(x,y)
  return entities:add({
    x=x,y=y,w=8,h=8,z=1,spd=0.6,hp=1,anim_t=0,facing=1,invuln_time=30,
    vx=0,vy=0,state="move",state_t=60,move_time=240,pause_time=60,
    hurt=function(self, dmg, stun_frames)
      apply_hurt(self, dmg, stun_frames)
    end,
    update=function(self)
      if is_timed(self, "stun") then return end
      if self.state_t <= 0 then
        if self.state == "move" then
          self.state = "pause"
          self.state_t = self.pause_time
        else
          self.state = "move"
          self.state_t = self.move_time
          local ang = math.random() * math.pi * 2
          self.vx = math.cos(ang)
          self.vy = math.sin(ang)
        end
      end
      if self.state == "move" then
        local nx = self.x + self.vx * self.spd
        local ny = self.y + self.vy * self.spd
        if not can_move(nx, self.y, self.w,2) then
          self.vx = -self.vx
          nx = self.x + self.vx * self.spd
        end
        if not can_move(self.x, ny, self.w,2) then
          self.vy = -self.vy
          ny = self.y + self.vy * self.spd
        end
        local moved = false
        if can_move(nx, self.y, self.w,2) then
          self.x = nx
          moved = true
        end
        if can_move(self.x, ny, self.w,2) then
          self.y = ny
          moved = true
        end
        if self.vx < 0 then self.facing = -1
        elseif self.vx > 0 then self.facing = 1 end
        if moved then self.anim_t = self.anim_t + 1 end
      end
      self.state_t = self.state_t - 1
    end,
    draw=function(self)
      if is_timed(self, "invuln") and (t//2)%2 == 0 then return end
      local id = (self.anim_t//10)%2
      local flip = (self.facing == -1) and 0 or 1
      sprw(id,self.x,self.y,10,1,flip,0,1,1)
    end,
    on_collide_start=function(self, other)
      if other == plr then
        local hb = get_hurtbox(plr)
        if check_collision(self, hb) then
          plr:hurt(10, 30)
        end
      end
    end
  })
end
--@endregion

--@region Containers
function add_container(x,y,opts)
  opts = opts or {}
  local e = entities:add({
    x=x,y=y,w=opts.w or 8,h=opts.h or 8,z=opts.z or 0,
    use_hurtbox=true,
    hx=3,hy=3,hw=2,hh=2,
    on_collide_start=function(self, other)
      if self.opened then return end
      if other.on_interact_start then other:on_interact_start(self) end
    end,
    on_collide_end=function(self, other)
      if other.on_interact_end then other:on_interact_end(self) end
    end,
    on_interact=function(self, other)
      self.opened = true
      self:on_collide_end(other)
      trace("on_interact", self, other)
    end
  })
  return e
end
--@endregion

--@region BOOT & TIC

function BOOT()
  local map_w, map_h = 240, 136
  for my=0,map_h-1 do
    for mx=0,map_w-1 do
      local id = mget(mx,my)
      if id == 65 then
        add_rat(mx*8, my*8)
        mset(mx, my, 28)
      elseif id == 5 then
        add_trap_1(mx*8, my*8)
        mset(mx, my, 28)
      elseif id == 6 then
        add_trap_2(mx*8, my*8)
        mset(mx, my, 28)
      end
    end
  end
  cam.x=plr.x-W/2;cam.y=plr.y-H/2
  cam.tx=cam.x;cam.ty=cam.y
end

function TIC()
  if game_state == "game" then
    update_timers()
    entities:update()
    entities:collide()
    update_subtitles()
  end

	cls(13)
  update_camera(plr.x,plr.y,16)
  mapdrw() -- draw a 31x18 section of the map to camera position
  entities:draw()
  draw_subtitles()
  print("HP:"..plr.hp,4,4,12)
  if game_state == "gameover" then
    rect(0,0,W,H,0)
    print("GAME OVER", W//2-24, H//2-4, 15)
  end
  if debug_mode then
    rectb(minx,miny,maxx-minx,maxy-miny,12) -- draw camera bounding box
  end
  glitch:update()
	t=t+1


-- test
  -- if btnp(KEY_X) then remove_timer("test") end
  if keyp(28) then add_rat(plr.x+16,plr.y) end--1
  if keyp(29) then debug_mode = not debug_mode end--2
  if keyp(30) then add_trap(plr.x+16,plr.y) end--3
  if keyp(31) then glitch:play(10) end--4
  if keyp(32) then subtitle("Hello, world!"..t,6,120) end--5
  if keyp(33) then add_container(plr.x+16,plr.y) end--6
end

-- glitch效果
function BDR(row)
	if glitch.shake>0 then
		poke(0x3FF9,math.random(-glitch.d,glitch.d))
	end
end
--@endregion