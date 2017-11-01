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
    self.sortList = nil
    self.sortList = {}

    for i,v in ipairs(self.nodeList) do
    
        if v.tarIndex ~= -1 then
            
            table.insert(self.sortList, v)
        end
    end
    print("sortList len = " , #_this.sortList)

    --sort
    local tmp = nil
    for i = 1 , #self.sortList do  
        for j = 1 , #self.sortList - i do 
            
            if self.sortList[j].tarLen > self.sortList[j+1].tarLen then
                
                tmp = _this.sortList[j]  
                _this.sortList[j] = _this.sortList[j+1]
                _this.sortList[j+1] = tmp
            end

            -- if _this.sortList[j].weight > _this.sortList[j+1].weight then
            --     tmp = _this.sortList[j]  
            --     _this.sortList[j] = _this.sortList[j+1]
            --     _this.sortList[j+1] = tmp
            -- elseif _this.sortList[j].weight == _this.sortList[j+1].weight and _this.sortList[j].tarLen > _this.sortList[j+1].tarLen then
            --     tmp = _this.sortList[j]  
            --     _this.sortList[j] = _this.sortList[j+1]
            --     _this.sortList[j+1] = tmp
            -- end

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
    -- for i,v in ipairs(_this.sortList) do
        
    --     print(string.format( "wei = %d , tarLen = %d , tarIndex = %d , index = %d ",v.weight , v.tarLen , v.tarIndex , v.index ))
    -- end
end

--每个单独产生的G位置都存在对应整体map的寻路地址
--G位置产生水滴
--G位置产生的水滴按自己本身的寻路地址散布


function _this:Refresh()

    --clear
    -- for i,v in ipairs(L_NodeController.nodeList) do
        
    --     if v.status == L_TypeStatusNode.IDLE or v.status == L_TypeStatusNode.NONE then
            
    --         L_Map:SetMergeData(v.index , 0)
    --     else
    --         L_Map:SetMergeData(v.index , 2) --2 是临时值
    --     end
    -- end

    for i,v in ipairs(self.sortList) do
        
        if v.status == L_TypeStatusNode.IDLE then
        elseif v.status == L_TypeStatusNode.NONE then 

            if v.tarIndex == 1 then -- 1 为起点  直接产生
                -- print("creat : " , v.index)
                self:SetNodeStatus(v.index , L_TypeStatusNode.DROP)
            else
                --交换
                L_Map:RefreshMergeData()
                -- print("Find :  ----------- " , 1 , v.index)
                local paths = L_Map:FindPath(1 , v.index)
                if paths ~= nil then
                    
                    if #paths >= 2 then 

                        local isExecute = true
                        for i = 2, #paths - 1 do --原点不判断
                            
                            local tranfIndex = paths[i] + 1
                            -- print(tranfIndex , self.nodeList[tranfIndex].status)
                            if self.nodeList[tranfIndex].status ~= L_TypeStatusNode.IDLE then
                                
                                isExecute = false
                                break
                            end
                        end
                        
                        -- print(isExecute)
                        if isExecute then
                            for i = #paths, 2 , -1 do
                                
                                local tranfIndex = paths[i] + 1
                                -- print("tranf : " , tranfIndex)
                                self:SetNodeStatus(tranfIndex , L_TypeStatusNode.DROP)
                            end
                        end
                    else
                        print("Error paths len = " , #paths , dex)
                    end
                else
                    -- print("Error paths = nil ")
                end
            end
        end
    end

    for i,v in ipairs(self.sortList) do
        
        if v.status == L_TypeStatusNode.DROP then
            
            self:SetNodeStatus(v.index , L_TypeStatusNode.IDLE)
        end
        v:UpdateStatus()
    end
end

function _this:SetNodeStatus(index , status)
    
    if L_Map.mergeData[index] == nil then
        
        print("Error SetNodeStatus mergeData index = %d" , index)
        return
    end

    if self.nodeList[index] == nil then
        
        print("Error SetNodeStatus nodeList index = %d" , index)
        return
    end
    self.nodeList[index].status = status
    if self.nodeList[index].status == L_TypeStatusNode.NONE or self.nodeList[index].status == L_TypeStatusNode.IDLE then
        L_Map:SetMergeData(index , 0)
    else
        L_Map:SetMergeData(index , 1)
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

