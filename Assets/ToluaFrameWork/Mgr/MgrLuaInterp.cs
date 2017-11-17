/*
  The Long night
  The night gives me black eyes, but I use it to find the light. 
  The sprite write in 2017
*/

using UnityEngine;
using LuaInterface;
using System.Text;
using System.Collections.Generic;
public class MgrLuaInterp{

    const bool isLoadLuaBundle = false;
    static public LuaFileUtils luaFileUtils = null;
    static public Dictionary<string , LuaAssets> assetsMap = new Dictionary<string, LuaAssets>();
    static public List<string> tags = new List<string>();
    public MgrLuaInterp(LuaFileUtils lfUtiles){

      luaFileUtils = lfUtiles;
    }

    static public LuaFileUtils GetLuaFileUtils(){

        return luaFileUtils;
    }

    static public bool IsContainBundle(string name){

        return assetsMap.ContainsKey(name);
    }

    static public void AddSearchBundle(string name , AssetBundle bundle){

        string tag = name.Split('_')[0];
        if (!tags.Contains(tag))
        {
            tags.Add(tag);
        }
        TextAsset[] textAssets = bundle.LoadAllAssets<TextAsset>();
        if (textAssets.Length <= 0)
        {
            Debug.LogError(string.Format("{0} Length = 0 " , name));
            return;
        }
        LuaAssets las = new LuaAssets(name);
        foreach (var t in textAssets)
        {
            las.AddBytesToMap(t.name + ".bytes" , Encoding.UTF8.GetBytes(DesEncrypt.Decrypt(t.text)));
        }
        assetsMap.Add(name , las);
    }

    static public byte[] GetLuaBytes(string zipName , string fileName){

    LuaAssets las = null;
    for (int i = 0; i < tags.Count; i++)
    {
        string mapName = null;
        if (zipName.Length > 0)
        {
            mapName = tags[i] + zipName;
        }else mapName = tags[i];
        if (assetsMap.TryGetValue(mapName , out las))
        {
            byte[] b = las.GetBytesFromName(fileName);
            if (b != null)
            {
                return b;
            }
        }
    }
    // Debug.LogError(string.Format("LuaAssets {0} is not exists" , name));
    return null;
    }
}

public class LuaAssets{

    string strPackName = "<unknow>";
    Dictionary<string , byte[]> byteMap = new Dictionary<string, byte[]>();

    public LuaAssets(string pName){

        strPackName = pName;
    }

    public string packageName{

        get{return strPackName;}
    }

    public void AddBytesToMap(string name , byte[] bytes){

        if (!byteMap.ContainsKey(name))
        {
            byteMap.Add(name , bytes);
        }else{
            Debug.LogError(string.Format("lua {0} is already exists" , name));
        }
    }

    public byte[] GetBytesFromName(string name){

        byte[] bytes = null;
        if (!byteMap.TryGetValue(name , out bytes))
        {
            // Debug.LogError(string.Format("lua {0} is not exists" , name));
            return null;
        }
        return bytes;
    }
}