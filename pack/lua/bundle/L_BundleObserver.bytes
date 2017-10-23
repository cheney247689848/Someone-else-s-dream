-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------

require("observer/L_Observer")

L_BundleObserver = {}
setmetatable(L_BundleObserver, {__index = _G})
local _this = L_BundleObserver

_this.tListeners = {}
_this.tPostEvents = {}
_this.lId = 0

function _this:PostEvent(lType)

    table.insert( tPostEvents,  lType)
end

--==============================--
--desc:  只执行一次后移除事件
--time:2017-09-11 11:44:28
--@lType:
--@listener:
--@return 返回 listener id
--==============================--
function _this:AddListener(lType , listener)
    
    self.lId = self.lId + 1
    local struct = {["id"] = self.lId , ["type"] =  lType , ["listener"] = listener}
    table.insert( self.tListeners, structListener)
    return id
end

--==============================--
--desc:  删除id 下对应的事件
--time:2017-09-11 11:48:03
--@id:
--@return 
--==============================--
function _this.DelListerner(id)
    
    for i = #self.tListeners, 1 do
        if id == self.tListeners[i].id then
            table.remove( self.tListeners, i )
        end
    end
end

--==============================--
--desc: 清除所有事件
--time:2017-09-11 11:45:37
--@return 
--==============================--
function _this.Clean()
    
    self.tListeners = nil
    self.tListeners = {}
end

function _this:NotifyUpdate()
    
    --write the mes 
    for i = #self.tListeners, 1 do
        

    end
end