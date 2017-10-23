local BitConverter = require "System.BitConverter"
local Byte = require "System.Byte"

--定义模块
L_ByteStream = {}
setmetatable(L_ByteStream, {__index = _G})
local _ENV = L_ByteStream

function _ENV:Creat(max)
    
    local b = {}
    setmetatable(b , self)
    self.__index = self
    b.nMax = max
    return b
end

buffer = {}
nCount = 0
nMax = 0
nReadPos = 0
nWritePos = 0
nHead = 10

function _ENV:WriteBegin()

    for i = 1,self.nMax + 1, 1 do
        
        self.buffer[i] = 0
    end
    self.nWritePos = nHead
end

function _ENV:WriteEnd()
    
    
end

function _ENV:WriteInt(__arg)

    if self.nWritePos + 4 > self.nMax then
        
        print("Error ByteStream : WriteInt Is Out Of Line")
        return
    end
    local bit = BitConverter.GetBytes(__arg)
    for i = 1,4, 1 do
        
        self.buffer[i + self.nWritePos] = bit[i]
    end
    self.nWritePos = self.nWritePos + 4
end

function _ENV:WriteUInt(__arg)

    
end

function _ENV:WriteShort(__arg)

    
end

function _ENV:WriteFloat(__arg)

    
end

function _ENV:WriteString(__arg)

    
end

function _ENV:ReadBegin()
    
    self.nReadPos = self.nHead
end

function _ENV:ReadInt()

    if self.nReadPos + 4 > self.nMax then
        
        print("Error ByteStream : ReadInt Is Out Of Line")
        return
    end

    local n = BitConverter.ToInt32(self.buffer,0);
    return n
end