
L_Landlords = {}
setmetatable(L_Landlords, {__index = _G})
local _this = L_Landlords


function _this:GetShunZi(list)
    
    local shunZiList = {}
    --sort
    --遍历list 标记lz 卡牌
    


    return shunZiList
    --return {{{1 , 2 , 0},{1 , 2 , 0},{1 , 2 , 0}} , {{1 , 2 , 0},{1 , 2 , 0},{1 , 2 , 0}}}
end

function _this:CreatCard(id , num , lz)
    
    local card = {id = id , num = num , lz = lz}
    return card
end