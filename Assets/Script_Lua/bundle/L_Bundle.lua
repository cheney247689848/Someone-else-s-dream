-------------------------------------------------------------------
-- The Long night
-- The night gives me black eyes, but I use it to find the light. 
-- In 2017
-------------------------------------------------------------------

local AssetBundle = UnityEngine.AssetBundle
local AssetBundleCreateRequest = UnityEngine.AssetBundleCreateRequest

L_Bundle = {}
setmetatable(L_Bundle, {__index = _G})
local _this = L_Bundle

_this.strMainifest = "StreamingAssets"
_this.mainifest = nil
_this.strMainifestBundles = nil

_this.persPath = ""  --沙盒路径
_this.localPath = "" --本地路径
_this.platform = nil
_this.progress = 0
_this.isLoad = false
_this.bundleName = ""
_this.path = ""

_this.fCallBack = nil
_this.cBundle = nil

_this.loadDataList = {}
_this.bundles = {}

function _this:AddBundle(bName , args)

    if self.bundles[bName] == nil then
    
        self.bundles[bName] = args
    end
end

function _this:GetBundle(bName)

    if self.bundles[bName] ~= nil then
    
        return self.bundles[bName]
    end
    print(string.format( "Error :: GetBundle name = %s ", bName ))
    return nil
end

function _this:RemoveBundle(bName)

    if self.bundles[bName] ~= nil then
    
        self.bundles[bName]:Unload(true)
        self.bundles[bName] = nil
    end
end

function _this:IsExistBundle(bName)

    if self.bundles[bName] ~= nil then
    
        return true
    end
    return false
end

function _this:LoadBundle(bName , call)


    if self.isLoad == false then
       self.isLoad = true
       local loadData = {["bundleName"] = bName , 
       ["call"] = call , 
       ["path"] = _this:GetPath(bName), --self.localPath..bName , 
       ["dependencies"] = {}}
       coroutine.start(self.IELoadBundle , loadData)
    else
        --添加到队列中
        table.insert(self.loadDataList, {bName , call})
    end
end

function _this.IELoadBundle(loadData)

    if _this.mainifest == nil then  
        print("Error : mainifest = nil")
        return
    end

    print(string.format( "Load bundle :  %s  " , loadData.bundleName ))
    local isEnd = false
    local assect = nil
    local ldata =  loadData
    while not isEnd do
        
        local bunReq = AssetBundle.LoadFromFileAsync(ldata.path)
        while not bunReq.isDone do
            coroutine.wait(0.02)
            --print(string.format( "Load bundle :  %d  " , _this.progress ))
        end
        if bunReq.assetBundle == nil then
        
            print("Error IELoadBundle Failed to load AssetBundle")
        else
            print("Load bundle : Complete " .. tostring(bunReq.assetBundle))
            _this:AddBundle(ldata.bundleName , bunReq.assetBundle)
            if assect == nil then 
                assect = bunReq.assetBundle  --只记录主bundle
            end
            if _this:IsMainifestContainAb(bunReq.assetBundle.name) then
                
                local depens = _this.mainifest:GetAllDependencies(bunReq.assetBundle.name):ToTable()
                if depens ~= nil then
                    
                    for i,v in ipairs(depens) do

                        print("关联" , v)
                        if not _this:IsExistBundle(v) then


                            local ld = {["bundleName"] = v , 
                                    ["call"] = nil , 
                                    ["path"] = _this:GetPath(v)}--_this.localPath..v}                
                            table.insert(ldata.dependencies ,ld)
                        end
                    end
                end
            end
        end
        --递归关联bundle
        if #loadData.dependencies > 0 then
            
            ldata =  loadData.dependencies[#loadData.dependencies]
            table.remove( loadData.dependencies, #loadData.dependencies )
        else
            isEnd = true
        end
    end
    loadData.call(assect)
    loadData = nil
    _this.isLoad = false

    --继续队列
    if #_this.loadDataList > 0 then
        
        local d = _this.loadDataList[1]
        table.remove(_this.loadDataList, 1)
        _this:LoadBundle(d[1] , d[2])
    end
end

function _this:InitMainifest(mainifestName)

    self.strMainifest = mainifestName
    print(self:GetPath(self.strMainifest))
    local bundle = AssetBundle.LoadFromFile(self:GetPath(self.strMainifest))
    self.mainifest = bundle:LoadAsset("AssetBundleManifest")
    if self.mainifest == nil then
        
        print("Error : mainifest = nil")
    else
        self.strMainifestBundles = self.mainifest:GetAllAssetBundles():ToTable()
    end
end

function _this:IsMainifestContainAb(abName)
    
    for i,v in ipairs(self.strMainifestBundles) do
        if v == abName then
            
            return true
        end
    end
    return false    
end

function _this:Repeat()


end


function _this:GetProgress()

    return progress
end

function _this:IsLoading()

    return isLoad
end

function _this:GetPath(bundleName)
    
    local path = self.persPath .. bundleName
    if not CacheTool.IsFile(path) then
        
        path = self.localPath .. bundleName
    end
    return path
end

--function fib(n)
--    local a, b = 0, 1
--    while n > 0 do
--        a, b = b, a + b
--        n = n - 1
--    end
--
--    return a
--end
--
--function CoFunc()
--    print('Coroutine started')
--    local i = 0
--    for i = 0, 10, 1 do
--        print(fib(i))                    
--        coroutine.wait(0.1)						
--    end	
--	print("current frameCount: "..Time.frameCount)
--	coroutine.step()
--	print("yield frameCount: "..Time.frameCount)
--
--	local www = UnityEngine.WWW("http://www.baidu.com")
--	coroutine.www(www)
--	local s = tolua.tolstring(www.bytes)
--	print(s:sub(1, 128))
--    print('Coroutine ended')
--end
--
--function TestCortinue()	
--    coroutine.start(CoFunc)
--end
--
--local coDelay = nil
--
--function Delay()
--	local c = 1
--
--	while true do
--		coroutine.wait(1) 
--		print("Count: "..c)
--		c = c + 1
--	end
--end
--
--function StartDelay()
--	coDelay = coroutine.start(Delay)
--end
--
--function StopDelay()
--	coroutine.stop(coDelay)
--end