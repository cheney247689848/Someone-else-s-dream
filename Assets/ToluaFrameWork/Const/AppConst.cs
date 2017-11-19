using UnityEngine;
using System.Text;
public class AppConst
{
    public const string Name = "example";                       //游戏名字
    public const int GameFrameRate = 60;                        //游戏帧频
    public const bool DebugMode = false;
    static public bool isUpdateMode = false;
    static public bool isZip = false;                            //是否加载脚本bundle
    
    //沙盒目录
#if UNITY_EDITOR
    static public string platform = "Android";
    static public string AssetDir = Application.dataPath + "/StreamingAssets/";
    static public string boxAssetDir = Application.persistentDataPath;
#elif UNITY_IPHONE
    static public string platform = "IOS";
    static public string AssetDir = Application.dataPath + "/Raw/";
    static public string boxAssetDir = Application.persistentDataPath;
#elif UNITY_ANDROID
    static public string platform = "Android";
    static public string AssetDir = Application.dataPath + "!assets/";
    static public string boxAssetDir = Application.persistentDataPath;
    
#endif

    //lua
    static public string luaDirName = "luaScript";
    static public string boxLuaDirName = "";

    static public string luaPath{

        get{
            return System.IO.Path.Combine(AssetDir  , platform ) +  "/luaScript";
        }
    }

    static public string luaBoxPath{

        get{
            return System.IO.Path.Combine(boxAssetDir , platform) + "/luaScript";
        }
    }


    static public string resPath{

        get{
            return System.IO.Path.Combine(AssetDir  , platform );
        }
    }

    static public string resBoxPath{

        get{
            return System.IO.Path.Combine(boxAssetDir , platform);
        }
    }
}
