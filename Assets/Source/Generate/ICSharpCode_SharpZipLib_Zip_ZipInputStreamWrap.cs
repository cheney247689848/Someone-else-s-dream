﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class ICSharpCode_SharpZipLib_Zip_ZipInputStreamWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ICSharpCode.SharpZipLib.Zip.ZipInputStream), typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
		L.RegFunction("GetNextEntry", GetNextEntry);
		L.RegFunction("CloseEntry", CloseEntry);
		L.RegFunction("ReadByte", ReadByte);
		L.RegFunction("Read", Read);
		L.RegFunction("Close", Close);
		L.RegFunction("New", _CreateICSharpCode_SharpZipLib_Zip_ZipInputStream);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Password", get_Password, set_Password);
		L.RegVar("CanDecompressEntry", get_CanDecompressEntry, null);
		L.RegVar("Available", get_Available, null);
		L.RegVar("Length", get_Length, null);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateICSharpCode_SharpZipLib_Zip_ZipInputStream(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 1)
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = new ICSharpCode.SharpZipLib.Zip.ZipInputStream(arg0);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.Stream), typeof(int)))
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				int arg1 = (int)LuaDLL.luaL_checknumber(L, 2);
				ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = new ICSharpCode.SharpZipLib.Zip.ZipInputStream(arg0, arg1);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ICSharpCode.SharpZipLib.Zip.ZipInputStream.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetNextEntry(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.ZipInputStream));
			ICSharpCode.SharpZipLib.Zip.ZipEntry o = obj.GetNextEntry();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int CloseEntry(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.ZipInputStream));
			obj.CloseEntry();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ReadByte(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.ZipInputStream));
			int o = obj.ReadByte();
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
			ToLua.CheckArgsCount(L, 4);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.ZipInputStream));
			byte[] arg0 = ToLua.CheckByteBuffer(L, 2);
			int arg1 = (int)LuaDLL.luaL_checknumber(L, 3);
			int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
			int o = obj.Read(arg0, arg1, arg2);
			LuaDLL.lua_pushinteger(L, o);
			return 1;
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
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.ZipInputStream));
			obj.Close();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Password(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)o;
			string ret = obj.Password;
			LuaDLL.lua_pushstring(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index Password on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_CanDecompressEntry(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)o;
			bool ret = obj.CanDecompressEntry;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index CanDecompressEntry on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Available(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)o;
			int ret = obj.Available;
			LuaDLL.lua_pushinteger(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index Available on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Length(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)o;
			long ret = obj.Length;
			LuaDLL.tolua_pushint64(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index Length on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_Password(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream obj = (ICSharpCode.SharpZipLib.Zip.ZipInputStream)o;
			string arg0 = ToLua.CheckString(L, 2);
			obj.Password = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index Password on a nil value" : e.Message);
		}
	}
}

