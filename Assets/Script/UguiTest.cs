

using System;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

public class UguiTest : MonoBehaviour {

	// Use this for initialization11123

    int angle = 0;
	void Start () {

        //Button b = this.gameObject.GetComponent<Button>();
        //b.onClick.AddListener(OnClick__Cal);
        //print("addListener");
      
        
        Debug.Log(0x00000001);
        Debug.Log(0x00000010);
        Debug.Log(0x00000100);
        Debug.Log(0x00001000);

        // AssetBundle bundle;
        // bundle.LoadAsset()
        // unit

        // GameObject.Instantiate()
        // transform.FindChild


        // var q =  Quaternion.Euler(0 , 30 , 0) * new Vector3(0 , 0 , 10);
        // Debug.Log(q);
	}
	
	// Update is called once per frame
	void Update () {
		
        var q =  Quaternion.Euler(0 , angle , 0) * new Vector3(0 , 0 , 10);
        if (angle % 90 == 0)
        {
            Debug.Log("angle = " + angle + " - " +  q);
        }
        
        angle ++;
	}

    void OnClick_Tri() {

        print("OnClick_Tri");
    }

    void OnClick__Cal() {

        print("OnClick__Cal");

        
    }
}
