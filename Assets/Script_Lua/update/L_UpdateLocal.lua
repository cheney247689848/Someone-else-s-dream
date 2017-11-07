-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
--流程
--获取本地版本号
--获取网上版本号
--对比版本号（添加下载队列）
--下载
--解压

--加载 lua mainifest 文件
--加载所有lua.unity3d
--启动登陆场景
-------------------------------------------------------------------

local GameObject = UnityEngine.GameObject
local WWW = UnityEngine.WWW
local AssetBundle = UnityEngine.AssetBundle
local AssetBundleCreateRequest = UnityEngine.AssetBundleCreateRequest
local TextAsset = UnityEngine.TextAsset
local StreamWriter = require "System.IO.StreamWriter"
local StreamReader = require "System.IO.StreamReader"
local File = require "System.IO.File"

require "AppConst"
require "MgrLuaInterp"
require "MgrLuaThread"
require "ZipTool"
require "CacheTool"
require "update/L_UpdateConfig"
require "update/L_UpdateView"
require "GameLaunch"



--定义模块
L_UpdateLocal = {}
setmetatable(L_UpdateLocal, {__index = _G})
local _this = L_UpdateLocal

_this.updateObject = nil
_this.localVers = 1
_this.cdnVers = {}
_this.ztool = nil
_this.zipList = nil
_this.isZipMode = false
_this.isZipRunning = false
_this.view = nil

function _this.StartTest()

    print(string.format( "---StartTest--- persPath = %s", _this.persPath))
    _this.view = L_UpdateView
    _this.view:Init()
    _this.view:UpdateLabel("读取配置表.")

    if AppConst.isUpdateMode then
        
        _this.updateObject = GameObject.New()
        _this.updateObject.name = "updateObject"
        coroutine.start(_this.IECheckVersion) --start
    else

        coroutine.start(_this.IEChangeToGame)
        -- _this:ChangeToGame()
    end
end

function _this.IECheckVersion()

    local localPath = _this.persPath .. "/Version"
    if File.Exists(localPath) then
        
        local reader = StreamReader.New(localPath);
        local str = reader:ReadLine()
        reader:Close()
        if str ~= nil then
        
            local vs = {}
            for ver in string.gfind(str, '[%d]+') do

                table.insert( vs, tonumber(ver) )
            end
            if #vs == 2 and L_UpdateConfig.sourceVersion == vs[1] then
                
                _this.localVers = vs[2]
                print(string.format( "local version = %d", _this.localVers))
            else

                print("Error sourceVersion ")
                coroutine.stop(_this.IECheckVersion) --stop
                return
            end
            vs = nil
        end
        str = nil
    else

        print("no local version ")
    end
    while _this.isLoad do
            
        coroutine.wait(0.02)
    end
    _this.view:UpdateLabel("对比版本.")
    _this:LoadBundleFromWWW(L_UpdateConfig.cdnUrl .. "/" .. L_UpdateConfig.sourceVersion .. "/" .. _this.platform .. "/Version" , function (txt)

        if txt ~= nil then
            
            for ver in string.gfind(txt, '[%d]+') do
                if tonumber(ver) > _this.localVers then
                    --添加版本
                    table.insert( _this.cdnVers, tonumber(ver))
                end
            end
            print(string.format( "update list count = %d ", #_this.cdnVers))
            coroutine.start(_this.IELoadBundleFormUrl)
        end
    end , 1)
    coroutine.stop(_this.IECheckVersion) --stop
end

function _this.IELoadBundleFormUrl()
    local time = Time.time
    _this.ztool = _this.updateObject:AddComponent(typeof(ZipTool))
    _this.isZipMode = true
    _this.zipList = {}
    coroutine.start(_this.ZipDequeue)
    while  #_this.cdnVers > 0 do
        
        local ver = _this.cdnVers[1]
        local path = string.format( "%s/%d/%s/%s/%s.zip", L_UpdateConfig.cdnUrl ,
                                                            L_UpdateConfig.sourceVersion , 
                                                            ver ,
                                                            _this.platform ,
                                                            _this.platform)
        table.remove( _this.cdnVers, 1)
        _this:LoadBundleFromWWW(path , function (bytes)
            --empty
            if bytes ~= nil then

                local outPath = string.format("%s/%s_%d.zip" , _this.persPath , _this.platform , ver)
                CacheTool.CreatFile(outPath , bytes)
                --ztool:UnPackage(outPath , _this.persPath)
                table.insert( _this.zipList, {outPath , _this.persPath , ver})
            end
        end , 2)
        while _this.isLoad do

            _this.view:UpdateLabel(string.format( "下载版本......%d%%", _this.progress * 100))
            coroutine.wait(0.02)
        end
    end

    _this.view:UpdateLabel("正在解压......")
    print("等待解压完成")
    --等待解压完成
    while #_this.zipList > 0 or _this.isZipRunning do

       coroutine.wait(0.02)
    end
    print("全部解压完成")
    _this.view:UpdateLabel("解压完成......")
    _this.isZipMode = false
    _this.zipList = nil
    coroutine.stop(_this.ZipDequeue)   

    GameObject.Destroy(ztool)
    GameObject.Destroy(_this.updateObject)
    _this.ztool = nil
    _this.updateObject = nil
    print("IELoadBundleFormUrl Finsh : time = " .. (Time.time - time))

    --删除所有zip
    local files = CacheTool.GetAllFiles(_this.persPath , "*.zip")
    local len = files.Length
    for i = 0, len - 1 do
        CacheTool.DeleteFile(files[i])
    end
    coroutine.start(_this.IEChangeToGame)
end

function _this.ZipDequeue()
    
    while _this.isZipMode do
        
        if #_this.zipList > 0 and not _this.isZipRunning then
            
            _this.isZipRunning = true
            local zData = _this.zipList[1]
            GameLaunch.StartThread("L_UpdateLocal.UnZip" , zData[1] , zData[2] , zData[3])
        end
        coroutine.wait(0.02)
    end
end

function _this.UnZipFunc(oPath , pPath , ver)
    print('unzip start ... ' .. ver)
    _this.ztool:UnPackage(oPath , pPath , function ()
        
        print('unzip finsh ... ')
        _this.isZipRunning = false
        table.remove( _this.zipList, 1 )
        _this:RefreshVersion(string.format( "%d|%d", L_UpdateConfig.sourceVersion , ver ))
    end)
end

function _this.UnZip()   
       
    local co = coroutine.create(_this.UnZipFunc)                 
    return co
end

function _this:RefreshVersion(strVersion)
    
    print("RefreshVersion : " .. strVersion)
    local localPath = _this.persPath .. "/Version"
    local writer = StreamWriter.New(localPath);
    writer:Write(strVersion)
    writer:Flush()
    writer:Close()
    writer = nil
end

--加载mainifest文件
--加载所有 lua assets
function _this:IEChangeToGame()
    
    if AppConst.isZip then
        
        _this.view:UpdateLabel("加载 Assets......")
        local mainifestBundle = _this:LoadLuaFile("luaScript")
        local mainfest = mainifestBundle:LoadAsset("AssetBundleManifest")
        local bundlePaths = mainfest:GetAllAssetBundles()
        for i = 0, bundlePaths.Length - 1 do

            --print('Array: '..tostring(bundlePaths[i]))
            local name = tostring(bundlePaths[i])
            if name ~= "lua_update" then
            
                local bundle = _this:LoadLuaFile(name)
                MgrLuaInterp.AddSearchBundle(name , bundle)
                bundle:Unload(true)
                bundle = nil
                coroutine.wait(0.02)
            end
        end
        mainifestBundle:Unload(true)
        mainifestBundle = nil        
    end

    coroutine.stop(_this.IEChangeToGame) 
    _this.view:UpdateLabel("启动中......")
    require "L_Game"
    Launch()
end

_this.fCallBack = nil
_this.isLoad = false
_this.progress = 0
--==============================--
--desc:
--time:2017-09-20 06:25:41
--@path:
--@call:
--@type: 0:assetbundle 1:txt 2:bytes
--@return 
--==============================--
function _this:LoadBundleFromWWW(path , call , type)
    
    if self.isLoad == false then

       self.fCallBack = call
       self.isLoad = true
       print("load start : " .. path)
       coroutine.start(self.IELoadBundle , path , type)
    end
end

function _this.IELoadBundle(path , type)

    local www = WWW(path)
    while not www.isDone do
        
        _this.progress = www.progress
        --print(string.format( "progress : %d", _this.progress))
        coroutine.wait(0.02)
    end
    if 0 >= www.bytes.Length then
    
        print("load error \n" .. www.error);
        _this.fCallBack(nil)
    else
        _this.progress = 1
        print("load finsh : len = " .. www.bytes.Length)    
        if type == 1 then
            _this.fCallBack(www.text)
        elseif type == 2 then
            _this.fCallBack(www.bytes)
        else
            _this.fCallBack(www.assetBundle)
        end
    end
    coroutine.stop(_this.IELoadBundle)
    _this.isLoad = false
    www:Dispose()
    www = nil
end

function _this:LoadLuaFile(bundleName)
    
    local path = string.format( "%s/%s/%s", AppConst.boxAssetDir , AppConst.boxLuaDirName , bundleName)
    if not CacheTool.IsFile(path) then
        
        path = string.format( "%s/%s/%s", AppConst.AssetDir , AppConst.luaDirName , bundleName)
    end
    print(path)
    return AssetBundle.LoadFromFile(path)
end
