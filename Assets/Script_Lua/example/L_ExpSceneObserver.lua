--[[
function listener(arg1 , arg2 , arg3)
    
    print("listener")
    --print("listener")
    print(arg1 , arg2 , arg3)
end

require "observer/L_SceneObserver"
print("value - " , L_SceneObserver["adfs"] , #L_SceneObserver["adfs"])
L_SceneObserver["adfs"] = L_SceneObserver["adfs"] + listener  
L_SceneObserver["adfs"] = L_SceneObserver["adfs"] + listener 
L_SceneObserver["adfs"] = L_SceneObserver["adfs"] + listener 
L_SceneObserver["adfs"] = L_SceneObserver["adfs"] + listener 
L_SceneObserver["adfs"] = L_SceneObserver["adfs"] + listener   
print("value - " , L_SceneObserver["adfs"] , #L_SceneObserver["adfs"])

L_SceneObserver:PostEvent("adfs" , 1 , 2 , 3)
L_SceneObserver:PostEvent("adfs" , 1 , 2 , 3)
L_SceneObserver:PostEvent("adfs" , 1 , 2 , 3)
L_SceneObserver:PostEvent("adfs" , 1 , 2 , 3)
L_SceneObserver:PostEvent("adfs" , 1 , 2 , 3)

print("clean")
L_SceneObserver:Clean()

L_SceneObserver["adfs"] = L_SceneObserver["adfs"] - listener 
print("value - " , L_SceneObserver["adfs"] , #L_SceneObserver["adfs"])

L_SceneObserver["adfs"] = L_SceneObserver["adfs"] - listener 
print("value - " , L_SceneObserver["adfs"] , #L_SceneObserver["adfs"])

L_SceneObserver["adfs"] = L_SceneObserver["adfs"] - listener 
print("value - " , L_SceneObserver["adfs"] , #L_SceneObserver["adfs"])

L_SceneObserver["adfs"] = L_SceneObserver["adfs"] - listener 
print("value - " , L_SceneObserver["adfs"] , #L_SceneObserver["adfs"])

L_SceneObserver["adfs"] = L_SceneObserver["adfs"] - listener 
print("value - " , L_SceneObserver["adfs"] , #L_SceneObserver["adfs"])

L_SceneObserver["adfs"] = L_SceneObserver["adfs"] - listener 
print("value - " , L_SceneObserver["adfs"] , #L_SceneObserver["adfs"])

]]