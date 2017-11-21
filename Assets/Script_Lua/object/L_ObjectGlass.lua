-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require "observer/L_MessageObserver"

L_ObjectGlass = {}
setmetatable(L_ObjectGlass , {__index = G})
local _this = L_ObjectGlass

_this.mesObserver = nil
_this.hp = nil
_this.objImg = nil

function _this:Config(data , obj)
    
    _this.hp = 10
    _this.objImg = obj
    mesObserver = L_MessageObserver.New()
end

function _this:HpAdd(hp)
    
    if hp < 0 then
        
        print(string.format( "Error HpAdd hp = %d",hp ))
        return
    end
    _this.hp = _this.hp + hp
    mesObserver:PostEvent(L_TypeObjectGlass.UPDATEHP , 1 , 2 , 3)
    --event
end

function _this:SubAdd(hp)
    
    if hp < 0 then
        
        print(string.format( "Error SubAdd hp = %d",hp ))
        return
    end
    _this.hp = _this.hp - hp
    if _this.hp < 0 then
        
        _this.hp = 0
    end
    --event
    --death event
    mesObserver:PostEvent(L_TypeObjectGlass.UPDATEHP , 1 , 2 , 3)
    mesObserver:PostEvent(L_TypeObjectGlass.LOSS , 1 , 2 , 3)
end