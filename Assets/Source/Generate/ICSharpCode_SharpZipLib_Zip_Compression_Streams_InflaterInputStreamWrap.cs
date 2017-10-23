﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class ICSharpCode_SharpZipLib_Zip_Compression_Streams_InflaterInputStreamWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream), typeof(System.IO.Stream));
		L.RegFunction("Skip", Skip);
		L.RegFunction("Flush", Flush);
		L.RegFunction("Seek", Seek);
		L.RegFunction("SetLength", SetLength);
		L.RegFunction("Write", Write);
		L.RegFunction("WriteByte", WriteByte);
		L.RegFunction("BeginWrite", BeginWrite);
		L.RegFunction("Close", Close);
		L.RegFunction("Read", Read);
		L.RegFunction("New", _CreateICSharpCode_SharpZipLib_Zip_Compression_Streams_InflaterInputStream);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("IsStreamOwner", get_IsStreamOwner, set_IsStreamOwner);
		L.RegVar("Available", get_Available, null);
		L.RegVar("CanRead", get_CanRead, null);
		L.RegVar("CanSeek", get_CanSeek, null);
		L.RegVar("CanWrite", get_CanWrite, null);
		L.RegVar("Length", get_Length, null);
		L.RegVar("Position", get_Position, set_Position);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateICSharpCode_SharpZipLib_Zip_Compression_Streams_InflaterInputStream(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 1)
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = new ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream(arg0);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.Stream), typeof(ICSharpCode.SharpZipLib.Zip.Compression.Inflater)))
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				ICSharpCode.SharpZipLib.Zip.Compression.Inflater arg1 = (ICSharpCode.SharpZipLib.Zip.Compression.Inflater)ToLua.CheckObject(L, 2, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Inflater));
				ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = new ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream(arg0, arg1);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (count == 3 && TypeChecker.CheckTypes(L, 1, typeof(System.IO.Stream), typeof(ICSharpCode.SharpZipLib.Zip.Compression.Inflater), typeof(int)))
			{
				System.IO.Stream arg0 = (System.IO.Stream)ToLua.CheckObject(L, 1, typeof(System.IO.Stream));
				ICSharpCode.SharpZipLib.Zip.Compression.Inflater arg1 = (ICSharpCode.SharpZipLib.Zip.Compression.Inflater)ToLua.CheckObject(L, 2, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Inflater));
				int arg2 = (int)LuaDLL.luaL_checknumber(L, 3);
				ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = new ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream(arg0, arg1, arg2);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Skip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
			long arg0 = LuaDLL.tolua_checkint64(L, 2);
			long o = obj.Skip(arg0);
			LuaDLL.tolua_pushint64(L, o);
			return 1;
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
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
			obj.Flush();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Seek(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
			long arg0 = LuaDLL.tolua_checkint64(L, 2);
			System.IO.SeekOrigin arg1 = (System.IO.SeekOrigin)ToLua.CheckObject(L, 3, typeof(System.IO.SeekOrigin));
			long o = obj.Seek(arg0, arg1);
			LuaDLL.tolua_pushint64(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SetLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
			long arg0 = LuaDLL.tolua_checkint64(L, 2);
			obj.SetLength(arg0);
			return 0;
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
			ToLua.CheckArgsCount(L, 4);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
			byte[] arg0 = ToLua.CheckByteBuffer(L, 2);
			int arg1 = (int)LuaDLL.luaL_checknumber(L, 3);
			int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
			obj.Write(arg0, arg1, arg2);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int WriteByte(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
			byte arg0 = (byte)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteByte(arg0);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int BeginWrite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
			byte[] arg0 = ToLua.CheckByteBuffer(L, 2);
			int arg1 = (int)LuaDLL.luaL_checknumber(L, 3);
			int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
			System.AsyncCallback arg3 = null;
			LuaTypes funcType5 = LuaDLL.lua_type(L, 5);

			if (funcType5 != LuaTypes.LUA_TFUNCTION)
			{
				 arg3 = (System.AsyncCallback)ToLua.CheckObject(L, 5, typeof(System.AsyncCallback));
			}
			else
			{
				LuaFunction func = ToLua.ToLuaFunction(L, 5);
				arg3 = DelegateFactory.CreateDelegate(typeof(System.AsyncCallback), func) as System.AsyncCallback;
			}

			object arg4 = ToLua.ToVarObject(L, 6);
			System.IAsyncResult o = obj.BeginWrite(arg0, arg1, arg2, arg3, arg4);
			ToLua.PushObject(L, o);
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
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
			obj.Close();
			return 0;
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
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)ToLua.CheckObject(L, 1, typeof(ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream));
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
	static int get_IsStreamOwner(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
			bool ret = obj.IsStreamOwner;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index IsStreamOwner on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Available(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
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
	static int get_CanRead(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
			bool ret = obj.CanRead;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index CanRead on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_CanSeek(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
			bool ret = obj.CanSeek;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index CanSeek on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_CanWrite(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
			bool ret = obj.CanWrite;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index CanWrite on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Length(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
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
	static int get_Position(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
			long ret = obj.Position;
			LuaDLL.tolua_pushint64(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index Position on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_IsStreamOwner(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			obj.IsStreamOwner = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index IsStreamOwner on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_Position(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream obj = (ICSharpCode.SharpZipLib.Zip.Compression.Streams.InflaterInputStream)o;
			long arg0 = LuaDLL.tolua_checkint64(L, 2);
			obj.Position = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index Position on a nil value" : e.Message);
		}
	}
}

