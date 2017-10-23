local FontStyle = UnityEngine.FontStyle
local Font = UnityEngine.Font
local CharacterInfo = UnityEngine.CharacterInfo

L_TextMaker = {}
setmetatable(L_TextMaker, {__index = _G})
local _this = L_TextMaker

_this.uTextConversion = nil
_this.uFont = nil
_this.tW = 100
_this.defaultSize = 16

function _this:UpdateBounds(cText , font , size , textWidth)
    
    self.uTextConversion = cText
    self.uFont = font
    self.tW = textWidth
    self.defaultSize = size
    print(self.tW , self.defaultSize)
end

function _this:UpdateSort(xStr)
    
    --local xStr = self.uText.text 
    local str = xStr .. "{sprite=0}" --尾端添加  运算后自动忽略（hulue）  
    local spriteList = {}
    
    local value = {self.defaultSize}
    local tpl = {}
    local countPl = 0
    local pl = 0
    local pw = 0
    local l = 0
    local i = 0
    local j = 0
    local len = 0
    local mk = 0
    while len < #str do
        
        local x , y = string.find(str , "{sprite=%d+}" , len)
        if x ~= nil and y ~= nil then
            
            local subStr = string.sub(str, len , x - 1)
            --print(" subStr :  " .. subStr)
            --print(string.format( "pw = %d , x = %d , y = %d ", pw , len , x - 1))
            if #subStr > 0 then

                local txt = {}
                self:Sort(txt , value , subStr)
                for t = 1, #txt , 1 do
                    
                    --print("str = " .. txt[t][3])
                    --print(string.format( "txt : pw = %d  strlen = %s ", pw , #subStr))
                    i = 1
                    j = 0
                    local w = 0
                    local z = tonumber(txt[t][2])
                    local k = 0
                    local s = txt[t][3]
                    
                    while i <= #s do

                        local count = self:GetByteCount(s , i)
                        local bs = string.sub(s, i , i + count - 1)
                        w , k = self:GetPfw(bs , self.uFont , z , FontStyle.Normal)
                        if pw + w > self.tW then

                            --i = i - 1 --\n
                            j = i
                            countPl = countPl + l
                            table.insert( tpl, {l , countPl})
                            --print(string.format( "换行 %s ， pl = %d , l = %d", bs , pl , l))
                            pl = pl + 1
                            pw = 0
                            l = 0
                            mk = 0
                        else 
                            l = math.max(l, k)
                            pw = pw + w
                            i = i + count
                        end

                        --print(string.format( "pl = %d , i = %d , bs = %s , count = %d , w = %d , k = %d", pl , i , bs , count, w , k))
                        --i = i + 1
                    end                    
                end
                --print(string.format( "pw = %d , pl = %d", pw , pl))

            end
            --print("pw = " , pw)
            --print("add sprite")
            local pStr = string.sub(str, x , y)
            local id = self:GetSpriteId(pStr)
            local rs = self:GetPopStr(id)
            local rw = self:GetLengthArrayPfw(rs , self.uFont , self.defaultSize , FontStyle.Normal)
            rs = self:PackStr(rs)
            --len = x + #rs
            --print(pw , rw)
            if pw + rw > self.tW then

                pl = pl + 1
                pw = rw
                len = x + #rs + 1
                rs = "\n" .. rs
                countPl = countPl + l -- 这里有歧义  字符小于15时候
                table.insert( tpl,  {l , countPl})
                l = 0
                --print(string.format( "添加换行符  pl = %d " , pl))
                table.insert(spriteList , {id , rw / 2, pl})  --id 初始位置 相对高度
            else
                
                table.insert(spriteList , {id , pw + rw / 2, pl})
                pw = pw + rw
                len = x + #rs
                
            end
            str = self:StrReplace(str , x , y , rs)
            
        else
            len = #str
        end
    end

    if pw > 0 then

        --添加最后一行
        countPl =  countPl + l
        table.insert( tpl,  {l , countPl})
        --print(string.format( "换行 %s ， pl = %d , l = %d , countPl = %d , ", bs , pl , l , countPl))
    end


    -- local dd = 0
    -- for i,v in ipairs(tpl) do

    --     local par = GameObject.Find("Cube")
    --     local obj = GameObject.Instantiate(par)
    --     obj.transform.parent = par.transform.parent
    --     obj.transform.localScale = Vector3(30 , 2 , 10)
    --     obj.transform.localPosition = Vector3(-155, -v , 0)

    --     --print(i , -v , v - dd)
    --     -- dd = v
    -- end


    return str , spriteList , tpl
end

--==============================--
--desc: 获取替换后的字符串
--time:2017-08-15 08:25:27
--@id: sprite id
--@return 替换后的字符串
--==============================--
function _this:GetPopStr(id)
    local str = "　　　" --使用全角空格
    return str
end

function _this:PackStr(str)

    return string.format( "<size=%d>%s</size>", self.defaultSize , str)
end

--==============================--
--desc:  获取匹配精灵图片ID
--time:2017-08-15 08:21:55
--@str: 需要匹配的字符串
--@return sprite id 
--==============================--
function _this:GetSpriteId(str)

    local mStr = string.match( str,"{sprite=%d+}")
    if mStr ~= nil then
        mStr = string.match(mStr,"%d+")
        if mStr ~= nil then return tonumber(mStr) end        
    end
    return -1
end

--==============================--
--desc:  替换位置下的字符串
--time:2017-08-19 04:52:39
--@str:
--@s:
--@e:
--@rStr:
--@return 
--==============================--
function _this:StrReplace(str , s , e , rStr)
    
    local ps = string.sub(str, 0, s - 1)
    local pe = string.sub(str, e + 1, #str)
    return ps .. rStr .. pe
end

--==============================--
--desc:递归计算属性值
--time:2017-09-06 04:56:00
--@txt:
--@value:
--@str:
--@px:
--@pl:
--@return 
--==============================--
function _this:Sort( txt , value , str , px , pl)
    
    local serachp = 0
    local tx = 0 
    local ty = 0

    --属性叠加
    for s in string.gfind(str, "%b<>") do

        local ms = s
        local x , y = string.find(str, ms , serachp)
        serachp = y
        if x - ty >= 2 then

            table.insert(txt , {0 , value[#value] , string.sub(str, ty + 1 , x - 1)})
            --计算值
        end
        tx = x
        ty = y
        
        local iter = string.gfind(ms, "<[%l]+")
        local st = iter()
        if st ~= nil then
            
            iter = string.gfind(ms, "<size=%d+")
            st = iter()
            if st ~= nil then
                
                iter = string.gfind(ms, "%d+")
                st = iter()
                if st ~= nil then
                    
                    --print("属性 : " .. st)
                    table.insert(value , st)
                end
            end
        end

        iter = string.gfind(ms, "</[%l]+")
        st = iter()
        if st ~= nil then 

            iter = string.gfind(ms, "</size>")
            st = iter()
            if st ~= nil then

                --print("移除属性 : " .. value[#value])
                table.remove( value, #value)
            end        
        end     
    end
    if #str - ty >= 2 then table.insert(txt , { 0 , value[#value] , string.sub(str, ty + 1 , #str)})end
    return txt
end


--==============================--
--desc:
--time:2017-09-06 04:30:03
--@str:
--@font:
--@fontsize:
--@type:
--@return 
--==============================--
function _this:GetPfw(str , font , fontsize , type)

        --print(str , font , fontsize , type)
        local pStr = str
        local width , height
        font:RequestCharactersInTexture(pStr , fontsize , type)
        local cstr = System.String.New(pStr)
        local buffer = cstr:ToCharArray()
        if buffer.Length >= 1 then
        
            local b , characterInfo = font:GetCharacterInfo(buffer[0], nil ,fontsize)
            width = characterInfo.advance
            self.uTextConversion.text = string.format("<size=%d>A</size>", fontsize)
            height = self.uTextConversion.preferredHeight
            return width , height            
        else
            return 0 , 0 
        end
end

--==============================--
--desc:
--time:2017-09-06 04:28:52
--@str:
--@font:
--@fontsize:
--@type:
--@return 
--==============================--
function _this:GetLengthArrayPfw(str , font , fontsize , type)
    
        font:RequestCharactersInTexture(str , fontsize , type)
        local cstr = System.String.New(str)
        local buffer = cstr:ToCharArray()
        local width = 0
        for i = 0 , buffer.Length - 1 do
            
            local b , characterInfo = font:GetCharacterInfo(buffer[i], nil ,fontsize)
            width = width + characterInfo.advance
            --print(buffer.Length , i , characterInfo.advance)
        end
        return width
end

--==============================--
--desc: 判断字符类型
--time:2017-09-06 04:29:01
--@str:
--@i:
--@return 
--==============================--
function _this:GetByteCount(str , i)
    
    local curByte = string.byte(str, i)
    local byteCount = 1
    if curByte>0 and curByte<=127 then
        byteCount = 1
    elseif curByte>=192 and curByte<223 then
        byteCount = 2
    elseif curByte>=224 and curByte<239 then
        byteCount = 3
    elseif curByte>=240 and curByte<=247 then
        byteCount = 4
    end
    return byteCount
end

--==============================--
--desc:四舍五入取整
--time:2017-09-06 04:29:35
--@r:
--@return 
--==============================--
function _this:GetRound(r)
    
    local r1 = math.ceil(r)
    local r2 =math.floor(r)
    if r1 == r then return r end
    return r >= (r1 + r2) / 2 and r1 or r2 
end
