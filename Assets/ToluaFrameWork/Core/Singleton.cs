using UnityEngine;

public abstract class Singleton<T> where T : class, new()
{

    protected static T m_Instance = new T();

    protected Singleton()
    {
        if (null != m_Instance)
            throw new SingletonException("This " + (typeof(T)).ToString() + " Singleton Instance is not null !!!");
    }

    public static T Instance
    {
        get { return m_Instance; }
    }

    public virtual void Init() {}
}

public class SingletonException : System.Exception
{
    public SingletonException(string msg): base(msg){}
}