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
_this.color = nil
_this.status = nil
_this.position = nil

function _this:Init()
    
    self.index = -1
    self.tarIndex = -1
    self.color = -1
    self.status = L_TypeStatusNode.NONE
end

function _this:SetIndex(dex)
    
    self.index = dex
end

function _this:SetTarIndex(dex)
    
    self.tarIndex = dex
end

function _this:SetColor(col)
    
    self.color = col
end

function _this:UpdatePosition()
    
    
end

function _this.New(o)
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    return o;
end

