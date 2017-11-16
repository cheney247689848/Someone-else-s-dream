-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require "observer/L_MessageObserver"
require "type/L_TypeMesAiBot"
require "core/state/L_State"
require "core/state/L_StateMachine"


L_AiBot = {}
setmetatable(L_AiBot, {__index = _G})
local _this = L_AiBot

_this.mesObserver = nil 
_this.botLayouts = nil
_this.botLayoutIndex = nil
_this.stateIndex = nil
_this.machine = nil
_this.isActive = nil

function _this.New(o)
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    o:Init()
    return o;
end

function _this:Init()
    
    self.machine = L_StateMachine.New()
    self.botLayouts = {}
    self.botLayoutIndex = -1
    self.stateIndex = -1
    self.isActive = false
    self.mesObserver = L_MessageObserver.New()
    self:Config()
end

function _this:Config()
    
    print("you need to overwrite function Config")
end

--==============================--
--desc:  注册事件 
--事件本身可以分开处理回合制和即时战略
--time:2017-11-14 03:57:26
--@return 
--==============================--
function _this:RegisterEvent()
    
    local event_stateEnd = function ()
        
        self:SetNextState()
    end
    self.mesObserver[L_TypeMesAiBot.MES_STATE_END] = self.mesObserver[L_TypeMesAiBot.MES_STATE_END] + event_stateEnd
end


--==============================--
--desc: 设置进入下一个状态
--time:2017-11-14 03:59:11
--@return 
--==============================--
function _this:SetNextState()
    
    if self.stateIndex <= self.botLayouts[self.botLayoutIndex]:GetLength()  then
        
        local state = self.botLayouts[self.botLayoutIndex]:GetState(self.stateIndex)
        if state == nil then
            
            print("Error ChangeLayout state = nil")
            return
        end
        self.machine:ChangeState(state)
        self.stateIndex = self.stateIndex + 1
    end
end

--==============================--
--desc:休眠开关
--time:2017-11-14 03:59:26
--@active:
--@return 
--==============================--
function _this:SetActive(active)
    
    self.isActive = active
end

function _this:Update()
    
    if not self.isActive then
        return false
    end

    if self.machine ~= nil then

        self.machine:Update(UnityEngine.Time.deltaTime)
    end
    return true
end

--==============================--
--desc:
--time:2017-11-15 02:45:06
--@layout:
--@return 
--==============================--
function _this:AddBotLayout(layout)
    
    table.insert( self.botLayouts, layout )
end

function _this:SubBotLayout(layout)
    
    for i,v in ipairs(self.botLayouts) do
        if layout == v then
            table.remove( self.layout, i )
            return
        end
    end
end

--==============================--
--desc:
--time:2017-11-15 02:45:10
--@return 
--==============================--
function _this:CurrentBotLayout()
    
    return self.botLayouts[self.botLayoutIndex]
end

--==============================--
--desc:
--time:2017-11-15 02:45:13
--@index:
--@return 
--==============================--
function _this:ChangeBotLayout(index)
    
    if self.botLayouts[index] == nil then
        
        print(string.format( "Error ChangeLayout index = %d", index ))
        return
    end
    self.botLayoutIndex = index
    local layout = self.botLayouts[self.botLayoutIndex]
    if layout == nil then
        
        print("Error ChangeLayout layout = nil")
        return
    end

    if layout.stateGlobal ~= nil then
        
        self.machine:SetGlobalState(layout.stateGlobal)
    end

    self.stateIndex = 1 --默认第一个状态
    local state = layout:GetState(self.stateIndex)
    if state == nil then
        
        print("Error ChangeLayout state = nil")
        return
    end
    -- self.machine:SetCurrentState(state)
end





