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
    o.airTimer = 0
    o.isGrounded = true
    o.forceX, o.forceY = 0, 0

    return o
end

function Physics:setForce(forceX, forceY)
    if forceX ~= nil and forceX ~= 0 
    then
        self.forceX = forceX
    end
    if forceY ~= nil and forceY ~= 0
    then
        self.forceY = forceY
    end
end

function Physics:addForce(forceX, forceY)
    if forceX ~= nil and forceX ~= 0
    then
        self.forceX = self.forceX + forceX
    end
    if forceY ~= nil and forceY ~= 0
    then
        self.forceY = self.forceY + (-1)*forceY 
    end
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

function Player:sayName()
    print(self.name)
end

player = Player:newPlayer('HERO', 50, 50, 10, 10, 6)

function _init()
    cls()
    player:addToWorld()
    player:sayName()
    player:drawBounds()
    print("-> " .. Physics.world["HERO"].x)
end

function _update60() 

end

function _draw()
    -- cls()
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
