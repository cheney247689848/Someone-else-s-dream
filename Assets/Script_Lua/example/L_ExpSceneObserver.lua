function listener(arg1 , arg2 , arg3)
    
    print("listener")
    --print("listener")
    print(arg1 , arg2 , arg3)
end

require "observer/L_MessageObserver"
local mesObserver = L_MessageObserver.New()

print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])
mesObserver["adfs1"] = mesObserver["adfs"] + listener  
mesObserver["adfs"] = mesObserver["adfs"] + listener 
mesObserver["adfs"] = mesObserver["adfs"] + listener 
mesObserver["adfs"] = mesObserver["adfs"] + listener 
mesObserver["adfs"] = mesObserver["adfs"] + listener   
print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

mesObserver:PostEvent("adfs" , 1 , 2 , 3)

print("clean")
mesObserver:Clean() 

mesObserver:PostEvent("adfs" , 1 , 2 , 3)

mesObserver["adfs"] = mesObserver["adfs"] - listener 
print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

mesObserver["adfs"] = mesObserver["adfs"] - listener 
print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

mesObserver["adfs"] = mesObserver["adfs"] - listener 
print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

mesObserver["adfs"] = mesObserver["adfs"] - listener 
print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

mesObserver["adfs"] = mesObserver["adfs"] - listener 
print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

mesObserver["adfs"] = mesObserver["adfs"] - listener 
print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])