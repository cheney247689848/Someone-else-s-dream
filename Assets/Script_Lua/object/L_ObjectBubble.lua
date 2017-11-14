local GameObject = UnityEngine.GameObject
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

require("core/bot/L_AiBot")
require("core/bot/L_AiBotLayout")

L_ObjectBubble = L_AiBot.New({name = "object - bubble"})
local _this = L_ObjectBubble

function _this.New(o)
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    o:Init()
    return o;
end

function _this:Config()

    self.stateIdle = self.GetStateIdle({m_nStatus = 0} , self)
    self.stateWalk = self.GetStateWalk({m_nStatus = 0} , self)
    self.stateAttack = self.GetStateAttack({m_nStatus = 0} , self)
    self.stateFreeze = self.GetStateFreeze({m_nStatus = 0} , self)
    
    local layout0 = L_AiBotLayout.New()
    layout0:AddState(self.stateWalk)
    layout0:AddState(self.stateAttack)

    local layout1= L_AiBotLayout.New()
    layout1:AddState(self.stateWalk)
    layout1:AddState(self.stateAttack)
    layout1:AddState(self.stateFreeze)
    layout1:AddState(self.stateAttack)

    self:AddBotLayout(layout0)
    self:AddBotLayout(layout1)
    self:ChangeBotLayout(1)
end

--==============================--
--desc:重写事件方法
--time:2017-11-14 05:53:56
--@return 
--==============================--
function _this:RegisterEvent()
    
    local event_stateEnd = function ()
        
        --self:SetNextState()
        self:SetActive(false) -- 回合休眠
    end
    self.mesObserver[L_TypeMesAiBot.MES_STATE_END] = self.mesObserver[L_TypeMesAiBot.MES_STATE_END] + event_stateEnd
end

_this.GetStateIdle = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Idle状态------")
        self.m_bEnd = false
    end

    function state:Execute(nTime)
        
        --do thing
        self.m_bEnd = true
        self.m_eNtity.mesObserver:PostEvent(L_TypeMesAiBot.MES_STATE_END)
    end

    function state:Exit()

        print("------退出Idle状态------")
    end
    return state
end

_this.GetStateWalk = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Walk状态------")
        self.m_bEnd = false
    end

    function state:Execute(nTime)
        
        --do thing
        if 0 == self.m_nTick then

            self.m_bEnd = true
            self.m_eNtity.mesObserver:PostEvent(L_TypeMesAiBot.MES_STATE_END)
        end
    end

    function state:Exit()

        print("------退出Walk状态------")
    end
    return state
end

_this.GetStateAttack = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Attack状态------")
        self.m_bEnd = false
    end

    function state:Execute(nTime)
        
        --do thing
        self.m_bEnd = true
        self.m_eNtity.mesObserver:PostEvent(L_TypeMesAiBot.MES_STATE_END)
    end

    function state:Exit()

        print("------退出Attack状态------")
    end
    return state
end

_this.GetStateFreeze = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Freeze状态------")
        self.m_bEnd = false
    end

    function state:Execute(nTime)
        
        --do thing
        self.m_bEnd = true
        self.m_eNtity.mesObserver:PostEvent(L_TypeMesAiBot.MES_STATE_END)
    end

    function state:Exit()

        print("------退出Freeze状态------")
    end
    return state
end