require "core/state/L_Scene"
require "core/state/L_StateMachine"
require "core/scene/L_SceneState"

L_SceneTemplate = {}
L_SceneTemplate = L_Scene:New({})
local _this = L_SceneTemplate

_this.stateNone = nil
_this.stateLayout = nil
_this.stateProcess = nil
_this.stateGlobal = nil

function _this:Init()
    print("--- Init ---")
end

function _EVN:ConfState()
    --state config
    _EVN.view = SZGameSceneView --conn view class
    _EVN.stateNone = SZGameSceneState.stateNone
    _EVN.stateReady = SZGameSceneState.stateReady
    _EVN.stateLayout = SZGameSceneState.stateLayout
    _EVN.stateProcess = SZGameSceneState.stateProcess
    _EVN.stateGlobal = SZGameSceneGlobalState.stateGlobal
    --temp
    _EVN.stateNone.m_eNtity = _EVN
    _EVN.stateReady.m_eNtity = _EVN
    _EVN.stateLayout.m_eNtity = _EVN
    _EVN.stateProcess.m_eNtity = _EVN
    _EVN.stateGlobal.m_eNtity = _EVN

    _EVN.machine = L_StateMachine:New()
    _EVN.machine:SetGlobalState(_EVN.stateGlobal)
    _EVN.machine:SetCurrentState(_EVN.stateNone)
end

function _EVN:Update()
    
    if _EVN.machine ~= nil then
        _EVN.machine:Update(UnityEngine.Time.deltaTime)
    end
end

function _EVN:FixedUpdate()


end

function _EVN:OnDestory()

     print("--- OnDestory ---")
end