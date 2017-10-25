require "map/L_Map"

L_SceneGameState = {}
setmetatable(L_SceneGameState, {__index = _G})
local _this = L_SceneGameState

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
        self.m_eNtity.view:InitView()
    end

    function state:Execute(nTime)
        
        --do thing
        self.m_eNtity:ChangeToState(self.m_eNtity.stateMapLayout)
    end

    function state:Exit()

    print("------退出Layout状态------")
    end
    return state
end

_this.stateMapLayout = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入MapLayout状态------")
        self.m_nTimer = 0
        self.m_nTick = 0
    end

    function state:Execute(nTime)
        
        --do thing
        if 0 == self.m_nTick then
            
            print("配置地形")
            L_Map.SetConfigRamdom()
            self.m_eNtity.view:InitMap(L_Map.formx ,L_Map.formy,L_Map.metaData)
            self.m_nTick = 1

            local paths = L_Map:FindPath(0 , 61)

            -- local pos = L_Map:GetPosition(0)
            -- print(pos.x , pos.y)
            -- self.m_eNtity.view:DebugPos(pos)
            -- pos = L_Map:GetPosition(1)
            -- print(pos.x , pos.y)
            -- self.m_eNtity.view:DebugPos(pos)
            -- pos = L_Map:GetPosition(2)
            -- print(pos.x , pos.y)
            -- self.m_eNtity.view:DebugPos(pos)
            -- pos = L_Map:GetPosition(30)
            -- print(pos.x , pos.y)
            -- self.m_eNtity.view:DebugPos(pos)
            -- pos = L_Map:GetPosition(111)
            -- print(pos.x , pos.y)
            -- self.m_eNtity.view:DebugPos(pos)

            for i = 1, #paths do

                print('i : '.. tostring(paths[i]))
                local pos = L_Map:GetPosition(paths[i])
                -- print(pos.x , pos.y)
                self.m_eNtity.view:DebugPos(pos)
            end
            -- ZCLOG(paths)
            -- print_r(paths)
        end
    end

    function state:Exit()

    print("------退出MapLayout状态------")
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

