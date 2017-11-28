local GameObject = UnityEngine.GameObject
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

require "landlords/L_Landlords"

L_ExpLandlordsScene = {}
setmetatable(L_ExpLandlordsScene, {__index = _G})
local _this = L_ExpLandlordsScene

function _this:Init()

    local cardList = {

        {0 , 1 , 0},
        {1 , 2 , 0},
        {2 , 5 , 0},
        {3 , 7 , 0},
        {4 , 8 , 0},
        {5 , 9 , 0},
        {6 , 2 , 0},
        {7 , 7 , 0},
        {8 , 6 , 0},
        {9 , 4 , 0},
        {10 , 4 , 0},
        {11 , 3 , 0},
        {11 , 9 , 0}
    }

    local list = {}
    for i,v in ipairs(cardList) do
        
        table.insert( list, L_Landlords:CreatCard(v[1] , v[2], v[3]))
    end
    print(string.format( "初始化牌 %s 张", #list ))

    local shunZiList =  L_Landlords:GetShunZi(list)

    local debugStr = "得出的顺子:\n"
    for i,v in ipairs(shunZiList) do
        
        for j,k in ipairs(v) do
            
            debugStr = debugStr .. "  " .. k[2]
        end
        debugStr = debugStr .. "\n"
    end
    print(debugStr)
    UpdateBeat:Add(self.Update , self)
end

function _this:Update()

    if Input.GetKeyDown(KeyCode.Alpha1) then

        
    elseif Input.GetKeyDown(KeyCode.Alpha2) then

        
    end
end