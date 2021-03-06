﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class ZipToolWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ZipTool), typeof(UnityEngine.MonoBehaviour));
		L.RegFunction("UnPackage", UnPackage);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("zipCall", get_zipCall, set_zipCall);
		L.RegVar("unPackageByteCount", get_unPackageByteCount, null);
		L.RegVar("unPackageCount", get_unPackageCount, null);
		L.RegFunction("DelegateZipCall", ZipTool_DelegateZipCall);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int UnPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			ZipTool obj = (ZipTool)ToLua.CheckObject(L, 1, typeof(ZipTool));
			string arg0 = ToLua.CheckString(L, 2);
			string arg1 = ToLua.CheckString(L, 3);
			ZipTool.DelegateZipCall arg2 = null;
			LuaTypes funcType4 = LuaDLL.lua_type(L, 4);

			if (funcType4 != LuaTypes.LUA_TFUNCTION)
			{
				 arg2 = (ZipTool.DelegateZipCall)ToLua.CheckObject(L, 4, typeof(ZipTool.DelegateZipCall));
			}
			else
			{
				LuaFunction func = ToLua.ToLuaFunction(L, 4);
				arg2 = DelegateFactory.CreateDelegate(typeof(ZipTool.DelegateZipCall), func) as ZipTool.DelegateZipCall;
			}

			obj.UnPackage(arg0, arg1, arg2);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object arg0 = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object arg1 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool o = arg0 == arg1;
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_zipCall(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ZipTool obj = (ZipTool)o;
			ZipTool.DelegateZipCall ret = obj.zipCall;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index zipCall on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_unPackageByteCount(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ZipTool obj = (ZipTool)o;
			int ret = obj.unPackageByteCount;
			LuaDLL.lua_pushinteger(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index unPackageByteCount on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_unPackageCount(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ZipTool obj = (ZipTool)o;
			int ret = obj.unPackageCount;
			LuaDLL.lua_pushinteger(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index unPackageCount on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_zipCall(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ZipTool obj = (ZipTool)o;
			ZipTool.DelegateZipCall arg0 = null;
			LuaTypes funcType2 = LuaDLL.lua_type(L, 2);

			if (funcType2 != LuaTypes.LUA_TFUNCTION)
			{
				 arg0 = (ZipTool.DelegateZipCall)ToLua.CheckObject(L, 2, typeof(ZipTool.DelegateZipCall));
			}
			else
			{
				LuaFunction func = ToLua.ToLuaFunction(L, 2);
				arg0 = DelegateFactory.CreateDelegate(typeof(ZipTool.DelegateZipCall), func) as ZipTool.DelegateZipCall;
			}

			obj.zipCall = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index zipCall on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ZipTool_DelegateZipCall(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);

			if (count == 1)
			{
				Delegate arg1 = DelegateFactory.CreateDelegate(typeof(ZipTool.DelegateZipCall), func);
				ToLua.Push(L, arg1);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate arg1 = DelegateFactory.CreateDelegate(typeof(ZipTool.DelegateZipCall), func, self);
				ToLua.Push(L, arg1);
			}
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

