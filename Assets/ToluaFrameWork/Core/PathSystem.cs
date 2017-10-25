using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Text;

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
		
		return index + " , F = " + F + " , G = " + G + " , H = " + H;
	}
}

public class PathSystem {
	
	//test
	//public int nPos = 0;
	public int[] data;
	private int rh = 2;
	private int rw = 2;

	//data
	private List<Square> allList;
	private List<Square> openList;
	private List<Square> closeList;
	private List<Square> currentList;
	private List<Square> recordList;
	
	private Square A;
	private Square B;
	private Square C;
	private Square T;
	
	private bool isFindThePath = false;
	
	public PathSystem(int h , int w){
		
		rh = h;
		rw = w;
	}
	
	// Use this for initialization
	public void Init () {
		
		if(null == data){
			Debug.Log("Path data = null");
			return ;
		}

		StringBuilder s = new StringBuilder();
		for (int i = 0; i < data.Length; i++)
		{
			s.Append(data[i] + ",");
		}
		Debug.Log(s.ToString());
		
		allList = new List<Square>();
		for(int i = 0; i < data.Length; ++i){
			
			allList.Add(new Square());
			allList[i].index = i;
		}
		openList = new List<Square>();
		closeList = new List<Square>();
		currentList = new List<Square>();
		recordList = new List<Square>();
	}
	
	//清除记录
	void Clean(){
		
		foreach(Square sqa in allList){
			
			sqa.Clean();
		}
	}
	
	//寻找路径
	public int[] FindThePath(int oriIndex , int tarIndex){
        //Debug.LogWarning(oriIndex + " move to " + tarIndex);
        if (oriIndex == tarIndex) return new int[1] { tarIndex };
		if(oriIndex < 0 || oriIndex >= data.Length || 0 != data[oriIndex] ||
            tarIndex < 0 || tarIndex >= data.Length || 0 != data[tarIndex]) return new int[1] { oriIndex };
		//CLEAN
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
		//T = A;
		//将A点添加到close列表中
		openList.Add(A);
		do{
			//计算最小
			C = GetLowerValue();
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
			List<Square> sqas = GetDirectionIndex(C.index);
			currentList.Clear();
			foreach(Square sqa in sqas){

				if(closeList.Contains(sqa)){
					
					continue;
				}
				
				if(!openList.Contains(sqa)){
					
					//openList.Add(sqa);
					if(0 == data[sqa.index]){
						openList.Add(sqa);
						sqa.G = C.G + 1;
						sqa.H = Mathf.Abs(B.index % rh - sqa.index % rh) +  Mathf.Abs(B.index / rh - sqa.index / rh);
						sqa.F = sqa.G + sqa.H;
						currentList.Add(sqa);
					}else{
						
						closeList.Add(sqa);
					}
					
				}else{
					//已经存在于列表中
					if(sqa.G > C.G + 1){
						
						sqa.G = C.G + 1;
						sqa.F = sqa.G + sqa.H;
					}
					currentList.Add(sqa);
				}
			}
			//计算最小F值   C
			//添加到open列表中
			//
		}while(0 != openList.Count);
		
		if(isFindThePath){			
			
			int[] path = new int[B.G + 1];
			int i = 0;
			/*for(i = 0; i < recordList.Count; ++i){
				Debug.Log(i + " --------------  " + recordList[i].ToString());
			}*/
			for(i = recordList.Count - 2; i > 0; --i){
				
				if(recordList[i + 1].G - recordList[i].G != 1 || !TestPath(recordList[i].index , recordList[i + 1].index)){
					
					recordList.RemoveAt(i);		
				}
			}
			
			for(i = 0; i < recordList.Count; ++i){
				
				//Debug.Log(i + "   " + recordList[i].ToString());
				path[i] = recordList[i].index;
			}
			return path;
		}else return null;
	}
	
	private Square tempSqa;
	Square GetLowerValue(){
		tempSqa = null;
		//优先选择最近一次
		if(0 != currentList.Count){
			tempSqa = currentList[0];
			foreach(Square sq in currentList){
				
				if(tempSqa.F > sq.F){
					
					tempSqa = sq;
				}
			}
			//return sqa;
		}
		if(null == tempSqa){
			tempSqa = openList[0];
		}
		
		foreach(Square sq in openList){
			
			if(tempSqa.F > sq.F){
				
				tempSqa = sq;
			}
		}
		return tempSqa;
	}
	
	//获得点的信息 0 1 2 3
	List<Square> GetDirectionIndex(int tarIndex){
		
		int index;
		List<Square> sqlist = new List<Square>();
		index = tarIndex + rw;
		if(index < data.Length && index >= 0)sqlist.Add(GetSquare(index));

		index = tarIndex + 1;
		if(index < data.Length && index >= 0 && index / rw == (index - 1)/ rw)sqlist.Add(GetSquare(index));
		
		index = tarIndex - rw;
		if(index < data.Length && index >= 0)sqlist.Add(GetSquare(index));
		
		index = tarIndex - 1;
		if(index < data.Length && index >= 0 && index / rw == (index + 1)/ rw)sqlist.Add(GetSquare(index));
		return sqlist;
	}
	
	bool TestPath(int currentIndex , int preIndex){
		
		if(currentIndex + 1 == preIndex)return true;
		if(currentIndex - 1 == preIndex)return true;
		if(currentIndex + rw == preIndex)return true;
		if(currentIndex - rh == preIndex)return true;
		return false;
	}
	
	Square GetSquare(int index){
		
		Square sq = allList[index];
		return sq;
	}
}