local GameObject = UnityEngine.GameObject
local Text = UnityEngine.UI.Text
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode
require("tool/L_TextSprite")

L_ExpTextScene = {}
setmetatable(L_ExpTextScene, {__index = _G})
local _this = L_ExpTextScene


function _this:Init()
    
    local uText = GameObject.Find("Text"):GetComponent("Text")
    local uRText = GameObject.Find("TextFormat"):GetComponent("Text")
    L_TextSprite:Init(uRText)
    L_TextSprite:ReBuild(uText.text)
    --UpdateBeat:Add(self.Update , self)
end


-- function _this:Update()

--     if Input.GetKeyDown(KeyCode.Alpha1) then


--     elseif Input.GetKeyDown(KeyCode.Alpha2) then

--     end

--     if Input.GetKeyDown(KeyCode.Space) then
        
--         self:ReBuild()
--     end
-- end

