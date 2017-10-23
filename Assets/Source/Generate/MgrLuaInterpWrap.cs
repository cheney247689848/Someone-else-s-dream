﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class MgrLuaInterpWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MgrLuaInterp), typeof(System.Object));
		L.RegFunction("GetLuaFileUtils", GetLuaFileUtils);
		L.RegFunction("AddSearchBundle", AddSearchBundle);
		L.RegFunction("GetLuaAssets", GetLuaAssets);
		L.RegFunction("New", _CreateMgrLuaInterp);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("luaFileUtils", get_luaFileUtils, set_luaFileUtils);
		L.RegVar("assetsMap", get_assetsMap, set_assetsMap);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateMgrLuaInterp(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 1)
			{
				LuaInterface.LuaFileUtils arg0 = (LuaInterface.LuaFileUtils)ToLua.CheckObject(L, 1, typeof(LuaInterface.LuaFileUtils));
				MgrLuaInterp obj = new MgrLuaInterp(arg0);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: MgrLuaInterp.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetLuaFileUtils(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaInterface.LuaFileUtils o = MgrLuaInterp.GetLuaFileUtils();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int AddSearchBundle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string arg0 = ToLua.CheckString(L, 1);
			UnityEngine.AssetBundle arg1 = (UnityEngine.AssetBundle)ToLua.CheckUnityObject(L, 2, typeof(UnityEngine.AssetBundle));
			MgrLuaInterp.AddSearchBundle(arg0, arg1);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetLuaAssets(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string arg0 = ToLua.CheckString(L, 1);
			LuaAssets o = MgrLuaInterp.GetLuaAssets(arg0);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_luaFileUtils(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, MgrLuaInterp.luaFileUtils);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_assetsMap(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, MgrLuaInterp.assetsMap);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_luaFileUtils(IntPtr L)
	{
		try
		{
			LuaInterface.LuaFileUtils arg0 = (LuaInterface.LuaFileUtils)ToLua.CheckObject(L, 2, typeof(LuaInterface.LuaFileUtils));
			MgrLuaInterp.luaFileUtils = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_assetsMap(IntPtr L)
	{
		try
		{
			System.Collections.Generic.Dictionary<string,LuaAssets> arg0 = (System.Collections.Generic.Dictionary<string,LuaAssets>)ToLua.CheckObject(L, 2, typeof(System.Collections.Generic.Dictionary<string,LuaAssets>));
			MgrLuaInterp.assetsMap = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

