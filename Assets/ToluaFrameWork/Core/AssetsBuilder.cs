using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

public interface IMotion{}
public delegate void Motion();
public delegate void Motion<T>(T type)where T : Texture;

/// <summary>
/// Bundle.  manage
/// </summary>
public class Bundle : Singleton<Bundle>{
	
	private Dictionary<string, AssetBundle> bundles = new Dictionary<string, AssetBundle>();

	public void AddBundle(string key , AssetBundle ab){

		//缓存
		bundles.Add(key , ab);
	}

	public AssetBundle GetBundle(string str){

		AssetBundle ab;
		if(bundles.TryGetValue(str , out ab)){

			return ab;
		}
		return null;
	}

	public void RemoveBundle(string str){

		//AssetBundle b = GetBundle (str);
		bundles.Remove (str);
		//return b;
	}

    public bool IsExitBundle(string str)
    {
        AssetBundle ab;
        if (bundles.TryGetValue(str, out ab))
        {
            return true;
        }
        return false;
    }
}

public class AssetsBuilder : MonoBehaviour
{

    public delegate void LoadDelegate(AssetBundle bundle);
    // private LoadDelegate m_LoadDelegate;
    private bool bLoading;
    public bool isLoading{get{return bLoading;}}

    public float fProgress;
    /// <summary>
    /// Loads the bundle.
    /// </summary>
    /// <param path="path">Name.</param>
    /// <param path="loadDelegate">Load delegate.</param>
    public void LoadBundle(string path, LoadDelegate loadDelegate)
    {
        if (bLoading) {

            Debug.LogError("Error : is Loading ");
            return;
        }
        bLoading = true;
        fProgress = 0;
        Debug.Log("LoadBundle : " + path);
        // m_LoadDelegate = loadDelegate;
        //string path = System.IO.Path.Combine(StreamPath, name);
        ArrayList objList = new ArrayList();
        objList.Add(path);
        objList.Add(loadDelegate);
        StartCoroutine("IELoadBundle", objList);
    }

	/// <summary>
	/// IEs the load bundle.
	/// </summary>
	/// <returns>The load bundle.</returns>
	/// <param name="objList">Object list.</param>
	IEnumerator IELoadBundle(ArrayList objList)
    {
		string path = (string)objList[0];
		LoadDelegate loadDelegate =(LoadDelegate)objList[1];
        var bunReq = AssetBundle.LoadFromFileAsync(path);//Debug.Log(path);
        do
        {
            yield return new WaitForEndOfFrame();
            fProgress = bunReq.progress;//Debug.LogError(bunReq.progress);
        } while (!bunReq.isDone);
        fProgress = 1;
        yield return bunReq;
        var loadedBundle = bunReq.assetBundle;
        if (loadedBundle == null)
        {
            Debug.Log("Error Failed to load AssetBundle");
            yield break;
        }
       Debug.Log("加载成功 :" + bunReq.assetBundle);
       if (null != loadDelegate){

			loadDelegate(bunReq.assetBundle);
			loadDelegate = null;
	   }
       bunReq.assetBundle.Unload(true);
       bunReq = null;
       bLoading = false;
    }

	/// <summary>
	/// Loads the image from UR.
	/// </summary>
	/// <param name="imgURL">Image UR.</param>
	/// <param name="callback">Callback.</param>
    // Download an image using WWW from a given URL
    public void LoadImgFromURL(string imgURL, Motion<Texture> callback)
    {
        this.StartCoroutine(LoadImgEnumerator(imgURL, callback));
    }

	/// <summary>
	/// Loads the image enumerator.
	/// </summary>
	/// <returns>The image enumerator.</returns>
	/// <param name="imgURL">Image UR.</param>
	/// <param name="callback">Callback.</param>
    private IEnumerator LoadImgEnumerator(string imgURL, Motion<Texture> callback)
    {
        WWW www = new WWW(imgURL);
        yield return www;

        if (www.error != null)
        {
            Debug.LogError(www.error);
            yield break;
        }
        callback(www.texture);
    }

	/// <summary>
	/// Gets the stream path.
	/// </summary>
	/// <value>The stream path.</value>
    public static string StreamPath
    {
        get
        {
#if UNITY_EDITOR && UNITY_IPHONE
			return Application.dataPath + "/StreamingAssets/";
#elif UNITY_IPHONE
			return Application.streamingAssetsPath + "/";
#elif UNITY_EDITOR && UNITY_ANDROID
			return Application.dataPath + "/StreamingAssets/";
#elif UNITY_ANDROID
			return Application.persistentDataPath + "/Cache/";
#else
            return string.Empty; 
#endif
        }
    }


    public static string PersistentPath
    {
        get
        {
#if UNITY_EDITOR && UNITY_IPHONE
			return Application.dataPath + "/StreamingAssets/";
#elif UNITY_IPHONE
			return Application.persistentDataPath + "/";
#elif UNITY_EDITOR && UNITY_ANDROID
            return Application.dataPath + "/StreamingAssets_local/";
#elif UNITY_ANDROID
			return Application.persistentDataPath + "/Cache/";
#else
            return string.Empty;
#endif
            
        }
    }
}
