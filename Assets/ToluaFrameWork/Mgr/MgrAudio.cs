using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace ToLuaFrameWork
{

    public struct LoopVoice
    {
        public float cTime;
        public float tTime;
        public AudioSource sour;
        public bool bBreak;
        public int nKey;
    }

    public class MgrAudio : MonoBehaviour
    {
        private Dictionary<string, AudioClip> clips = new Dictionary<string, AudioClip>();
        private Dictionary<string, AssetBundle> clipBundles = new Dictionary<string, AssetBundle>();
        private Dictionary<int, LoopVoice> loopVoices = new Dictionary<int, LoopVoice>();
        private int loopKey = 0;
        private AudioSource source;
        private AudioSource sourceEffect;

        /// <summary>
        /// Awake is called when the script instance is being loaded.
        /// </summary>
        void Awake()
        {
            this.gameObject.name = "MgrAudio";
            source = this.gameObject.AddComponent<AudioSource>();
        }

        /// <summary>
        /// Update is called every frame, if the MonoBehaviour is enabled.
        /// </summary>
        void Update()
        {
            
            if (loopVoices.Count > 0)
            {
                for (int i = loopVoices.Count; i > 0; i--)
                {
                    if (loopVoices[i].bBreak == true)
                    {
                        loopVoices.Remove(loopVoices[i].nKey);
                    }
                }
            }
        }

        public void AddBundle(AssetBundle bundle){

            if (!clipBundles.ContainsKey(bundle.name)){

                clipBundles.Add(bundle.name,bundle);
            }else{

                Debug.LogError(string.Format("Error : Bundle {0} is exist." , bundle.name));
            }            
        }

        public void RemoveBundle(AssetBundle bundle){

            if (clipBundles.ContainsKey(bundle.name)){

                clipBundles.Remove(bundle.name);
            }else{

                Debug.LogError(string.Format("Error : Bundle {0} is no exist." , bundle.name));
            }      
        }

        public AudioClip GetVoiceClip(string voiceName){

            AssetBundle ab = GetVoiceBundle(voiceName);
            if (ab != null){

                return ab.LoadAsset<AudioClip>(voiceName);
            }
            return null;
        }

        public AssetBundle GetVoiceBundle(string voiceName){

            foreach (KeyValuePair<string, AssetBundle> ab in clipBundles)
            {
                if (ab.Value.Contains(voiceName))
                {
                    return ab.Value;
                }
            }
            return null;
        }

        public void PlayVoice(string voiceName){

            PlayVoice(voiceName , 1);
        }

        public void PlayVoice(string voiceName , float fVolume){

            AudioClip c;
            if (clips.TryGetValue(voiceName , out c)){

                source.PlayOneShot(c , fVolume);
            }else{
                
                 c = GetVoiceClip(voiceName);
                 if (c != null)
                 {
                     source.PlayOneShot(c , fVolume);
                 }else
                 {
                     Debug.LogError(string.Format("Error : Cant not find the voice {0}." , voiceName));
                     return;
                 }
            }
            clips.Add(c.name , c);
        }

        public void PlayVoice(string voiceName , float fVolume , AssetBundle bundle){


        }

        public void PlayBgVoice(string voiceName){


        }

        public void PlayBgVoice(string voiceName , float fVolume){


        }        

        public void PlayBgVoice(string voiceName , float fVolume , AssetBundle bundle){


        }

        public void PlayLoopVoice(string voiceName){


        }

        public void PlayLoopVoice(string voiceName , float fVolume , float loopTime){

            AudioClip c = GetVoiceClip(voiceName);
            if (c != null){
                
                GameObject obj = new GameObject();
                obj.name = "loopVoice";
                AudioSource source = this.gameObject.AddComponent<AudioSource>();
                source.clip = c;
                source.loop = true;
                source.volume = fVolume;

                loopKey ++;
                LoopVoice lv;
                lv.cTime = 0;
                lv.tTime = loopTime;
                lv.sour = source;
                lv.bBreak = false;
                lv.nKey = loopKey;
                
                loopVoices.Add(lv.nKey ,lv);
            }else{

                //error
                Debug.LogError(string.Format("Error : Cant not find the voice {0}." , voiceName));
            }

        }

        public void StopLoopVoice(int key){

            LoopVoice lv;
            if (loopVoices.TryGetValue(key , out lv))
            {
                lv.bBreak = true;
            }else
            {
                Debug.LogError(string.Format("Error : Cant not find the key {0}." , key));
            }
        }

    }
}