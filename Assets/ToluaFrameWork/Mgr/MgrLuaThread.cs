
/*
  The Long night
  The night gives me black eyes, but I use it to find the light. 
  The sprite write in 2017
*/
using UnityEngine;
using System;
using LuaInterface;
public class MgrLuaThread{

    LuaState state = null;
    LuaThread thread = null;
    public MgrLuaThread(LuaState s){

        state = s;
    }

    public void Start(string strFunc , params object[] args){

        LuaFunction func = state.GetFunction(strFunc);
        func.BeginPCall();
        func.PCall();
        thread = func.CheckLuaThread();
        thread.name = "LuaThread";
        func.EndPCall();
        func.Dispose();
        func = null;
        thread.Resume(args);
    }

    public void Close(){

        if (thread != null)
        {
            thread.Dispose();
            thread = null;
        }
        state = null; //释放对state引用
    }

    public void OnUpdate(){

        state.CheckTop();
        state.Collect();
    }
}