L_Father = {} --chatmgr
setmetatable(L_Father, {__index = _G})
local _this = L_Father

_this.fullName = "大牛"
_this.fristName = "陈"

function _this:FullName()
    
    print("父亲的全名 ：" .. self.fristName .. self.fullName)
end

function _this:FristName()
    
    print("父亲的姓 ：" .. self.fristName)
end

function _this:ChangeFristName(name)
    
    _this.fristName = name
end

function _this:New(o)

    o = o or {}
    setmetatable(o , self)
    self.__index = self
    return o;
end