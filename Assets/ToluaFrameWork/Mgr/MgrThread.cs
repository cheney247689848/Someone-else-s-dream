using System.Collections;
using System.Threading;
using System.Collections.Generic;
using System.IO;
using System.Diagnostics;
using System.Net;
using System;
using UnityEngine;

namespace ToLuaFramework {

public delegate void DelegateThreadFunc();
public delegate void DelegateThreadFuncCb();
public class ThreadEvent {
    public string Key;
    public List<object> evParams = new List<object>();
    public DelegateThreadFunc func;
    public DelegateThreadFuncCb funcCb;
}

public class NotiData {
    public string evName;
    public object evParam;

    public NotiData(string name, object param) {
        this.evName = name;
        this.evParam = param;
    }
}


    public class MgrThread{
        private Thread thread;
        private Stopwatch sw = new Stopwatch();
        static readonly object m_lockObject = new object();
        static Queue<ThreadEvent> events = new Queue<ThreadEvent>();
        delegate void ThreadSyncEvent(NotiData data);
        public MgrThread(){

            thread = new Thread(OnUpdate);
        }

        // Use this for initialization
        public void Start() {

            thread.Start();
        }

        public void Stop(){

            thread.Abort();
        }

        public void AddExecuteFun(ThreadEvent ev) {
            lock (m_lockObject) {
                events.Enqueue(ev);
            }
        }

        // Update is called once per frame
        void OnUpdate() {
            while (true) {
                lock (m_lockObject) {
                    if (events.Count > 0) {
                        ThreadEvent ev = events.Dequeue();
                        try {
                            OnProcessFunc(ev);
                        } catch (System.Exception ex) {
                            UnityEngine.Debug.LogError(ex.Message);
                        }
                    }
                }
                Thread.Sleep(1);
            }
        }

        void OnProcessFunc(ThreadEvent ev){
            
            UnityEngine.Debug.Log("OnProcessFunc");
            
            sw.Reset();
            sw.Start();
            //参数获取
            //ev.func();
            sw.Stop();
            //ev.funcCb();
            UnityEngine.Debug.Log("Thread : " + sw.ElapsedMilliseconds);
        }

        /// <summary>
        /// 应用程序退出
        /// </summary>
        void OnDestroy() {

            if (thread != null)
            {
                thread.Abort();
            }
            thread = null;
        }
    }
}