-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-- 配置地形  数据查询  类型筛选  算法结构
-- 
-------------------------------------------------------------------
L_Map = {}
setmetatable(L_Map, {__index = _G})
local _this = L_Map

_this.metaData = nil --暂定是一维数据

--get

-- _this.isFiex = function ()
    
--     return false
-- end

--func

function _this:SetConfig(data)
    
    _this.metaData = data
end





