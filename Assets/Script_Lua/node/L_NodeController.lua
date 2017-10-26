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

_this.nodeParent = nil
_this.nodeList = nil
_this.SortList = nil

function _this:Init(num , parent)
    
    _this.nodeParent = parent
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
    
    --clean
    _this.SortList = nil
    _this.SortList = {}

    for i,v in ipairs(_this.nodeList) do
        
        if v.tarIndex ~= -1 then
            
            table.insert( _this.SortList, v)
        end
    end
    --print("SortList len = " , #_this.SortList)

    --sort
    local tmp = nil
    for i=1 , #_this.SortList - 1 do  
        for j=1 , #_this.SortList - i do  
            if _this.SortList[j].tarLen < _this.SortList[j+1].tarLen then  
                tmp = _this.SortList[j]  
                _this.SortList[j] = _this.SortList[j+1]
                _this.SortList[j+1] = tmp  
            end  
        end  
    end

    --debug
    -- for i,v in ipairs(_this.SortList) do
        
    --     print(v.tarLen , v.tarIndex , v.index)
    -- end
end

--思路
--寻找最短的路径
--path list 
function _this:Refresh()
    
    for i,v in ipairs(_this.SortList) do
        
        if v.status == L_TypeStatusNode.NONE then
            --当前为空块
            if v.tarIndex ~= -1 then
                
                if v.tarIndex == 1 then
                    -- 1 为起点  直接产生
                    print("creat : " , v.index)
                    v.status = L_TypeStatusNode.IDLE
                else
                    
                    if self.nodeList[v.tarIndex].status == L_TypeStatusNode.IDLE then
                        --可转换
                        self.nodeList[v.tarIndex].status = L_TypeStatusNode.NONE
                        v.status = L_TypeStatusNode.IDLE
                        print("creat tranf : " , v.tarIndex , v.index)
                    end
                end
            end
        end
    end

    for i,v in ipairs(_this.SortList) do
        
        v:UpdateStatus()
    end
    
    -- for i = 1 , 10 do  --for metadata

    --     if condition then   --寻找空格子
            
    --         --保存得出的路径  添加到队列中
    --     end
    -- end
    --合并路径  得出需移动的路线
    --复制元数据 标记路径 碰到路径就断开
    --计算出每个空格子填充的方向属性
end


--UI

function _this:CreatNodeUI()

    local bundle = L_Bundle:GetBundle("sgame_prefab_point")
    local point = L_Unit:LoadPrefabInstantiate("point" , bundle , self.nodeParent)
    return point
end

