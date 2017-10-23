using System.IO;
using System.Text;
using System.Security.Cryptography;
public class DesEncrypt{
    public static string Key = "DKMAB5DE";//加密密钥必须为8位
    //加密算法
    public static string Encrypt(string pToEncrypt)
    {
        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
        byte[] inputByteArray = Encoding.UTF8.GetBytes(pToEncrypt);//Encoding.Default.GetBytes(pToEncrypt);
        des.Key = Encoding.Default.GetBytes(Key);
        des.IV = Encoding.Default.GetBytes(Key);
        MemoryStream ms = new MemoryStream();
        CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
        cs.Write(inputByteArray, 0, inputByteArray.Length);
        cs.FlushFinalBlock();
        StringBuilder ret = new StringBuilder();
        foreach (byte b in ms.ToArray())
        {
            ret.AppendFormat("{0:X2}", b);
        }
        return ret.ToString();
    }

    //解密算法
    public static string Decrypt(string pToDecrypt)
    {
        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
        byte[] inputByteArray = new byte[pToDecrypt.Length / 2];
        for (int x = 0; x < pToDecrypt.Length / 2; x++)
        {
            int i = (System.Convert.ToInt32(pToDecrypt.Substring(x * 2, 2), 16));
            inputByteArray[x] = (byte)i;
        }
        des.Key = Encoding.Default.GetBytes(Key);
        des.IV = Encoding.Default.GetBytes(Key);
        MemoryStream ms = new MemoryStream();
        CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
        cs.Write(inputByteArray, 0, inputByteArray.Length);
        cs.FlushFinalBlock();
        StringBuilder ret = new StringBuilder();
        return System.Text.Encoding.UTF8.GetString(ms.ToArray());
    }


    // public static byte[] EncryptByte(byte[] inputBytes)
    // {
    //     DESCryptoServiceProvider des = new DESCryptoServiceProvider();
    //     des.Key = ASCIIEncoding.ASCII.GetBytes(Key);
    //     des.IV = ASCIIEncoding.ASCII.GetBytes(Key);
    //     MemoryStream ms = new MemoryStream();
    //     CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
    //     cs.Write(inputBytes, 0, inputBytes.Length);
    //     cs.FlushFinalBlock();
    //     return ms.ToArray();
    // }

    // public static byte[] DecryptByte(byte[] decBytes)
    // {
    //     DESCryptoServiceProvider des = new DESCryptoServiceProvider();
    //     // byte[] inputByteArray = new byte[pToDecrypt.Length / 2];
    //     // for (int x = 0; x < pToDecrypt.Length / 2; x++)
    //     // {
    //     //     int i = (System.Convert.ToInt32(pToDecrypt.Substring(x * 2, 2), 16));
    //     //     inputByteArray[x] = (byte)i;
    //     // }
    //     des.Key = ASCIIEncoding.ASCII.GetBytes(Key);
    //     des.IV = ASCIIEncoding.ASCII.GetBytes(Key);
    //     MemoryStream ms = new MemoryStream();
    //     CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
    //     cs.Write(decBytes, 0, decBytes.Length);
    //     cs.FlushFinalBlock();
    //     // StringBuilder ret = new StringBuilder();
    //     return ms.ToArray();
    // }
}
