﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class PathSystemWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PathSystem), typeof(System.Object));
		L.RegFunction("Init", Init);
		L.RegFunction("FindThePath", FindThePath);
		L.RegFunction("New", _CreatePathSystem);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("data", get_data, set_data);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreatePathSystem(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 2)
			{
				int arg0 = (int)LuaDLL.luaL_checknumber(L, 1);
				int arg1 = (int)LuaDLL.luaL_checknumber(L, 2);
				PathSystem obj = new PathSystem(arg0, arg1);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: PathSystem.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			PathSystem obj = (PathSystem)ToLua.CheckObject(L, 1, typeof(PathSystem));
			obj.Init();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int FindThePath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PathSystem obj = (PathSystem)ToLua.CheckObject(L, 1, typeof(PathSystem));
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			int arg1 = (int)LuaDLL.luaL_checknumber(L, 3);
			int[] o = obj.FindThePath(arg0, arg1);
			ToLua.Push(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_data(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			PathSystem obj = (PathSystem)o;
			int[] ret = obj.data;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index data on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_data(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			PathSystem obj = (PathSystem)o;
			int[] arg0 = ToLua.CheckNumberArray<int>(L, 2);
			obj.data = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index data on a nil value" : e.Message);
		}
	}
}

