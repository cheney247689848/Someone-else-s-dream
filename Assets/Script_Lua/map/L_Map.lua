-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-- 配置地形  数据查询  类型筛选  算法结构
-- 默认 1280*720  90x90 14*8(格子)
-------------------------------------------------------------------
require "PathSystem"

local Rect = UnityEngine.Rect

L_Map = {}
setmetatable(L_Map, {__index = _G})
local _this = L_Map

_this.offsetx = 10 --10像素的位移
_this.formx = 14
_this.formy = 8
_this.imgRect = {x = 90 , y = 90}
_this.metaData = nil --暂定是一维数据
_this.metaDynData = nil
_this.mergeData = nil
_this.pathSystem = nil
_this.glassPoint = 1

_this.sceneRect = Rect.New(0,0,1280,720)

--get

-- _this.isFiex = function ()
    
--     return false
-- end

--func

function _this:SetConfig(data)
    
    self.metaData = data
end

function _this:SetConfigRamdom()
    
    self.glassPoint = 50
    self.metaData = {
    0,0,0,0,0,0,0,0,0,0,0,0,1,0,
    0,0,0,0,1,0,0,0,0,0,0,0,0,0,
    0,0,0,0,1,0,0,0,0,0,1,0,0,0,
    0,0,0,1,1,0,0,0,0,1,0,0,0,0,
    0,0,0,1,0,0,0,1,0,1,0,0,0,0,
    0,0,0,1,0,0,1,1,1,0,0,0,0,0,
    0,0,0,1,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0
    }
    --clone
    _this.mergeData = {}
    for i = 1 , #self.metaData do

        table.insert(self.mergeData , self.metaData[i])
    end
    self.pathSystem = PathSystem.New(self.formx , self.formy , self.metaData)
end

function _this:CleanMergeData()

    for i= 1 , #self.metaData do
        
        self.mergeData[i] = self.metaData[i]
    end
end

function _this:SetMergeData(index , value)
    
    if self.glassPoint == index then
        
        print(string.format( "Error SetMergeData glassPoint = index = %d", index ))
        return
    end

    if self.mergeData[index] ~= nil then
        
        self.mergeData[index] = self.metaData[i] ~= 0 and self.metaData[i] or value
    else
        print(string.format( "Error SetMergeData index = %d", index ))
    end
end

function _this:RefreshMergeData()

    self.pathSystem:RefreshData(self.mergeData)
end

function _this:IsBlock(dex)

    if self.glassPoint == dex then
        
        return false
    end

    if self.metaData[dex] == 0 then
        
        return true
    end
    return false
end

function _this:IsGlass(dex)

    if self.glassPoint == dex then
        
        return true
    end
    return false
end

function _this:FindPath(sPos , ePos)
    
    local path = self.pathSystem:FindThePath(sPos - 1 , ePos - 1)
    if path == nil then
        return nil
    end
    local tPath = path:ToTable()
    return tPath
end

function _this:GetPosition(index)
    
    if self.metaData[index] == nil then
        
        print(string.format( "Error GetPosition index = %d", index ))
        return nil
    end
    local x , v1 = math.modf((index - 1) % self.formx)-- = index % _this.formx
    local y , v2 = math.modf((index - 1) / self.formx)
    -- local y = index / _this.formy
    -- print(x , y)
    return Vector3(self.imgRect.x * x , - (self.imgRect.y * y ), 0)
end

function _this:GetIndexByPosition(pos)
    
    -- pos.x = pos.x + _this.offsetx
    -- print(pos.x , pos.y)
    local x , v1 = math.modf(pos.x / self.imgRect.x)
    local y , v2 = math.modf(pos.y / self.imgRect.y)

    local index = x + self.formx * y + 1
    
    -- print(pos.x , pos.y , index)
    if self.metaData[index] ~= nil then
        
        return index
    end
    return -1
end




