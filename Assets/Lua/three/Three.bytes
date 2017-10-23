-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-- 简单树结构
-------------------------------------------------------------------

L_Three = {}
setmetatable(L_Three, {__index = _G})
local _this = L_Three

_this.trunk = {} --默认创建主干
_this.data = nil
--trunk
--branch
function _this:New(o)
    
    o = o or {}
    _this.data = o
    function _this.data:New()
        --重写new
        local d = {}
        setmetatable(d , self)
        self.__index = self
        return d
    end
    setmetatable(o , self)
    self.__index = self
    return o
end

function _this:AddBranch(trunk)
    
    local branch = _this.data:New()
    table.insert( trunk, branch )
end






