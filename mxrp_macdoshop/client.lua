ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

local position = {
    {x = 281.85, y = -971.48, z = 28.40},
    {x = 280.36, y = -971.46, z = 28.40},
    {x = 278.91, y = -971.44, z = 28.40},
}   


mxrp_mcdo              = {}
mxrp_mcdo.DrawDistance = 100
mxrp_mcdo.Size         = {x = 1.0, y = 1.0, z = 1.0}
mxrp_mcdo.Color        = {r = 255, g = 0, b = 0}
mxrp_mcdo.Type         = 27

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (mxrp_mcdo.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < mxrp_mcdo.DrawDistance) then
                DrawMarker(mxrp_mcdo.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mxrp_mcdo.Size.x, mxrp_mcdo.Size.y, mxrp_mcdo.Size.z, mxrp_mcdo.Color.r, mxrp_mcdo.Color.g, mxrp_mcdo.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour commander Mcdo")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('mcdo', 'main'), not RageUI.Visible(RMenu:Get('mcdo', 'main')))
                end   
            end
        end
    end
end)

------------ Création du Menu -----------

RMenu.Add('mcdo', 'main', RageUI.CreateMenu("", "Bienvenue chez Mcdonald's"))
RMenu.Add('mcdo', 'menu', RageUI.CreateSubMenu(RMenu:Get('mcdo', 'main'), "", "Choisis ton menu"))
RMenu.Add('mcdo', 'burger', RageUI.CreateSubMenu(RMenu:Get('mcdo', 'main'), "", "Choisis un burger"))
RMenu.Add('mcdo', 'petitefaim', RageUI.CreateSubMenu(RMenu:Get('mcdo', 'main'), "", "Choisis un complément"))
RMenu.Add('mcdo', 'boisson', RageUI.CreateSubMenu(RMenu:Get('mcdo', 'main'), "", "Choisis ta boisson"))
RMenu.Add('mcdo', 'dessert', RageUI.CreateSubMenu(RMenu:Get('mcdo', 'main'), "", "Choisis ton dessert"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('mcdo', 'main'), true, true, true, function()
            RageUI.Button("Menus", nil, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('mcdo', 'menu'))
            RageUI.Button("Burger", nil, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('mcdo', 'burger'))
            RageUI.Button("Petite faim", nil, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('mcdo', 'petitefaim'))
            RageUI.Button("Boissons", nil, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('mcdo', 'boisson'))
            RageUI.Button("Desserts", nil, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('mcdo', 'dessert'))
        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('mcdo', 'menu'), true, true, true, function()
            RageUI.Button("Menu Best OF", "description", {RightLabel = "~g~20$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buybestof')
                end
            end)
			RageUI.Button("Menu MC Frist - boeuf", "description", {RightLabel = "~g~15$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcfirstboeuf')
                end
            end)
			RageUI.Button("Menu MC Frist - poulet", "description", {RightLabel = "~g~15$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcfirstpoulet')
                end
            end)
			RageUI.Button("Menu MC Frist - poisson", "description", {RightLabel = "~g~15$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcfirstpoisson')
                end
            end)
			RageUI.Button("Menu Happy Meal", "description", {RightLabel = "~g~10$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:BuyHappymeal')
                end
            end)
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('mcdo', 'burger'), true, true, true, function()
            RageUI.Button("Signature", "description", {RightLabel = "~g~7$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdosignature')
                end
            end)
			RageUI.Button("Mc Baguette", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdobaguette')
                end
            end)
			RageUI.Button("Big Mac", "description", {RightLabel = "~g~8$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdobigmac')
                end
            end)
			RageUI.Button("Filet O Fish", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdofiletofish')
                end
            end)
			RageUI.Button("C.B.O.", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdocbo')
                end
            end)
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('mcdo', 'petitefaim'), true, true, true, function()
            RageUI.Button("Boite de nuggets", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdonuggets')
                end
            end)
			RageUI.Button("Croque macdo", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdocroquemcdo')
                end
            end)
			RageUI.Button("Wrap", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdowrap')
                end
            end)
			RageUI.Button("Frites", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdofrites')
                end
            end)
			RageUI.Button("Potatoes", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcdopotatoes')
                end
            end)
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('mcdo', 'boisson'), true, true, true, function()
            RageUI.Button("Coca", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buycoca')
                end
            end)
			RageUI.Button("Coca cherry", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buycocacherry')
                end
            end)
			RageUI.Button("Ice-Tea", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buyicetea')
                end
            end)
			RageUI.Button("Sprite", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buysprite')
                end
            end)
			RageUI.Button("Fanta", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buyfanta')
                end
            end)
            RageUI.Button("Evian", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buyevian')
                end
            end)
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('mcdo', 'dessert'), true, true, true, function()
            RageUI.Button("Mc Flurry", "description", {RightLabel = "~g~8$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymcflurry')
                end
            end)
			RageUI.Button("Sunday", "description", {RightLabel = "~g~7$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buysunday')
                end
            end)
			RageUI.Button("Donut", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buydonuts')
                end
            end)
			RageUI.Button("Milk Shake", "description", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('mxrp_macdoshop:Buymilkshake')
                end
            end)
        end, function()
        end)


    
        Citizen.Wait(0)
        end
    end)

local blip = {
    {name="Macdonald's", colour=5, id=124, x = 278.91, y = -971.44, z = 28.40}
}  

Citizen.CreateThread(function()

   for _, info in pairs(blip) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 0.9)
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.name)
     EndTextCommandSetBlipName(info.blip)
   end
end)