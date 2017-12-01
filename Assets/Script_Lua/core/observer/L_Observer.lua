-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
L_Observer = {}
setmetatable(L_Observer, {__index = _G})
local _this = L_Observer

function _this:NotifyUpdate()
    
    --write something there
    print("You need overwrite function NotifyUpdate to make your messages send success . ")
end

function _this.New(o)

    o = o or {}
    setmetatable(o , {__index = function (t , k)
        o[k] = {}
        setmetatable(o[k] , L_Mt)
        return o[k]
    end})
    _this.__index = _this
    return o;
end

L_Mt = {}
L_Mt.__add = function ( a , b )
    
    if b == nil then
        print(error("error func = nil"))
        return nil
    end

    for i,v in ipairs(a) do
        if v == b then
            print(error("error b is contan!"))
            return nil
        end
    end

    table.insert( a, b)
    return a
end

L_Mt.__sub = function ( a , b )
    
    if b == nil then
        print(error("error func = nil"))
        return nil
    end
    for i = #a , 0 , -1 do
        if a[i] == b then
            -- print(i)
            table.remove( a, i )
            break
        end
    end
    return a
end