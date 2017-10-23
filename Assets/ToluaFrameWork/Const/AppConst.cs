using UnityEngine;

public class AppConst
{
    public const string Name = "example";                       //游戏名字
    public const int GameFrameRate = 60;                        //游戏帧频
    public const bool DebugMode = false;
    public const bool isUpdateMode = true;
    public const bool isZip = false;                            //是否加载脚本bundle
    static public string AssetDir = Application.dataPath + "/StreamingAssets/";           //本地目录
    //沙盒目录
#if UNITY_EDITOR
    static public string boxAssetDir = Application.dataPath + "/StreamingAssets/"; 
#elif UNITY_IPHONE
    static public string boxAssetDir = Application.persistentDataPath + "/";  
#elif UNITY_ANDROID
    static public string boxAssetDir = Application.persistentDataPath + "/";
#endif
    
}
