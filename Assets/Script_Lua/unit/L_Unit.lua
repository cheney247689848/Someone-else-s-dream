
-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------

local GameObject = UnityEngine.GameObject
local Texture = UnityEngine.Texture
local Shader = UnityEngine.Shader
local Font = UnityEngine.Font

L_Unit = {}
setmetatable(L_Unit, {__index = _G})
local _this = L_Unit

function _this:LoadPrefabInstantiate(pName , bundle , parent)
    
    return self:Instantiate(self:LoadPrefab(pName , bundle) , parent)
end

function _this:Instantiate(prefab , parent)
    
    local assets = GameObject.Instantiate(prefab)
    assets.transform:SetParent(parent.transform , false)
    assets.tag = parent.tag
    -- assets.transform.localPosition = Vector3.zero
    -- assets.transform.localScale = Vector3.one
    return assets
end

function _this:LoadPrefab(pName , bundle)
    
    local pPrefab = bundle:LoadAsset(pName , typeof(GameObject))
    return pPrefab
end

function _this:LoadEffect(eName , bundle , parent)
    
    local pEffect = bundle:LoadAsset(eName , typeof(GameObject))
    return self:Instantiate(pEffect , parent)
end

function _this:LoadTexture(tName , bundle)
    
    local pTexture = bundle:LoadAsset(tName , typeof(Texture))
    return pTexture
end

function _this:LoadFont(fName , bundle)
    
    local pFont = bundle:LoadAsset(fName , typeof(Font))
    return pFont
end

function _this:LoadShader(sName , bundle)
    
    local pShader = bundle:LoadAsset(sName , typeof(Shader))
    return pShader
end

function ZCLOG(Lua_table)  

        local function define_print(_tab,str)  
            str = str .. "  "  
            for k,v in pairs(_tab) do  
                if type(v) == "table" then  
                    if not tonumber(k) then  
                        print(str.. k .."{")  
                    else  
                        print(str .."{")  
                    end  
                    define_print(v,str)  
                    print( str.."}")  
                else  
                    print(str .. tostring(k) .. " " .. tostring(v))  
                end  
            end  
        end  
    if type(Lua_table) == "table" then  
        define_print(Lua_table," ")  
    else  
        print(tostring(Lua_table))  
    end  
end

function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        -- print(indent.."["..pos.."] => "..tostring(t).." {")
                        indent = indent.."["..pos.."] => "..tostring(t).." {"
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        -- print(indent..string.rep(" ",string.len(pos)+6).."}")
                        indent = indent..string.rep(" ",string.len(pos)+6).."}"
                    elseif (type(val)=="string") then
                        -- print(indent.."["..pos..'] => "'..val..'"')
                        indent = indent.."["..pos..'] => "'..val..'"'
                    else
                        -- print(indent.."["..pos.."] => "..tostring(val))
                        indent = indent.."["..pos.."] => "..tostring(val)
                    end
                end
            else
                -- print(indent..tostring(t))
                indent = indent..tostring(t)
            end
        end
        print(indent)
    end
    
    if (type(t)=="table") then
        -- print(tostring(t).." {")
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        -- print("}")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end