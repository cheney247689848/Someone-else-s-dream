﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class System_IO_TextWriterWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(System.IO.TextWriter), typeof(System.MarshalByRefObject));
		L.RegFunction("Close", Close);
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("Flush", Flush);
		L.RegFunction("Synchronized", Synchronized);
		L.RegFunction("Write", Write);
		L.RegFunction("WriteLine", WriteLine);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Null", get_Null, null);
		L.RegVar("Encoding", get_Encoding, null);
		L.RegVar("FormatProvider", get_FormatProvider, null);
		L.RegVar("NewLine", get_NewLine, set_NewLine);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Close(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.CheckObject(L, 1, typeof(System.IO.TextWriter));
			obj.Close();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Dispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.CheckObject(L, 1, typeof(System.IO.TextWriter));
			obj.Dispose();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Flush(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.CheckObject(L, 1, typeof(System.IO.TextWriter));
			obj.Flush();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Synchronized(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.TextWriter arg0 = (System.IO.TextWriter)ToLua.CheckObject(L, 1, typeof(System.IO.TextWriter));
			System.IO.TextWriter o = System.IO.TextWriter.Synchronized(arg0);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Write(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(double)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				double arg0 = (double)LuaDLL.lua_tonumber(L, 2);
				obj.Write(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				obj.Write(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(bool)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				bool arg0 = LuaDLL.lua_toboolean(L, 2);
				obj.Write(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(char[])))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				char[] arg0 = ToLua.CheckCharBuffer(L, 2);
				obj.Write(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(object)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				object arg0 = ToLua.ToVarObject(L, 2);
				obj.Write(arg0);
				return 0;
			}
			else if (count == 3 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string), typeof(object)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				object arg1 = ToLua.ToVarObject(L, 3);
				obj.Write(arg0, arg1);
				return 0;
			}
			else if (count == 4 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(char[]), typeof(int), typeof(int)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				char[] arg0 = ToLua.CheckCharBuffer(L, 2);
				int arg1 = (int)LuaDLL.lua_tonumber(L, 3);
				int arg2 = (int)LuaDLL.lua_tonumber(L, 4);
				obj.Write(arg0, arg1, arg2);
				return 0;
			}
			else if (count == 4 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string), typeof(object), typeof(object)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				object arg1 = ToLua.ToVarObject(L, 3);
				object arg2 = ToLua.ToVarObject(L, 4);
				obj.Write(arg0, arg1, arg2);
				return 0;
			}
			else if (count == 5 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string), typeof(object), typeof(object), typeof(object)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				object arg1 = ToLua.ToVarObject(L, 3);
				object arg2 = ToLua.ToVarObject(L, 4);
				object arg3 = ToLua.ToVarObject(L, 5);
				obj.Write(arg0, arg1, arg2, arg3);
				return 0;
			}
			else if (TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string)) && TypeChecker.CheckParamsType(L, typeof(object), 3, count - 2))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				object[] arg1 = ToLua.ToParamsObject(L, 3, count - 2);
				obj.Write(arg0, arg1);
				return 0;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.IO.TextWriter.Write");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int WriteLine(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 1 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				obj.WriteLine();
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(double)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				double arg0 = (double)LuaDLL.lua_tonumber(L, 2);
				obj.WriteLine(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				obj.WriteLine(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(bool)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				bool arg0 = LuaDLL.lua_toboolean(L, 2);
				obj.WriteLine(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(char[])))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				char[] arg0 = ToLua.CheckCharBuffer(L, 2);
				obj.WriteLine(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(object)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				object arg0 = ToLua.ToVarObject(L, 2);
				obj.WriteLine(arg0);
				return 0;
			}
			else if (count == 3 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string), typeof(object)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				object arg1 = ToLua.ToVarObject(L, 3);
				obj.WriteLine(arg0, arg1);
				return 0;
			}
			else if (count == 4 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(char[]), typeof(int), typeof(int)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				char[] arg0 = ToLua.CheckCharBuffer(L, 2);
				int arg1 = (int)LuaDLL.lua_tonumber(L, 3);
				int arg2 = (int)LuaDLL.lua_tonumber(L, 4);
				obj.WriteLine(arg0, arg1, arg2);
				return 0;
			}
			else if (count == 4 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string), typeof(object), typeof(object)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				object arg1 = ToLua.ToVarObject(L, 3);
				object arg2 = ToLua.ToVarObject(L, 4);
				obj.WriteLine(arg0, arg1, arg2);
				return 0;
			}
			else if (count == 5 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string), typeof(object), typeof(object), typeof(object)))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				object arg1 = ToLua.ToVarObject(L, 3);
				object arg2 = ToLua.ToVarObject(L, 4);
				object arg3 = ToLua.ToVarObject(L, 5);
				obj.WriteLine(arg0, arg1, arg2, arg3);
				return 0;
			}
			else if (TypeChecker.CheckTypes(L, 1, typeof(System.IO.TextWriter), typeof(string)) && TypeChecker.CheckParamsType(L, typeof(object), 3, count - 2))
			{
				System.IO.TextWriter obj = (System.IO.TextWriter)ToLua.ToObject(L, 1);
				string arg0 = ToLua.ToString(L, 2);
				object[] arg1 = ToLua.ToParamsObject(L, 3, count - 2);
				obj.WriteLine(arg0, arg1);
				return 0;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.IO.TextWriter.WriteLine");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Null(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, System.IO.TextWriter.Null);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Encoding(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			System.IO.TextWriter obj = (System.IO.TextWriter)o;
			System.Text.Encoding ret = obj.Encoding;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index Encoding on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_FormatProvider(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			System.IO.TextWriter obj = (System.IO.TextWriter)o;
			System.IFormatProvider ret = obj.FormatProvider;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index FormatProvider on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_NewLine(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			System.IO.TextWriter obj = (System.IO.TextWriter)o;
			string ret = obj.NewLine;
			LuaDLL.lua_pushstring(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index NewLine on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_NewLine(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			System.IO.TextWriter obj = (System.IO.TextWriter)o;
			string arg0 = ToLua.CheckString(L, 2);
			obj.NewLine = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index NewLine on a nil value" : e.Message);
		}
	}
}

