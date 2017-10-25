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
    --print(_this.pathSystem.data)
end

function _this:IsBlock(dex)

    if _this.metaData[dex] == 0 then
        
        return true
    end
    return false
end

function _this:FindPath(sPos , ePos)
    
    local path = _this.pathSystem:FindThePath(sPos , ePos):ToTable()
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
    print(x , y)
    return Vector3(L_Map.rect.x * x , - (L_Map.rect.y * y ), 0)
end

--思路
--寻找最短的路径
--path list 

function _this:Refresh()
    
    for i = 1 , 10 do  --for metadata

        if condition then   --寻找空格子
            
            --保存得出的路径  添加到队列中
        end
    end
    --合并路径  得出需移动的路线
    --复制元数据 标记路径 碰到路径就断开
    --计算出每个空格子填充的方向属性
end


