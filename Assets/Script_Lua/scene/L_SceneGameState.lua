local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

require "node/L_Node"
require "node/L_NodeController"
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
        
        -- if Input.GetKeyDown(KeyCode.Alpha1) then


        -- elseif Input.GetKeyDown(KeyCode.Alpha2) then
            
        -- end
        if Input.GetMouseButtonDown(0) then
            
            local index = self.m_eNtity:UpdateInput(Input.mousePosition)
            if index ~= -1 then

                print(string.format("index = %d , tarIndex = %d" , index ,L_NodeController.nodeList[index].tarIndex ))
            end
        end
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
            L_NodeController:Init(L_Map.formx * L_Map.formy , self.m_eNtity.view.blockNode)
            -- local paths = L_Map:FindPath(0 , 5)
            -- for i = 1, #paths do

            --     local pos = L_Map:GetPosition(paths[i])
            --     self.m_eNtity.view:DebugPos(pos)
            -- end
            -- ZCLOG(paths)
            -- print_r(paths)

            for i,v in ipairs(L_NodeController.nodeList) do
                
                local dex = v.index
                if 1 ~= dex and L_Map:IsBlock(dex) then
                    
                    local paths = L_Map:FindPath(1 , dex)
                    if paths ~= nil then
                        
                        if #paths >= 2 then
                            v:SetTarIndex(paths[#paths - 1] + 1 , #paths)
                        else
                            print("Error paths len = " , #paths , dex)
                        end
                    else
                        print("Error Path is nil")
                    end
                end
            end

            
            self.m_nTick = 1
        end

        if 1 == self.m_nTick then

            self.m_nTimer = self.m_nTimer + nTime
            if self.m_nTimer > 1 then

                print("REFRESH")
                L_NodeController:Sort()
                L_NodeController:Refresh()

                -- self.m_nTick = 2
                self.m_nTimer = 0
            end
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

