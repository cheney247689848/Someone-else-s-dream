using UnityEngine;
using System.Collections.Generic;
using LuaInterface;
using System.Collections;
using System.IO;
using System;
#if UNITY_5
using UnityEngine.SceneManagement;
#endif

public class LuaCom : MonoBehaviour
{
	public static LuaCom Instance
	{
		get;
		protected set;
	}

	protected LuaState luaState = null;
	protected LuaLooper loop = null;
	protected LuaFunction levelLoaded = null;

	protected bool openLuaSocket = false;
	protected bool beZbStart = false;

	public LuaState mLua{

		get{ return luaState;}
	}

	protected virtual LuaFileUtils InitLoader()
	{
		return new LuaResLoader();
	}

	protected virtual void LoadLuaFiles()
	{
		OnLoadFinished();
	}

	protected virtual void OpenLibs()
	{
		luaState.OpenLibs(LuaDLL.luaopen_pb);
		luaState.OpenLibs(LuaDLL.luaopen_struct);
		luaState.OpenLibs(LuaDLL.luaopen_lpeg);
		#if UNITY_STANDALONE_OSX || UNITY_EDITOR_OSX
		luaState.OpenLibs(LuaDLL.luaopen_bit);
		#endif    

		// if (LuaConst.openZbsDebugger)
		// {
		// 	OpenZbsDebugger();
		// }
	}

	public void OpenZbsDebugger(string ip = "localhost")
	{
		if (!Directory.Exists(LuaConst.zbsDir))
		{
			Debugger.LogWarning("ZeroBraneStudio not install or LuaConst.zbsDir not right");
			return;
		}

		if (!string.IsNullOrEmpty(LuaConst.zbsDir))
		{
			luaState.AddSearchPath(LuaConst.zbsDir);
		}

		luaState.LuaDoString(string.Format("DebugServerIp = '{0}'", ip));
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int LuaOpen_Mime_Core(IntPtr L)
	{
		return LuaDLL.luaopen_mime_core(L);
	}

	protected void StartLooper()
	{
		loop = gameObject.AddComponent<LuaLooper>();
		loop.luaState = luaState;
	}

	protected virtual void Bind()
	{        
		LuaBinder.Bind(luaState);
		LuaCoroutine.Register(luaState, this);
	}

	protected void Init()
	{        
		InitLoader();
		luaState = new LuaState();
		OpenLibs();
		luaState.LuaSetTop(0);
		Bind();
		LoadLuaFiles();    
	}

	protected void Awake()
	{
		Instance = this;
		Init();

		#if UNITY_5_4
		SceneManager.sceneLoaded += OnSceneLoaded;
		#endif        
	}

	protected virtual void OnLoadFinished()
	{
		luaState.Start();
		StartLooper();
	}

	void OnLevelLoaded(int level)
	{
		if (levelLoaded != null)
		{
			levelLoaded.BeginPCall();
			levelLoaded.Push(level);
			levelLoaded.PCall();
			levelLoaded.EndPCall();
		}

		if (luaState != null)
		{
			//luaState.LuaGC(LuaGCOptions.LUA_GCCOLLECT);
			luaState.RefreshDelegateMap();
		}
	}

	#if UNITY_5_4
	void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
	OnLevelLoaded(scene.buildIndex);
	}
	#else
	protected void OnLevelWasLoaded(int level)
	{
		OnLevelLoaded(level);
	}
	#endif

	public virtual void Destroy()
	{
		if (luaState != null)
		{
			#if UNITY_5_4
			SceneManager.sceneLoaded -= OnSceneLoaded;
			#endif    
			LuaState state = luaState;
			luaState = null;

			if (levelLoaded != null)
			{
				levelLoaded.Dispose();
				levelLoaded = null;
			}

			if (loop != null)
			{
				loop.Destroy();
				loop = null;
			}

			state.Dispose();            
			Instance = null;
		}
	}

	protected void OnDestroy()
	{
		//Destroy();
	}

	protected void OnApplicationQuit()
	{
		//Destroy();
	}

	public LuaLooper GetLooper()
	{
		return loop;
	}
}

