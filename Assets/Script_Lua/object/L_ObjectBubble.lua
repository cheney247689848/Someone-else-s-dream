local GameObject = UnityEngine.GameObject
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

require("core/bot/L_AiBot")
require("core/bot/L_AiBotLayout")

L_ObjectBubble = L_AiBot.New({
    name = "object - bubble" , 
    index = -1,
    objImg = nil,
    isClose = false,
})
local _this = L_ObjectBubble

function _this.New(o)
    o = o or {}
    setmetatable(o , _this)
    _this.__index = _this
    o:Init()
    return o;
end

function _this:Config()
 
    self.stateNone = self.GetStateNone({m_nStatus = L_TypeObjectState.NONE} , self)
    self.stateIdle = self.GetStateIdle({m_nStatus = L_TypeObjectState.IDLE} , self)
    self.stateWalk = self.GetStateWalk({m_nStatus = L_TypeObjectState.WALK} , self)
    self.stateAttack = self.GetStateAttack({m_nStatus = L_TypeObjectState.ATTACK} , self)
    self.stateFreeze = self.GetStateFreeze({m_nStatus = L_TypeObjectState.FREEZE} , self)
    self.stateAnger = self.GetStateAnger({m_nStatus = L_TypeObjectState.ANGER} , self)
    
    
    local layout0 = L_AiBotLayout.New()
    layout0:SetStateGlobal()
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

    self.machine:SetCurrentState(self.stateNone)
end

function _this:Instantiate()
    
    local bundle = L_Bundle:GetBundle("sgame_prefab_monster")
    local bPrefab = L_Unit:LoadPrefab("monster" , bundle)
    self.objImg = L_Unit:Instantiate(bPrefab , GameObject.Find("BlockNode"))
    self.objImg.transform.localPosition =  L_Map:GetPosition(self.index)
end

--==============================--
--desc:重写事件方法
--time:2017-11-14 05:53:56
--@return 
--==============================--
function _this:RegisterEvent()
    
    local event_stateEnd = function ()

        self:SetActive(false) -- 回合休眠
    end
    self.mesObserver[L_TypeMesAiBot.MES_STATE_END] = self.mesObserver[L_TypeMesAiBot.MES_STATE_END] + event_stateEnd
end

function _this:SetPreState()

    if self:GetStatus() == L_TypeObjectState.WALK then
        
        if not self.isClose then
            --set state  --
            return self.stateIndex
        end
    elseif self:GetStatus() == L_TypeObjectState.ANGER then
        --特殊动态状态不需要并入队列
        return self.stateIndex
    end
    self.stateIndex = self.stateIndex + 1
    if self.stateIndex > self.botLayouts[self.botLayoutIndex]:GetLength() then
        
        self.stateIndex = 1
    end
    return self.stateIndex
end


_this.GetStateNone = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入None状态------")
    end

    function state:Execute(nTime)
        

    end

    function state:Exit()

        print("------退出None状态------")
    end
    return state
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
    state.paths = nil
    state.pathIndex = nil
    function state:Enter()

        print("------进入Walk状态------")
        self.m_nTick = 0
    end

    function state:Execute(nTime)
        
        if 0 == self.m_nTick then

            self.paths = L_Map:FindPath(self.m_eNtity.index , L_Map.glassPoint)
            if self.paths == nil then
                
                self.m_eNtity.machine:ChangeState(self.stateAnger)
                self.m_nTick = 2
            else
                self.pathIndex = 2  --初始化路径
                self.m_nTick = 1
            end
        end

        if 1 == self.m_nTick then
            
            print(self.pathIndex , #self.paths)
            local newIndex = self.paths[self.pathIndex] + 1
            if L_ObjectController:SetIndex(self.m_eNtity , newIndex) then
                
                self.m_eNtity.objImg.transform.localPosition =  L_Map:GetPosition(newIndex)
                self.m_eNtity.mesObserver:PostEvent(L_TypeMesAiBot.MES_STATE_END)
                if self.pathIndex == #self.paths - 2 then
                    
                    self.m_eNtity.isClose = true
                end
            else
                print(Error("Error walk state SetIndex false"))            
            end
            self.m_nTick = 2
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

_this.GetStateAnger = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Anger状态------")
    end

    function state:Execute(nTime)
        

    end

    function state:Exit()

        print("------退出Anger状态------")
    end
    return state
end