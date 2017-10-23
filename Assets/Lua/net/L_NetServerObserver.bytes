--定义模块
L_NetServerObserver = {}
setmetatable(L_NetServerObserver, {__index = _G})
local _ENV = L_NetServerObserver

--关系观察命令
nCmd = 0
function _ENV:NotifyUpdate()
    
    if L_NetInfoProcess.m_Cmd == self.nCmd then
    
        self:NotifyRelation()
    end
end

--通知相关的信息
function _ENV:NotifyRelation()

    --you need to ovrite write something
end

function _ENV:New(o)

    o = o or {}
    setmetatable(o , self)
    self.__index = self
    return o;
end
--endregion

--EXP
--设置观察者
--local loginObserver = L_NetServerObserver:New()
--loginObserver.nCmd = L_CmdType.enum.eCMD_LOGIN_RES
--function loginObserver:NotifyRelation()
--    
--    print("进入登录观察者")
--end
