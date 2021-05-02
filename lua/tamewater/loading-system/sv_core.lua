--[[
  Creates addon object and begins loading process. Called by client (console command)
  ARGS:
  WorkshopID | string
]]
concommand.Add("tw_loadAddon", function(ply, string, args, argStr)
  if not args[1] then TW_LIB.Print("Loading-System", "Invalid Arguement [1] - Workshop ID | String");return; end
  local id = tonumber(args[1])
  local addon = TW_LOADINGSYSTEM:AddRequiredAddon(id)
  if not addon then TW_LIB.Print("Loading-System", "Broken ID - Workshop ID | String");return; end
  TW_LOADINGSYSTEM:RefreshAddons()
end)

--[[
  Add an Addon Object to the required addons (addons to be downloaded by the player), index is the ID
  ARGS:
  WorkshopID | string
  RETURNS:
  Required Addons | table
]]
function TW_LOADINGSYSTEM:AddRequiredAddon(id)
  addon = false
  if not TW_LOADINGSYSTEM.RequiredAddons[id] then
    addon = setmetatable({}, TW_LOADINGSYSTEM.ADDONMETA)(id)
    TW_LOADINGSYSTEM.RequiredAddons[id] = addon
    TW_LIB.Print("Loading-System", "Added "..id.." to Required Addons")
  end
  return addon
end

--[[
  Get the table of required addons
  RETURNS:
  Required Addons | table
]]
function TW_LOADINGSYSTEM:GetRequiredAddons()
  return self.RequiredAddons
end

--[[
  Forces all addons to be reloaded (serverside and clientside).
]]

function TW_LOADINGSYSTEM:RefreshAddons()
  TW_LIB.Print("Loading-System", "Refreshing Required Addons")
  local addons = self:GetRequiredAddons()
  -- Client load
  netstream.Start(nil, "TW.LOADINGSYSTEM.DownloadAddon", table.GetKeys(addons))
  -- Server load
  for id, addonMeta in pairs(addons) do
    if not addonMeta:IsMounted() then
      addonMeta:StartLoading()
    else
      TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Already Mounted', addonMeta:GetWSID()))
    end
  end
end

--[[
  Appends all the new addons to the required addons. Refreshes all server and client addons (downloads all).
  ARGS:
  Table WorkshopID | table string
]]
local function AskServerLoad(ply, addons)
  TW_LIB.Print("Loading-System", ply:Nick()..string.format("(%s) is adding to Required Addons", ply:SteamID()))
  for i=1, #addons do
    local addon = tostring(addons[i])
    if TW_LOADINGSYSTEM.Config.WhitelistedAddons[addon] then
      TW_LOADINGSYSTEM:AddRequiredAddon(tonumber(addon))
    else
      TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Loading Failed, tried to load unwhitelisted addon', addon))
    end
  end
  TW_LOADINGSYSTEM:RefreshAddons()
end
netstream.Hook("TW.LOADINGSYSTEM.AskServerLoad", AskServerLoad)

--[[
  Ask the player to download a set of addons
  ARGS:
  Player to download addons | PLAYER
  Addons to be downloaded | table
]]
local function AskClientLoad(target, addons)
  netstream.Start(target, "TW.LOADINGSYSTEM.DownloadAddon", addons)
  TW_LIB.Print("Loading-System", string.format('Player: %s | Sending addon download request to client', target:Name()))
end
hook.Add("SendDownloadRequest", "TW.LOADINGSYSTEM.AskClientLoad", AskClientLoad)

--[[
  Use hook.Call("SendDownloadRequest", nil, targets, addons)
  ARGS:
  targets | Single player or table of players or all players| PLAYER or table PLAYER or nil
  Addons to be downloaded | table
]]
hook.Add("PlayerInitialSpawn", "TW.LOADINGSYSTEM.SendInitialDownloads", function(ply)
  timer.Simple(10, function()   -- added timer for test purposes, remove later
    hook.Call("SendDownloadRequest", nil, ply, table.GetKeys(TW_LOADINGSYSTEM:GetRequiredAddons()))
  end)
end)

--[[
  Function to call when gamemode starts
]]
hook.Add("Initialize", "TW.LOADINGSYSTEM.AddingGamemodeHooks", function()
  -- Checks if config says the server is darkrp based, hooks load addons to players changing teams that have required addons --
  if TW_LOADINGSYSTEM.Config.IsDarkrpBased then
    hook.Add("PlayerChangedTeam", "TW.LOADINGSYSTEM.RequireAddonsOnJobChange", function(ply, oldTeam, newTeam)
      if not ply:IsValid() then return end
      local table = RPExtraTeams[newTeam]
      if table and table.RequiredAddons then
        for i=1, #table.RequiredAddons do
          TW_LOADINGSYSTEM:AddRequiredAddon(tonumber(table.RequiredAddons[i]))
        end
        hook.Call("SendDownloadRequest", nil, nil, table.RequiredAddons)
      end
    end)
  end
end)
