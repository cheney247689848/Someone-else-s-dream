local GameObject = UnityEngine.GameObject
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

require("core/bot/L_AiBot")
require("core/bot/L_AiBotLayout")

L_ExpAiBotScene = {}
setmetatable(L_ExpAiBotScene, {__index = _G})
local _this = L_ExpAiBotScene

_this.ai = nil

function _this:Init()

    self.ai = L_AiBot.New({name = "Ai-Tester"})

    self.stateIdle = self.GetStateIdle({m_nStatus = 0} , self.ai)
    self.stateWalk = self.GetStateIdle({m_nStatus = 0} , self.ai)
    self.stateAttack = self.GetStateIdle({m_nStatus = 0} , self.ai)
    self.stateFreeze = self.GetStateIdle({m_nStatus = 0} , self.ai)
    
    local layout0 = L_AiBotLayout.New()
    layout0:AddState(self.stateWalk)
    layout0:AddState(self.stateAttack)

    local layout1= L_AiBotLayout.New()
    layout1:AddState(self.stateWalk)
    layout1:AddState(self.stateAttack)
    layout1:AddState(self.stateFreeze)
    layout1:AddState(self.stateAttack)

    
    self.ai:AddBotLayout(layout0)
    self.ai:AddBotLayout(layout1)

    self.ai:ChangeBotLayout(1)

    UpdateBeat:Add(self.Update , self)
end

function _this:Update()

    if Input.GetKeyDown(KeyCode.Alpha1) then

        self.ai:ChangeBotLayout(1)
    elseif Input.GetKeyDown(KeyCode.Alpha2) then

        self.ai:ChangeBotLayout(2)
    end

    self.ai:Update()
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
    end

    function state:Exit()

        print("------退出Freeze状态------")
    end
    return state
end