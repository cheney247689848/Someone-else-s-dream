-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
require("core/observer/L_Observer")

L_MessageObserver = {}
setmetatable(L_MessageObserver, {__index = _G})
local _this = L_MessageObserver

_this.notifyer = nil
function _this.New(o)
    
    local observer = L_Observer.New(o)
    --==============================--
    --desc: 发送事件  type 事件的类型
    --time:2017-09-11 11:45:37
    --@return 
    --==============================--
    function observer:PostEvent(lType, ...)

        self:NotifyUpdate(lType, ...)
    end

    --==============================--
    --desc:  通知所有
    --time:2017-10-13 11:02:28
    --@lType:
    --@args:
    --@return 
    --==============================--
    function observer:NotifyUpdate(lType, ...)
        --write the mes 
        --print(string.format( "notify len = %d ", #_this[lType] ))
        for i,v in ipairs(observer[lType]) do
            v(...)
        end
    end

    --==============================--
    --desc: 清除所有事件
    --time:2017-09-11 11:45:37
    --@return 
    --==============================--
    function observer:Clean()

        for i, v in pairs(observer) do  
            --print(i , v, type(v)) 
            if type(v) == "table" then
                observer[i] = nil
            end
        end 
    end
    return observer
end



