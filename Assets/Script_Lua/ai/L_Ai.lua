-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------


L_Ai = {}
setmetatable(L_Ai, {__index = _G})
local _this = L_Ai

_this.layouts = nil
_this.layoutIndex = nil

_this.machine = nil

function _this.New(o)
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    return o;
end

function _this:Init()
    
    self.layouts = {}
    self.layoutIndex = -1
    self.machine = nil
end

function _this:AddLayout(layout)

    table.insert( self.layouts, layout )
end

function _this:SubLayout(layout)
    
    for i,v in ipairs(self.layouts) do
        if layout == v then
            table.remove( self.layout, i )
            return
        end
    end
end

function _this:CurrentLayout()
    
    return self.layouts[self.layoutIndex]
end

function _this:ChangeLayout(index)
    
    if self.layouts[index] == nil then
        
        print(string.format( "Error ChangeLayout index = %d", index ))
        return
    end
    self.layoutIndex = index
    local layout = self.layouts[self.layoutIndex]
end

function _this:Update()
    
    if self.machine ~= nil then
        self.machine:Update(UnityEngine.Time.deltaTime)
    end
end





