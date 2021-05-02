local META = TW_LOADINGSYSTEM.ADDONMETA or {}
META.__index = META

--[[
  Called when object is created. Checks for number workshop id and assigns the id to the metatable
  ARGS:
  WorkshopID | string
  RETURNS:
  ADDONMETA or False | metatable or boolean
]]
function META:__call(id)
  if type(id) == 'number' then
    self.WorkshopID = id
    return self
  else
    TW_LIB.Print("Loading-System", "Invalid Arguement [1] - Workshop ID | Number")
    return false
  end
end

--[[
  Returns the string format of the object. Concatenated workshop id and loading status.
  RETURNS:
  Metatable info | string
]]
function META:__tostring()
  return string.format("Workshop Addon: [%s] | Load Status: [%s]", self:GetWSID(), self:GetMountStatus())
end

--[[
  Tests for equal addon objects. Used to stop from duplicating addon objects
  RETURNS:
  Are addon IDs equal | boolean
]]
function META:__eq(other)
  return self:GetWSID() == other:GetWSID()
end

--[[
  Begins loading process for addon. Checks for assigned workshop id.
]]
function META:StartLoading()
  if not self:IsValid() then return false end
  if self:IsMounted() then
    TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Already Mounted', self:GetWSID()))
    return
  end
  self:IsAddonWhitelisted()
end

--[[
  Compares the stored workshop ID to the list of whitelisted IDs. Sends addon for download/mount.
]]
function META:IsAddonWhitelisted()
  if not self:GetWSID() then TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Loading Failed', self:GetWSID())); return false; end
  if not TW_LOADINGSYSTEM.Config.WhitelistedAddons[tostring(self:GetWSID())] then TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Loading Failed, tried to load unwhitelisted addon', self:GetWSID())); return false; end
  if CLIENT then
    local downloaded, path = self:IsDownloaded()
    if downloaded then
      self.LoadStatus = TW_LOADINGSYSTEM.Enums.LOADING_STATUS.DOWNLOADED
      self:MountAddon(path)
    else
      self:ValidWorkshopAddon()
    end
  else
    self:MountAddon("gmas/"..self:GetWSID()..".gma")
  end
end

--[[
  Checks if workshop addon is 1. Within size limit 2. Not already installed 3. Not disabled. Calls addon download if cleared.
]]
function META:ValidWorkshopAddon()
  if self.LoadStatus == TW_LOADINGSYSTEM.Enums.LOADING_STATUS.WORKSHOP_CLEARED then
    self:DownloadAddon()
  else
    steamworks.FileInfo(self:GetWSID(), function(result)
      -- Make sure the size of the addon isn't over the limit, isn't already installed, and addon isn't disabled
      if result.size > TW_LOADINGSYSTEM.Config.MaxAddonSizeBytes then TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Size too big ([%s])', self:GetWSID(), result.size)); return; end
      if result.installed then TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Already Installed', self:GetWSID())); return; end
      if result.disabled then TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Addon Disabled', self:GetWSID())); return; end
      if result.size == 0 then TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Invalid Addon (0 Byte)', self:GetWSID())); return; end
      self.LoadStatus = TW_LOADINGSYSTEM.Enums.LOADING_STATUS.WORKSHOP_CLEARED
      self:DownloadAddon()
    end)
  end
end

--[[
  Begins WorkshopUDC download. OnSuccess, Mark as downloaded and call mount. OnFailure, mark back to workshop cleared.
]]
function META:DownloadAddon()
  -- Addon passed all checks, begin download
  self.LoadStatus = TW_LOADINGSYSTEM.Enums.LOADING_STATUS.DOWNLOADING
  steamworks.DownloadUGC(self:GetWSID(), function(path, file)
    if path ~= nil then
      self.LoadStatus = TW_LOADINGSYSTEM.Enums.LOADING_STATUS.DOWNLOADED
      self:MountAddon(path)
    else
      TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Download Failed', self:GetWSID()))
      self.LoadStatus = TW_LOADINGSYSTEM.Enums.LOADING_STATUS.WORKSHOP_CLEARED
    end
  end)
end

--[[
  Mounts addon to the player's game. OnSuccess, mark as mounted. OnFailure, mark back as downloaded.
]]
function META:MountAddon(path)
  --if self.LoadStatus != TW_LOADINGSYSTEM.Enums.LOADING_STATUS.DOWNLOADED then TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling Mount: Addon not downloaded', self:GetWSID())); return; end
  TW_LOADINGSYSTEM.CURRENTLY_LOADING = true
  local success, result = game.MountGMA(path)
  if success then
      self.LoadStatus = TW_LOADINGSYSTEM.Enums.LOADING_STATUS.MOUNTED
      TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Mount successful', self:GetWSID()))
      TW_LOADINGSYSTEM.CURRENTLY_LOADING = false
      --self:ReloadAddon(result)
  else
      TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Mount Failed', self:GetWSID()))
      self.LoadStatus = TW_LOADINGSYSTEM.Enums.LOADING_STATUS.DOWNLOADED
  end
end

--[[
  Reloads all init.lua serverside files from the addon. Sends a message to the client to do the same with cl_init.lua
  ARGS:
  Files that were added | table string
]]
function META:ReloadAddon(files)
  if SERVER then
    for i=1, #files do
        if string.StartWith(files[i], "lua/") then
            if string.StartWith(files[i], "lua/autorun") and not string.StartWith(files[i], "lua/autorun/client/") then
                AddCSLuaFile(string.sub(files[i], 5))
                ENT = {}
                include(string.sub(files[i], 5))
                ENT = nil
            elseif string.find(files[i], "cl_") or string.EndsWith(files[i], "shared.lua")then
                AddCSLuaFile(string.sub(files[i], 5))
            elseif string.EndsWith(files[i], "init.lua") or string.find(files[i], "sv_") then
                ENT = {}
                include(string.sub(files[i], 5))
                if string.StartWith(files[i], "lua/entities") then
                scripted_ents.Register(ENT, string.sub(files[i], 14, string.len(files[i])-9))
                end
                ENT = nil
            elseif string.StartWith(files[i], "lua/entities") then
                AddCSLuaFile(string.sub(files[i], 5))
                ENT = {}
                include(string.sub(files[i], 5))
                scripted_ents.Register(ENT, string.sub(files[i], 14, string.len(files[i])-4))
                ENT = nil
            end
        end
    end
  else
    local _include = include
    include = function(path)
        local files, directories = file.Find(TW_LOADINGSYSTEM.curPath.."/"..path, "lcl")
        if files then
            ENT = {}
            local entity = CompileString(file.Read(TW_LOADINGSYSTEM.curPath.."/"..path, 'lcl'), "TW.LOADINGSYSTEM", false)
            entity()
        end
    end

    --[[

        FIX THIS GODDAMN CODE IM GONNA CRY

    ]]
    for i=1, #files do
        TW_LOADINGSYSTEM.curPath = ""
        if string.StartWith(files[i], "lua/") then
            local filesTable, directories = file.Find(files[i], "LUA")
            PrintTable(filesTable)
            if filesTable then
                TW_LOADINGSYSTEM.curPath = directories[1]
                ENT = {}
                local entity = CompileString(file.Read(filesTable[1], 'lcl'), "TW.LOADINGSYSTEM", false)
                entity()
            end
        end
    end
    include = _include
  end
end

--[[

    if string.StartWith(files[i], "lua/autorun/") then
        ENT = {}
        local entity = CompileString(file.Read(string.sub(files[i], 5), 'LUA'), "TW.LOADINGSYSTEM")
        entity()
        print(string.sub(files[i], 5))
        PrintTable(ENT)

    ENT = {}
    local entity = CompileString(file.Read(string.sub(files[i], 5), 'LUA'), "TW.LOADINGSYSTEM")
    entity()
    print(string.sub(files[i], 5))
    PrintTable(ENT)
    scripted_ents.Register(ENT, string.sub(files[i], 14, string.len(files[i])-12))
]

--[[
  Checks if there is an assigned workshop ID
  RETURNS:
  is ID present | boolean
]]
function META:IsValid()
  return self:GetWSID() ~= nil
end

--[[
  Checks if an addon is mounted already.
  RETURNS:
  is addon mounted | boolean
]]
function META:IsMounted()
  local addons = engine.GetAddons()
  local id = tostring(self:GetWSID())
  for i=1, #addons do
    if addons[i].wsid == id then
      return addons[i].mounted
    end
  end
end

--[[
  Checks if an addon is downloaded already.
  RETURNS:
  is addon downloaded | boolean
]]
function META:IsDownloaded()
  local addons = engine.GetAddons()
  local id = tostring(self:GetWSID())
  for i=1, #addons do
    if addons[i].wsid == id then
      return addons[i].downloaded, addons[i].file
    end
  end
end

--[[
  Gets the string format of the loading status.
  RETURNS:
  load status | string
  enum value | number
]]
function META:GetMountStatus()
  if self.LoadStatus == 0 then
    return "NONE", 0
  elseif self.LoadStatus == 10 then
    return "WORKSHOP_CLEARED", 10
  elseif self.LoadStatus == 15 then
    return "DOWNLOADING", 15
  elseif self.LoadStatus == 20 then
    return "DOWNLOADED", 20
  elseif self.LoadStatus == 30 then
    return "MOUNTED", 30
  end
end

--[[
  Gets the workshop ID assigned to the addon object
  RETURNS:
  WorkshopID | string
]]
function META:GetWSID()
  return self.WorkshopID
end

TW_LOADINGSYSTEM.ADDONMETA = META
