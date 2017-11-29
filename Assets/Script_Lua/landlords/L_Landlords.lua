
L_Landlords = {}
setmetatable(L_Landlords, {__index = _G})
local _this = L_Landlords


function _this:GetShunZi(list)
    
    if #list < 5 then
        return
    end
    --clone
    local cloneList = {}
    for i,v in ipairs(list) do
        table.insert( cloneList, v )
    end

    local totalList = {}
    local tempList = {}
    local lz = {}
    local dex = {}
    for i,v in ipairs(cloneList) do
        if v.lz > 0 then
            v.pnum = v.num
            v.num = 1
            table.insert( lz, v )
            dex[#lz] = 1
        end
    end

    local len = math.pow(13,#lz)
    local up = true
    print("len =", len)
    for i = 1, len do
        up = true
        if i ~= 1 then
            for j = 1 , #dex do
                if up then
                    dex[j] = dex[j] + 1
                    if dex[j] > 13 then
                        dex[j] = 1
                        up = true
                    else
                        up = false
                        break
                    end
                end
            end
        end
        
        -- local str = ""
        for l=1,#lz do
            -- str = str .. "  " .. dex[l]
            lz[l].num =  dex[l]
        end
        -- print(str)
        local combinList = self:Combin(cloneList)
        for u,y in ipairs(combinList) do
            
            local isAdd = true
            for u2,y2 in ipairs(tempList) do
                
                if y2 == y then
                    isAdd = false
                end
            end
            if isAdd then
                table.insert(tempList, y)
            end
        end
    end

    for i,v in ipairs(tempList) do
        
        --匹配规则
        --区间匹配
        local t = {}
        -- print(v)
        for s in string.gfind(v, "%d+") do
            -- print(tonumber(s))
            table.insert(t , list[tonumber(s) + 1])
        end
        -- print("break")
        table.insert(totalList , t)
    end

    --sort
    for i = 1 , #totalList do
        for j = 1 , #totalList - i do

            if #totalList[j] < #totalList[j+1] then
                
                tmp = totalList[j]  
                totalList[j] = totalList[j+1]
                totalList[j+1] = tmp
            end
        end  
    end

 
    return totalList
    --return {{{1 , 2 , 0},{1 , 2 , 0},{1 , 2 , 0}} , {{1 , 2 , 0},{1 , 2 , 0},{1 , 2 , 0}}}
end


function _this:Combin(list)
    
    local shunZiList = {}
    local lzCount = 0
    --sort
    local tmp = nil
    for i = 1 , #list do
        for j = 1 , #list - i do

            if list[j].num < list[j+1].num then
                
                tmp = list[j]  
                list[j] = list[j+1]
                list[j+1] = tmp
            end
        end  
    end

    for i = 1, #list do

        local combin = tostring(list[i].id)
        local num = list[i].num
        local count = 0
        for j = i + 1, #list do
            
            -- print(string.format( "num = %d , toNum = %d", num , list[j].num))
            if list[j].num + 1 == num then

                -- table.insert( combin, list[j])
                combin = combin .. "," .. list[j].id
                num = list[j].num
                count = count + 1
            elseif list[j].num == num then
            else
                break
            end
        end
        -- print("break")
        if count >= 5 then
            -- print("output")
            table.insert( shunZiList, combin)
        end
    end
    return shunZiList
end


function _this:CreatCard(id , num , lz)
    
    local card = {id = id , num = num , lz = lz}
    return card
end