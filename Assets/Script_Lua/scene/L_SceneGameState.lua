local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode
local GameObject = UnityEngine.GameObject

require "node/L_Node"
require "node/L_NodeController"
require "map/L_Map"
require "eliminate/L_Eliminate"
require "object/L_ObjectController"
require "object/L_ObjectGlass"

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
        -- if Input.GetMouseButtonDown(0) then
            
        --     print(Input.mousePosition.x , Input.mousePosition.y ,Input.mousePosition.z)
        --     local index = self.m_eNtity:UpdateInput(Input.mousePosition)
        --     if index ~= -1 then

        --         print(string.format("index = %d , tarIndex = %d" , index ,L_NodeController.nodeList[index].tarIndex ))
        --     end
        -- end
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
            --self.m_eNtity.view:InitMap(L_Map.formx ,L_Map.formy,L_Map.metaData)

            --creat block
            local glassIndex = 1
            for y = 0 , L_Map.formy - 1 do
                for x = 0 , L_Map.formx - 1 do
        
                    local v = x + y * L_Map.formx + 1
                    if L_Map:IsBlock(v) then
                        
                        local block = self.m_eNtity.view:CreatBlock(Vector3(L_Map.imgRect.x * x , - L_Map.imgRect.y * y , 0))
                        L_NodeController.nodeList[v].uiNode = block
                    elseif L_Map:IsGlass(v) then
                        
                        glassIndex = v
                        local objNode = self.m_eNtity.view:CreatGlass(Vector3(L_Map.imgRect.x * x , - L_Map.imgRect.y * y , 0))
                        L_ObjectGlass:Config(nil , objNode)
                    end
                end
            end
            
            --初始化路径
            for i,v in ipairs(L_NodeController.nodeList) do
                
                local dex = v.index
                if glassIndex ~= dex and L_Map:IsBlock(dex) then
                    
                    local paths = L_Map:FindPath(glassIndex , dex)
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

            L_NodeController:Sort()
            if L_NodeController:Refresh() then
                
                L_NodeController:UpdateDebugUI()
                self.m_nTick = 2
            else
                self.m_nTick = 3
            end

            -- if Input.GetKeyDown(KeyCode.Alpha1) then

            --     L_NodeController:Sort()
            --     if L_NodeController:Refresh() then
                    
            --         L_NodeController:UpdateDebugUI()
            --         -- self.m_nTick = 2
            --     else
            --         self.m_nTick = 3
            --     end
            -- elseif Input.GetKeyDown(KeyCode.Alpha2) then
                
            --     self.m_nTick = 2
            -- end
        end

        if 2 == self.m_nTick then
            
            local isForBreak = true
            for i,v in ipairs(L_NodeController.nodeList) do
                
                if v.status == L_TypeStatusNode.DROP then
                    
                    if Vector3.Distance(v.uiObject.transform.localPosition , v.position) > 1 then
                        
                        v.uiObject.transform.localPosition = Vector3.MoveTowards(v.uiObject.transform.localPosition , v.position , 12 )
                        isForBreak = false
                    else
                        L_NodeController:SetNodeStatus(v.index , L_TypeStatusNode.IDLE)
                    end
        
                    --测试
                    -- v.uiObject.transform.localPosition = v.position
                    -- L_NodeController:SetNodeStatus(v.index , L_TypeStatusNode.IDLE)

                elseif v.status == L_TypeStatusNode.CREAT then

                    v.uiObject = L_NodeController:CreatNodeUI()
                    v:SetColor(math.random(0 , 4)) --设置颜色
                    v.uiObject.transform.localPosition = v.position
                    L_NodeController:SetNodeStatus(v.index , L_TypeStatusNode.IDLE)
                    isForBreak = false
                end
            end

            if isForBreak then
                
                L_NodeController:UpdateDebugUI()
                self.m_nTick = 1
            end
        end

        if 3 == self.m_nTick then
            
            print("配置怪物")
            for i = 1, 1 do
                local id = 1654867
                local object = L_ObjectController:CreatObject(id , 15)
                print("creat " , id)
            end

            -- self.m_eNtity:ChangeToState(self.m_eNtity.stateObject) --直接测试怪物状态
            self.m_eNtity:ChangeToState(self.m_eNtity.stateProcess)
            self.m_nTick = 4
        end
    end

    function state:Exit()

    print("------退出MapLayout状态------")
    end
    return state
end

_this.stateProcess = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    state.startPosition = nil
    state.movePosition = nil
    state.startIndex = nil
    state.endIndex = nil
    state.forwardPosition = nil
    state.forward = nil
    state.startNode = nil
    state.endNode = nil
    function state:Enter()

        print("------进入Process状态------")
        self.m_nTick  = 0
    end

    function state:Execute(nTime)

        if Input.GetKeyDown(KeyCode.Alpha1) then

            --测试  跳过状态
            self.m_eNtity:ChangeToState(self.m_eNtity.stateEliminate)
        end

        if 0 == self.m_nTick then

            if Input.GetMouseButtonDown(0) then
                
                -- print(Input.mousePosition.x , Input.mousePosition.y ,Input.mousePosition.z)
                local index = self.m_eNtity:UpdateInput(Input.mousePosition)
                if index ~= -1 then
                    
                    self.startPosition = Input.mousePosition
                    self.startIndex = index
                    self.movePosition = Vector3.zero
                    self.endIndex = -1
                    self.forwardPosition = nil
                    self.forward = -1
                    self.startNode = nil
                    self.endNode = nil
                    print(string.format("index = %d , tarIndex = %d" , index ,L_NodeController.nodeList[index].tarIndex ))
                    self.m_nTick = 1
                end
            end
        end

        if 1 == self.m_nTick then
            
            if Input.GetMouseButton(0) then
                
                self.movePosition = Input.mousePosition
                local nX = Mathf.Abs(self.startPosition.x - self.movePosition.x)
                local nY = Mathf.Abs(self.startPosition.y - self.movePosition.y)
                -- print(nX , nY)
                if nX > 5 or nY > 5 then
                    
                    if nX > nY then
                        --横
                        if self.startPosition.x < self.movePosition.x then
                            
                            self.endIndex = self.startIndex + 1
                            self.forward = 0
                        else
                            
                            self.endIndex = self.startIndex - 1
                            self.forward = 1
                        end
                    else
                        --竖
                        if self.startPosition.y < self.movePosition.y then
                            
                            self.endIndex = self.startIndex - L_Map.formx
                            self.forward = 2
                        else
                            
                            self.endIndex = self.startIndex + L_Map.formx
                            self.forward = 3
                        end
                    end
                    print(string.format( " %d swap to %d", self.startIndex , self.endIndex ))
                    

                    --判断合法性
                    self.startNode = L_NodeController:GetNode(self.startIndex)
                    self.endNode = L_NodeController:GetNode(self.endIndex)
                    if self.startNode == nil then
                        
                        --false
                        
                    elseif self.endNode == nil then

                        --false
                        -- self.m_nTick = 0
                    else

                        local isExchange = false
                        if self.startNode.status ~= L_TypeStatusNode.IDLE then

                            self.m_nTick = 0
                            return
                        elseif self.endNode.status ~= L_TypeStatusNode.IDLE then
                            
                            --false
                            isExchange = false
                        else

                            self:ExChange()
                            local list = L_Eliminate:Detect(self.startIndex , self.endIndex)
                            if list ~= nil then
                                
                                self.m_eNtity.stateEliminate.list = list
                                isExchange = true
                            else
                                self:ExChange()   --不产生交换
                                isExchange = false
                            end
                        end
                        
                        if not isExchange then
                            
                            self.forwardPosition = Vector3(self.startNode.position.x , self.startNode.position.y , self.startNode.position.z)
                            if self.forward == 0 then
                                
                                self.forwardPosition.x = self.forwardPosition.x + 45
                            elseif self.forward == 1 then
    
                                self.forwardPosition.x = self.forwardPosition.x - 45
                            elseif self.forward == 2 then
    
                                self.forwardPosition.y = self.forwardPosition.y + 45
                            else
    
                                self.forwardPosition.y = self.forwardPosition.y - 45
                            end
                            --print(self.forwardPosition.x , self.forwardPosition.y  , self.startNode.position.x , self.startNode.position.y)
                            self.m_nTick = 11 --测试
                        else

                            self.m_nTick = 21
                        end
                    end
                end

            elseif Input.GetMouseButtonUp(0) then

                --cancel
                self.m_nTick = 0
            end
        end

        if 11 == self.m_nTick then
            
            --false
            if Vector3.Distance(self.startNode.uiObject.transform.localPosition , self.forwardPosition) > 1 then
                
                self.startNode.uiObject.transform.localPosition = Vector3.MoveTowards(self.startNode.uiObject.transform.localPosition , self.forwardPosition , 8 )
            else
                self.m_nTick = 12
            end
        end

        if 12 == self.m_nTick then
            
            --false
            if Vector3.Distance(self.startNode.uiObject.transform.localPosition , self.startNode.position) > 1 then
                
                self.startNode.uiObject.transform.localPosition = Vector3.MoveTowards(self.startNode.uiObject.transform.localPosition , self.startNode.position , 8 )
            else
                self.m_nTick = 0
            end
        end

        if 21 == self.m_nTick then
            
            local isLoop = false
            if Vector3.Distance(self.startNode.uiObject.transform.localPosition , self.startNode.position) > 1 then
                
                self.startNode.uiObject.transform.localPosition = Vector3.MoveTowards(self.startNode.uiObject.transform.localPosition , self.startNode.position , 8 )
                isLoop = true
            end

            if Vector3.Distance(self.endNode.uiObject.transform.localPosition , self.endNode.position) > 1 then
                
                self.endNode.uiObject.transform.localPosition = Vector3.MoveTowards(self.endNode.uiObject.transform.localPosition , self.endNode.position , 8 )
                isLoop = true
            end

            if not isLoop then
                
                L_NodeController:UpdateDebugUI()
                self.m_eNtity:ChangeToState(self.m_eNtity.stateEliminate)
                self.m_nTick = 99
            end
        end
    end

    function state:Exit()

        print("------退出Process状态------")
    end

    function state:ExChange()
        
        local tempMeta = self.startNode.meta
        self.startNode.meta = self.endNode.meta
        self.endNode.meta = tempMeta

        local tempObj = self.startNode.uiObject
        self.startNode.uiObject = self.endNode.uiObject
        self.endNode.uiObject = tempObj
    end
    return state
end


_this.stateEliminate = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    state.list = nil
    function state:Enter()

        print("------进入Eliminate状态------")
        self.m_nTick = 1
    end

    function state:Execute(nTime)
        
        if 1 == self.m_nTick then
            
            --print(#self.list)
            for i,v in ipairs(self.list) do
                
                for j,n in ipairs(v) do
                    
                    -- print(n.index)
                    GameObject.Destroy(n.uiObject)
                    n.uiObject = nil
                    L_NodeController:SetNodeStatus(n.index , L_TypeStatusNode.NONE)
                end
            end
            self.m_eNtity:ChangeToState(self.m_eNtity.stateObject)
            self.m_nTick = 2
        end
        
    end

    function state:Exit()

        print("------退出Eliminate状态------")
    end
    return state
end


_this.stateObject = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入object状态------")
        self.m_nTick = 0
        L_ObjectController:SetNextState()
    end

    function state:Execute(nTime)

        if 0 == self.m_nTick then
            
            if L_ObjectController:Update() then
                
                self.m_eNtity:ChangeToState(self.m_eNtity.stateDrop)
                self.m_nTick = 1
            end
        end 
    end

    function state:Exit()

        print("------退出object状态------")
    end
    return state
end


_this.stateDrop = function (o , eNtity)
    
    local state = L_State.New(o , eNtity)
    function state:Enter()

        print("------进入Drop状态------")
        self.m_nTick = 0
    end

    function state:Execute(nTime)
        
        if 0 == self.m_nTick then

            L_NodeController:Sort()
            if L_NodeController:Refresh() then
                
                L_NodeController:UpdateDebugUI()
                self.m_nTick = 1
            else
                self.m_nTick = 2
            end
        end

        if 1 == self.m_nTick then
            
            local isForBreak = true
            for i,v in ipairs(L_NodeController.nodeList) do
                
                if v.status == L_TypeStatusNode.DROP then
                    
                    if Vector3.Distance(v.uiObject.transform.localPosition , v.position) > 1 then
                        
                        v.uiObject.transform.localPosition = Vector3.MoveTowards(v.uiObject.transform.localPosition , v.position , 8 )
                        isForBreak = false
                    else
                        L_NodeController:SetNodeStatus(v.index , L_TypeStatusNode.IDLE)
                    end
        
                    --测试
                    --v.uiObject.transform.localPosition = v.position
                    --L_NodeController:SetNodeStatus(v.index , L_TypeStatusNode.IDLE)

                elseif v.status == L_TypeStatusNode.CREAT then

                    v.uiObject = L_NodeController:CreatNodeUI()
                    v:SetColor(math.random(0 , 4))
                    v.uiObject.transform.localPosition = v.position
                    L_NodeController:SetNodeStatus(v.index , L_TypeStatusNode.IDLE)
                    isForBreak = false
                end
            end

            if isForBreak then
                
                L_NodeController:UpdateDebugUI()
                self.m_nTick = 0
            end
        end

        if 2 == self.m_nTick then
            
            self.m_eNtity:ChangeToState(self.m_eNtity.stateProcess)
            self.m_nTick = 4
        end
    end

    function state:Exit()

        print("------退出Drop状态------")
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

