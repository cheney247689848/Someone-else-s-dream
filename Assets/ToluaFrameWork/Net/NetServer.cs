using System;
using System.Net;
using System.Net.Sockets;
using UnityEngine;

//会话编号
public class SessionId
{
    public int nUserId;
    public int nTickTime;
    public short nSequence;
    public short nRand;

    public SessionId()
    {
        Clear();
    }

    public void Clear()
    {
        nUserId = 0;
        nTickTime = 0;
        nSequence = 0;
        nRand = 0;
    }
}

public class NetServer
{

    public const int MAX_BYTE = 1024;

    //Socket
    private Socket clientSocket;
    //标识是否已经释放
    private bool isDispose;
    //会话编号
    private SessionId m_SessionId;

    public NetServer()
    {

        m_SessionId = new SessionId();
    }
    public SessionId Session { get { return m_SessionId; } }

    //接收数据事件
    public event EventHandler EventRecv;
    public void Connect(string address, int port)
    {
        Debug.Log(string.Format("****** connet scoket address = {0}  port = {1}", address, port));
        IPEndPoint ip = new IPEndPoint(IPAddress.Parse(address), port);
        AddressFamily addFamily = AddressFamily.InterNetwork;
        clientSocket = new Socket(addFamily, SocketType.Stream, ProtocolType.Tcp);
        try
        {
            //建立异步链接
            clientSocket.BeginConnect(ip, new System.AsyncCallback(ConnectionCallback), clientSocket);

        }
        catch (Exception ex)
        {
            Debug.LogError(ex.ToString());
        }
    }

    //关闭链接
    public void Close()
    {
        if (null != clientSocket)
        {
            isDispose = true;
            //clientSocket.Shutdown(SocketShutdown.Both);//缓存中的数据全部发送成功后才会返回
            //clientSocket.Disconnect(true);
            clientSocket.Close();
            clientSocket = null;
        }
    }

    //连接回调函数
    private void ConnectionCallback(System.IAsyncResult ar)
    {

        Debug.Log("****** 连接回调响应");
        try
        {
            clientSocket.EndConnect(ar);
            SetReceiveAsyns();
            Debug.Log("****** 连接成功 ");
        }
        catch (System.Exception e)
        {
            throw new Exception(string.Format("****** 连接失败 : {0} ", e.ToString()));
        }
    }

    public void Send(PacketStream stream)
    {
        if (!clientSocket.Connected) {

            throw new Exception("链接异常");
        }
        clientSocket.BeginSend(stream.m_Buffer, 0, stream.m_nCount, 0, new AsyncCallback(SendCallback), clientSocket);
    }

    private void SendCallback(IAsyncResult ar)
    {
        try
        {   
            Socket client = (Socket)ar.AsyncState;    
            int bytesSent = client.EndSend(ar);
            DebugSer.Log(string.Format("Sent {0} bytes to server.", bytesSent));
        }
        catch (Exception e)
        {
            throw new Exception(string.Format(" * *****发送失败 : { 0 } ", e.ToString()));
        }
    }


    //接收数据回调
    private void ReceiveCallback(System.IAsyncResult ar)
    {
        DebugSer.Log("******数据回调响应");
        try
        {
            PacketStream recvCache = (PacketStream)ar.AsyncState;
            int nCount = clientSocket.EndReceive(ar);
            if (nCount > 0)
            {
                recvCache.m_nCount = (int)recvCache.ReadShort();
                DebugSer.Log(string.Format("******收到数据: {0} packageCount = {1}", nCount, recvCache.m_nCount));

                if (nCount < recvCache.m_nCount)
                {
                    Debug.LogError("******数据丢包");
                }
                else
                {
                    DebugSer.Log("******接收数据成功");
                    EventRecv.Invoke(recvCache, new EventArgs());
                    SetReceiveAsyns();
                }
            }
            ar.AsyncWaitHandle.Close();
        }
        catch (System.Exception e)
        {
            throw new Exception(string.Format("******接收数据失败:{0}", e.ToString()));
        }
    }
 
    public void SetReceiveAsyns()
    {

        PacketStream stream = new PacketStream(MAX_BYTE);
        clientSocket.BeginReceive(stream.m_Buffer,
            stream.m_nHead + stream.m_nCount,
            stream.m_nMax,
            SocketFlags.None,
            new AsyncCallback(this.ReceiveCallback),
            stream);
    }
}

public class DebugSer
{

    static public bool bIsDebug = false;
    static public void Log(string str)
    {

        if (!bIsDebug) return;
        Debug.Log(str);
    }

    static public void LogError(string str)
    {
        if (!bIsDebug) return;
        Debug.LogError(str);
    }
}