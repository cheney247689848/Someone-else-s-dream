--require "L_MetaData"
--require "Space_CacheTool.CacheTool"
local WWW = UnityEngine.WWW
local PlayerPrefs = UnityEngine.PlayerPrefs
local CacheTool = Space_CacheTool.CacheTool

local AssetBundle = UnityEngine.AssetBundle
local AssetBundleCreateRequest = UnityEngine.AssetBundleCreateRequest
local TextAsset = UnityEngine.TextAsset

--module(...,package.seeall)


--定义模块
L_UpdateStrategy = {}
setmetatable(L_UpdateStrategy, {__index = _G})
local _ENV = L_UpdateStrategy


Process_loadlocalview = {nTick = 0 , nTimer = 0}
Process_downLoadConf = {nTick = 0 , nTimer = 0}  -- 下载配置表
Process_updatescript = {nTick = 0 , nTimer = 0}  -- 更新script   启动资源更新script

--初始化热更界面
function Process_loadlocalview:Execute(nTime)

    print("--初始化热更界面--")
    _ENV.curProcess = _ENV.Process_downLoadConf
end

--下载配置表
function Process_downLoadConf:Execute(nTime)

    print("--下载配置表--")
    _ENV.curProcess = _ENV.Process_updatescript
end

--更新本地脚步
function Process_updatescript:Execute(nTime)

    --解包
    --释放脚步
    --启动脚步
    if self.nTick == 0 then
        
        self.nTick = 1
        print("--更新本地脚步--")
        print(_ENV.localPath)
        print(_ENV.persPath)
        _ENV.persPath = _ENV.persPath .. "/script"
        local bunReq = AssetBundle.LoadFromFileAsync(_ENV.localPath.."abundle_scriptlua")
        if bunReq.assetBundle == nil then
    
            print("Error IELoadBundle Failed to load AssetBundle")
            return nil
        end
        print("IEGetBudle Load Complete")
        
        local textAss = bunReq.assetBundle:LoadAllAssets(typeof(TextAsset))
        print(textAss.Length)
        --print(textAss[1].text)

        --先查找出
        local pathFile = nil
        for i = 1, textAss.Length - 1 , 1 do
            
            --print(textAss[i].name)
            if "L_PathInfo" == textAss[i].name then
            
                pathFile = textAss[i]
                break
            end
        end

        if pathFile == nil then
            
            print("Error no find the script : L_PathInfo ")
            return
        end

        --print(pathFile.text)
        local str = pathFile.text
        local str2 = string.gsub(str , "\\" , "/")
        local tb = loadstring("return ".. str2)
        local a = tb()
        print(a.L_Bundle)

        for i = 1, textAss.Length - 1 , 1 do
            
            if a[textAss[i].name] ~= nil then
                
                print(textAss[i].name , a[textAss[i].name])
                if CacheTool.IsDirectory(_ENV.persPath ..a[textAss[i].name]) == false then
                
                    CacheTool.CreatDirectory(_ENV.persPath ..a[textAss[i].name])
                end
                CacheTool.CreatFile(_ENV.persPath ..a[textAss[i].name].."/"..textAss[i].name ..".lua" , textAss[i].bytes)
            else
                
                print("Error no find the script : " .. textAss[i].name)
            end
        end
    end

    if self.nTick == 1 then
        
        
    end
end

function Process_updatescript:Exit()

    --退出转入热更后资源更新脚步
    UpdateBeat:Remove(_ENV.Update , _ENV)
end

function Process_updatescript:IELoadBundle()

    print("IELoadBundle Start To Load " .. bundleName)
    progress = 0;
    local bunReq = AssetBundle.LoadFromFileAsync(path)
	while not bunReq.isDone do
        progress = bunReq.progress;
		--print("Count: "..progress)
		coroutine.wait(0.02) 
	end
    coroutine.stop(IELoadBundle)
    progress = 1
    if bunReq.assetBundle == nil then
    
        print("Error IELoadBundle Failed to load AssetBundle")
        return nil
    end
    print("IEGetBudle Load Complete")
    cBundle = bunReq.assetBundle
    isLoad = false
    fCallBack(cBundle)
    bunReq = nil
    --fCallBack = nil
end


_ENV.curProcess = _ENV.Process_loadlocalview
function _ENV:Update()

    --print("update  ".. UnityEngine.Time.deltaTime)
    self.curProcess:Execute()
end
UpdateBeat:Add(_ENV.Update , _ENV)


       
















---------------------------------------------------------------------------------------------------------------------


--客户端版本信息
version = 0
--每个资源包的版本号
bundleInfo = {
    --{版本号，对应的bundleName}
    {101 , "abundle_scriptlua"},
    {101 , "abundle_login"},

	{101 , "abundle_audio"},
	{101 , "abundle_public"},
	
	{101 , "abundle_main"},
	{101 , "abundle_match"},
	{101 , "abundle_clean"},
	{101 , "abundle_raiders"},
	{101 , "abundle_battle"},

	{101 , "abundle_bar"},
	{101 , "abundle_card"},
	{101 , "abundle_library"},
	{101 , "abundle_pub"},
}
preLoaderInfos = {}
completeCallBack = nil
local US = L_UpdateStrategy
--校验版本信息
function CheckVersion(callBack)
    
    completeCallBack = callBack
    --PlayerPrefs.DeleteAll()
    --return
    --与服务器校验本地存储的信息
    for i = 1 , #L_MetaData.aBundles_Ver, 1 do
        
        local localVer_script = PlayerPrefs.GetInt(L_MetaData.aBundles_Ver[i][2])
        if localVer_script ~= L_MetaData.aBundles_Ver[i][1] then
        
            --添加更新
            print("添加更新 - "..L_MetaData.aBundles_Ver[i][1].." , "..L_MetaData.aBundles_Ver[i][2])
            --table.insert(preLoaderInfos , L_MetaData.aBundles_Ver[i])
            --PlayerPrefs.SetInt(L_MetaData.aBundles_Ver[i][2] , L_MetaData.aBundles_Ver[i][1])
        end
    end

    if #preLoaderInfos <= 0 then
        
        print("不需要更新")
        DownloadComplete()
    else
        
        cacheTool = CacheTool("Bundles")
        DownloadInfo()
    end
end

--
downDex = 0
function DownloadInfo()
    
    downDex = downDex + 1
    if downDex <= #preLoaderInfos then
        
        print(downDex)
        print(preLoaderInfos[downDex][2])
        LoadBundleFromWWW(preLoaderInfos[downDex][2] , DownloadInfo)
    else

        --结束更新
        DownloadComplete()
        fCallBack = nil
    end
    
end

function DownloadComplete()
    
    completeCallBack()
    --free
    completeCallBack = nil
    preLoaderInfos = nil
end

cacheTool = nil
bundleName = nil
fCallBack = nil
url = "http://47.90.58.224/"
path = nil
isLoad = false
process = 0
function LoadBundleFromWWW(bName , call)
    
    if isLoad == false then
    
       bundleName = tostring(bName)
       fCallBack = call
       path = url..bundleName..".unity3d"
       --print(self.path)
       isLoad = true
       print("开始下载 " .. bundleName)
       coroutine.start(IELoadBundle)
    end
end

function IELoadBundle()

    print(path)
    local www = WWW(path)
    while not www.isDone do
        
        progress = www.progress
        print(progress)
        coroutine.wait(0.02) 
    end
    if 0 >= www.bytes.Length then
    
        print("下载失败\n" .. www.error);
    else
        progress = 1
        print("下载完成")
        --CreatFile
        cacheTool:CreatFile(bundleName , www.bytes)
    end
    www:Dispose()
    www = nil
    isLoad = false
    path = nil
    fCallBack()
    coroutine.stop(IELoadBundle)
end