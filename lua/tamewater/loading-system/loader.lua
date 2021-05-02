TW_LOADINGSYSTEM = TW_LOADINGSYSTEM or {}
TW_LOADINGSYSTEM.RequiredAddons = TW_LOADINGSYSTEM.RequiredAddons or {}
TW_LOADINGSYSTEM.config = TW_LOADINGSYSTEM.config or {}
TW_LOADINGSYSTEM.Enums = TW_LOADINGSYSTEM.Enums or {}

include("sh_enums.lua")
include("sh_loading-meta.lua")
include("sh_config.lua")

if SERVER then
  util.AddNetworkString("TW.LOADINGSYSTEM.AskForDownload")

  AddCSLuaFile("sh_enums.lua")
  AddCSLuaFile("sh_loading-meta.lua")
  AddCSLuaFile("sh_config.lua")
  AddCSLuaFile("cl_core.lua")
  AddCSLuaFile("cl_addonMenu.lua")

  include("sv_core.lua")
end

if CLIENT then
  include("cl_core.lua")
  include("cl_addonMenu.lua")
end
