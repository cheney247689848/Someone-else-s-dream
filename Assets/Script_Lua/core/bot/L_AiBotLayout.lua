-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------

L_AiBotLayout = {}
setmetatable(L_AiBotLayout, {__index = _G})
local _this = L_AiBotLayout

_this.stateGlobal = nil
_this.stateList = nil

-- _this.length = v = function ()
    
--     return #self.stateList
-- end

function _this.New(o)
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    o.stateList = {}
    return o;
end

function _this:SetStateGlobal(state)
    
    _this.stateGlobal = state
end

--==============================--
--desc:
--time:2017-11-11 05:08:20
--@state:
--@return 
--==============================--
function _this:AddState(state)
    
    table.insert( self.stateList, state)
end

--==============================--
--desc:
--time:2017-11-11 05:08:17
--@state:
--@return 
--==============================--
function _this:SubState(state)
    
    for i,v in ipairs(self.stateList) do
        if state == v then
            table.remove( self.stateList, i )
            return
        end
    end
end

function _this:GetStateList()
    
    return self.stateList
end

function _this:GetLength()
    
    return #self.stateList
end

function _this:GetState(index)
    
    if self.stateList[index] ~= nil then
        
        return self.stateList[index]
    end
    return nil
end

function _this:GetGlobalState()
    
    return self.stateGlobal
end



