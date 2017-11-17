using System;
using UnityEngine;
using LuaInterface;
using ToLuaFramework;
using System.Collections;
using System.Reflection;
using System.IO;
using System.Security.Cryptography;
using System.Text;
public class GameLaunch:LuaClient
{    
    LuaFunction function;

    public GameLaunch(){}

    void Start()
    {
 #if UNITY_EDITOR
        LuaFileUtils.Instance.beZip = AppConst.isZip;
#else
        LuaFileUtils.Instance.beZip = true;
#endif
        if (LuaFileUtils.Instance.beZip)
        {
            StartCoroutine("IELoading");
        }else
        {
            Init();
            GameInit();
        }
    }

    public void GameInit(){

		Application.targetFrameRate = AppConst.GameFrameRate;
        LuaState lua = LuaClient.GetMainState();
        lua.LogGC = false;
        //lua.Start();
        //LuaBinder.Bind(lua);
        lua.BeginModule(null);
        Register(lua);
        //UIEventListenerWrap.Register(lua);
        lua.EndModule();
        //DelegateFactory.dict.Add(typeof(UIEventListener.VoidDelegate), UIEventListener_OnClick);
        //DelegateFactory.dict.Add(typeof(UIEventListener.BoolDelegate), UIEventListener_OnPress);
        lua.DoFile("update/L_UpdateLocal");
        // Debug.Log(AssetsBuilder.StreamPath);
        lua["localPath"] = System.IO.Path.Combine(AssetsBuilder.StreamPath, AppConst.platform) + "/";
        lua["persPath"] = Application.persistentDataPath;
        lua["platform"] = AppConst.platform;
        function = lua.GetFunction("L_UpdateLocal.StartTest");
        function.Call();
    }

    public override void Destroy()
    {

        if (function != null)
        {
            function.Dispose();
            function = null;
        }
        base.Destroy();
        Resources.UnloadUnusedAssets();
    }

    void OnApplicationFocus(bool hasFocus){

        //Debug.LogError("OnApplicationFocus : " + hasFocus);
    }

    void OnApplicationPause(bool pauseStatus){

        //Debug.LogError("OnApplicationPause : " + pauseStatus);
    }

    public void LoadBundleBack(AssetBundle bundle){

        LuaFileUtils.Instance.AddSearchBundle(bundle.name, bundle);
    }
    IEnumerator IELoading(){
        Debug.Log("IELoading Loading ... ... ");
        string[] loadList = new String[10]{

            "tolua" , 
            "tolua_cjson" , 
            "tolua_lpeg" , 
            "tolua_misc" , 
            "tolua_protobuf" , 
            "tolua_socket" , 
            "tolua_system" , 
            "tolua_system_reflection" , 
            "tolua_unityengine",
            "lua_update"
        };
        AssetsBuilder builder = this.gameObject.AddComponent<AssetsBuilder>();
        for (int i = 0; i < loadList.Length; i++)
        {
            var path = System.IO.Path.Combine(AppConst.luaBoxPath , loadList[i]);
            if (!CacheTool.IsFile(path))
            {
                path = System.IO.Path.Combine(AppConst.luaPath , loadList[i]);
            }
            builder.LoadBundle(path , LoadBundleBack);
            do
            {
                yield return new WaitForEndOfFrame();
            } while (builder.isLoading);
        }
        Debug.Log("IELoading LoadFinsh");   

        Init();
        GameInit();
    }


    //OnClick
    //class UIEventListener_OnClick_Event : LuaDelegate
    //{
    //    public UIEventListener_OnClick_Event(LuaFunction func) : base(func) { }
    //
    //    public void Call(UnityEngine.GameObject param0)
    //    {
    //        func.BeginPCall();
    //        func.Push(param0);
    //        func.PCall();
    //        func.EndPCall();
    //    }
    //}
    //
    //public static Delegate UIEventListener_OnClick(LuaFunction func, LuaTable self, bool flag)
    //{
    //    if (func == null)
    //    {
    //        UIEventListener.VoidDelegate fn = delegate { };
    //        return fn;
    //    }
    //
    //    UIEventListener.VoidDelegate d = (new UIEventListener_OnClick_Event(func)).Call;
    //    return d;
    //}
    //
    ////OnPress
    //class UIEventListener_OnPress_Event : LuaDelegate
    //{
    //    public UIEventListener_OnPress_Event(LuaFunction func) : base(func) { }
    //
    //    public void Call(UnityEngine.GameObject param0, bool param1)
    //    {
    //        func.BeginPCall();
    //        func.Push(param0);
    //        func.Push(param1);
    //        func.PCall();
    //        func.EndPCall();
    //    }
    //}
    //
    //public static Delegate UIEventListener_OnPress(LuaFunction func, LuaTable self, bool flag)
    //{
    //    if (func == null)
    //    {
    //        UIEventListener.BoolDelegate fn = delegate { };
    //        return fn;
    //    }
    //
    //    UIEventListener.BoolDelegate d = (new UIEventListener_OnPress_Event(func)).Call;
    //    return d;
    //}

    public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GameLaunch), typeof(System.Object));
		L.RegFunction("StartThread", StartThread);
		L.RegFunction("CloseThread", CloseThread);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int StartThread(IntPtr L)
	{
		try
		{
            int count = LuaDLL.lua_gettop(L);
			// ToLua.CheckArgsCount(L, 3);
			string func = ToLua.CheckString(L, 1);
            object[] arg = ToLua.ToParamsObject(L, 2, count - 1);
            MgrLuaThread thread = new MgrLuaThread(GetMainState());
            thread.Start(func , arg);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	static int CloseThread(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
            MgrLuaThread thread = (MgrLuaThread)ToLua.CheckObject(L, 1, typeof(MgrLuaThread));
            thread.Close();
            thread = null;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

