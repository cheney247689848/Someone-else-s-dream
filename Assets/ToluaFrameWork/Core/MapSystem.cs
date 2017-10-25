using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class MapSystem{

	static public int RW;
	static public int RH;

	static public Vector2 RECTPIC;
	
	private int rh = 2;
	private int rw = 2;
	private Vector2 m_vRectPic;//每个格子大小
	private Vector2 m_vOffset = Vector3.zero;

	private Rect m_rAreaRect;

	//System
	private PathSystem m_PathSystem;
	
	private int[] m_nData;

	private int[] m_nBuildingData;

	public int Rw{get {return rw;}}
	public int Rh{get {return rh;}}
	public int[] Data{

		get{

			return m_nData;
		}
	}

	public int[] DynData{

		get{

			return m_PathSystem.dynData;
		}
	}
	public int[] StaticData{
		
		get{
			
			return m_PathSystem.staticData;
		}
	}

	public int[] BuildingData{
		
		get{
			return m_nBuildingData;
		}
	}

	public Rect GetRect{

		get{

			return m_rAreaRect;
		}
	}
	public Vector2 GetPerSize{

		get{

			return m_vRectPic;
		}
	}

	public MapSystem(TextAsset t){

		//int w , int h , Vector2 p
		string[] strArr =  t.text.Split('|');
		string[] strArrD1 = strArr[0].Split(',');
		string[] strArrD2 = strArr[1].Split(',');
		rw = int.Parse(strArrD1[2]);
		rh = int.Parse(strArrD1[3]);
		m_vRectPic = new Vector2(float.Parse(strArrD1[4])  ,float.Parse(strArrD1[5]));
		RECTPIC = m_vRectPic;
		m_vOffset = new Vector2(float.Parse(strArrD1[6]) ,float.Parse(strArrD1[7]));
		m_rAreaRect = new Rect(0 , 0 , float.Parse(strArrD1[0]) , float.Parse(strArrD1[1]));//m_vOffset.x , m_vOffset.y

		Debug.Log("[" + rw + " , " + rh + "] Rect = " + m_vRectPic + " ,  Offset = " + m_vOffset + " , Rect = " + m_rAreaRect);
		if(rw * rh != strArrD2.Length){

			Debug.LogError("Error Str Length");
			return;
		}

		m_nData = new int[strArrD2.Length];

		for(int i = 0; i < strArrD2.Length; ++i){

			m_nData[i] = int.Parse(strArrD2[i]);
		}
		m_PathSystem = new PathSystem(rw , rh , m_nData);
		m_nBuildingData = new int[rw * rh];
		//m_PathSystem.SetWeight(0);

		RW = rw;
		RH = rh;


	}

	public int GetIndexByPos(Vector3 vPos){

		int nDx = -1;
		if (m_rAreaRect.Contains(vPos)){
			
			//vPos += new Vector3(- m_rAreaRect.x, - m_rAreaRect.y, 0);//Debug.Log(vPos);
			nDx = (int)(vPos.x / m_vRectPic.x) + (int)(vPos.y / m_vRectPic.y) * rw;
			//Debug.Log("选中 : " + nDx);
		}
		return nDx;
	}

	public int m_nPathCount = 0;
	public int[] GetPath(int a , int b){

		m_nPathCount ++;
		return  m_PathSystem.FindThePath(a , b);
	}

	public int[] GetSmoothPath(int[] path){

		return m_PathSystem.SmoothPath(path);
	}

	public Vector3 GetIndexPos(int i){

		return new Vector3(i % rw * m_vRectPic.x + m_vRectPic.x/2 , i / rw * m_vRectPic.y + m_vRectPic.y/2, 0);
	}

	public string ToString(){

		return ToStringPath(m_nData);
	}

	public string ToStringPath(int[] d){

		string str = "Length = " + d.Length + " , {";
		
		for(int i = 0; i < d.Length; ++i){
			
			str += d[i] + " , ";
		}
		str += "}";
		return str;
	}
	
	public void SetDynData(int i , int v){
		
		m_PathSystem.SetDynData(i , v);
	}

	public void CleanDynData(){
		
		m_PathSystem.DynDataClean();
	}

	public void SetStaticData(int i , int v){
		
		m_PathSystem.SetStaticData(i , v);
	}
	
	public void CleanStaticData(){
		
		m_PathSystem.StaticDataClean();
	}

	public bool IsPathing(int i){

		if(0 == m_PathSystem.data[i] && 
		   0 == m_PathSystem.staticData[i]){//0 == m_PathSystem.dynData[i] &&

			return true;
		}
		return false;
	}

	public bool IsIdleIndex(int i){

		if(0 == Data[i] && 0 == DynData[i])return true;
		return false;
	}

	//判断建筑地形是否可以
	public bool IsBuilding(int[] l , int i){

		/*int k = 0;
		int x = i % rw;
		int y = i / rw;

		foreach(int lc in l){

			int x1 = lc % rw;
			int y1 = lc / rw;
			k = lc + i;

			//Debug.Log("lc = " + lc + " , " + (x + x1) +  " , " + (y + y1));
			if(x + x1 < 0 || x + x1 >= rw){
				Debug.Log("1  " + lc);
				return false;
			}

			if(y + y1 < 0 || y + y1 >= rh){
				Debug.Log("2");
				return false;
			}

			if(0 != m_nData[k] || 0!= m_PathSystem.staticData[k] || k / rw > 30){//暂时定16行   16 * 20 = 320 //0 <= k && k < m_nData.Length &&
				Debug.Log("3");
				return false;
			}		
		}*/

		return true;
	}


	public bool IsExitBarrier(int startIndex , int endIndex){

		return m_PathSystem.IsExitBarrier(startIndex , endIndex);
	}
}