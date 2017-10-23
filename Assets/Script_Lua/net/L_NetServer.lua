require "NetService"
require "NetServerSystem"
require "PacketStream"
require "L_NetInfoProcess"
module(...,package.seeall)
--网络
netSocket = nil
netInfo = L_NetInfoProcess

local LN = L_NetServer
function LN:Init(anchor)
    
    netSocket = anchor:AddComponent(typeof(NetWordBehaviour))
    netSocket.m_strAddress = "192.168.188.129" -- "内192.168.16.106"; 外"47.90.58.224"
    netSocket.m_nPort = 9001 --9001
    --设置回调函数
    netSocket:SetQueueCallBack(L_NetInfoProcess.ProcessInfo)
end