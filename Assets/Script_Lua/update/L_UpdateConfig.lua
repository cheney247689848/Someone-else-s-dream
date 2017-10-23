-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
L_UpdateConfig = {}
setmetatable(L_UpdateConfig, {__index = _G})
local _this = L_UpdateConfig

--客户端版本信息
_this.version = "1.0.0"    --客户端脚步版本信息
_this.sourceVersion = 4    --资源版本号
_this.cdnUrl = "http://www.testqipai.com:81/suzhou"  --资源地址  Android/Version
_this.isHotUpdate = false --是否进行资源热更