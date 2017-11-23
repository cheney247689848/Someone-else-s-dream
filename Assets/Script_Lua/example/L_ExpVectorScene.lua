
local GameObject = UnityEngine.GameObject
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

L_ExpVectorScene = {}
setmetatable(L_ExpVectorScene, {__index = _G})
local _this = L_ExpVectorScene

function _this:Init()

    print("--- L_ExpVectorScene Init ---")
    UpdateBeat:Add(self.Update , self)

    local objP1 = GameObject.Find("p1")
    local objP2 = GameObject.Find("p2")
    local objV = GameObject.Find("v")

    local p1 = Vector3(0 , 0 , 20)
    local p2 = Vector3(0 , 20 , 1)

    local v = Vector3.Cross(p1 , p2)
    print(v.x , v.y , v.z)
    
    objP1.transform.localPosition = p1
    objP2.transform.localPosition = p2
    objV.transform.localPosition = v
end
    
function _this:Update()

    if Input.GetKeyDown(KeyCode.Alpha1) then

        
    elseif Input.GetKeyDown(KeyCode.Alpha2) then

        
    end

end