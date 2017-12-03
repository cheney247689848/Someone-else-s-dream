-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require "object/L_ObjectBubble"
require "node/L_NodeController"

L_ObjectController = {}
setmetatable(L_ObjectController, {__index = _G})
local _this = L_ObjectController

_this.objcetList = {}
function _this:CreatObject(id , index)
    
    local object = L_ObjectBubble.New()
    if not self:SetIndex(object , index) then
        
        print(string.format("Error CreatObject SetIndex = %d" , index))
        return
    end
    object:Instantiate()
    table.insert( self.objcetList, object)
    return object
end

function _this:SetIndex(obj , index)
    
    local node = L_NodeController:GetNode(index)
    if node == nil then
        
        print(string.format("Error SetIndex node = nil index = %d" , index))
        return false
    end

    if node.status ~= L_TypeStatusNode.IDLE then
        
        print("Error SetIndex node status ~= IDLE")
        return false
    end

    if obj.index ~= -1 then
        --reset
        L_NodeController:SetNodeStatus(obj.index , L_TypeStatusNode.NONE)
        print("------------------------------------------------" , obj.index)
    end
    obj.index = index
    L_NodeController:SetNodeStatus(index , L_TypeStatusNode.MONSTER)
    --ui
    L_NodeController:AddInPool(node.uiObject)
    node.uiObject = nil
    return true
end

function _this:SetNextState()

    for i,v in ipairs(self.objcetList) do
        v:SetActive(true)
        v:SetNextState()
    end
end

function _this:Clear()

    --destroy gameobject
    --reset table
end

function _this:Update()
    
    local isUpdate = false
    for i,v in ipairs(self.objcetList) do
        isUpdate = v:Update()
    end
    return isUpdate
end

