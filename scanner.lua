local HttpService = game:GetService("HttpService")

local function recupererServeurs(placeId)
    local url = "https://games.roblox.com/v1/games/" .. tostring(placeId) .. "/servers/Public?sortOrder=Asc&limit=15"
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if success then
        local data = HttpService:JSONDecode(response)
        return data.data or {}
    else
        warn("Erreur HTTP: " .. tostring(response))
        return {}
    end
end

local placeId = game.PlaceId
print("Scan des serveurs pour le jeu ID : " .. tostring(placeId))

local serveurs = recupererServeurs(placeId)

if #serveurs == 0 then
    print("Aucun serveur public trouvé.")
else
    for i, serveur in ipairs(serveurs) do
        print(string.format("Serveur #%d : Joueurs = %d / %d - ID Job = %s",
            i, serveur.playing, serveur.maxPlayers, serveur.id))
    end
end
