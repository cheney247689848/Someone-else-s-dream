-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-- 场景属性和预加载配置
-------------------------------------------------------------------

L_ScenePreloading = {}
setmetatable(L_ScenePreloading, {__index = _G})
local _this = L_ScenePreloading

_this.data = {

    {"Login" , "a|b|c|d|d|f|g" , name = "Login"},
    {"Major" , "a|b|c|d|d|f|g" , name = "Major"},
    {"Game" , "a|b|c|d|d|f|g" , name = "Game"}
}

function _this:GetPreLoadingData(sceneName)
    
    for i,v in ipairs(self.data) do

        if v.name == sceneName then
            return v
        end
    end
    return nil
end