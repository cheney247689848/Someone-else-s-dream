using UnityEngine;
using System;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using System.Collections;
using System.Collections.Generic;

public class ZipTool : MonoBehaviour
{
    private bool isUnPackage = false;
    private int nUnPackageByteCount = 0;
    private int nUnPackageCount = 0;

    public delegate void DelegateZipCall();
    public DelegateZipCall zipCall;
    public int unPackageByteCount{

        get{return nUnPackageByteCount;}
    }

    public int unPackageCount{

        get{return nUnPackageByteCount;}
    }

    public void UnPackage(string zipPath, string zipOutPath , DelegateZipCall call){

        if (isUnPackage)
        {
            Debug.LogError("Error 只能同时解压一个文件");
        }else
        {
            isUnPackage = true;
            zipCall = call;
            StartCoroutine(IEUnPackage(zipPath , zipOutPath));
        }
    }

    IEnumerator IEUnPackage(string zipPath, string zipOutPath)
    {
        Debug.logger.Log("开始解包");
        nUnPackageCount = 0;
        nUnPackageByteCount = 0;
        Stream _inputStream = File.OpenRead(zipPath);
        if ((null == _inputStream))
        {
            Debug.logger.Log("解压文件输入流有误");
            isUnPackage = false;
            yield break;
        }
        
        ZipEntry entry = null;
        using (ZipInputStream zipInputStream = new ZipInputStream(_inputStream))
        {
            while (null != (entry = zipInputStream.GetNextEntry()))
            {
                if (string.IsNullOrEmpty(entry.Name))
                    continue;
                //string filePathName = Path.Combine(_outputPath, entry.Name);
                string filePathName = Path.Combine(zipOutPath, entry.Name.Substring(entry.Name.LastIndexOf('\\') + 1));
                //Debug.logger.Log(filePathName);
                // 写入文件
                try
                {
                    using (FileStream fileStream = File.Create(filePathName))
                    {
                        byte[] bytes = new byte[1024];
                        int bytesCount = 0;
                        nUnPackageByteCount = 0;
                        while (true)
                        {
                            int count = zipInputStream.Read(bytes, 0, bytes.Length);
                            if (count > 0)
                            {
                                fileStream.Write(bytes, 0, count);
                                bytesCount += count;
                            }
                            else
                            {
                                // Debug.logger.Log("单个文件解压完成");                              
                                break;
                            }
                        }
                        nUnPackageByteCount += bytesCount;
                        fileStream.Dispose();
                        fileStream.Close();
                    }
                    
                    nUnPackageCount++;
                }
                catch (System.Exception _e)
                {
                    Debug.LogError(string.Format("Error zip e = {0}" , _e.ToString()));
                    isUnPackage = false;
                    yield break;
                }
                
                yield return 1;
            }
        }
        isUnPackage = false;
        Debug.logger.Log(string.Format("解包完成  共解压：{0} 个文件" , nUnPackageCount));
        zipCall();
        zipCall = null;
    }
}

