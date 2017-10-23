using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System;
using LuaInterface;

public class ShellConverter : MonoBehaviour {

    int iTick = 0;
    const string strLuaKey = "LUA_EXIST";
    string strPerPath;
    WWW www;

	// Update is called once per frame
	void Update () {

        if (iTick == 0) {

#if UNITY_EDITOR

            iTick = 1;//3
#else
            //检查是否已经释放了lua     
            int key = PlayerPrefs.GetInt(strLuaKey);
            if (key != 1) {

                //释放脚本
                iTick = 1;
            }
#endif
        }

        if (iTick == 1) {

            strPerPath = string.Format("{0}/{1}/Lua", Application.persistentDataPath, LuaConst.osDir);
            strAssetBundleName = System.IO.Path.Combine(LocalURL, "abundle_scriptlua");
            bIsLoading = true;
            bIsSuccess = false;
            StartCoroutine("IELoadBundle");
            iTick = 2;
        }

        if (iTick == 2) {

            if (!bIsLoading) {

                if (bIsSuccess)
                {

                    //释放lua
                    TextAsset[] testAss = www.assetBundle.LoadAllAssets<TextAsset>();
                    TextAsset pathFile = null;
                    int i = 0;
                    for (i = 0; i < testAss.Length; ++i) {

                        if (testAss[i].name == "L_PathInfo") {

                            pathFile = testAss[i];
                            break;
                        }
                    }

                    if (pathFile == null) {

                        Debug.LogError("Error no find the script : L_PathInfo");
                    }else{

                        CacheTool.DeleteDirectory(strPerPath);
                        LuaState lua = new LuaState();
                        lua.Start();
                        string script = @"pathinfo = " + pathFile.text.Replace('\\', '@');
                        lua.DoString(script);
                        for (i = 0; i < testAss.Length; ++i)
                        {

                            object r = lua["pathinfo." + testAss[i].name];
                            if (r != null)
                            {
                                string str = (string)r;
                                str = str.Replace("@", "/");
                                string p = strPerPath + str;
                                //Debug.Log(p);
                                if (!CacheTool.IsDirectory(p))
                                {

                                    CacheTool.CreatDirectory(p);
                                }
                                CacheTool.CreatFile(p + "/" + testAss[i].name + ".lua", testAss[i].bytes);
                            }
                        }
                        lua.CheckTop();
                        lua.Dispose();
                        lua = null;
                        www.Dispose();
                        www = null;

                        Debug.Log("relarse lua finsh");
                        iTick = 3;
                    }
                }
                else
                {

                    Debug.LogError("Error relarse lua");
                    iTick = 4;
                }
            }
        }

        if (iTick == 3) {

            this.gameObject.AddComponent<GameLaunch>();
            GameObject.Destroy(this);
        }
	}


    bool bIsSuccess = false;
    bool bIsLoading = false;
    string strAssetBundleName;
    IEnumerator IELoadBundle()
    {
        Debug.Log(strAssetBundleName);
        www = new WWW(strAssetBundleName);
        do
        {
            yield return new WaitForFixedUpdate();
        } while (!www.isDone);
        bIsLoading = false;
        if (0 >= www.bytes.Length)
        {

            Debug.Log("下载lua失败\n" + www.error);
        }
        else
        {
            Debug.Log("下载完成 length = " + www.bytes.Length);
            bIsSuccess = true;
            yield return 0;
            //www.assetBundle
            //yield return 0;
            //CreatFile(m_strDirectory, m_strRNameList[m_nUpdatePoint], w.bytes);
            //w.Dispose();
            //w = null;
        }
    }

    public static string LocalURL
    {

        get
        {
#if UNITY_EDITOR && UNITY_IPHONE
			return "file://" + Application.dataPath + "/StreamingAssets_local/";
#elif UNITY_IPHONE
			return "file://" + Application.streamingAssetsPath + "/";
#elif UNITY_EDITOR && UNITY_ANDROID
            return "file://" + Application.dataPath + "/StreamingAssets_local/";
#elif UNITY_ANDROID
			return "Error not set";
#endif
        }
    }
}
