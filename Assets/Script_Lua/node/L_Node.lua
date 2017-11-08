-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require "type/L_TypeNode"

L_Node = {}
setmetatable(L_Node, {__index = _G})
local _this = L_Node

--base
_this.index = nil
_this.tarIndex = nil
_this.tarLen = nil
_this.weight = nil
_this.isTranf = nil
_this.status = nil
_this.position = nil

_this.uiObject = nil
_this.uiNode = nil
_this.meta = nil

function _this:Init()
    
    self.index = -1
    self.tarIndex = -1
    self.weight = -1
    self.tarLen = -1
    self.isTranf = false
    self.meta = {color = -1}
    self.status = L_TypeStatusNode.NONE
end

function _this:SetIndex(dex)
    
    self.index = dex
end

function _this:SetTarIndex(dex , len)
    
    self.tarIndex = dex
    self.tarLen = len
end

function _this:SetColor(col)
    
    self.meta.color = col
    if self.uiObject ~= nil then

        local image = self.uiObject:GetComponent("Image")
        image.sprite = L_NodeController:GetGemImg(col)
        image.transform.sizeDelta = Vector2(86 , 86)
    end
end

function _this:UpdatePosition()
    
    
end

function _this:UpdateStatus()
    
    -- print(self.index , self.status)
    if self.status == L_TypeStatusNode.IDLE then
    
        if self.uiObject == nil then
            
            self.uiObject = L_NodeController:CreatNodeUI()
            self.uiObject.transform.localPosition = node.position --L_Map:GetPosition(self.index)
        else
            self.uiObject:SetActive(true)
        end
        self.weight = -1
    else
        
        if self.uiObject ~= nil then

            self.uiObject:SetActive(false)
        end
    end

    self.isTranf = false
end

function _this:UpdateUI()

    if self.uiNode == nil then
        return
    end

    local tIndex = self.uiNode.transform:Find("txt_index"):GetComponent("Text")
    local tLen = self.uiNode.transform:Find("txt_len"):GetComponent("Text")
    local tarIndex = self.uiNode.transform:Find("txt_tarIndex"):GetComponent("Text")

    tIndex.text = string.format( "%d(l = %d)", self.index , self.tarLen)
    -- tLen.text = tostring(self.tarLen)
    tarIndex.text = string.format( "%d_%d:%d", self.status , L_Map.mergeData[self.index] , self.meta.color)
end

function _this.New(o)
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    return o;
end

