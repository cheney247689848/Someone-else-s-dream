require "PacketStream"
require "L_CmdType"
require "L_MetaPlayer"

require "L_MetaBattle"

require "observer/L_Observer"
require "observer/L_Subject"

module(...,package.seeall)
local m_Stream = nil

m_SubJect = L_Subject:New()
m_Cmd = 0
function ProcessInfo(stream)
    
    local recvType = 0
    m_Stream = stream;
    local nType = m_Stream:ReadShort()
    local nState = m_Stream:ReadShort()
    local nPlayerId = m_Stream:ReadInt()
    m_Cmd = nType

    if L_CmdType.enum.eCMD_VERSION_RES == nType then
            
        VERSION_RES_Handler(nState);

    elseif L_CmdType.enum.eCMD_ERROR_RES == nType then
        
        print("--- ERROR : 错误网络消息---")
        recvType = -1
        ERROR_RES_Handler()
    else
        
        print("--- ERROR : 未知网络消息---")
        recvType = -1
    end

    if recvType == 0 then
        
        recvType = nState
    end

    m_SubJect:NotifyObservers()
    return recvType
end

--错误返回
function ERROR_RES_Handler(nState)

    if nState == 99 then
        
        --重新链接  数据丢包
    end
end

--版本数据响应
function VERSION_RES_Handler(nState)
    
    
    L_MetaData.version = m_Stream:ReadShort()
    local bunds = m_Stream:ReadShort()
    --print(bunds)
    for v = 1, bunds , 1 do
        
        local ver = m_Stream:ReadShort()
        local size = m_Stream:ReadInt()
        local name = m_Stream:ReadString(size)
        table.insert(L_MetaData.aBundles_Ver , {ver , name})
        --print(ver.. " , " .. name)
    end
end

--登陆数据响应
function LOGIN_RES_Handler(nState)

    if nState ~= 0 then
        
        print("Error nState = "..nState)
        return;
    end

    local iUserID = m_Stream:ReadInt()
    --L_MetaPlayer.iUserID = iUserID
    --L_MetaPlayer.iLevel = m_Stream:ReadShort()
    --L_MetaPlayer.iGold = m_Stream:ReadInt()
    --L_MetaPlayer.iDiamond = m_Stream:ReadInt()
    --L_MetaPlayer.sLadderLevel = m_Stream:ReadShort()
    --
    --
    --L_MetaPlayer.vBooks[1] = m_Stream:ReadShort()
    --L_MetaPlayer.vBooks[2] = m_Stream:ReadShort()
    --L_MetaPlayer.vBooks[3] = m_Stream:ReadShort()
    --L_MetaPlayer.vBooks[4] = m_Stream:ReadShort()
    --
    --print("iUserID = "..iUserID.." iGold = "..L_MetaPlayer.iGold.. " iDiamond = "..L_MetaPlayer.iDiamond)
    --print("[ RES:登陆响应 ]")
end



