pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

local Physics = {}
Physics.__index = Physics
Physics.world = {}

function Physics:newRec2D(x, y, w, h, gravity)
    local o = setmetatable({}, self)
    o.__index  = o
    o.x, o.y = x, y
    o.w, o.h = w, h
    o.gravity = gravity
    o.airTimer = 0
    o.isGrounded = true

    return o
end

function Physics:addToWorld(name)
    Physics.world[name] = self
end

function Physics:deleteFromWorld(name)
    Physics.world[name] = nil
    self = nil
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
    player.rec2D = Physics:newRec2D(x, y, w, h, g)

    return player
end

function Player:drawBounds()
    self.rec2D.drawBounds()
end

function Player:addToWorld()
    self.rec2D:addToWorld(self.name)
end

function Player:killPlayer()
    self.rec2D.deleteFromWorld(self.name)
    self = nil
end

function Player:sayName()
    print(self.name)
end

player = Player:newPlayer('HERO', 50, 50, 10, 10, 6)

function _init()
    player:addToWorld()
end

function _update60() 

end

function _draw()
    cls()
    player:sayName()
    print(player.rec2D.x)
    player:drawBounds()
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
