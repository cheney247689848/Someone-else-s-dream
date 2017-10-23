local GameObject = UnityEngine.GameObject
local Text = UnityEngine.UI.Text
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

require("observer/L_Subject")
require("bundle/L_BundleObserver")

L_ExpBundleScene = {}
setmetatable(L_ExpBundleScene, {__index = _G})
local _this = L_ExpBundleScene

function _this:Init()
    
    L_Subject:AddObserver(L_BundleObserver)

    L_Bundle:InitMainifest("StreamingAssets")

    UpdateBeat:Add(self.Update , self)
end


function _this:Update()

    --L_Subject:NotifyObservers()   --相当与manager  管理所有的观察者

    if Input.GetKeyDown(KeyCode.Alpha1) then

    L_Bundle:LoadBundle( "slogin_texture_noticebg" , function (cBundle)

        --local prafab = cBundle:LoadAsset("prafabimage")
        --GameObject.Instantiate(prafab)
        print("load noticebg sucess")
    end)

    elseif Input.GetKeyDown(KeyCode.Alpha2) then

        L_Bundle:LoadBundle( "slogin_prafab_prafabimage" , function (cBundle)

            print("load prafabimage sucess")
            print(cBundle)
            local prafab = cBundle:LoadAsset("prafabimage")
            GameObject.Instantiate(prafab)
        end)
    end
end