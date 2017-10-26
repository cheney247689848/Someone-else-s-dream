-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-- 配置地形  数据查询  类型筛选  算法结构
-- 默认 1280*720  90x90 14*8(格子)
-------------------------------------------------------------------
require "PathSystem"

L_Map = {}
setmetatable(L_Map, {__index = _G})
local _this = L_Map

_this.offsetx = 10 --10像素的位移
_this.formx = 14
_this.formy = 8
_this.rect = {x = 90 , y = 90}
_this.metaData = nil --暂定是一维数据
_this.pathSystem = nil

--get

-- _this.isFiex = function ()
    
--     return false
-- end

--func

function _this:SetConfig(data)
    
    _this.metaData = data
end

function _this:SetConfigRamdom()
    
    _this.metaData = {
    0,0,0,0,1,0,0,0,0,0,0,0,0,0,
    0,0,0,0,1,0,0,0,0,0,0,0,0,0,
    0,0,0,0,1,0,0,0,0,0,0,0,0,0,
    0,0,0,1,1,0,0,0,0,0,0,0,0,0,
    0,0,0,1,0,0,0,0,0,0,0,0,0,0,
    0,0,0,1,0,0,0,0,0,0,0,0,0,0,
    0,0,0,1,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0
    }

    _this.pathSystem = PathSystem.New(_this.formx , _this.formy , _this.metaData)
end

function _this:IsBlock(dex)

    if _this.metaData[dex] == 0 then
        
        return true
    end
    return false
end

function _this:FindPath(sPos , ePos)
    
    local path = _this.pathSystem:FindThePath(sPos - 1 , ePos - 1):ToTable()
    -- if path ~= nil then
    --     path = path:ToTable()
    -- end
    return path
end

function _this:GetPosition(index)
    
    if _this.metaData[index + 1] == nil then
        
        print(string.format( "Error index = %d", index ))
        return nil
    end
    local x , v1 = math.modf(index % _this.formx)-- = index % _this.formx
    local y , v2 = math.modf(index / _this.formx)
    -- local y = index / _this.formy
    -- print(x , y)
    return Vector3(L_Map.rect.x * x , - (L_Map.rect.y * y ), 0)
end

function _this:GetIndexByPosition(pos)
    
    -- pos.x = pos.x + _this.offsetx
    pos.x = pos.x + _this.rect.x / 2
    pos.y = -(pos.y - _this.rect.y / 2)
    -- print(pos.x , pos.y)

    local x , v1 = math.modf(pos.x / _this.rect.x)
    local y , v2 = math.modf(pos.y / _this.rect.y)

    local index = x + _this.formx * y + 1
    
    print(pos.x , pos.y , index)
    if _this.metaData[index] ~= nil then
        
        return index
    end
    return -1
end




