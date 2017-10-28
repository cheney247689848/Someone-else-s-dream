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

public class AssectsExporterWindos : EditorWindow {

    static public string[] strMeta = new string[3]{
    "Assets/StreamingAssets/luaScript : luaScript : Recording_Main.txt : ResUpdate_Main",
    "Assets/StreamingAssets/luaScript2 : luaScript : Recording_NN.txt : ResUpdate_NN",
    "Assets/StreamingAssets/luaScript3 : luaScript : Recording_BJ.txt : ResUpdate_BJ"
    };
    
    static bool isRefresh = false;
    static bool isShow = false;
    static int chooseIndex = 0;
    static int showIndex = 0;
    static int pIndex = 0;
    static int eIndex = 0;
    static string[] options = null;
    static List< AbHashTable> compareList = new List<AbHashTable>();
    static string strTip = "";
    static string strCopyTip = "";
    static List<string> bList = new List<string>();

    static void PackMainifest(int index){

        //发布选项
        if (EditorUtility.DisplayDialog("发布选项!" , "是否校对文件(用于区分已经更新的bundle)." , "是" , "否"))
        {
            if (!Directory.Exists(AssectsExporter.strDir))
            {
                Debug.Log(string.Format("创建文件夹 : {0}" , AssectsExporter.strDir));
                Directory.CreateDirectory(AssectsExporter.strDir);
                Directory.CreateDirectory(AssectsExporter.strUpdateDir);
            }
           AppendMainifest(index);
        }
    }
    
    static public void AppendMainifest(int index){

        string[] ms = strMeta[index].Split(':');
        string path = System.IO.Path.Combine(GetRecordPath() , ms[2].Trim());
        FileStream fs = new FileStream(path,FileMode.Append);
        StreamWriter writer = new StreamWriter(fs);
        //time
        writer.WriteLine(DateTime.Now.ToString("yyyy-MM-dd HH：mm：ss"));

        try{

            AssetBundle bundle = AssetBundle.LoadFromFile(System.IO.Path.Combine(ms[0].Trim() , ms[1].Trim()));//Debug.Log(System.IO.Path.Combine(ms[0].Trim() , ms[1].Trim()));
            AssetBundleManifest mainfest = bundle.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
            string[] abs = mainfest.GetAllAssetBundles();
            for (int i = 0; i < abs.Length; i++)
            {
                Hash128 hash = mainfest.GetAssetBundleHash(abs[i]);
                writer.WriteLine(string.Format("{0} : {1}" , abs[i] , hash.ToString()));
                
            }
            bundle.Unload(true);
            bundle = null;
        }catch{

            Debug.LogError("打包文件错误");
        }
        writer.WriteLine("");
        writer.Flush();
        writer.Close();
        fs.Close();
        fs = null;
        Debug.Log("packMainifest finsh");
    }    


    [MenuItem("Build Bundle/ Compare Asset Bundles")]
    static void Init()
    {
        AssectsExporterWindos exporterWindos = (AssectsExporterWindos)EditorWindow.GetWindow(typeof(AssectsExporterWindos), false, "ExporterWindos", true);
        exporterWindos.Show();//展示
    }

    Vector2 scrollPos;
    void OnGUI()
    {

        chooseIndex = EditorGUILayout.Popup(chooseIndex, strMeta,GUILayout.MinWidth(300));
        if (GUILayout.Button("PackMainifest" , GUILayout.Height(30) , GUILayout.Width(100))){

            PackMainifest(chooseIndex);
            isRefresh = false;
        }
        if (showIndex != chooseIndex || !isRefresh)
        {
            showIndex = chooseIndex;
            pIndex = 0;
            eIndex = 0;
            isRefresh = true;
            isShow = Choose(showIndex);
            strTip = "需要重新 Compare";
            bList.Clear();            
        }
        if(!isShow)return;
        pIndex = EditorGUILayout.Popup(pIndex, options,GUILayout.Width(200));
        eIndex = EditorGUILayout.Popup(eIndex, options,GUILayout.Width(200));

        if (GUILayout.Button("Compare" , GUILayout.Height(30))){

            Compare();
        }
            

        if (strTip.Length > 0)
        {
            EditorGUILayout.BeginHorizontal(GUILayout.Height(200));
            scrollPos = EditorGUILayout.BeginScrollView(scrollPos , GUILayout.MaxHeight(200));
            GUILayout.Label(strTip , GUILayout.MaxHeight(3000));//
            EditorGUILayout.EndScrollView();
            EditorGUILayout.EndVertical();
            if (bList.Count > 0 && GUILayout.Button("copy 复制生成到以下目录 ../Assets/pack/ResUpdate" , GUILayout.Height(30)))
            {
                CopyAsset(showIndex);
            }

            if (strCopyTip.Length > 0)
            {
                GUILayout.Label(strCopyTip , GUILayout.MaxHeight(3000));
            }
        }
    }

    static bool Choose(int index){

        if (index < 0 && index >= strMeta.Length)
        {
            Debug.LogError("索引错误");
            return false;
        }
        string[] ms = strMeta[index].Split(':');
        string txtPath = System.IO.Path.Combine(GetRecordPath() , ms[2].Trim());
        if (!File.Exists(txtPath)){
            return false;
        }
        //校对发生改变
        // string strKey = DateTime.Now.ToString("yyyy");
        FileStream fs = new FileStream(txtPath , FileMode.Open);
        StreamReader reader = new StreamReader(fs);
        String line;
        AbHashTable table = null;
        List<string> labels = new List<string>();
        List<AbHash> abHashList = new List<AbHash>();
        compareList.Clear();
        while ((line = reader.ReadLine()) != null) 
        {
            if (line.Length > 0)
            {
                //Debug.Log(line);
                if (line.StartsWith("201"))
                {
                    //创建组
                    //Debug.Log(line);
                    abHashList.Clear();
                    table = new AbHashTable();
                    table.label = line;
                    labels.Add(table.label);
                    compareList.Add(table);
                    
                }else if(line.IndexOf(':') != -1){
                    string[] nh = line.Split(':');
                    AbHash abh;
                    abh.bName = nh[0];
                    abh.hash = nh[1];
                    abHashList.Add(abh);
                    table.abHashs = abHashList.ToArray();//
                }
            }
        }
        //调出提示框
        options = labels.ToArray();
        reader.Close();   
        return true;  
    }
    
	
	static void Compare(){

        //Debug.Log(pIndex + " , " +  eIndex);
        strTip = "";
        strCopyTip = "";
        if (pIndex >= eIndex)
        {
            strTip = "Error : 对比的日期时间必须满足 t1 < t2";
            return;
        }

        AbHashTable pHasht = compareList[pIndex];
        AbHashTable eHasht = compareList[eIndex];
        bList.Clear();

        for (int i = 0; i < eHasht.abHashs.Length; i++)
        {
            AbHash h = eHasht.abHashs[i];
            bool isFind = false;
            for (int j = 0; j < pHasht.abHashs.Length; j++)
            {
                if (h.bName.Equals(pHasht.abHashs[j].bName))
                {
                    isFind = true;
                    if (!h.hash.Equals(pHasht.abHashs[j].hash))
                    {
                        //已更新
                        //Debug.Log("更新:" + h.bName);
                        bList.Add(h.bName);
                    }
                    break;
                }
            }
            if (!isFind)
            {
                //新增加
                //Debug.Log("新增加:" + h.bName);
                bList.Add(h.bName);
            }
        }

        StringBuilder builder = new StringBuilder();
        builder.AppendLine(string.Format("已检查以下更新 {0} 项:" , bList.Count));
        for (int i = 0; i < bList.Count; i++)
        {
            builder.AppendLine(bList[i]);
        }
        strTip = builder.ToString();
	}

    static public void CopyAsset(int index){

        if (bList.Count <= 0)
        {
            Debug.Log("更新内容为0");
            return;
        }

        string[] ms = strMeta[index].Split(':');
        string sourPath = System.IO.Path.Combine("" , ms[0].Trim());
        string copyPath = System.IO.Path.Combine(AssectsExporter.strDir + "/" + AssectsExporter.strUpdateDir , ms[3].Trim());
        if (Directory.Exists(copyPath))Directory.Delete(copyPath , true); //fiex
        Directory.CreateDirectory(copyPath);
        StringBuilder builder = null;
        for (int i = 0; i < bList.Count; i++)
        {
            string name = bList[i].Trim(); //+ "unity.3d"
            string oldPath = System.IO.Path.Combine(sourPath , name);
            string newPath = System.IO.Path.Combine(copyPath , name);
            if (!AssetDatabase.CopyAsset(oldPath, newPath))
            {
                if (builder == null)
                {
                    builder = new StringBuilder();
                    builder.AppendLine("复制错误:");
                }
                builder.AppendLine(name);
            }
            // StringBuilder bDebug = new StringBuilder();
            // bDebug.AppendLine(oldPath);
            // bDebug.AppendLine(newPath);
            // Debug.Log(bDebug);
        }
        if (builder != null)strCopyTip = builder.ToString();
        System.Diagnostics.Process.Start(copyPath);      
    }

    static public string GetRecordPath(){

        string streamPath = Application.dataPath;
        streamPath = System.IO.Path.Combine(streamPath.Replace("Assets" , "") , AssectsExporter.strDir);
        return streamPath;
    }

	class AbHashTable
    {
        public string label;
        public AbHash[] abHashs;
    }

    struct AbHash
    {
        public string bName;
        public string hash;
    }
}