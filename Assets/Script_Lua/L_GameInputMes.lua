-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-- 用于调试
-------------------------------------------------------------------


local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

require "proxyScene/L_ProxyScene"

L_GameInputMes = {}
setmetatable(L_GameInputMes, {__index = _G})
local _this = L_GameInputMes

function _this:Update()
    
    -- if Input.GetKeyDown(KeyCode.Alpha1) then

    --     require "scene/L_SceneLogin"
    --     L_ProxyScene:ChangeScene(L_SceneLogin)

    -- elseif Input.GetKeyDown(KeyCode.Alpha2) then

    --     require "scene/L_SceneMajor"
    --     L_ProxyScene:ChangeScene(L_SceneMajor)
    -- end
end
UpdateBeat:Add(_this.Update , _this)