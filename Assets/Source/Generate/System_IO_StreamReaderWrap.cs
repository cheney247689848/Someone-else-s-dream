﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class System_IO_StreamReaderWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(System.IO.StreamReader), typeof(System.IO.TextReader));
		L.RegFunction("Close", Close);
		L.RegFunction("DiscardBufferedData", DiscardBufferedData);
		L.RegFunction("Peek", Peek);
		L.RegFunction("Read", Read);
		L.RegFunction("ReadLine", ReadLine);
		L.RegFunction("ReadToEnd", ReadToEnd);
		L.RegFunction("New", _CreateSystem_IO_StreamReader);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Null", get_Null, null);
		L.RegVar("BaseStream", get_BaseStream, null);
		L.RegVar("CurrentEncoding", get_CurrentEncoding, null);
		L.RegVar("EndOfStream", get_EndOfStream, null);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateSystem_IO_StreamReader(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 1 && TypeChecker.CheckTypes(L, 1, typeof(string)))
			{
				string arg0 = ToLua.CheckString(L, 1);
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 1 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.Stream)))
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(string), typeof(bool)))
			{
				string arg0 = ToLua.CheckString(L, 1);
				bool arg1 = LuaDLL.luaL_checkboolean(L, 2);
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0, arg1);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(string), typeof(System.Text.Encoding)))
			{
				string arg0 = ToLua.CheckString(L, 1);
				System.Text.Encoding arg1 = (System.Text.Encoding)ToLua.CheckObject(L, 2, typeof(System.Text.Encoding));
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0, arg1);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.Stream), typeof(bool)))
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				bool arg1 = LuaDLL.luaL_checkboolean(L, 2);
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0, arg1);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.Stream), typeof(System.Text.Encoding)))
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				System.Text.Encoding arg1 = (System.Text.Encoding)ToLua.CheckObject(L, 2, typeof(System.Text.Encoding));
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0, arg1);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 3 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.Stream), typeof(System.Text.Encoding), typeof(bool)))
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				System.Text.Encoding arg1 = (System.Text.Encoding)ToLua.CheckObject(L, 2, typeof(System.Text.Encoding));
				bool arg2 = LuaDLL.luaL_checkboolean(L, 3);
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0, arg1, arg2);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 3 && TypeChecker.CheckTypes(L, 1, typeof(string), typeof(System.Text.Encoding), typeof(bool)))
			{
				string arg0 = ToLua.CheckString(L, 1);
				System.Text.Encoding arg1 = (System.Text.Encoding)ToLua.CheckObject(L, 2, typeof(System.Text.Encoding));
				bool arg2 = LuaDLL.luaL_checkboolean(L, 3);
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0, arg1, arg2);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 4 && TypeChecker.CheckTypes(L, 1, typeof(string), typeof(System.Text.Encoding), typeof(bool), typeof(int)))
			{
				string arg0 = ToLua.CheckString(L, 1);
				System.Text.Encoding arg1 = (System.Text.Encoding)ToLua.CheckObject(L, 2, typeof(System.Text.Encoding));
				bool arg2 = LuaDLL.luaL_checkboolean(L, 3);
				int arg3 = (int)LuaDLL.luaL_checknumber(L, 4);
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0, arg1, arg2, arg3);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 4 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.Stream), typeof(System.Text.Encoding), typeof(bool), typeof(int)))
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				System.Text.Encoding arg1 = (System.Text.Encoding)ToLua.CheckObject(L, 2, typeof(System.Text.Encoding));
				bool arg2 = LuaDLL.luaL_checkboolean(L, 3);
				int arg3 = (int)LuaDLL.luaL_checknumber(L, 4);
				System.IO.StreamReader obj = new System.IO.StreamReader(arg0, arg1, arg2, arg3);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: System.IO.StreamReader.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Close(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.StreamReader obj = (System.IO.StreamReader)ToLua.CheckObject(L, 1, typeof(System.IO.StreamReader));
			obj.Close();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int DiscardBufferedData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.StreamReader obj = (System.IO.StreamReader)ToLua.CheckObject(L, 1, typeof(System.IO.StreamReader));
			obj.DiscardBufferedData();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Peek(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.StreamReader obj = (System.IO.StreamReader)ToLua.CheckObject(L, 1, typeof(System.IO.StreamReader));
			int o = obj.Peek();
			LuaDLL.lua_pushinteger(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Read(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 1 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.StreamReader)))
			{
				System.IO.StreamReader obj = (System.IO.StreamReader)ToLua.ToObject(L, 1);
				int o = obj.Read();
				LuaDLL.lua_pushinteger(L, o);
				return 1;
			}
			else if (count == 4 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.StreamReader), typeof(char[]), typeof(int), typeof(int)))
			{
				System.IO.StreamReader obj = (System.IO.StreamReader)ToLua.ToObject(L, 1);
				char[] arg0 = ToLua.CheckCharBuffer(L, 2);
				int arg1 = (int)LuaDLL.lua_tonumber(L, 3);
				int arg2 = (int)LuaDLL.lua_tonumber(L, 4);
				int o = obj.Read(arg0, arg1, arg2);
				LuaDLL.lua_pushinteger(L, o);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.IO.StreamReader.Read");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ReadLine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.StreamReader obj = (System.IO.StreamReader)ToLua.CheckObject(L, 1, typeof(System.IO.StreamReader));
			string o = obj.ReadLine();
			LuaDLL.lua_pushstring(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ReadToEnd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			System.IO.StreamReader obj = (System.IO.StreamReader)ToLua.CheckObject(L, 1, typeof(System.IO.StreamReader));
			string o = obj.ReadToEnd();
			LuaDLL.lua_pushstring(L, o);
			return 1;
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
			ToLua.PushObject(L, System.IO.StreamReader.Null);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_BaseStream(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			System.IO.StreamReader obj = (System.IO.StreamReader)o;
			System.IO.Stream ret = obj.BaseStream;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index BaseStream on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_CurrentEncoding(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			System.IO.StreamReader obj = (System.IO.StreamReader)o;
			System.Text.Encoding ret = obj.CurrentEncoding;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index CurrentEncoding on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_EndOfStream(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			System.IO.StreamReader obj = (System.IO.StreamReader)o;
			bool ret = obj.EndOfStream;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index EndOfStream on a nil value" : e.Message);
		}
	}
}

