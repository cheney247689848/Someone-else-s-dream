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
            
            -- print(Input.mousePosition.x , Input.mousePosition.y ,Input.mousePosition.z)
            -- local index = self.m_eNtity:UpdateInput(Input.mousePosition)
            -- if index ~= -1 then

            --     print(string.format("index = %d , tarIndex = %d" , index ,L_NodeController.nodeList[index].tarIndex ))
            -- end
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
            L_Map:SetConfigRamdom()
            L_NodeController:Init(L_Map.formx * L_Map.formy , self.m_eNtity.view.blockNode)
            self.m_eNtity.view:InitMap(L_Map.formx ,L_Map.formy,L_Map.metaData)

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

            -- L_Map.metaData[20] = 1
            -- L_Map.metaData[19] = 1
            -- L_Map.metaData[21] = 1

            -- for i,v in ipairs(L_NodeController.nodeList) do
                
            --     if v.status == L_TypeStatusNode.IDLE then
                    
            --         L_Map:SetDynData(v.index , 0)
            --     else
            --         L_Map:SetDynData(v.index , 0) --2 是临时值
            --     end
            -- end
            -- L_Map:SetDynData(20 , 2)
            -- L_Map:SetDynData(19 , 2)
            -- L_Map:MergeData()

            -- for i,v in ipairs(L_Map.mergeData) do

            --     print(i,v)
            -- end


            -- local paths = L_Map:FindPath(1 , 6)
            -- for i = 1, #paths do

            --     local pos = L_Map:GetPosition(paths[i] + 1)
            --     self.m_eNtity.view:DebugPos(pos)
            -- end
            -- ZCLOG(paths)
            -- print_r(paths)
            L_NodeController:UpdateDebugUI()
            self.m_nTick = 1
        end

        --优先填充pathlen短的

        --用挤的方式  并非用填充方式

        if 1 == self.m_nTick then

            if Input.GetKeyDown(KeyCode.Alpha1) then

                print("REFRESH")
                L_NodeController:Sort()
                L_NodeController:Refresh()
                L_NodeController:UpdateDebugUI()
            end

            -- self.m_nTimer = self.m_nTimer + nTime
            -- if self.m_nTimer > 0.1 then
    
            --     print("REFRESH")
            --     L_NodeController:Sort()
            --     L_NodeController:Refresh()
            --     L_NodeController:UpdateDebugUI()
            --     self.m_nTimer = 0
            -- end

            L_NodeController:Sort()
            if L_NodeController:Refresh() then
                
                L_NodeController:UpdateDebugUI()
                self.m_nTick = 2
            else
                self.m_nTick = 3
            end
        end

        if 2 == self.m_nTick then
            
            local isForBreak = true
            for i,v in ipairs(L_NodeController.nodeList) do
                
                if v.status == L_TypeStatusNode.DROP then
                    
                    if v.uiObject ~= nil then
                        
                        if Vector3.Distance(v.uiObject.transform.localPosition , v.position) > 1 then
                            
                            v.uiObject.transform.localPosition = Vector3.MoveTowards(v.uiObject.transform.localPosition , v.position , 1 )
                            isForBreak = true
                        end
                    end
                elseif v.status == L_TypeStatusNode.CREAT then

                    v.uiObject = L_NodeController:CreatNodeUI()
                    v.uiObject.transform.localPosition = v.position
                    isForBreak = true
                end
            end

            if isForBreak then
                
                self.m_nTick = 1
            end
        end

        if 3 == self.m_nTick then
            
            print("结束")
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

