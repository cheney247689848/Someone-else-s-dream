/// <summary>
/// 修改于 2015 5 20
/// </summary>
using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Square{
	
	public int index;
	public int F;
	public int G;
	public int H;
	
	public void Clean(){
		
		F = 0;
		G = 0;
		H = 0;
	}
	
	public string ToString(){
		
		return "[" + index + "] , F = " + F + " , G = " + G + " , H = " + H;
	}
}

public class PathSystem {
	
	//test
	//public int nPos = 0;
	private int[] m_data;
	private int[] m_staticData;
	private int[] m_dynData;
	private int rh = 2;
	private int rw = 2;

	//data

	private Square[] allList;
	private List<Square> openList;
	private List<Square> closeList;
	private List<Square> currentList;
	private List<Square> recordList;
	
	private Square A;
	private Square B;
	private Square C;
	private Square T;
	
	private bool isFindThePath = false;
	//是否斜线行走
	private bool isbSlash = true;

	//路径思维
	private int nPathWeight = -1;//-1 默认不选择  0 竖  1 横
	
	public PathSystem(int w , int h , int[] d){

		if(h * w != d.Length){

			Debug.LogError("ERROR d.length != h * w");
			return;
		}
		rh = h;
		rw = w;
		m_data = d;
		m_dynData = new int[m_data.Length];
		m_staticData = new int[m_data.Length];
	
		Init();
	}

	/// <summary>
	/// Gets the data.
	/// </summary>
	/// <value>The data.</value>
	public int[] data{

		get{return m_data;}
	}

	/// <summary>
	/// Gets the dyn data.
	/// </summary>
	/// <value>The dyn data.</value>
	public int[] dynData{

		get{return m_dynData;}
	}

	public int[] staticData{
		
		get{return m_staticData;}
	}

	/// <summary>
	/// Sets the dyn data.
	/// </summary>
	/// <param name="i">The index.</param>
	public void SetDynData(int i , int v){

		m_dynData[i] = v;
	}

	/// <summary>
	/// Dyns the data clean.
	/// </summary>
	public void DynDataClean(){

		for(int i = 0; i < m_dynData.Length; ++i){

			m_dynData[i] = 0;
		}
	}

	/// <summary>
	/// Sets the dyn data.
	/// </summary>
	/// <param name="i">The index.</param>
	public void SetStaticData(int i , int v){
		
		m_staticData[i] = v;
	}
	
	/// <summary>
	/// Dyns the data clean.
	/// </summary>
	public void StaticDataClean(){
		
		for(int i = 0; i < m_staticData.Length; ++i){
			
			m_staticData[i] = 0;
		}
	}

	/// <summary>
	/// Sets the weight.
	///      2
	///   a4   a1
	/// 0         1
	///   a3   a2
	///      3
	/// </summary>
	/// <param name="a1">A1.</param>
	/// <param name="a2">A2.</param>
	/// <param name="a3">A3.</param>
	/// <param name="a4">A4.</param>
	public void SetWeight(int a1){

		if(0 == a1 || 1 == a1){

			nPathWeight = a1;
		}else Debug.LogError("Error SetWeight = " + a1);
	}
	
	// Use this for initialization
	void Init () {
		
		if(null == m_data){
			Debug.Log("Path data = null");
			return ;
		}

		allList = new Square[m_data.Length];
		for(int i = 0; i < m_data.Length; ++i){
			
			allList[i] = new Square();
			allList[i].index = i;
		}
		openList = new List<Square>();
		closeList = new List<Square>();
		currentList = new List<Square>();
		recordList = new List<Square>();
	}

	//
	public int[] SmoothPath(int[] path){

		int[] mPath = (int[])path.Clone();
		int x;
		int y;
		int x1;
		int y1;
		int k = 0;
		int c;
		//移除横、竖等量路径
		for(int i = 0; i < mPath.Length - 1; ++i){

			if(-1 == mPath[i])continue;
			x = mPath[i + 1] % rw - mPath[i] % rw;
			y = mPath[i + 1] / rw - mPath[i] / rw;
			c = 2;
			for(int j = i + 2; j < mPath.Length -1; ++j){

				x1 = mPath[j] % rw - mPath[i] % rw;
				y1 = mPath[j] / rw - mPath[i] / rw;
				//Debug.Log("i = " + i + "  :  (" + x + " , " + y +  ") ---- ( " + x1 + " , " + y1 +  ")");
				if(x1 == x * c && y1 == y * c){

					mPath[j - 1] = -1;
					k ++;
					c ++;
				}else{

					break;
				}
			}
		}

		//移除无阻碍路径
		c = 0;
		int ncp = 0;
		int nbreak = -1;
		int nStart = 0;
		int nEnd = -1;
		do{

			nStart = c;
			ncp = 0;
			nbreak = -1;
			for(int i = nStart + 1; i < mPath.Length; ++i){

				if(-1 != mPath[i]){

					ncp ++;
					if(ncp >= 2){

						nEnd = i;
						if(IsExitBarrier(mPath[nStart] , mPath[nEnd])){
							//遇到障碍跳出
							c = nbreak;
							break;
						}else{

							mPath[nbreak] = -1;
							k++;
							//Debug.Log("nbreak = " + nbreak + " , nStart = " + nStart + " , nEnd = "  + nEnd);
							nbreak = nEnd;
						}
					}else{

						nbreak = i;//Debug.Log("braak = " + i + " -> " + mPath[i]);
						c = nbreak;
					}
				}
				//c++;
			}

		}while(-1 != c && c < mPath.Length - 1);

		int[] kPath = new int[mPath.Length - k];
		c = 0;
		for(int i = 0; i < mPath.Length; ++i){

			if(-1 != mPath[i]){

				kPath[c] = mPath[i]; 
				c++;
			}
		}
		return kPath;
	}

	//寻找路径
	public int[] FindThePath(int oriIndex , int tarIndex){
        //Debug.LogWarning(oriIndex + " move to " + tarIndex);
		if (oriIndex == tarIndex) return new int[1] { oriIndex };
		
		if(oriIndex < 0 || oriIndex >= m_data.Length || 0 != m_data[oriIndex] ||
		   tarIndex < 0 || tarIndex >= m_data.Length || 0 != m_data[tarIndex]){

			Debug.LogError("Error index = " + oriIndex + " = " + m_data[oriIndex] + "  TO  " + tarIndex + " = " + m_data[tarIndex]);
			return new int[1] { oriIndex };
		}

		//CLEAN
		int nNum = 0;
		isFindThePath = false;
		Clean();
		closeList.Clear();
		openList.Clear();
		currentList.Clear();
		recordList.Clear();
		// A move to B 
		A = GetSquare(oriIndex);
		B = GetSquare(tarIndex);
		C = A;
		T = A;
		//将A点添加到close列表中
		openList.Add(A);
		do{
			nNum ++;
			//计算最小
			T = C;
			C = GetLowerValue();
			if(null == C){

				Debug.LogError("Error Cant not find the Path");
				isFindThePath = true;
				return new int[1] { oriIndex };
			}

			recordList.Add(C);
			closeList.Add(C);
			openList.Remove(C);
			
			if(closeList.Contains(B)){
				//Find the Path
				//Debug.Log("Find the Path");
				isFindThePath = true;
				break;
			}
			//T = null;
			GetDirectionIndex(C.index);
			currentList.Clear();
			for(int p = 0; p < directionlist.Count; ++p){
				
				if(closeList.Contains(directionlist[p]))continue;
				
				if(!openList.Contains(directionlist[p])){
					
					//openList.Add(sqa);
					if(0 == m_data[directionlist[p].index] && 0 == m_staticData[directionlist[p].index]){//0 == m_dynData[directionlist[p].index]
						openList.Add(directionlist[p]);
						directionlist[p].G = C.G + 1;
						//sqa.H = Mathf.Abs(B.index % rh - sqa.index % rh) +  Mathf.Abs(B.index / rh - sqa.index / rh);
						directionlist[p].H = Mathf.Abs(B.index % rw - directionlist[p].index % rw) +  Mathf.Abs(B.index / rw - directionlist[p].index / rw);
						directionlist[p].F = directionlist[p].G + directionlist[p].H;
						currentList.Add(directionlist[p]);
					}else{
						
						closeList.Add(directionlist[p]);
					}
					
				}else{
					//已经存在于列表中
					if(directionlist[p].G > C.G + 1){
						
						directionlist[p].G = C.G + 1;
						directionlist[p].F = directionlist[p].G + directionlist[p].H;
					}
					currentList.Add(directionlist[p]);
				}
			}
			//计算最小F值   C
			//添加到open列表中
		}while(0 != openList.Count);
		//Debug.LogWarning("T nNum = "  + nNum);
		if(isFindThePath){

			if(0 == B.G)return new int[1]{0};
			//sort
			for(int l1 = 0; l1 < recordList.Count; ++l1){

				for(int l2 = l1; l2 < recordList.Count; ++l2){
					
					if(recordList[l1].G > recordList[l2].G){

						Square s = recordList[l1];
						recordList[l1] = recordList[l2];
						recordList[l2] = s;
					}
				}
			}

			int[] path = new int[B.G + 1];//Debug.Log("Path.Length = " + path.Length);
			int i = 0;
			int runTime = 0;
			//debug
			/*for(i = 0; i < recordList.Count; ++i){

				Debug.Log(i + " --------------  " + recordList[i].ToString());
			}*/
			path[path.Length - 1] = recordList[recordList.Count - 1].index;
			path[0] = recordList[0].index;
			int c = path.Length - 2;
			int ki = path[path.Length - 1];
			int n = recordList.Count - 2;
			int fn = 99;
			do{
				//Debug.Log("C :: ==== " + c);
				fn = 99;
				for(i = n; i > 0; --i){

					runTime ++;
					//Debug.Log("c == " + c + " [a = " + ki + " , b = " + recordList[i].index  + " G = " + recordList[i].G + " ] , tt = ");
					if(c <= recordList[i].G){

						int tt = TestPath(ki , recordList[i].index);
						//Debug.Log("c == " + c + " [a = " + ki + " , b = " + recordList[i].index  + " G = " + recordList[i].G + " ] , tt = " + tt);
						if(c == recordList[i].G){


							/*if(-1 == nPathWeight){
							//不筛选
							//Debug.Log("nPathWeight = " + nPathWeight + " , " + tt + " , " + recordList[i].index);
							path[c] = recordList[i].index;
							break;
						}else if(0 == path[c] || tt != nPathWeight){
							//筛选走向
							//Debug.Log("nPathWeight = " + nPathWeight + " , " + tt + " , " + recordList[i].index);
							path[c] = recordList[i].index;
							if(tt != nPathWeight)break;
						}*/
							//Debug.Log("KI == " + c + " [a = " + ki + " , b = " + recordList[i].index  + "] , tt = " + tt);
							if(-1 != tt && fn > tt){
								
								path[c] = recordList[i].index;
								fn = tt;
								//Debug.Log("fn = " + fn);
							}
						}
					}else{

						//Debug.Log("Break : " + i);
						break;
					}
				}

				n = i;
				ki = path[c];
				c--;
				//Debug.Log("n = " + n + " ki = " + ki  + " c = " + c);
				
			}while(c > 0);

			//Debug.Log("Run time = " + runTime);
//			for(i = 0; i < path.Length; ++i){
//				
//				Debug.Log(i + "   " + path[i].ToString());
//			}
			return path;
		}else return null;
	}
	
	private Square tempSqa;
	Square GetLowerValue(){

		tempSqa = null;
		//优先选择最近一次
		//Debug.Log("CurrentList.Count = " + currentList.Count);
		if(0 != currentList.Count){

			tempSqa = currentList[0];
			for(int i = 0; i < currentList.Count; ++i){

				//Debug.Log(tempSqa.ToString() + " --- " + sq.ToString() + " --- " + T.ToString());
				if(tempSqa.F > currentList[i].F){
					
					tempSqa = currentList[i];
				}//else if(tempSqa.F == currentList[i].F && nPathWeight == TestPath(currentList[i].index , T.index)){
					
					//Debug.Log("KK === " + sq.index + " , " + T.index + sq.ToString());
					//tempSqa = currentList[i];
				//}
			}
		}

		if(null == tempSqa)tempSqa = openList[0];
		for(int i = 0; i < openList.Count; ++i){
			
			if(tempSqa.F > openList[i].F){

				tempSqa = openList[i];
			}
		}
		return tempSqa;
	}

	private List<Square> directionlist = new List<Square>();
	private bool[] bs = new bool[4];
	//获得点的信息 0 1 2 3
	void GetDirectionIndex(int tarIndex){

		directionlist.Clear();
		int index;

		int x = tarIndex % rw;
		int y = tarIndex / rw;

		bs[0] = false;
		bs[1] = false;
		bs[2] = false;
		bs[3] = false;

		if(y + 1 < rh){

			//index = tarIndex + rw;
			//directionlist.Add(GetSquare(index));
			bs[2] = true;
		}

		if(y - 1 >= 0){

			//index = tarIndex - rw;
			//directionlist.Add(GetSquare(index));
			bs[0] = true;
		}

		if(x + 1 < rw){

			//index = tarIndex + 1;
			//directionlist.Add(GetSquare(index));
			bs[1] = true;
		}

		if(x - 1 >= 0){

			//index = tarIndex - 1;
			//directionlist.Add(GetSquare(index));
			bs[3] = true;
		}

		if(isbSlash){

			if(bs[0] && bs[1]){
				//上右
				index = tarIndex - rw + 1;
				directionlist.Add(GetSquare(index));
			}

			if(bs[1] && bs[2]){
				//右下
				index = tarIndex + rw + 1;
				directionlist.Add(GetSquare(index));
			}

			if(bs[2] && bs[3]){
				//下左
				index = tarIndex + rw - 1;
				directionlist.Add(GetSquare(index));
			}

			if(bs[3] && bs[0]){
				//左上
				index = tarIndex - rw - 1;
				directionlist.Add(GetSquare(index));
			}
		}


		if(bs[2]){
			
			index = tarIndex + rw;
			directionlist.Add(GetSquare(index));
		}
		
		if(bs[0]){
			
			index = tarIndex - rw;
			directionlist.Add(GetSquare(index));
		}
		
		if(bs[1]){
			
			index = tarIndex + 1;
			directionlist.Add(GetSquare(index));
		}
		
		if(bs[3]){
			
			index = tarIndex - 1;
			directionlist.Add(GetSquare(index));
		}

	}
	
	//   2  
	//0     1 
	//   3  
	//
	int TestPath(int currentIndex , int preIndex){

		int a1 = currentIndex % rw;
		int b1 = currentIndex / rw;
		int a2 = preIndex % rw;
		int b2 = preIndex / rw;

		if(a1 - a2 == 1 && b1 == b2){

			return 1;//horizontal
		}

		if(a1 - a2 == -1 && b1 == b2){
			
			return 1;//horizontal
		}

		if(b1 - b2 == 1 && a1 == a2){
			
			return 0;//Vertical
		}

		if(b1 - b2 == -1 && a1 == a2){
			
			return 0;//Vertical
		}

		if(isbSlash){

			if(Mathf.Abs(a1 - a2) == 1 && Mathf.Abs(b1 - b2) == 1){
				
				return 2;
			}
		}
		return -1;
	}

	//清除记录
	void Clean(){

		for(int i = 0; i < allList.Length; ++i){

			allList[i].Clean();
		}
	}
	
	Square GetSquare(int index){

		return allList[index];
	}

	/// <summary>
	/// Gets the index position. 获取假意坐标点
	/// </summary>
	/// <returns>The index position.</returns>
	/// <param name="i">The index.</param>
	private Vector2 GetPosByIndex(int i){

		return new Vector2 (i % rw * 4, i / rw * 4);
	}

	/// <summary>
	/// Gets the index of the position by.
	/// </summary>
	/// <returns>The position by index.</returns>
	/// <param name="v">V.</param>
	private int GetIndexByPos(Vector2 v){

		return (int)(v.x / 4) + (int)(v.y / 4) * rw;
	}

	Vector2 ns = Vector2.zero;
	Vector2 ne = Vector2.zero;
	Vector2 nr = Vector2.zero;
	int len = 0;
	public bool IsExitBarrier(int startIndex , int endIndex){

		ns = GetPosByIndex(startIndex);
		ne =  GetPosByIndex(endIndex);
		nr = ne - ns;
		len = (int)Vector2.Distance(Vector2.zero , nr);
		nr = nr.normalized;
		
		//Debug.Log("nStart = {" + nStart + " , " + mPath[nStart] + "} nEnd = {" + nEnd + " , " + mPath[nEnd] + "} len = " + len + ", ns = " + ns);
		//判断两点之间是否有障碍
		for(int j = 0; j < len; ++j){
			
			ns += nr;
			if(0 != m_data[GetIndexByPos(ns)]){
				//遇到障碍 跳出
				//Debug.Log("遇到障碍 : " + GetIndexByPos(ns));
				return true;
			}
		}
		return false;
	}
}