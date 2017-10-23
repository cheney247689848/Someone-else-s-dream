-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------
L_Subject = {}
setmetatable(L_Subject, {__index = _G})
local _this = L_Subject

L_Subject.obsVector = {}
--添加观察者
function _this:AddObserver(observer)
    
    table.insert(self.obsVector , observer)
end

--删除观察者
function _this:DelObserver(observer)
    
    for i = 1, #self.obsVector , 1 do
        
        if self.obsVector[i] == observer then
            
            table.remove(self.obsVector , i)
            return
        end
    end
end

--通知所有观察者
function _this:NotifyObservers(observer)

    for i = 1, #self.obsVector , 1 do

        self.obsVector[i]:NotifyUpdate()
    end
end

function _this.New()

    o = {}
    setmetatable(o , _this)
    _this.__index = _this
    return o;
end
