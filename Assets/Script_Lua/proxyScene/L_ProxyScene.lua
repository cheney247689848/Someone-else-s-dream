-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require "core/scene/L_Scene"
local Resources = UnityEngine.Resources
local GameObject = UnityEngine.GameObject

L_ProxyScene = {}
setmetatable(L_ProxyScene, {__index = _G})
local _this = L_ProxyScene

--当前场景
_this.currScene = nil
_this.nextScene = nil
_this.isEnable = true
_this.anchor = nil --GameObject.Find("Anchor")
--==============================--
--desc:  转换场景
--time:2017-10-11 02:05:05
--@scene:
--@return 
--==============================--
function _this:ChangeScene(scene)

    if type(scene) ~= "table" or getmetatable(scene) ~= L_Scene then

        print("Error type scene")
        return
    end

    if _this.currScene ~= nil and _this.currScene == scene then
        
        print("Error type scene is same")
        return
    end

    if self.isEnable then

        self.isEnable = false
        coroutine.start(self.IEChangeScene , scene)
    else
        print(string.format( "Error ChangeScene isEnable is %s ", tostring(isEnable)))
    end    
end

--==============================--
--desc:场景转换进程
--time:2017-10-11 02:54:54
--@return 
--==============================--
function _this.IEChangeScene(scene)
    --开启等待界面
    _this.nextScene = scene
    if not _this.nextScene.isInit then

        _this.nextScene:Init()  --初始化
        _this.nextScene:ConfState()  --实例化状态
        _this.nextScene:AddUpdateEvent()
    end
    _this.nextScene:ChangeToState(_this.nextScene.stateLoad) --转入加载
    while _this.nextScene:GetCurrentStatus() == L_TypeSceneState.Load do
        --等待加载
        coroutine.wait(0.02)
    end

    if _this.currScene ~= nil then
        
        _this.currScene:ChangeToState(_this.currScene.stateExit)
        while _this.currScene:GetCurrentStatus() == L_TypeSceneState.Exit do
            --等待场景回收
            coroutine.wait(0.02)
        end
        _this.currScene:RemoveUpdateEvent()
        _this.currScene:RemoveFixedUpdateEvent()
        _this.currScene:OnDestory()
        _this.currScene = nil
        Resources.UnloadUnusedAssets()
    end
    _this.currScene = _this.nextScene
    _this.nextScene = nil
    print(" ::: viewChange -> ".._this.currScene.name)
    --关闭等待界面
    _this.currScene:ChangeToState(_this.currScene.stateLayout) --转入布局状态
    coroutine.stop(_this.IEChangeScene)
    _this.isEnable = true
end

function _this:GetCurrentScene()

    return _this.currScene
end