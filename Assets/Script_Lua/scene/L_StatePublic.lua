-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-- 公共状态
-------------------------------------------------------------------

L_StatePublic = {}
setmetatable(L_StatePublic, {__index = _G})
local _this = L_StatePublic

_this.stateNone = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入None状态------")
    end

    function state:Execute(nTime)
        
        --do thing
    end

    function state:Exit()

    print("------退出None状态------")
    end
    return state
end

_this.stateLoad = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Load状态------")
        self.m_nTimer = 0
        self.m_nTick = 0
    end

    function state:Execute(nTime)
        
        --do thing
        if 0 == self.m_nTick then
            
            self.m_nTimer = self.m_nTimer + nTime
            print(self.m_nTimer)
            if self.m_nTimer > 3 then
                
                self.m_eNtity:ChangeToState(self.m_eNtity.stateNone)
            end
        end
        
    end

    function state:Exit()

    print("------退出Load状态------")
    end
    return state
end

_this.stateExit = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Exit状态------")
        self.m_nTimer = 0
        self.m_nTick = 0
    end

    function state:Execute(nTime)
        
        --do thing
        if 0 == self.m_nTick then
            
            self.m_nTimer = self.m_nTimer + nTime
            print(self.m_nTimer)
            if self.m_nTimer > 3 then
            
                self.m_eNtity:ChangeToState(self.m_eNtity.stateNone)
            end
        end
    end

    function state:Exit()

    print("------退出Exit状态------")
    end
    return state
end


