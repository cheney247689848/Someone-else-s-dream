
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