/*
  The Long night
  The night gives me black eyes, but I use it to find the light. 
  The sprite write in 2017
*/

using UnityEngine;
using UnityEditor;
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Text;
public class AssectsExporter : EditorWindow
{
    struct package
    {
        public string[] assets;
        public string sName;
    }

    static DateTime preTime;
    const string spritePath = "Assets/Script_Lua";
    public const string strDir = "pack";
    public const string strUpdateDir = "ResUpdate";
    static List<package> luaPackages = new List<package>();
    static List<package> accestsPackages = new List<package>();

    	[MenuItem("Build Bundle/ Build Lua Asset Bundles")]
        static void Build_Lua() {

        if (!Directory.Exists(strDir))
        {
            Debug.Log(string.Format("创建文件夹 : {0}" , strDir));
            Directory.CreateDirectory(strDir);
        }
        if (!Directory.Exists(System.IO.Path.Combine(strDir , "lua")))
        {
            Debug.Log(string.Format("创建文件夹 : {0}" , "lua"));
            Directory.CreateDirectory(System.IO.Path.Combine(strDir , "lua"));
        }

        preTime = DateTime.Now;
        luaPackages.Clear();
        Directory.CreateDirectory("Assets/ResLua");
        PackLua(spritePath , "lua");
        Pack(luaPackages , "luaScript");
        Directory.Delete("Assets/ResLua" , true);
        Debug.Log("time use = " + (DateTime.Now - preTime).ToString());
        AssetDatabase.Refresh();
    }

    static void PackLua(string pathDir , string preName , bool isPre = false){

        //Debug.Log(string.Format("Pack lua : pathDir = {0} , preName = {1}" , pathDir, preName));
        string dir = pathDir.Substring(pathDir.LastIndexOf('/') + 1);
        string sp = System.IO.Path.Combine("Assets/ResLua" , "lua");//strDir
        string newDir = "";
        string bundleName = "";
        StringBuilder strBundleName = new StringBuilder();
        if (isPre)
        {
            strBundleName.Append(preName);
            strBundleName.Append("_" + dir);
            bundleName =  "lua_" + pathDir.Replace(spritePath + "/" , "").Replace("/" , "_");
            newDir = pathDir.Replace(spritePath + "/" , "");
        }else{
            
            strBundleName.Append(preName);
            bundleName = "lua";
            newDir = pathDir.Replace(spritePath , "");
        }
        Debug.Log("isPre  " + isPre);
        Debug.Log("bundleName  " + bundleName);

        newDir = System.IO.Path.Combine(sp , newDir);
        Directory.CreateDirectory(newDir);   

        //读取文件夹下的lua文件
        string[] luaPaths = Directory.GetFiles(pathDir, "*.lua", SearchOption.TopDirectoryOnly);
        string[] assetsPaths = new string[luaPaths.Length];
        for (int i = 0; i < luaPaths.Length; i++)
        {
            string sLua = luaPaths[i];
            string operaStr = sLua.Replace("/", "\\");
            string newPath = operaStr.Replace(spritePath.Replace("/" , "\\") + "\\" , "");
            newPath = System.IO.Path.Combine(sp , newPath).Replace(".lua" , ".lua.bytes");
            assetsPaths[i] = newPath;

            StreamReader render = new StreamReader(sLua);
            string desStr = DesEncrypt.Encrypt(render.ReadToEnd());
            render.Close();
            byte[] bytes = Encoding.UTF8.GetBytes(desStr);//Debug.Log(bytes.Length);
            CacheTool.CreatFile(newPath , bytes);
            AssetDatabase.ImportAsset(newPath);
            //Debug.Log("sLua :" + sLua);
     
        }
        
        package pack;
        pack.sName = bundleName;
        pack.assets = assetsPaths;
        luaPackages.Add(pack);
        //递归其他文件夹
        string[] otherSubDir = AssetDatabase.GetSubFolders(pathDir);
        foreach (string subDir in otherSubDir)
        {
            PackLua(subDir , strBundleName.ToString() , true);
        }
    }

    [MenuItem("Build Bundle/ Test dec lua")]
    static void DesLua(){

        // string path = System.IO.Path.Combine(Application.dataPath , "Assets/ResLua/lua/L_Game.lua.bytes");
        TextAsset t = AssetDatabase.LoadAssetAtPath<TextAsset>("Assets/ResLua/lua/L_Game.lua.bytes");
        Debug.Log(t.bytes.Length);
        Debug.Log(DesEncrypt.Decrypt(t.text));
        // FileStream stream = new FileInfo(path).OpenRead();
        // Byte[] buffer = new Byte[stream.Length];
        // stream.Read(buffer, 0, Convert.ToInt32(stream.Length));
        // Debug.Log(System.Text.Encoding.ASCII.GetString(DesEncrypt.Decrypt(buffer)));
    }


    /*
    对依赖关系打包
    相同资源下避免重复打包
    */
    [MenuItem("Build Bundle/ Build Asset Bundles")]
    static void BuildLocalAbs()
    {
        //配置打包信息
        string sPath = "Assets/Res";
        StringBuilder packList = new StringBuilder();
        packList.AppendFormat("Prafab:{0}" , 1);packList.Append(",");
        packList.AppendFormat("Texture:{0}" , 1);

        accestsPackages.Clear();
        string[] packageList = AssetDatabase.GetSubFolders(sPath);
        for (int i = 0; i < packageList.Length; i++)
        {
            //Debug.Log(packageList[i]);
            string[] pList = packList.ToString().Split(',');
            for (int p = 0; p < pList.Length; p++)
            {
                int dex = pList[p].IndexOf(':');
                string pName = pList[p].Substring(0 , dex);
                int nType = int.Parse(pList[p].Substring(dex + 1,1));
                Debug.Log(string.Format("pName = {0} , type = {1}" ,pName, nType));
                Collect(System.IO.Path.Combine(packageList[i] , pName) , nType);
            }
        }
        Pack(accestsPackages , "");
    }

    static void Collect(string pathName  , int nType)
    {
        List<package> pl = new List<package>();
        switch (nType)
        {
            case 1:
                TypeCollect(pathName);
            break;
            default:
            break;
        }
    }

    static void TypeCollect(string pathName){

        string[] collects = Directory.GetFiles(pathName, "*", SearchOption.AllDirectories);
        for (int i = 0; i < collects.Length; i++)
        {
            if (!collects[i].EndsWith(".meta"))
            {
                //Debug.Log(collects[i]);
                string strp = collects[i].Replace("\\" , "/");
                int ds = strp.IndexOf("/" , 7);
                int de = strp.IndexOf(".");
                string s = strp.Substring(ds + 1 , de - ds - 1);
                s = s.Replace("/" , "_");//Debug.Log(s);
                package p;
                p.sName = s;
                p.assets = new string[1]{collects[i]};
                accestsPackages.Add(p);
            }
        }
    }

    static void Pack(List<package> packages , string dirName){
        
        Debug.Log("pack ------------------------------------");
        BuildAssetBundleOptions options;
#if UNITY_IPHONE

        options = BuildAssetBundleOptions.DeterministicAssetBundle;
#else
   
        if (false)
        {
            options = BuildAssetBundleOptions.DeterministicAssetBundle |
            BuildAssetBundleOptions.UncompressedAssetBundle;
        }
        else
        {
            options = BuildAssetBundleOptions.DeterministicAssetBundle;
        }
#endif
        AssetBundleBuild[] buildMap = new AssetBundleBuild[packages.Count];
        for (int i = 0; i < packages.Count; i++)
        {
            buildMap[i].assetBundleName = packages[i].sName;
            buildMap[i].assetNames = packages[i].assets;

            //Debug
            
            StringBuilder sbuilder = new StringBuilder();
            sbuilder.AppendLine("len = " + packages[i].assets.Length);
            foreach (var n in packages[i].assets)
            {
                sbuilder.AppendLine(n);
                //Debug.Log(System.IO.Path.Combine(Application.dataPath.Replace("/Assets" , "") , n));
                //Debug.Log(File.Exists(System.IO.Path.Combine(Application.dataPath.Replace("/Assets" , "") , n)));
            }
            //Debug.Log(string.Format("bundleName = {0} , assets = {1}" ,packages[i].sName , sbuilder.ToString()));
        }
        string path = System.IO.Path.Combine("Assets/StreamingAssets" , dirName);
        if (!Directory.Exists(path))
        {
            Debug.Log(string.Format("创建文件夹 : {0}" , path));
            Directory.CreateDirectory(path);
        }
        Debug.Log(path);

#if UNITY_IPHONE

        BuildPipeline.BuildAssetBundles(path, buildMap, options, BuildTarget.iOS);
#else

        BuildPipeline.BuildAssetBundles(path, buildMap, options, BuildTarget.Android);
#endif
        AssetDatabase.Refresh();
        Debug.Log("pack finsh");
    }

}
