local GameObject = UnityEngine.GameObject
local Input = UnityEngine.Input
local Text = UnityEngine.UI.Text
local KeyCode = UnityEngine.KeyCode

require "landlords/L_Landlords"

L_ExpLandlordsScene = {}
setmetatable(L_ExpLandlordsScene, {__index = _G})
local _this = L_ExpLandlordsScene

_this.cardIndex = 1
_this.shunZiList = nil

function _this:Init()

    local cardList = {

        {0 , 3 , 0},
        {1 , 4 , 0},
        {2 , 7 , 0},
        {3 , 7 , 0},
        {4 , 7 , 0},
        {5 , 9 , 0},
        {6 , 9 , 0},
        {7 , 10 , 0},
        {8 , 11 , 0},
        {9 , 12 , 0},
        {10 , 2 , 1},
        {11 , 2 , 1},
        {12 , 2 , 1},
        {13 , 2 , 1},
        {14 , 9 , 0},
        {15 , 9 , 0},
        {16 , 9 , 0},
        {17 , 9 , 0}
    }

    local list = {}
    local strText = ""
    for i,v in ipairs(cardList) do
        
        table.insert( list, L_Landlords:CreatCard(v[1] , v[2], v[3]))

        strText = strText .. v[2] .. "  "
    end

    local uCardText = GameObject.Find("TextCard"):GetComponent("Text")
    uCardText.text = strText

    print(string.format( "初始化牌 %s 张", #list ))

    self.shunZiList =  L_Landlords:GetShunZi(list)

    local debugStr = "得出的顺子列表 " .. #self.shunZiList .. " 个:\n"
    for i,v in ipairs(self.shunZiList) do

        for j,k in ipairs(v) do
            
            if k.lz > 0 then

                debugStr = debugStr .. "  (" .. k.pnum .."x)"
            else
                debugStr = debugStr .. "  " .. k.num
            end
        end
        -- debugStr = debugStr .. "  " .. v
        debugStr = debugStr .. "\n"
    end
    print(debugStr)
    UpdateBeat:Add(self.Update , self)
end

function _this:UpdateUI()

    local c = self.shunZiList[self.cardIndex]
    local t = ""
    for i,v in ipairs(c) do
        if v.lz > 0 then
    
            t = t .. "  (" .. v.pnum .."x)"
        else
            t = t .. "  " .. v.num
        end
    end
    local uoCardText = GameObject.Find("OutPutTextCard"):GetComponent("Text")
    uoCardText.text = t
end

function _this:Update()

    if Input.GetKeyDown(KeyCode.Alpha1) then

        self:UpdateUI()
        self.cardIndex = self.cardIndex + 1
        if self.cardIndex > #self.shunZiList then
            self.cardIndex = 1
        end
    elseif Input.GetKeyDown(KeyCode.Alpha2) then

        self:UpdateUI()
        self.cardIndex = self.cardIndex - 1
        if self.cardIndex < 1 then
            self.cardIndex = 1
        end
    end
end

