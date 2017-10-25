﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class AppConstWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AppConst), typeof(System.Object));
		L.RegFunction("New", _CreateAppConst);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Name", get_Name, null);
		L.RegConstant("GameFrameRate", 60);
		L.RegConstant("DebugMode", 0);
		L.RegConstant("isUpdateMode", 1);
		L.RegConstant("isZip", 0);
		L.RegVar("AssetDir", get_AssetDir, set_AssetDir);
		L.RegVar("boxAssetDir", get_boxAssetDir, set_boxAssetDir);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateAppConst(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				AppConst obj = new AppConst();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: AppConst.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Name(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, AppConst.Name);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_AssetDir(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, AppConst.AssetDir);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_boxAssetDir(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, AppConst.boxAssetDir);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_AssetDir(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			AppConst.AssetDir = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_boxAssetDir(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			AppConst.boxAssetDir = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

