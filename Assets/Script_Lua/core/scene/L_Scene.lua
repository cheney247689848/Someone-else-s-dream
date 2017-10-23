-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require "core/state/L_State"
require "core/state/L_StateMachine"

L_Scene = {}
setmetatable(L_Scene, {__index = _G})
local _this = L_Scene

_this.isInit = false
_this.name = "No Name"
_this.view = nil
_this.machine = nil
_this.stateNone = nil
_this.stateLoad = nil
_this.stateGuide = nil
_this.stateExit = nil
_this.stateLayout = nil
_this.stateProcess = nil
_this.bundle = nil

function _this:Init(metaDataScene)
  print("you need to overwrite function Init")
end

function _this:ConfState()
  print("you need to overwrite function ConfState")
end

function _this:ChangeToState(state)

    self.machine:ChangeState(state)
end

function _this:GetCurrentStatus()
    
    if self.machine ~= nil then
        local state = self.machine:GetCurrentState()
        if state ~= nil then
            return state.m_nStatus
        end
    end
    return -1
end

function _this:Update()
    print("you need to overwrite function Update")
end

function _this:FixedUpdate()
    print("you need to overwrite function FixedUpdate")
end

function _this:OnDestory()
    print("--- L_Scene:OnDestory() ---")
end

function _this:RemoveUpdateEvent()
    print("--- UpdateBeat . Remove [Update] ---")
    UpdateBeat:Remove(self.Update, self)
end

function _this:AddUpdateEvent()
    print("--- UpdateBeat . Add [Update] ---")
    UpdateBeat:Add(self.Update , self)
end

function _this:RemoveFixedUpdateEvent()
    print("--- UpdateBeat . Remove [FixedUpdate] ---")
    FixedUpdateBeat:Remove(self.FixedUpdate, self)
end

function _this:AddFixedUpdateEvent()
    print("--- UpdateBeat . Add [FixedUpdate] ---")
    FixedUpdateBeat:Add(self.FixedUpdate , self)
end


local function Search(k , plist)

    for i = 1, #plist do
        local v = plist[i][k]
        if v then return v end
    end
end

-- function _this.New(...)
--     local c = {}
--     local parents = {}
--     setmetatable(c , {__index = function(t , k)
--     return Search(k , parents)
--     end})
--     c.__index = c
--     return c
-- end

function _this.New(o)
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    return o;
end

-- function _this:LoadAssectInstantiate(args , gType)
--     if self.bundle ~= nil then
--       local prefab = self.bundle:LoadAsset(args , gType)
--       return GameObject.Instantiate(prefab)
--     end
--     print("Error No bundle")
-- end

-- function _this:LoadGameObjectInstantiate(args , parent)
--     if self.bundle ~= nil then
--       local prefab = self.bundle:LoadAsset(args , typeof(GameObject))
--       local assect = GameObject.Instantiate(prefab)
--       assect.transform.parent = parent.transform
--       assect.transform.localPosition = Vector3.zero
--       assect.transform.localScale = Vector3.one
--       return assect
--     end
--     print("Error No bundle")
-- end