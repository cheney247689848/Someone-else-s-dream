-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require "node/L_Node"
require "map/L_Map"

L_NodeController = {}
setmetatable(L_NodeController, {__index = _G})
local _this = L_NodeController

_this.nodeList = nil

function _this:Init(num)
    
    _this.nodeList = {}
    for i = 1, num do

        local node = L_Node.New()
        node:Init()
        node:SetIndex(i)
        table.insert(_this.nodeList, node)
    end
    -- print(#_this.nodeList)
end

function _this:Sort()
    

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

