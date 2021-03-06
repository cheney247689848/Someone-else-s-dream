using UnityEngine;
using System.Collections;
using System.Net.Sockets;

public class PacketStream 
{
	//缓存区	
	public byte[] m_Buffer;
	//最大数据量
	public int m_nMax;
	//已有数据
	public int m_nCount;
	//数据头部位置
	public int m_nHead;
	//读取位置
	public int m_nReadPos;
	//写数据个数
	private int m_nWriteCount;
	//接收标志,0为没有提交接收，1为正在接收中.
	public int m_nRecv;
	
	public PacketStream(int nMax)
	{
		m_Buffer = new byte[nMax];
		m_nMax = nMax;
		m_nCount = 0;	
		m_nHead = 0;
		m_nReadPos = 0;
		m_nWriteCount = 0;
		m_nRecv = 0;
	}
	//重新设置
	public void ReSet()
	{
		m_nCount = 0;
		m_nHead = 0;
		m_nReadPos = 0;
		m_nWriteCount = 0;
		m_nRecv = 0;
	}
	//接收整理
	public void Make()
	{
		if (0 == m_nCount){
			m_nHead = 0;
			m_nReadPos = 0;
			m_nWriteCount = 0;
		} else {
			if (m_nHead > 0){
				for (int i = 0; i < m_nCount; ++i){
					m_Buffer[i] = m_Buffer[m_nHead + i];
					m_Buffer[m_nHead + i] = 0;
				}
				m_nHead = 0;
			}
		}
	}
	//向缓存区中压人数据
	public void Push(byte[] buffer, int nCount)
	{
		for (int i = 0; i < nCount; ++i) {
			m_Buffer[m_nHead + m_nCount + i] = buffer[i];	
		}
		m_nCount += nCount;
	}
	//开始写数据
	public void BeginWrite(short nCmd, SessionId id)
	{
		m_nWriteCount = 0;
		WriteShort(0);
		WriteShort(nCmd);

		WriteInt(id.nUserId);
		WriteInt(id.nTickTime);
		WriteShort(id.nSequence);
		WriteShort(id.nRand);
		//Debug.Log(nCmd + " , " + id.nUserId + " , " + id.nTickTime + " , " + id.nSequence + " , " + id.nRand );
	}
	//写整型
	private void _WriteInt(int n)
	{
		if (m_nCount + 4 > m_nMax){
			Debug.LogError("写数据超出范围");
			return;	
		}
		byte[] buf = new byte[4];
		buf = System.BitConverter.GetBytes(n);
		for (int i = 0; i < 4; ++i){			
			m_Buffer[m_nCount] = buf[i];
			m_nCount += 1;
		}
	}
	
	public void WriteInt(int n){
		_WriteInt(n);	
		m_nWriteCount += 4;
	}
	
	private void _WriteUInt(uint n)
	{
		if (m_nCount + 4 > m_nMax){
			Debug.LogError("写数据超出范围");
			return;	
		}
		byte[] buf = new byte[4];
		buf = System.BitConverter.GetBytes(n);
		for (int i = 0; i < 4; ++i){			
			m_Buffer[m_nCount] = buf[i];
			m_nCount += 1;
		}
	}
	
	public void WriteUInt(uint n)
	{
		_WriteUInt(n);
		m_nWriteCount += 4;
	}
	
	public void _WriteShort(short n)
	{
		if (m_nCount + 2 > m_nMax){
			Debug.LogError("写数据超出范围");
			return;	
		}
		byte[] buf = new byte[2];
		buf = System.BitConverter.GetBytes(n);
		for (int i = 0; i < 2; ++i){			
			m_Buffer[m_nCount] = buf[i];
			m_nCount += 1;
		}
	}
	
	public void WriteShort(short n)
	{
		_WriteShort(n);
		m_nWriteCount += 2;
	}
	//写浮点型
	private void _WriteFloat(float n)
	{
		if (m_nCount + 4 > m_nMax){
			Debug.LogError("写数据超出范围");
			return;	
		}
		
		byte[] buf = new byte[4];
		buf = System.BitConverter.GetBytes(n);
		for (int i = 0; i < 4; ++i){
			m_Buffer[m_nCount] = buf[i];
			m_nCount += 1;
		}
	}
	public void WriteFloat(float n)
	{
		_WriteFloat(n);
		m_nWriteCount += 4;
	}
	//写一个字节
	private void _WriteByte(byte b)
	{
		if (m_nCount + 1 > m_nMax){
			Debug.LogError("写数据超出范围");
			return;	
		}
		
		m_Buffer[m_nCount] = b;
		m_nCount += 1;
	}
	
	public void WriteByte(byte b)
	{
		_WriteByte(b);
		m_nWriteCount += 1;
	}
	//写字符串
	private void _WriteString(string str, int len)
	{
		if (m_nCount + len > m_nMax){
			Debug.LogError("写数据超出范围");
			return;
		}
		
		byte[] buf = System.Text.Encoding.UTF8.GetBytes(str);
		for (int i = 0; i < len; ++i){
			if (i < buf.Length){
				m_Buffer[m_nCount] = buf[i];
			} else {
				m_Buffer[m_nCount] = 0;	
			}
			m_nCount += 1;
		}
	}
	public void WriteString(string str, int len)
	{
		_WriteString(str, len);
		m_nWriteCount += len;
	}
	//写byte数组
	private void _WriteBytes(byte[] buf, int len)
	{
		if (m_nCount + len > m_nMax){
			Debug.LogError("写数据超出范围");
			return;
		}
		for (int i = 0; i < len; ++i){
			if (i < buf.Length){ 
				m_Buffer[m_nCount] = buf[i];
			} else {
				m_Buffer[m_nCount] = 0;	
			}
			m_nCount += 1;
		}
	}
	public void WriteBytes(byte[] buf, int len)
	{
		_WriteBytes(buf, len);
		m_nWriteCount += len;
	}
	//写结束
	public void EndWrite()
	{
		byte[] buf = System.BitConverter.GetBytes(m_nWriteCount);
		for (int i = 0; i < 2; ++i){			
			m_Buffer[i] = buf[i];//默认长度位置
		}
	}

	//开始读数据
	//public void BeginRead(out short nCmd, out short nLength)
	//{
	//	m_nReadPos = m_nHead;
	//	//Debug.Log("m_nReadPos:" + m_nReadPos + ";m_nHead:" + m_nHead + ";m_nCount:" + m_nCount);
	//	nLength = ReadShort();
	//	nCmd = ReadShort();
	//}
	//读整型
	public int ReadInt()
	{
		if (m_nReadPos + 4 <= m_nHead + m_nCount){ 
			int n = System.BitConverter.ToInt32(m_Buffer, m_nReadPos);
			m_nReadPos += 4;
			return n;
		}  else {
			Debug.Log("m_nReadPos:" + m_nReadPos + ";m_nHead:" + m_nHead + ";m_nCount:" + m_nCount);
			Debug.LogError("ReadInt读数据过界");
			return 0;
		}
	}
	
	public short ReadShort()
	{
		if (m_nReadPos + 2 <= m_nHead + m_nCount){ 
			short n = System.BitConverter.ToInt16(m_Buffer, m_nReadPos);
			m_nReadPos += 2;
			return n;
		}  else {
			Debug.Log("m_nReadPos:" + m_nReadPos + ";m_nHead:" + m_nHead + ";m_nCount:" + m_nCount);
			Debug.LogError("ReadShort读数据过界");
			return 0;
		}
	}
	
	public uint ReadUInt()
	{
		if (m_nReadPos + 4 <= m_nHead + m_nCount){
			uint n = System.BitConverter.ToUInt32(m_Buffer, m_nReadPos);
			m_nReadPos += 4;
			return n;
		} else {
			Debug.LogError("ReadUInt读数据过界");
			return 0;
		}
	}
	//读浮点
	public float ReadFloat()
	{
		if (m_nReadPos + 4 <= m_nHead + m_nCount){
			float n = System.BitConverter.ToSingle(m_Buffer, m_nReadPos);
			m_nReadPos += 4;
			return n;
		} else {
			Debug.LogError("ReadFloat读数据过界, m_nReadPos = " + m_nReadPos + ", m_nHead = " + m_nHead + ", m_nCount = " + m_nCount);
			return 0.0f;
		}
	}
	//读字节
	public byte ReadByte()
	{
		if (m_nReadPos + 1 <= m_nHead + m_nCount){
			byte b = m_Buffer[m_nReadPos];
			m_nReadPos += 1;
			return b;
		} 
		return 0;
	}
	//读字符串 
	public string ReadString(int nLength)
	{
		if (m_nReadPos + nLength <= m_nHead + m_nCount){
			string str = System.Text.Encoding.UTF8.GetString(m_Buffer, m_nReadPos, nLength);
		
			m_nReadPos += nLength;
			return str;
		} else {
			Debug.LogError("ReadString读数据过界");
			return null;
		}
	}
	//读数据结束
	public void ReadEnd(int nLength)
	{
		m_nHead = m_nHead + nLength;
		m_nCount = m_nCount - nLength;
		//Debug.Log("读数据结束:Head = " + m_nHead + ";Count = " + m_nCount + ";Length = " + nLength);
	}
}
