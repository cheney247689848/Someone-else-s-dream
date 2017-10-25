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

    {name = "Login" , loadBundles = "slogin_texture_noticebg|slogin_prefab_prafabimage|slogin_prefab_cube"},
    {name = "Major" , loadBundles = ""},
    {name = "Game" , loadBundles = "sgame_packtextures|sgame_prefab_cube|sgame_prefab_block|sgame_prefab_point"}
}

function _this:GetPreLoadingData(sceneName)
    
    for i,v in ipairs(self.data) do

        if v.name == sceneName then
            return v
        end
    end
    return nil
end