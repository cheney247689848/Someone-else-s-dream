

using System;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

public class UguiTest : MonoBehaviour {

	// Use this for initialization11123
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
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    void OnClick_Tri() {

        print("OnClick_Tri");
    }

    void OnClick__Cal() {

        print("OnClick__Cal");

        
    }
}
