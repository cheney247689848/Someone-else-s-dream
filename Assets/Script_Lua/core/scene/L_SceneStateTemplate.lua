require "core/state/L_State"
L_SceneStateTemplate = {}
local _this = L_SceneStateTemplate

_this.stateNone = L_State:New({} , nil)
_this.stateLayout = L_State:New({} , nil)
_this.stateProgress = L_State:New({} , nil)

--==============================--
--desc: ------state for none------
--time:2017-07-21 11:19:29
--@return 
--==============================--
function _EVN.stateNone:Enter()
    print("------进入None状态------")
end

function _EVN.stateNone:Execute(nTime)
    
end

function _EVN.stateNone:Exit()
   print("------退出None状态------")
end

--==============================--
--desc:------state for layout------
--time:2017-07-21 11:20:09
--@return 
--==============================--
function _EVN.stateLayout:Enter()
    print("------进入Layout状态------")
end

function _EVN.stateLayout:Execute(nTime)

end

function _EVN.stateLayout:Exit()
   print("------退出Layout状态------")
end

--==============================--
--desc:------state for process------
--time:2017-07-21 11:20:16
--@return 
--==============================--
function _EVN.stateProgress:Enter()
    print("------进入progress状态------")
end

function _EVN.stateProgress:Execute(nTime)  
    if self.m_nTick == 0 then
        
        print("progress state")
        self.m_nTick = 1
    end
end

function _EVN.stateProgress:Exit()
   print("------退出progress状态------")
end