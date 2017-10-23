using System;
using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
public class CacheTool
{

    public CacheTool (){}
    static public string[] GetAllFiles(string path, string searchPattern){

        return Directory.GetFiles(path,searchPattern);
    }

    /// <summary>
    /// juest the dir is exis
    /// </summary>
    /// <param name="dirName"></param>
    static public bool IsDirectory(string dirName)
    {

        if (Directory.Exists(dirName))
        {
            return true;
        }
        return false;
    }

    /// <summary>
    /// Creats the cache directory.
    /// </summary>
    static public void CreatDirectory(string dirName){

        Debug.Log(dirName);
        if (dirName == "" || dirName == null) return;
        if (!Directory.Exists(dirName)) {

            string[] strlist = dirName.Split('/');
            if (strlist.Length >= 2) {

                int i = 0;
                string p = strlist[i];
                while (i < strlist.Length - 1) {

                    i++;
                    p = System.IO.Path.Combine(p, strlist[i]);
                    //Debug.Log(i + " - " + p);
                    if (!Directory.Exists(p)) {

                        Directory.CreateDirectory(p);
                    }
                }
            }
        }
    }

    /// <summary>
    /// delete the directory
    /// </summary>
    /// <param name="dirName"></param>
    static public void DeleteDirectory(string dirName) {

        if (!Directory.Exists(dirName))
        {

            Directory.Delete(dirName);
        }
    }

    /// <summary>
    /// Determines if is file the specified n.
    /// </summary>
    /// <returns><c>true</c> if is file the specified n; otherwise, <c>false</c>.</returns>
    /// <param name="n">name</param>
    static public bool IsFile(string pFile){

        FileInfo f = new FileInfo(pFile);
        if(f.Exists){
                
            return true;
        }
        return false;
    }

    /// <summary>
    /// Creats the file.
    /// </summary>
    /// <param name="n">name</param>
    /// <param name="b">byte/param>
    static public void CreatFile( string pFile, byte[] b){

        Debug.Log("CreatFile : " + pFile);
        Stream s;
        FileInfo f = new FileInfo(pFile);
        if(f.Exists){
            f.Delete();
        }
        s = f.Create();
        s.Write(b , 0 , b.Length);
        s.Close();
        s.Dispose();
    }

    /// <summary>
    /// Deletes the file.
    /// </summary>
    /// <param name="n">name.</param>
    static public void DeleteFile(string pFile)
    {

        Debug.Log("DeleteFile " + pFile);
        FileInfo f = new FileInfo(pFile);
        if(f.Exists){

            f.Delete();
        }
        f = null;
    }
}


