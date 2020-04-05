pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

local Physics = {}
Physics.__index = Physics
Physics.world = {}

function Physics:newRect2D(x, y, w, h, g)
    local o = setmetatable({}, self)
    o.__index  = o
    o.x, o.y, o.w, o.h = x, y, w, h
    o.gravity = g
    o.air_timer = -1
    o.is_grounded = false
    o.forceX, o.forceY = 0, 0

    return o
end

function Physics:setForce(v2D)
    if v2D.forceX ~= nil and v2D.forceX ~= 0 
    then
        self.forceX = v2D.forceX
    end

    if v2D.forceY ~= nil and v2D.forceY ~= 0
    then
        self.forceY = v2D.forceY
    end
end

function Physics:addForce(v2D)
    if v2D.forceX ~= nil and v2D.forceX ~= 0
    then
        self.forceX = self.forceX + v2D.forceX
    end

    if v2D.forceY ~= nil and v2D.forceY ~= 0
    then
        self.forceY = self.forceY + (-1) * v2D.forceY 
    end
end

function Physics:applyGravity()
    local next_py = self.y
    
    if self.is_grounded == false and
       self.air_timer <= 0
    then
        next_py = next_py + self.gravity
    end

    self.y = next_py
end

function Physics:update()

end

function Physics:addToWorld(name)
    Physics.world[name] = self
end

function Physics.deleteFromWorld(name)
    Physics.world[name] = nil
end

function Physics.drawBounds()
    for _, o in pairs(Physics.world) do
        rect(o.x, o.y, o.x + o.w, o.y + o.h, 8)
    end
end

local Player = {}
Player.__index = Player

function Player:newPlayer(name, x, y, w, h, g)
    local player = setmetatable({}, self)
    player.name = name
    player.sprite = "▥"
    player.rect2D = Physics:newRect2D(x, y, w, h, g)

    return player
end

function Player:drawBounds()
    self.rect2D.drawBounds()
end

function Player:addToWorld()
    self.rect2D:addToWorld(self.name)
end

function Player:killPlayer()
    self.rect2D.deleteFromWorld(self.name)
    self.rect2D = nil
end

function Player:applyGravity()
    self.rect2D:applyGravity()
end


function _init()
    cls()
    hero = Player:newPlayer('HERO', 50, 50, 10, 10, 1)
    hero:addToWorld()
end

function _update60() 
    hero:applyGravity()
end

function _draw()
    cls()
    hero:drawBounds()
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
