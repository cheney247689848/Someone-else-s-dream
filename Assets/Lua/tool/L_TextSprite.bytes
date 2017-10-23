local GameObject = UnityEngine.GameObject
local Text = UnityEngine.UI.Text
require "tool/L_TextMaker"
require "tool/L_TextMeta"

L_TextSprite = {}
setmetatable(L_TextSprite, {__index = _G})
local _this = L_TextSprite

_this.uText = nil
_this.uTextConversion = nil

function _this:Init(ut)
    
    self.uText = ut
    --clone the text
    self.uTextConversion = GameObject.Instantiate(ut.gameObject):GetComponent("Text")
    self.uTextConversion.name = "TextConversion"
    self.uTextConversion.transform:SetParent(ut.transform.parent)
    self.uTextConversion.transform.localScale = Vector3.one
    self.uTextConversion.transform.localPosition = Vector3(0 , 20000 , 0)
    
end

function _this:ReBuild(str)

    L_TextMaker:UpdateBounds(self.uTextConversion,
                                self.uText.font,
                                self.uText.fontSize,
                                self.uText.rectTransform.rect.width)

    local rStr , spriteList , lineInfos = L_TextMaker:UpdateSort(str)
    --设置显示文字 
    self.uText.text = rStr
    --显示图片精灵
    --print("len = " .. #spriteList)
    for i,v in ipairs(spriteList) do

        local info = lineInfos[v[3] + 1]
        local id = v[1]
        local x = v[2] + self.uText.rectTransform.rect.x
        local y = info[1]/2 - info[2]
        --print(string.format( "id = %d , x = %d , y = %d ", id , x , y))
        local sp = self:CreatSprite(id)
        sp.transform.localPosition = Vector3(x, y , 0)
    end
    --Debug显示行数信息
    --ShowDebug()
end

function _this:CreatSprite(id)
    
    local par = GameObject.Find("Image"):GetComponent("Image")
    local sp = GameObject.Instantiate(par)
    sp.transform:SetParent(par.transform.parent)
    sp.transform.localScale = Vector3(1 , 1 , 1)
    sp.transform.localPosition = Vector3(0 , 0 , 0)

    local w = 0
    local h = 0
    if L_TextMeta[id] ~= nil then

        w = L_TextMeta[id].width
        h = L_TextMeta[id].height
    else

        w = L_TextMeta[1].width
        h = L_TextMeta[1].height
    end
    sp.rectTransform.sizeDelta = Vector2(w, h); 
    return sp
end

function _this:ShowDebug()
    

end

function _this:CleanDebug()
    
    local u = GameObject.Find("TextFormat")
    for i = 0,u.transform.childCount-1 do

        if u.transform:GetChild(i).name == "Cube(Clone)" then
            
            GameObject.Destroy(u.transform:GetChild(i).gameObject , 0.1)
        end
    end
end

-- <b>text</b>
-- <i>text</i>
-- <size=10>text</size>
-- <color=red>text</color>
-- <color=#a4ffff>text</color>

