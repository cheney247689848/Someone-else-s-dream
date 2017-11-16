-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require "object/L_ObjectBubble"

L_ObjectController = {}
setmetatable(L_ObjectController, {__index = _G})
local _this = L_ObjectController

_this.objcetList = {}
function _this:CreatObject(id)
    
    local object = L_ObjectBubble.New()
    table.insert( self.objcetList, object )
    return object
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

