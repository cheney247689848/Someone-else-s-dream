--require "update/L_UpdateStrategy"
--require "core/L_ByteStream"
local GameObject = UnityEngine.GameObject
-- require "example/L_ExpTextScene"
require "L_GameInputMes"
require "bundle/L_Bundle"
require "proxyScene/L_ProxyScene"
require "scene/L_SceneLogin"
function Launch()

    print("Launch")
    --配置加载信息
    L_Bundle.localPath = localPath
    L_Bundle.persPath = persPath
    L_Bundle.platform = platform
    -- print(L_Bundle.streamPath)
    L_Bundle:InitMainifest(platform)

    --init bundle
    --L_Bundle.streamPath = localPath
    --print("streamPath : " .. L_Bundle.streamPath)
    --print("PersistentPath : " .. persPath)
    ----print(L_ProxyScene.anchor)
    --L_NetServer:Init(L_ProxyScene.anchor)
    --L_ProxyScene.ChangeView(L_SceneLogin)

    --L_UpdateStrategy.localPath = localPath
    --L_UpdateStrategy.persPath = persPath
    
    --L_ExpTextScene:Init()

    -- require("example/L_ExpBundleScene")
    -- L_ExpBundleScene:Init()

    -- require ("three/Three")
    -- local three = L_Three:New({["abc"] = 123})
    -- three:AddBranch(three.trunk)
    -- print("res = " .. three.trunk[1].abc)

    L_ProxyScene:ChangeScene(L_SceneLogin)

    -- require "other/L_ReadOnly"
    -- require "table/L_TestTable"


    -- f = 4  
    -- function a()  
    --     f = 3  
    --     print(getfenv(0).f, getfenv(1).f, getfenv(2).f, getfenv(3).f)  
    -- end  
    -- A = {}  
    -- setmetatable(A, {__index = _G})  
    -- setfenv(a, A)  
    
    -- function b()  
    --     f = 2  
    --     A.a()  
    -- end  
    -- B = {}  
    -- setmetatable(B, {__index = _G})  
    -- setfenv(b, B)  
    
    -- function c()  
    --     f = 1  
    --     B.b()  
    -- end  
    -- C = {}  
    -- setmetatable(C, {__index = _G})  
    -- setfenv(c, C)  
    -- c()  

end

-- observer = {}
-- function New(c)
--     local parents = {}
--     setmetatable(c , {__index = function(t , k)
--     return Search(k , parents)
--     end})
--     c.__index = c
--     return c
-- end

-- function Search(k , plist)

--     print("Search")
--     for i = 1, #plist do
--         print(i)
--         local v = plist[i][k]
--         if v then return v end
--     end
--     return {}
-- end

-- New(observer)

-- observer[type] = observer[type] + listener  --添加侦听
-- observer[type] = observer[type] - listener  --移除侦听

-- function listener(arg1 , arg2 , arg3)
    
--     print("listener")
--     --print("listener")
--     print(arg1 , arg2 , arg3)
-- end

-- require "observer/L_MessageObserver"

-- local mesObserver = L_MessageObserver.New()

-- print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])
-- mesObserver["adfs"] = mesObserver["adfs"] + listener  
-- mesObserver["adfs"] = mesObserver["adfs"] + listener 
-- mesObserver["adfs"] = mesObserver["adfs"] + listener 
-- mesObserver["adfs"] = mesObserver["adfs"] + listener 
-- mesObserver["adfs"] = mesObserver["adfs"] + listener   
-- print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

-- mesObserver:PostEvent("adfs" , 1 , 2 , 3)

-- print("clean")
-- mesObserver:Clean() 

-- mesObserver:PostEvent("adfs" , 1 , 2 , 3)

-- mesObserver["adfs"] = mesObserver["adfs"] - listener 
-- print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

-- mesObserver["adfs"] = mesObserver["adfs"] - listener 
-- print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

-- mesObserver["adfs"] = mesObserver["adfs"] - listener 
-- print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

-- mesObserver["adfs"] = mesObserver["adfs"] - listener 
-- print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

-- mesObserver["adfs"] = mesObserver["adfs"] - listener 
-- print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

-- mesObserver["adfs"] = mesObserver["adfs"] - listener 
-- print("value - " , mesObserver["adfs"] , #mesObserver["adfs"])

-- Set = {}
-- mt = {} --元表
 
-- function Set.new(l)
--     local set = {}
--     setmetatable(set, mt)
--     return set
-- end

-- function Set.union(a, b)
-- --[[    if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
--         error("attemp to 'add' a set with a non-set value", 2)   --error第二个参数的含义P116
--     end]]
--     local res = Set.new{}
--     return 0
-- end
-- s1 = Set.new{10, 20, 30, 50}
-- s2 = Set.new{30, 1}

-- mt.__add = Set.union

-- s3 = s1 + s2
-- print(s3)

-- mt = {}
-- ccc = {}
-- setmetatable(ccc, mt)
-- function ccc.AddListener(type , listener)
    
--     print("AddListener")
--     print(tostring(type))
--     print(tostring(listener))
--     return 0
-- end
-- mt.__add = function ( a , b )
    
--     return 1
-- end


-- local aaa = {1}
-- setmetatable(aaa, mt)


-- local bbb = {2}
-- setmetatable(bbb, mt)

-- print(getmetatable(aaa))
-- print(getmetatable(bbb))
-- function AAA()
    
-- end
-- local value = aaa + AAA
-- print(value)


