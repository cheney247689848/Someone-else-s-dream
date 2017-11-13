require "core/state/L_State"

L_StateMachine = {}
setmetatable(L_StateMachine, {__index = _G})
local _this = L_StateMachine

_this.m_pOwner = nil
_this.m_pCurrentState = nil
_this.m_pPreviousState = nil
_this.m_pGlobalState = nil

function _this:Update(nTimer)
    if self.m_pCurrentState ~= nil then
        self.m_pCurrentState:Execute(nTimer)
    end
    if self.m_pGlobalState ~= nil then
        self.m_pGlobalState:Execute(nTimer)
    end
end

function _this:FixedUpdate(nTimer)
    if self.m_pCurrentState ~= nil then
        self.m_pCurrentState:FixedExcute(nTimer)
    end
    if self.m_pGlobalState ~= nil then
        self.m_pGlobalState:FixedExcute(nTimer)
    end
end

function _this:ChangeState(newState)
	self.m_pPreviousState = self.m_pCurrentState
	self.m_pCurrentState = newState
	self.m_pCurrentState.m_pOwner = self
	self.m_pPreviousState:Exit()
	self.m_pCurrentState:Enter()
end

function _this:SetCurrentState(newState)
    if self.m_pCurrentState ~= nil then
        self.m_pCurrentState:Exit()
    end
    self.m_pCurrentState = newState;
    self.m_pCurrentState.m_pOwner = self
    self.m_pCurrentState:Enter()
end

function _this:SetGlobalState(newState)

    if self.m_pGlobalState ~= nil then
        self.m_pGlobalState:Exit()
    end
    self.m_pGlobalState = newState;
    self.m_pGlobalState.m_pOwner = self;
    self.m_pGlobalState:Enter ()
end

function _this:GetCurrentState()
    return self.m_pCurrentState
end

function _this:GetPreviousState()
    return self.m_pPreviousState
end

function _this:GetGlobalState()
    return self.m_pGlobalState
end

function _this.New()
    o = {}
    setmetatable(o , _this)
    _this.__index = _this
    return o;
end

