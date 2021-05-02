--[[
  Creates addon object and begins loading process. Called by client (console command)
  ARGS:
  WorkshopID | string
]]
concommand.Add("tw_loadAddon", function(ply, string, args, argStr)
  if not table.HasValue({"chiefexecutive", "executive", "hod"}, ply:GetUserGroup()) then print("You do not have permission to use this command");return; end
  if not args[1] then TW_LIB.Print("Loading-System", "Invalid Arguement [1] - Workshop ID | String");return; end
  local id = tonumber(args[1])
  TW_LOADINGSYSTEM:AskServerLoad({id})
end)

concommand.Add("tw_addonMenu", function(ply, string, args, argStr)
  TW_LOADINGSYSTEM:OpenAddonMenu()
end)

--[[
  Asks the server to load a table of addons
  ARGS:
  Table of WorkshopID | table string
]]
function TW_LOADINGSYSTEM:AskServerLoad(addons)
  netstream.Start("TW.LOADINGSYSTEM.AskServerLoad", addons) -- Target might be wrong
end

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
  Creates addon object and begins loading process. Called from server
  ARGS:
  WorkshopID | string
]]
local function DownloadAddon(addonsNetworked)
  local addons = TW_LOADINGSYSTEM:GetRequiredAddons()
  for k,v in pairs(addonsNetworked) do
    if not addons[v] then
        local addon = TW_LOADINGSYSTEM:AddRequiredAddon(v)
        if addon then
            addon:StartLoading()
        end
    else
        if not addons[v]:IsMounted() then
            addons[v]:StartLoading()
        else
            TW_LIB.Print("Loading-System", string.format('Workshop Addon: [%s] | Cancelling load: Already Mounted', addons[v]:GetWSID()))
        end
    end
  end
end
netstream.Hook("TW.LOADINGSYSTEM.DownloadAddon", DownloadAddon)
