L_SceneMajorState = {}
setmetatable(L_SceneMajorState, {__index = _G})
local _this = L_SceneMajorState

_this.stateGlobal = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Global状态------")
    end

    function state:Execute(nTime)
        
        --do thing
    end

    function state:Exit()

    print("------退出Global状态------")
    end
    return state
end

_this.stateLayout = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Layout状态------")
    end

    function state:Execute(nTime)
        
        --do thing
        if 0 == self.m_nTick then
            
            require "scene/L_SceneGame"
            L_ProxyScene:ChangeScene(L_SceneGame)
            self.m_nTick = 1
        end
    end

    function state:Exit()

    print("------退出Layout状态------")
    end
    return state
end

_this.stateProcess = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Process状态------")
    end

    function state:Execute(nTime)
        
        --do thing
    end

    function state:Exit()

    print("------退出Process状态------")
    end
    return state
end

_this.stateExit = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Exit状态------")
    end

    function state:Execute(nTime)
        
        --do thing
    end

    function state:Exit()

    print("------退出Exit状态------")
    end
    return state
end
