require "bundle/L_Bundle"
require "unit/L_Unit"
local GameObject = UnityEngine.GameObject

L_SceneGameView = {}
setmetatable(L_SceneGameView, {__index = _G})
local _this = L_SceneGameView

_this.sceneNode = nil

function _this:InitView()

    print(" --- init view --- ")
    _this.sceneNode = GameObject.Find("Canvas")
end

function _this:InitMap(fx , fy , data)
    
    local bundle = L_Bundle:GetBundle("sgame_prefab_block")
    local bPrefab = L_Unit:LoadPrefab("block" , bundle)

    for y = 0 , fy - 1 do
        for x = 0 , fx - 1 do
            local v = x + y * fx
            
            local block = L_Unit:Instantiate(bPrefab , _this.sceneNode)
            block.transform.localPosition = Vector3(-45 + L_Map.rect.x * x , 45 + L_Map.rect.y * y , 0)
            print(v , block.transform.localPosition.x , block.transform.localPosition.y)
        end
    end
end
--do otherthing