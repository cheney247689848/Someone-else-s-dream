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
        node.position = L_Map:GetPosition(i)
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
    -- print("sortList len = " , #_this.sortList)

    --sort
    local tmp = nil
    for i = 1 , #self.sortList do  
        for j = 1 , #self.sortList - i do 
            
            if self.sortList[j].tarLen > 2 and self.sortList[j+1].tarLen > 2 then
                
                if self.sortList[j].tarLen > self.sortList[j+1].tarLen then
                    
                    tmp = _this.sortList[j]  
                    _this.sortList[j] = _this.sortList[j+1]
                    _this.sortList[j+1] = tmp
                end
            elseif self.sortList[j].tarLen <=2 and self.sortList[j+1].tarLen > 2 then

                if self.sortList[j].tarLen < self.sortList[j+1].tarLen then
                    
                    tmp = _this.sortList[j]  
                    _this.sortList[j] = _this.sortList[j+1]
                    _this.sortList[j+1] = tmp
                end
            end
        end  
    end

    --debug
    -- for i,v in ipairs(_this.sortList) do
        
    --     print(string.format( "wei = %d , tarLen = %d , tarIndex = %d , index = %d ",v.weight , v.tarLen , v.tarIndex , v.index ))
    -- end
end

function _this:Refresh()

    -- print("Refresh-------------------------------------------------")
    local isCreat,isTranf = false
    for i,v in ipairs(self.sortList) do
        
        if v.status == L_TypeStatusNode.IDLE then
        elseif v.status == L_TypeStatusNode.TRANF then

            if v.tarLen == 2 then -- 1 为起点  直接产生
                -- print("creat : " , v.index)
                self:SetNodeStatus(v.index , L_TypeStatusNode.CREAT)
                isCreat = true
            end
        elseif v.status == L_TypeStatusNode.NONE then 

            if v.index == 1 then
                --原点
            elseif v.tarLen == 2 then -- 1 为起点  直接产生
                -- print("creat : " , v.index)
                self:SetNodeStatus(v.index , L_TypeStatusNode.CREAT)
                isCreat = true
            else
                --交换
                L_Map:RefreshMergeData()
                -- print("Find :  ----------- " , 1 , v.index)
                local paths = L_Map:FindPath(1 , v.index)
                if paths ~= nil then
                    -- print(string.format( "find : 1 to %d  len = %d ------------", v.index, #paths))
                    if #paths >= 3 then 

                        local isExecute = true
                        for i = 2, #paths - 1 do --原点不判断
                            
                            local tranfIndex = paths[i] + 1
                            -- print(string.format( "index = %d , status = %d", tranfIndex , self.nodeList[tranfIndex].status))
                            if self.nodeList[tranfIndex].status ~= L_TypeStatusNode.IDLE then
                                
                                isExecute = false
                                break
                            end
                        end
                        -- print(isExecute == true and "continue" or "break")
                        if isExecute then

                            --设置最近点
                            -- print("设置最近点 : " , paths[2] + 1)
                            self:SetNodeStatus(paths[2] + 1 , L_TypeStatusNode.DROP)
                            for i = #paths, 3 , -1 do
                                
                                local preIndex = paths[i - 1] + 1
                                local tranfIndex = paths[i] + 1
                                -- print(string.format( "preIndex = %d , tranfIndex = %d ", preIndex , tranfIndex))

                                self.nodeList[tranfIndex].uiObject = self.nodeList[preIndex].uiObject
                                self:SetNodeStatus(tranfIndex , L_TypeStatusNode.DROP)
                                
                                self.nodeList[preIndex].uiObject = nil
                                self:SetNodeStatus(preIndex , L_TypeStatusNode.TRANF)
                                isTranf = true
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
    return isCreat or isTranf
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

