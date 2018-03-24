--require "update/L_UpdateStrategy"
--require "core/L_ByteStream"
local GameObject = UnityEngine.GameObject
-- require "example/L_ExpTextScene"
require "L_GameInputMes"
require "bundle/L_Bundle"
require "proxyScene/L_ProxyScene"
require "scene/L_SceneLogin"
function Launch()

    print(" --- Launch --- ")
    --配置加载信息
    L_Bundle.localPath = localPath
    L_Bundle.persPath = persPath
    L_Bundle.platform = platform
    -- print(L_Bundle.streamPath)
    L_Bundle:InitMainifest(platform)

    --正式
    -- L_ProxyScene:ChangeScene(L_SceneLogin)

    --测试
    -- require "example/L_ExpLandlordsScene"
    -- L_ExpLandlordsScene:Init()

    -- require "example/L_ExpAiBotScene"
    -- L_ExpAiBotScene:Init()

    -- require "example/L_ExpSceneObserver"

    -- L_NetServer:Init(L_ProxyScene.anchor)
    -- L_ProxyScene.ChangeView(L_SceneLogin)

    -- L_ExpTextScene:Init()

    -- require("example/L_ExpBundleScene")
    -- L_ExpBundleScene:Init()

end
