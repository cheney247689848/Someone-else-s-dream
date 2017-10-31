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
_this.sortList = nil
_this.creatList = nil


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
    _this.sortList = nil
    _this.sortList = {}

    _this.creatList = nil
    _this.creatList = {}

    for i,v in ipairs(_this.nodeList) do
        
        if v.tarLen == 1 then
            
            table.insert( _this.creatList, v)
        elseif v.tarIndex ~= -1 then
            
            table.insert( _this.sortList, v)
        end
    end
    --print("sortList len = " , #_this.sortList)

    --sort
    local tmp = nil
    for i = 1 , #_this.sortList do  
        for j = 1 , #_this.sortList - i do 
            
            if _this.sortList[j].weight > _this.sortList[j+1].weight then
                tmp = _this.sortList[j]  
                _this.sortList[j] = _this.sortList[j+1]
                _this.sortList[j+1] = tmp
            elseif _this.sortList[j].weight == _this.sortList[j+1].weight and _this.sortList[j].tarLen > _this.sortList[j+1].tarLen then
                tmp = _this.sortList[j]  
                _this.sortList[j] = _this.sortList[j+1]
                _this.sortList[j+1] = tmp
            end

            -- if _this.sortList[j].tarIndex == 1 and _this.sortList[j+1].tarIndex ~= 1 then
            --     tmp = _this.sortList[j]  
            --     _this.sortList[j] = _this.sortList[j+1]
            --     _this.sortList[j+1] = tmp
            -- elseif _this.sortList[j].tarIndex ~= 1 and _this.sortList[j+1].tarIndex ~= 1 then

            --     if _this.sortList[j].tarLen > _this.sortList[j+1].tarLen then  
            --         tmp = _this.sortList[j]  
            --         _this.sortList[j] = _this.sortList[j+1]
            --         _this.sortList[j+1] = tmp
            --     elseif _this.sortList[j].tarLen == _this.sortList[j+1].tarLen and _this.sortList[j].weight >  _this.sortList[j+1].weight then
            --         tmp = _this.sortList[j]  
            --         _this.sortList[j] = _this.sortList[j+1]
            --         _this.sortList[j+1] = tmp
            --     end 
            -- end
        end  
    end

    --debug
    for i,v in ipairs(_this.sortList) do
        
        print(string.format( "wei = %d , tarLen = %d , tarIndex = %d , index = %d ",v.weight , v.tarLen , v.tarIndex , v.index ))
    end
end

--每个单独产生的G位置都存在对应整体map的寻路地址
--G位置产生水滴
--G位置产生的水滴按自己本身的寻路地址散布


function _this:Refresh()

    --clear
    for i,v in ipairs(L_NodeController.nodeList) do
        
        if v.status == L_TypeStatusNode.IDLE then
            
            L_Map:SetDynData(v.index , 0)
        else
            L_Map:SetDynData(v.index , 2) --2 是临时值
        end
    end

    for i,v in ipairs(_this.sortList) do
        
        -- if v.status == L_TypeStatusNode.NONE then
        --     --当前为空块
        --     if v.tarIndex ~= -1 then
                
        --         if v.tarIndex == 1 then
        --             -- 1 为起点  直接产生
        --             print("creat : " , v.index)
        --             v.status = L_TypeStatusNode.DROP
        --         else
                    
        --             if self.nodeList[v.tarIndex].status == L_TypeStatusNode.IDLE then
        --                 --可转换
        --                 self.nodeList[v.tarIndex].status = L_TypeStatusNode.NONE
        --                 self.nodeList[v.tarIndex].isTranf = true
        --                 v.status = L_TypeStatusNode.DROP
        --                 print("creat tranf : " , v.tarIndex , v.index)
        --             elseif self.nodeList[v.tarIndex].isTranf then
        --                 -- v.weight = v.weight + 1
        --                 print("weight add : " , v.tarIndex , v.index)
        --             end
        --         end
        --     end
        -- end

        if v.status == L_TypeStatusNode.IDLE then
            
            -- local paths = L_Map:FindPath(1 , dex)
            -- if paths ~= nil then
                
            --     if #paths >= 2 then
            --         v:SetTarIndex(paths[#paths - 1] + 1 , #paths)
            --     else
            --         print("Error paths len = " , #paths , dex)
            --     end
            -- else
            --     print("Error Path is nil")
            -- end

        elseif v.status == L_TypeStatusNode.NONE then 

            if v.tarIndex == 1 then
                -- 1 为起点  直接产生
                print("creat : " , v.index)
                v.status = L_TypeStatusNode.DROP
                L_Map:SetDynData(v.index , 2)
            else
                

            end
        end
    end

    for i,v in ipairs(_this.sortList) do
        
        if v.status == L_TypeStatusNode.DROP then
            
            v.status = L_TypeStatusNode.IDLE
        end
        v:UpdateStatus()
    end
end

function _this:UpdateDebugUI()
    
    for i,v in ipairs(_this.nodeList) do

        v:UpdateUI()
    end
end


--UI
function _this:CreatNodeUI()

    local bundle = L_Bundle:GetBundle("sgame_prefab_point")
    local point = L_Unit:LoadPrefabInstantiate("point" , bundle , self.nodeParent)
    return point
end

