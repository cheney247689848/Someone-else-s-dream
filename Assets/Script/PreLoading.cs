using System;
using UnityEngine;
using LuaInterface;
using ToLuaFramework;
using System.Collections;
using System.Reflection;
using System.IO;
using System.Security.Cryptography;
using System.Text;
public class PreLoading:MonoBehaviour
{    

    /// <summary>
    /// Awake is called when the script instance is being loaded.
    /// </summary>
    void Awake()
    {
        StartCoroutine("IELoading");
    }

    public void LoadBundleBack(AssetBundle bundle){

        LuaFileUtils.Instance.AddSearchBundle(bundle.name, bundle);
    }

    IEnumerator IELoading(){

        string[] loadList = new String[10]{

            "tolua" , 
            "tolua_cjson" , 
            "tolua_lpeg" , 
            "tolua_misc" , 
            "tolua_protobuf" , 
            "tolua_socket" , 
            "tolua_system" , 
            "tolua_system_reflection" , 
            "tolua_unityengine",
            "lua_update"
        };
        AssetsBuilder builder = this.gameObject.AddComponent<AssetsBuilder>();
        for (int i = 0; i < loadList.Length; i++)
        {
            var path = System.IO.Path.Combine(AppConst.boxAssetDir , loadList[i]);
            if (!CacheTool.IsFile(path))
            {
                path = System.IO.Path.Combine(AppConst.AssetDir , AppConst.platform + "/" + AppConst.luaDirName + "/" + loadList[i]);
            }
            builder.LoadBundle(path , LoadBundleBack);
            do
            {
                yield return new WaitForEndOfFrame();
            } while (builder.isLoading);
        }
        Debug.Log("IELoading LoadFinsh");   
        Lunach();
    }

    void Lunach(){

        this.gameObject.AddComponent<GameLaunch>();
        Destroy(this);
    }
}