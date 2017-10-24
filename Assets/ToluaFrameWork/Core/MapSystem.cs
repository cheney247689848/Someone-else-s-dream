using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class MapSystem{

	private int rh = 2;
	private int rw = 2;
	private Vector2 vRectPic;
	
	private float px;
	private float py;

	public List<int> m_moveList = new List<int>();

	public int Rw{get {return rw;}}
	public int Rh{get {return rw;}}
	public MapSystem(int w , int h, float x, float y, Vector2 rect){
		
		rh = h;
		rw = w;
		vRectPic = rect;
		px = x;
		py = y;	
		Debug.Log(rh + "  " + rw + "  " + px + "  " + py);
	}

	/// <summary>
	/// Updates the area.
	/// </summary>
	/// <param name="index">当前玩家位置索引</param>
	/// <param name="nMobility">该角色移动力</param>
	public void UpdateMovable(int index , int nMobility){
		//出现可走范围
		m_moveList.Clear();
		int tx = index % rw;
		int ty = index / rw;
		int length = rh * rw;
		for(int i = 0; i < length; ++i){
			
			int x = i % 10;
			int y = i / 10;
			if(Mathf.Abs(tx - x) + Mathf.Abs(ty - y) <= nMobility){
				
				m_moveList.Add(i);
			}
		}
		//debug
		/*string strd = "";
		for(int k = 0; k < m_moveList.Count; ++k){

			strd += " , " + m_moveList[k];
		}
		Debug.Log(strd);*/
	}
	
	public Vector3 GetIndexPosition(int idx){

		return new Vector3(idx / rh * px  +  px / 2 ,0 , idx % rh * py + py / 2);
	}

	public int GetIndex(Vector2 pos){
		
		if(Mathf.Abs(pos.x) > vRectPic.x/2 || Mathf.Abs(pos.y) > vRectPic.y/2)return -1;
		return ((int)((pos.x + vRectPic.x/2) / px) + (int)((pos.y + vRectPic.y/2) / py) * rw);
	}
	//调试
	public void DebugPoint(Vector3 cenPos){
		
		GameObject a = GameObject.Instantiate(Resources.Load("Plane" , typeof(GameObject))) as GameObject;// GameObject.CreatePrimitive(PrimitiveType.Plane);
		a.transform.localRotation = Quaternion.Euler(90,180,0);
		a.transform.localScale = new Vector3(10.24f,1f,5.12f);
		a.transform.position = cenPos + new Vector3(0,0,-10);
		//GameObject.Destroy(a , 1.5f);			
	}
}