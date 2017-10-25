require "bundle/L_Bundle"
require "unit/L_Unit"
local GameObject = UnityEngine.GameObject

L_SceneGameView = {}
setmetatable(L_SceneGameView, {__index = _G})
local _this = L_SceneGameView

_this.sceneNode = nil
_this.blockNode = nil

function _this:InitView()

    print(" --- init view --- ")
    _this.sceneNode = GameObject.Find("Canvas")
    _this.blockNode = GameObject.Find("BlockNode")  ---595  315
end

function _this:InitMap(fx , fy , data)
    
    local bundle = L_Bundle:GetBundle("sgame_prefab_block")
    local bPrefab = L_Unit:LoadPrefab("block" , bundle)

    for y = 0 , fy do
        for x = 0 , fx do

            local v = x + y * fx + 1
            if L_Map:IsBlock(v) then
                
                local block = L_Unit:Instantiate(bPrefab , _this.blockNode)
                block.transform.localPosition = Vector3(L_Map.rect.x * x , - L_Map.rect.y * y , 0)
                -- print(v , block.transform.localPosition.x , block.transform.localPosition.y)
            end
        end
    end
end
--do otherthing