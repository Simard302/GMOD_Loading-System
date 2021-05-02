local addonsToAdd = {}

function TW_LOADINGSYSTEM:OpenAddonMenu()
  local main = vgui.Create( "DFrame" )
	main:SetSize( ScrW() * 0.8, ScrH() * 0.8 )
	main:Center()
	main:SetTitle( "" )
	main:MakePopup()
	main:ShowCloseButton( false )
	main.Paint = function(self, w, h)
		surface.SetDrawColor( 20, 20, 20, 230 )
		surface.DrawRect( 0, 0, w, h )
	end

  local close = vgui.Create( "DButton", main )
	close:SetSize( 30, 30 )
	close:SetPos( main:GetWide() - 35, 5 )
	close:SetText( "" )
	close.Paint = function(self, w, h)
		surface.SetDrawColor( 255, 0, 0, 255 )
		surface.DrawRect( 0, 0, w, h )
	end
	close.DoClick = function()
		main:Remove()
    addonsToAdd = {}
	end


  local addons = table.GetKeys(TW_LOADINGSYSTEM.Config.WhitelistedAddons)
  local addonMain = vgui.Create("DScrollPanel", main)
  addonMain:SetSize(main:GetWide()/2-30, main:GetTall()-55)
  addonMain:SetPos(15, 40)

  local addedAddonMain = vgui.Create("DScrollPanel", main)
  addedAddonMain:SetSize(main:GetWide()/2-30, main:GetTall()-100)
  addedAddonMain:SetPos(main:GetWide()/2, 40)
  addedAddonMain.Paint = function(self, w, h)
    surface.SetDrawColor( 100, 200, 100, 50 )
    surface.DrawRect( 0, 0, w, h )
  end


  local loadServerButton = vgui.Create("DButton", main)
  loadServerButton:SetPos(main:GetWide()/2, main:GetTall()-50)
  loadServerButton:SetSize(main:GetWide()/2-30, 40)
  loadServerButton:SetColor(Color(255, 255, 255))
  loadServerButton:SetText("Load Server")
  loadServerButton:SetFont("CloseCaption_Bold")
  loadServerButton.Paint = function(self, w, h)
    surface.SetDrawColor( 100, 200, 100, 50 )
    surface.DrawRect( 0, 0, w, h )
  end
  loadServerButton.DoClick = function()
    TW_LOADINGSYSTEM:AskServerLoad(addonsToAdd)
    main:Remove()
    addonsToAdd = {}
  end

  for k,v in pairs(TW_LOADINGSYSTEM.Config.AddonMenuTree) do
    local addonCategory = vgui.Create("DCollapsibleCategory", addonMain)
    addonCategory:SetSize(addonMain:GetWide()-30, 100)
    addonCategory:SetPos(15, 1)
    addonCategory:Dock(TOP)
    addonCategory:DockMargin(0, 10, 0, 0)
    addonCategory:SetLabel(k)
    addonCategory.Paint = function(self, w, h)
      if addonCategory:IsHovered() == true then
       --DrawBlur(self, 5)
        surface.SetDrawColor( 100, 200, 100, 50 )
        surface.DrawRect( 0, 0, w, h )
      else
        --DrawBlur(self, 5)
        surface.SetDrawColor( 34, 134, 34, 50 )
        surface.DrawRect( 0, 0, w, h )
      end
    end

    local addonCategoryPanel = vgui.Create("DScrollPanel")
    addonCategoryPanel:SetSize(addonCategory:GetWide(), addonCategory:GetTall())
    addonCategoryPanel.Paint = function(self, w, h)
      surface.SetDrawColor(100, 100, 100, 50)
      surface.DrawRect(0, 0, w, h)
    end

    for x,y in pairs(v) do

      local addonCollapse = vgui.Create("DCollapsibleCategory", addonCategoryPanel)
      addonCollapse:SetSize(addonCategoryPanel:GetWide(), 200)
      addonCollapse:Dock(TOP)
      addonCollapse:DockMargin(0, 10, 0, 0)
      addonCollapse:SetLabel(x)
      addonCollapse:SetPadding(100)
      addonCollapse.Paint = function(self, w, h)
        if addonCollapse:IsHovered() == true then
            --DrawBlur(self, 5)
            surface.SetDrawColor( 100, 200, 100, 50 )
            surface.DrawRect( 0, 0, w, h )
        else
          --DrawBlur(self, 5)
          surface.SetDrawColor( 34, 134, 34, 50 )
          surface.DrawRect( 0, 0, w, h )
        end
      end
      addonCollapse:SetExpanded(false)

      local addonPanel = vgui.Create("DPanel")
      addonPanel:SetSize(addonCollapse:GetWide(), 100)
      addonPanel.Paint = function(self, w, h)
        surface.SetDrawColor(100, 200, 100, 50)
        surface.DrawRect(5, 5, self:GetWide()-10, 50)
        surface.SetFont( "Default" )
	      surface.SetTextColor( 255, 255, 255 )
	      surface.SetTextPos( 10, 10 )
	      surface.DrawText( y.Description )
        surface.SetTextPos( 10, 25 )
	      surface.DrawText( y.Guidelines )
        surface.SetTextPos( 10, 40 )
	      surface.DrawText( y.Rules )
      end
      local addonID = vgui.Create("DLabel", addonPanel)
      addonID:SetSize(100, 20)
      addonID:SetPos(80, 60)
      addonID:SetText(y.Addon)

      local addAddon = vgui.Create("DButton", addonPanel)
      addAddon:SetSize(50, 20)
      addAddon:SetPos(10, 60)
      addAddon:SetText("Add")
      addAddon.DoClick = function()
        if not table.HasValue(addonsToAdd, y.Addon) then
          table.insert(addonsToAdd, y.Addon)
          local addedAddon = vgui.Create("DButton", addedAddonMain)
          addedAddon:SetSize(addedAddonMain:GetWide(), 20)
          addedAddon:Dock(TOP)
          addedAddon:DockMargin(5, 10, 5, 0)
          addedAddon:SetColor(Color(255, 255, 255))
          addedAddon:SetText("Remove: "..x.." ("..y.Addon..")")
          addedAddon.Paint = function(self, w, h)
            surface.SetDrawColor( 100, 200, 100, 50 )
            surface.DrawRect( 0, 0, w, h )
          end
          addedAddon.DoClick = function()
            addedAddon:Remove()
            table.RemoveByValue(addonsToAdd, y.Addon)
          end
        end
      end

      addonCollapse:SetContents(addonPanel)
    end
    addonCategory:SetContents(addonCategoryPanel)
    addonCategory:SetExpanded(false)
  end
end
