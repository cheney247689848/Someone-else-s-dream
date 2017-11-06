-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------

L_Eliminate = {}
setmetatable(L_Eliminate, {__index = _G})
local _this = L_Eliminate

function _this:Detect(startIndex , endIndex)

    local elists = nil
    local startNode = L_NodeController:GetNode(startIndex)
    local endNode = L_NodeController:GetNode(endIndex)
    
    local startList = {}
    local tempList = {}
    tempList = self:DetectUpDown(startNode)
    -- print("s : ws" , #tempList)
    if #tempList >= 2 then
        for i,v in ipairs(tempList) do
            
            table.insert( startList, v)
        end
    end
    -- tempList = self:DetectDown(startNode)
    -- print("s : s" , #tempList)
    -- if #tempList >= 2 then
    --     for i,v in ipairs(tempList) do
            
    --         table.insert( startList, v)
    --     end
    -- end
    tempList = self:DetectLeftRight(startNode)
    -- print("s : ad" , #tempList)
    if #tempList >= 2 then
        for i,v in ipairs(tempList) do
            
            table.insert( startList, v)
        end
    end
    -- tempList = self:DetectRight(startNode)
    -- print("s : d" , #tempList)
    -- if #tempList >= 2 then
    --     for i,v in ipairs(tempList) do
            
    --         table.insert( startList, v)
    --     end
    -- end

    if  #startList >= 2 then

        elists = {}
        table.insert(startList , startNode)
        table.insert(elists , startList)
    end
    --排除相同的颜色
    if startNode.meta.color == endNode.meta.color then
        
        return elists
    end

    local endList = {}
    tempList = {}
    tempList = self:DetectUpDown(endNode)
    -- print("e : ws" , #tempList)
    if #tempList >= 2 then
        for i,v in ipairs(tempList) do
            
            table.insert( endList, v)
        end
    end
    -- tempList = self:DetectDown(endNode)
    -- print("e : s" , #tempList)
    -- if #tempList >= 2 then
    --     for i,v in ipairs(tempList) do
            
    --         table.insert( endList, v)
    --     end
    -- end
    tempList = self:DetectLeftRight(endNode)
    -- print("e : ad" , #tempList)
    if #tempList >= 2 then
        for i,v in ipairs(tempList) do
            
            table.insert( endList, v)
        end
    end
    -- tempList = self:DetectRight(endNode)
    -- print("e : d" , #tempList)
    -- if #tempList >= 2 then
    --     for i,v in ipairs(tempList) do
            
    --         table.insert( endList, v)
    --     end
    -- end
    if #endList >= 2 then

        if elists == nil then
            elists = {}
            table.insert(endList , endNode)
        end
        table.insert(elists , endList)
    end
    return elists
end

function _this:DetectUpDown(node)
    
    local isBreak = false
    local tIndex = node.index
    local list = {}
    while not isBreak do
        
        tIndex = tIndex - L_Map.formx
        local tNode = L_NodeController:GetNode(tIndex)
        if tNode ~= nil then
            
            if node.meta.color == tNode.meta.color then
                
                table.insert(list, tNode)
            else
                isBreak = true
            end
        else
            isBreak = true
        end
    end

    isBreak = false
    tIndex = node.index
    while not isBreak do
        
        tIndex = tIndex + L_Map.formx
        local tNode = L_NodeController:GetNode(tIndex)
        if tNode ~= nil then
            
            if node.meta.color == tNode.meta.color then
                
                table.insert(list, tNode)
            else
                isBreak = true
            end
        else
            isBreak = true
        end
    end
    return list
end

function _this:DetectLeftRight(node)
    
    local isBreak = false
    local tIndex = node.index
    local list = {}
    while not isBreak do
        
        tIndex = tIndex - 1
        local tNode = L_NodeController:GetNode(tIndex)
        if tNode ~= nil then
            
            if node.meta.color == tNode.meta.color then
                
                table.insert(list, tNode)
            else
                isBreak = true
            end
        else
            isBreak = true
        end
    end

    isBreak = false
    tIndex = node.index
    while not isBreak do
        
        tIndex = tIndex + 1
        local tNode = L_NodeController:GetNode(tIndex)
        if tNode ~= nil then
            
            if node.meta.color == tNode.meta.color then
                
                table.insert(list, tNode)
            else
                isBreak = true
            end
        else
            isBreak = true
        end
    end
    return list
end