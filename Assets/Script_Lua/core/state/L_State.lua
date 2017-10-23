L_State = {}
setmetatable(L_State, {__index = _G})
local _this = L_State

_this.m_eId = 0
_this.m_eNtity = nil
_this.m_nStatus = 0
_this.m_pOwner = nil
_this.m_nTimer = 0
_this.m_nTick = 0
_this.m_nTimerMax = 1

function _this.New(o , entity)--entity
    --m_eNtity = entity
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    o.m_eNtity = entity
    return o
end

function _this:Enter()
    --print("--- L_State:Enter() ---"..self.m_nTimerMax)
end

function _this:Execute(nTime)
    --print("--- L_State:Execute() ---"..nTime)
end

function _this:FixedExcute(nTime)
    --print("--- L_State:FixedExcute() ---"..nTime)
end

function _this:LateExcute(nTime)
    --print("--- L_State:LateExcute() ---"..nTime)
end

function _this:Exit()
   --print("--- L_State:Exit() ---")
end

function _this:Effect(obj)
   --print("--- L_State:Effect() ---")
end

function _this:GetEntity()
    return m_eNtity
end