-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
local GameObject = UnityEngine.GameObject

L_UpdateView = {}
setmetatable(L_UpdateView, {__index = _G})
local _this = L_UpdateView

_this.label = nil
function _this:Init()

    _this.label = GameObject.Find("Text"):GetComponent("Text")
    --addEvent
end

function _this:UpdateLabel(str)
    
    _this.label.text = str
end