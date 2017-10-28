using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;


public struct Mes
{

    public int eState;
    public PacketStream stream;
}

public class MesQueue
{

    public delegate int NetDelegateRecv(PacketStream stream);
    public NetDelegateRecv delegateRecv;
    private List<Mes> mes = new List<Mes>();

    public void MesAdd(Mes m)
    {
        mes.Add(m);
    }

    public void MesUpdateDeliver()
    {

        if (mes.Count > 0)
        {
            int eState = delegateRecv(mes[0].stream);
            if (eState == -1)
            {
                Debug.LogError("Error eState = " + eState);
            }
            mes.RemoveAt(0);
        }
    }
}

public class NetServerSystem : MonoBehaviour
{

    private NetServer clientServer;
    private MesQueue mesQueue;

    NetServerSystem() {

        clientServer = new NetServer();
        mesQueue = new MesQueue();
        //添加接收事件
        clientServer.EventRecv += new EventHandler(RecvHandlerEvent);
    }

    public void SetDelegateRecv(MesQueue.NetDelegateRecv callback) {

        mesQueue.delegateRecv = callback;
    }

    void RecvHandlerEvent(object obj, EventArgs e)
    {

        PacketStream stream = obj as PacketStream;
        Mes mes;
        mes.eState = 0;
        mes.stream = stream;
        mesQueue.MesAdd(mes);
    }

    void Update()
    {

        mesQueue.MesUpdateDeliver();
    }

    void OnApplicationQuit()
    {

        Debug.LogError("[--- 关闭链接 ---]");
        clientServer.Close();
    }
}

