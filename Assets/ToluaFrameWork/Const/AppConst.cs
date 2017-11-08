using UnityEngine;

public class AppConst
{
    public const string Name = "example";                       //游戏名字
    public const int GameFrameRate = 60;                        //游戏帧频
    public const bool DebugMode = false;
    static public bool isUpdateMode = false;
    static public bool isZip = false;                            //是否加载脚本bundle
    static public string AssetDir = Application.dataPath + "/StreamingAssets/";           //本地目录
    //沙盒目录
#if UNITY_EDITOR
    static public string boxAssetDir = Application.persistentDataPath;
    static public string platform = "Android";
#elif UNITY_IPHONE
    static public string boxAssetDir = Application.persistentDataPath;
    static public string platform = "IOS";
#elif UNITY_ANDROID
    static public string boxAssetDir = Application.persistentDataPath;
    static public string platform = "Android";
#endif

    //lua
    static public string luaDirName = "luaScript";
    static public string boxLuaDirName = "";
// #if UNITY_EDITOR
//     static public string boxLuaDirName = Application.dataPath + "/StreamingAssets/luaScript";
// #elif UNITY_IPHONE
//     static public string boxLuaAssetDir = Application.persistentDataPath + "/";
// #elif UNITY_ANDROID
//     static public string boxLuaAssetDir = Application.persistentDataPath + "/";
// #endif
    
}
