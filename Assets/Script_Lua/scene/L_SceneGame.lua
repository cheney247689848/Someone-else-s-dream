local Camera = UnityEngine.Camera

require "core/scene/L_Scene"
require "core/state/L_StateMachine"
require "other/L_ScenePreloading"   
require "scene/L_StatePublic"
require "scene/L_SceneGameView"
require "scene/L_SceneGameState"
require "type/L_TypeSceneState"
--场景类

local pData = L_ScenePreloading:GetPreLoadingData("Game")
L_SceneGame = L_Scene.New( pData ~= nil and pData or {})
local _this = L_SceneGame

_this.stateLayout = nil
_this.stateProcess = nil
_this.stateExit = nil
_this.stateGlobal = nil


function _this:Init()
    --房间初始化
    print("romm init - " , _this.name)
end

function _this:ConfState()
    --state config
    _this.view = L_SceneGameView --conn view class
    _this.stateNone = L_StatePublic.stateNone({m_nStatus = L_TypeSceneState.None} , _this)
    _this.stateLoad = L_StatePublic.stateLoad({m_nStatus = L_TypeSceneState.Load} , _this)
    _this.stateExit = L_StatePublic.stateExit({m_nStatus = L_TypeSceneState.Exit} , _this)
    _this.stateLayout = L_SceneGameState.stateLayout({m_nStatus = L_TypeSceneState.Layout} , _this)
    _this.stateProcess = L_SceneGameState.stateProcess({m_nStatus = L_TypeSceneState.Process} , _this)
    _this.stateGlobal = L_SceneGameState.stateGlobal({m_nStatus = L_TypeSceneState.Global} , _this)

    --other
    _this.stateMapLayout = L_SceneGameState.stateMapLayout({m_nStatus = L_TypeSceneState.Exit} , _this)    


    _this.machine = L_StateMachine.New()
    _this.machine:SetGlobalState(_this.stateGlobal)
    _this.machine:SetCurrentState(_this.stateNone)
end

function _this:Update()
    --print("update  ".. UnityEngine.Time.deltaTime)
    if _this.machine ~= nil then
        _this.machine:Update(UnityEngine.Time.deltaTime)
    end
end

function _this:FixedUpdate()
    --print("FixedUpdate  "..UnityEngine.Time.deltaTime)
end

function _this:UpdateInput(mousePosition)
    
    local vPos = self.view.blockNode.transform:InverseTransformPoint(
        Camera.main:ScreenToWorldPoint(mousePosition));
    vPos.x = vPos.x + L_Map.imgRect.x / 2
    vPos.y = -(vPos.y - L_Map.imgRect.y / 2)
    -- if L_Map.sceneRect:Contains(vPos) then
        
    --     print(true , vPos.x , vPos.y)
    --     return L_Map:GetIndexByPosition(vPos)
    -- else
    --     print(false , vPos.x , vPos.y)
    --     return -1
    -- end
    return L_Map:GetIndexByPosition(vPos)
end

function _this:OnDestory()

     print(_this.name .. "--- OnDestory ---")
end