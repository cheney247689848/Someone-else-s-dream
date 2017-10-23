module(...,package.seeall)
function L_Enum:CreatEnumTable(tbl, index) 
    --assert(IsTable(tbl)) 
    local enumtbl = {} 
    local enumindex = index or 0 
    for i, v in ipairs(tbl) do 
        enumtbl[v] = enumindex + i 
    end 
    return enumtbl 
end

function L_Enum:CreatEnumArrTable(tbl)

    local enumtbl = {} 
    for i = 1 ,  #tbl , 2 do
    
        --print(tbl[i] .. " , " .. tbl[i + 1])
        enumtbl[tbl[i]] = tbl[i + 1] 
    end
    return enumtbl
end