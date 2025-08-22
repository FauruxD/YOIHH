local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
if not WindUI then return end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
if not player or not ReplicatedStorage then return end

do
    wait(1)
    local blur = Instance.new("BlurEffect", Lighting)
    blur.Size = 0
    TweenService:Create(blur, TweenInfo.new(0.5), {Size = 24}):Play()

    local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = "ArcvourIntro"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1

    local bg = Instance.new("Frame", frame)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromHex("#1E142D")
    bg.BackgroundTransparency = 1
    bg.ZIndex = 0
    TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()
    
    local glowFrame = Instance.new("Frame", frame)
    glowFrame.Size = UDim2.new(1, 0, 1, 0)
    glowFrame.BackgroundTransparency = 1
    glowFrame.ZIndex = 1

    local glowAsset = "rbxassetid://5036224375" 
    local glowColor = Color3.fromHex("#8C46FF")

    local glowParts = {
        Top = { Size = UDim2.new(1, 40, 0, 100), Position = UDim2.new(0.5, 0, 0, 0) },
        Bottom = { Size = UDim2.new(1, 40, 0, 100), Position = UDim2.new(0.5, 0, 1, 0) },
        Left = { Size = UDim2.new(0, 100, 1, 40), Position = UDim2.new(0, 0, 0.5, 0) },
        Right = { Size = UDim2.new(0, 100, 1, 40), Position = UDim2.new(1, 0, 0.5, 0) }
    }

    for _, props in pairs(glowParts) do
        local glow = Instance.new("ImageLabel", glowFrame)
        glow.Image = glowAsset
        glow.ImageColor3 = glowColor
        glow.ImageTransparency = 1
        glow.Size = props.Size
        glow.Position = props.Position
        glow.AnchorPoint = Vector2.new(0.5, 0.5)
        glow.BackgroundTransparency = 1
        TweenService:Create(glow, TweenInfo.new(1), {ImageTransparency = 0.5}):Play()
    end

    local logo = Instance.new("ImageLabel", frame)
    logo.Image = "rbxassetid://90566677928169"
    logo.Size = UDim2.new(0, 150, 0, 150)
    logo.Position = UDim2.new(0.5, 0, 0.3, 0)
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.BackgroundTransparency = 1
    logo.ImageTransparency = 1
    logo.Rotation = 0
    logo.ZIndex = 2

    TweenService:Create(logo, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { ImageTransparency = 0, Size = UDim2.new(0, 200, 0, 200), Rotation = 15 }):Play()
    task.delay(0.5, function()
        TweenService:Create(logo, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0, 150, 0, 150), Rotation = 0 }):Play()
    end)

    local word = "ArcvourHub"
    local letters = {}

    local function tweenOutAndDestroy()
        for _, label in ipairs(letters) do
            TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 1, TextSize = 20}):Play()
        end
        for _, glow in ipairs(glowFrame:GetChildren()) do
             if glow:IsA("ImageLabel") then
                TweenService:Create(glow, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
             end
        end
        TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
        TweenService:Create(logo, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        wait(0.6)
        screenGui:Destroy()
        blur:Destroy()
    end

    task.wait(1)

    for i = 1, #word do
        local char = word:sub(i, i)
        local label = Instance.new("TextLabel")
        label.Text = char
        label.Font = Enum.Font.GothamBlack
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextStrokeTransparency = 1
        label.TextTransparency = 1
        label.TextScaled = false
        label.TextSize = 30
        label.Size = UDim2.new(0, 60, 0, 60)
        label.AnchorPoint = Vector2.new(0.5, 0.5)
        label.Position = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 45, 0.6, 0)
        label.BackgroundTransparency = 1
        label.Parent = frame
        label.ZIndex = 2
        local gradientUI = Instance.new("UIGradient")
        gradientUI.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#8C46FF")), ColorSequenceKeypoint.new(1, Color3.fromHex("#BE78FF")) })
        gradientUI.Rotation = 90
        gradientUI.Parent = label
        local tweenIn = TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0, TextSize = 60})
        tweenIn:Play()
        table.insert(letters, label)
        wait(0.15)
    end

    wait(2.5)
    tweenOutAndDestroy()
    wait(1)
end

function gradient(text, startColor, endColor)
    if not text or not startColor or not endColor then return "" end
    local result = ""
    local length = #text
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r .. ", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end
    return result
end

function formatMoney(number)
    if not number then return "$0" end
    local s = tostring(math.floor(number))
    local rev_s = string.reverse(s)
    local new_s = ""
    for i = 1, #rev_s do
        new_s = new_s .. string.sub(rev_s, i, i)
        if i % 3 == 0 and i ~= #rev_s then
            new_s = new_s .. ","
        end
    end
    return "$" .. string.reverse(new_s)
end

WindUI:AddTheme({
    Name = "Arcvour", Accent = "#4B2D82", Dialog = "#1E142D", Outline = "#46375A",
    Text = "#E5DCEA", Placeholder = "#A898C2", Background = "#221539", Button = "#8C46FF", Icon = "#A898C2"
})

local keyUrl = "https://arcvourhub.my.id/key/FAB.txt"
local fetchedKey
local success, response = pcall(function() return game:HttpGet(keyUrl, true) end)
if success and response and type(response) == "string" then
    fetchedKey = response:match("^%s*(.-)%s*$")
else
    warn("ArcvourHUB: Gagal mengambil kunci. Akses mungkin gagal.", response)
    fetchedKey = "FAILED_TO_FETCH_KEY_" .. math.random(1000, 9999)
end

local Window = WindUI:CreateWindow({
    Title = gradient("ArcvourHUB", Color3.fromHex("#8C46FF"), Color3.fromHex("#BE78FF")),
    Icon = "rbxassetid://90566677928169", Author = "Fish A Brainrot", Size = UDim2.fromOffset(500, 320),
    Folder = "ArcvourHUB_Config", Transparent = false, Theme = "Arcvour", ToggleKey = Enum.KeyCode.K,
    SideBarWidth = 160,
    KeySystem = { Key = fetchedKey, URL = "https://t.me/arcvourscript", Note = "Enter key to access.", SaveKey = false }
})
if not Window then return end

local floatingButtonGui = Instance.new("ScreenGui")
floatingButtonGui.Name = "ArcvourToggleGUI"; floatingButtonGui.IgnoreGuiInset = true; floatingButtonGui.ResetOnSpawn = false
floatingButtonGui.Parent = game.CoreGui; floatingButtonGui.Enabled = false
local floatingButton = Instance.new("ImageButton")
floatingButton.Size = UDim2.new(0, 40, 0, 40); floatingButton.Position = UDim2.new(0, 70, 0, 70)
floatingButton.BackgroundColor3 = Color3.fromHex("#1E142D"); floatingButton.Image = "rbxassetid://90566677928169"
floatingButton.Name = "ArcvourToggle"; floatingButton.AutoButtonColor = true; floatingButton.Parent = floatingButtonGui
local corner = Instance.new("UICorner", floatingButton); corner.CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke"); stroke.Thickness = 1.5; stroke.Color = Color3.fromHex("#BE78FF")
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; stroke.Parent = floatingButton
local gradientStroke = Instance.new("UIGradient")
gradientStroke.Color = ColorSequence.new { ColorSequenceKeypoint.new(0, Color3.fromHex("#8C46FF")), ColorSequenceKeypoint.new(1, Color3.fromHex("#BE78FF")) }
gradientStroke.Rotation = 45; gradientStroke.Parent = stroke
local dragging, dragInput, dragStart, startPos
floatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = floatingButton.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
floatingButton.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        floatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
floatingButton.MouseButton1Click:Connect(function() floatingButtonGui.Enabled = false; pcall(function() Window:Open() end) end)
Window:OnDestroy(function() floatingButtonGui:Destroy() end)
Window:DisableTopbarButtons({"Close", "Minimize"})
Window:CreateTopbarButton("MinimizeButton", "x", function() pcall(function() Window:Close() end); floatingButtonGui.Enabled = true end, 999)

local KnitPackages = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services")

local Tabs = {
    Fish = Window:Tab({ Title = "Fish", Icon = "fish", ShowTabTitle = true }), Sell = Window:Tab({ Title = "Sell", Icon = "receipt", ShowTabTitle = true }),
    Money = Window:Tab({ Title = "Money", Icon = "coins", ShowTabTitle = true }), Buy_Bait = Window:Tab({ Title = "Buy Bait", Icon = "bug", ShowTabTitle = true }),
    Buy_Rod = Window:Tab({ Title = "Buy Rod", Icon = "anchor", ShowTabTitle = true }), Buy_Supplies = Window:Tab({ Title = "Buy Supplies", Icon = "shopping-cart", ShowTabTitle = true }),
    Visual = Window:Tab({ Title = "Visual", Icon = "eye", ShowTabTitle = true }), Movement = Window:Tab({ Title = "Movement", Icon = "send", ShowTabTitle = true }),
    Experimental = Window:Tab({ Title = "Experimental", Icon = "code", ShowTabTitle = true })
}

local featureState = {
    AutoFish = false, AutoEquipBait = false, AutoUseSupplies = false, AutoBuyBaitActive = false,
    AutoBuySuppliesActive = false, AutoSort = false, AutoFavorite = false, AutoSell = false,
    AutoCollectMoney = false, RestockBaitNotify = false, RestockSuppliesNotify = false,
    AutoBuyBait = {}, AutoBuySupplies = {}, FavoriteRarities = {}, VisualMoney = false,
    WalkSpeed = false, InfiniteJump = false, NoClip = false, AutoSave = false
}

local featureValues = {
    AutoFishDelay = 2.5, AutoSellDelay = 3, AutoCollectMoneyDelay = 5, BaitEquipOrder = "From Biggest",
    SortType = "Rarity", MutationPriority = "Best First", WeightPriority = "Best First", UnfavoriteRarity = nil,
    VisualMoneyValue = "$1,000,000", FriendBoostValue = "0", WalkSpeedValue = 100
}

local UIElements = {}
local ConfigFolder = "ArcvourHUB_Config"
local currentConfigSlot = 1

local baitDataMaster={Worm={Price=100},Shrimp={Price=200},Eel={Price=275},Kiwi={Price=325},Banana={Price=350},CoffeeBeans={Price=450},Squid={Price=600},Crab={Price=600},Grape={Price=800},Orange={Price=1200},Tophat={Price=4250},Watermelon={Price=5000},Dragonfruit={Price=5500},GoldenBanana={Price=15000}}
local brainrotData={FrigoCamelo={Rarity="Mythic"},ChimpanziniBananini={Rarity="Legendary"},LiriliLarila={Rarity="Common"},BrrBrrPatapim={Rarity="Epic"},BananitaDolfinita={Rarity="Epic"},TrippiTroppi={Rarity="Rare"},CapybaraBanalelli={Rarity="Legendary"},OdinDinDinDun={Rarity="Secret"},LaVacaSaturnoSaturnita={Rarity="Secret"},RhinoToasterino={Rarity="Mythic"},BlueberrinniOctopussini={Rarity="Legendary"},BombombiniGusini={Rarity="Mythic"},BombardiroCrocodilo={Rarity="Mythic"},TrulimeroTrulicina={Rarity="Epic"},BrriBrriBicusDicusBombicus={Rarity="Epic"},BallerinaCappuccina={Rarity="Legendary"},IcharinaMatchanova={Rarity="Secret"},TigrrulliniWatermellini={Rarity="Uncommon"},AnpaliBabbel={Rarity="Uncommon"},LobiniPizzini={Rarity="Common"},CavalloVirtuoso={Rarity="Epic"},SpijuniroGolubiro={Rarity="Common"},TricTricBaraboom={Rarity="Uncommon"},OrcaleroOrcala={Rarity="Secret"},AvocadoGorilla={Rarity="Mythic"},BurbaloniLuliloli={Rarity="Rare"},PipiKiwi={Rarity="Uncommon"},FrulliFrulla={Rarity="Common"},SvininoBombondino={Rarity="Rare"},SigmaBoy={Rarity="Epic"},AvocadiniGuffo={Rarity="Epic"},PandacciniBanananini={Rarity="Uncommon"},BonecaAmbalabu={Rarity="Uncommon"},CocofantoElefanto={Rarity="Legendary"},GaramaMudundung={Rarity="Abyssal"},TiTiTiSahur={Rarity="Common"},CappuccinoAssassino={Rarity="Rare"},TralaleroCocosini={Rarity="Rare"},PerochelloLemonchello={Rarity="Uncommon"},GangsterFootera={Rarity="Uncommon"},TungTungTungSahur={Rarity="Common"},Matteo={Rarity="Secret"},BallerinoLololo={Rarity="Legendary"},ChefCrabracadabra={Rarity="Rare"},LeonelliCactuselli={Rarity="Epic"},TimCheese={Rarity="Epic"},BrrBrrGangsterGusini={Rarity="Epic"},GraipussMedussi={Rarity="Secret"},OrangutiniAnanasini={Rarity="Mythic"},GanganzelliTrulala={Rarity="Abyssal"},DragonfrutiAxuluti={Rarity="Abyssal"}}

local function SaveConfig(slot)
    local configName = "config_slot_" .. tostring(slot) .. ".json"
    pcall(function()
        local data = { State = featureState, Values = featureValues }
        writefile(ConfigFolder .. "/" .. configName, HttpService:JSONEncode(data))
    end)
end

local function AutoSave() if featureState.AutoSave then SaveConfig(currentConfigSlot) end end

do 
    Tabs.Fish:Section({ Title = "Farming Features" })
    local fishingService = KnitPackages.FishingService
    UIElements.AutoFish = Tabs.Fish:Toggle({
        Title = "Auto Fish Brainrot", Desc = "Automatically catches brainrots.", Value = featureState.AutoFish,
        Callback = function(v)
            featureState.AutoFish = v
            if v then
                task.spawn(function()
                    while featureState.AutoFish and player do
                        pcall(function()
                            fishingService.RF.RequestFish:InvokeServer()
                            task.wait(0.1); fishingService.RF.ClaimCatch:InvokeServer()
                            task.wait(0.1); fishingService.RF.RequestFish:InvokeServer()
                            task.wait(0.2); fishingService.RF.ClaimCatch:InvokeServer()
                        end)
                        if featureState.AutoSell then
                            task.delay(1, function() if featureState.AutoSell and featureState.AutoFish then pcall(function() fishingService.RF.SellInventory:InvokeServer() end) end end)
                        end
                        task.wait(featureValues.AutoFishDelay)
                    end
                end)
            end
            AutoSave()
        end
    })
    UIElements.AutoFishDelay = Tabs.Fish:Dropdown({ Title = "Fishing Delay", Values = {"2.5s", "3.0s", "3.5s"}, Value = featureValues.AutoFishDelay .. "s", Callback = function(v) featureValues.AutoFishDelay = tonumber(v:gsub("s", "")) or 2.5; AutoSave() end })
    Tabs.Fish:Section({Title = "Automation"})
    UIElements.AutoEquipBait = Tabs.Fish:Toggle({ Title = "Auto Equip Bait", Desc = "Automatically equips best bait.", Value = featureState.AutoEquipBait, Callback = function(v) featureState.AutoEquipBait = v; AutoSave() end })
    UIElements.BaitEquipOrder = Tabs.Fish:Dropdown({ Title = "Bait Priority", Values = {"From Biggest", "From Smallest"}, Value = featureValues.BaitEquipOrder, Callback = function(v) featureValues.BaitEquipOrder = v; AutoSave() end })
    Tabs.Fish:Section({Title = "Supplies Automation"})
    UIElements.AutoUseSupplies = Tabs.Fish:Toggle({ Title = "Auto Use Supplies", Desc = "Uses supplies automatically.", Value = featureState.AutoUseSupplies, Callback = function(v) featureState.AutoUseSupplies = v; AutoSave() end })
    UIElements.MutationPriority = Tabs.Fish:Dropdown({ Title = "Mutation Priority", Values = {"Best First", "Worst First", "None"}, Value = featureValues.MutationPriority, Callback = function(v) featureValues.MutationPriority = v; AutoSave() end })
    UIElements.WeightPriority = Tabs.Fish:Dropdown({ Title = "Weight Priority", Values = {"Best First", "Worst First", "None"}, Value = featureValues.WeightPriority, Callback = function(v) featureValues.WeightPriority = v; AutoSave() end })
    Tabs.Fish:Section({Title = "Inventory Management"})
    UIElements.AutoSort = Tabs.Fish:Toggle({ Title = "Auto Sort", Desc = "Sorts inventory automatically.", Value = featureState.AutoSort, Callback = function(v) featureState.AutoSort = v; AutoSave() end })
    UIElements.SortType = Tabs.Fish:Dropdown({ Title = "Auto Sort By", Values = {"Rarity", "Favorite", "Weight"}, Value = featureValues.SortType, Callback = function(v) featureValues.SortType = v; AutoSave() end })
    local rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Abyssal"}
    UIElements.AutoFavorite = Tabs.Fish:Toggle({ Title = "Auto Favorite", Desc = "Favorites brainrots by rarity.", Value = featureState.AutoFavorite, Callback = function(v) featureState.AutoFavorite = v; AutoSave() end })
    UIElements.FavoriteRarities = Tabs.Fish:Dropdown({ Title = "Favorite Rarity", Multi = true, AllowNone = true, Values = rarities, Value = featureState.FavoriteRarities, Callback = function(v) featureState.FavoriteRarities = v; AutoSave() end })
    UIElements.UnfavoriteRarity = Tabs.Fish:Dropdown({ Title = "Unfavorite Rarity", AllowNone = true, Values = rarities, Value = featureValues.UnfavoriteRarity, Callback = function(v) featureValues.UnfavoriteRarity = v; AutoSave() end })
    Tabs.Fish:Button({ Title = "Unfavorite Selected Rarity", Callback = function() if not featureValues.UnfavoriteRarity then WindUI:Notify({Title = "Error", Content = "Select a rarity to unfavorite.", Icon = "alert-triangle"}) return end; UIElements.AutoFavorite:Set(false); local utf = {}; for _,t in ipairs(player:WaitForChild("Backpack"):GetChildren()) do if t:IsA("Model") and t:GetAttribute("ToolType") == "Unit" then local un = t:GetAttribute("UnitName"); if brainrotData[un] and brainrotData[un].Rarity == featureValues.UnfavoriteRarity then table.insert(utf, t:GetAttribute("UnitUUID")) end end end; if #utf > 0 then KnitPackages.BackpackService.RE.FavoritedToolsUpdate:FireServer({}, utf); WindUI:Notify({Title="Success",Content="Unfavorited all "..featureValues.UnfavoriteRarity,Icon="check"}) else WindUI:Notify({Title="Info",Content="No "..featureValues.UnfavoriteRarity.." found.",Icon="info"}) end end })
    task.spawn(function() local sb={Rarity=player.PlayerGui.Inventory.Inventory.Backpack.SortContainer.SortButtons.RarityButton,Favorite=player.PlayerGui.Inventory.Inventory.Backpack.SortContainer.SortButtons.FavoriteButton,Weight=player.PlayerGui.Inventory.Inventory.Backpack.SortContainer.SortButtons.WeightButton}; while task.wait(1) do if featureState.AutoSort then pcall(function() local b=sb[featureValues.SortType] if b and firesignal then firesignal(b.Activated,nil,1)end end)end end end)
    task.spawn(function() while task.wait(0.5) do if featureState.AutoFavorite and #featureState.FavoriteRarities>0 then pcall(function() local utf={} for _,t in ipairs(player:WaitForChild("Backpack"):GetChildren())do if t:IsA("Model")and t:GetAttribute("ToolType")=="Unit"then local un=t:GetAttribute("UnitName") local f=t:GetAttribute("Favorited") if not f and brainrotData[un]then if table.find(featureState.FavoriteRarities,brainrotData[un].Rarity)then table.insert(utf,t:GetAttribute("UnitUUID"))end end end end if #utf>0 then KnitPackages.BackpackService.RE.FavoritedToolsUpdate:FireServer(utf,{})end end)end end end)
    task.spawn(function() while task.wait(1.5) do if featureState.AutoEquipBait then local bc=player.PlayerGui:FindFirstChild("Equipment",true)and player.PlayerGui.Equipment.Equipment.Background.SideBar:FindFirstChild("BaitContainer") local ceb=player:FindFirstChild("EquippedBait")and player.EquippedBait.Value if bc then local icea=ceb and ceb~=""and bc:FindFirstChild(ceb) if not icea then local ab={} for _,c in ipairs(bc:GetChildren())do if baitDataMaster[c.Name]then table.insert(ab,c.Name)end end if #ab>0 then table.sort(ab,function(a,b) if featureValues.BaitEquipOrder=="From Biggest"then return baitDataMaster[a].Price>baitDataMaster[b].Price else return baitDataMaster[a].Price<baitDataMaster[b].Price end end) KnitPackages.BaitService.RF.EquipBait:InvokeServer(ab[1])end end end end end end)
    task.spawn(function() local cs=KnitPackages.ConsumableService.RE.UseItem local pb=player:WaitForChild("Backpack") local function us(itc) for _,itn in ipairs(itc)do local i=pb:FindFirstChild(itn) if i and i:GetAttribute("Amount")>0 then cs:FireServer(itn) return end end end; while task.wait(20) do if featureState.AutoUseSupplies then if featureValues.MutationPriority=="Best First"then us({"MutationCharm","RustyMutationCharm"})elseif featureValues.MutationPriority=="Worst First"then us({"RustyMutationCharm","MutationCharm"})end task.wait(0.5) if featureValues.WeightPriority=="Best First"then us({"WeightCharm","RustyWeightCharm"})elseif featureValues.WeightPriority=="Worst First"then us({"RustyWeightCharm","WeightCharm"})end end end end)
end

do
    Tabs.Sell:Section({ Title = "Selling Options" })
    Tabs.Sell:Button({ Title = "Sell Held", Desc = "Sells your held brainrot.", Callback = function() pcall(function() KnitPackages.FishingService.RF.SellHeldItem:InvokeServer(); WindUI:Notify({Title="Success", Content="Held item sold.", Icon="check"}) end) end })
    Tabs.Sell:Button({ Title = "Sell All", Desc = "Sells your entire inventory.", Callback = function() pcall(function() KnitPackages.FishingService.RF.SellInventory:InvokeServer(); WindUI:Notify({Title="Success", Content="All items sold.", Icon="check"}) end) end })
    UIElements.AutoSell = Tabs.Sell:Toggle({ Title = "Auto Sell Inventory", Value = featureState.AutoSell, Callback = function(v) featureState.AutoSell = v; if v and not featureState.AutoFish then task.spawn(function() while featureState.AutoSell and not featureState.AutoFish and player do pcall(function() KnitPackages.FishingService.RF.SellInventory:InvokeServer() end) task.wait(featureValues.AutoSellDelay) end end) end; AutoSave() end })
    UIElements.AutoSellDelay = Tabs.Sell:Slider({ Title = "Sell Delay (Standalone)", Desc = "Only active if Auto Fish is off.", Value = {Min=3,Max=60,Default=featureValues.AutoSellDelay}, Step=1, Callback = function(v) featureValues.AutoSellDelay=tonumber(v)or 3; AutoSave() end })
end

do
    Tabs.Money:Section({Title = "Money Collection"})
    UIElements.AutoCollectMoney = Tabs.Money:Toggle({ Title = "Auto Collect Money", Desc = "Collects from all placeable areas.", Value = featureState.AutoCollectMoney, Callback = function(v) featureState.AutoCollectMoney = v; if v then task.spawn(function() while featureState.AutoCollectMoney and player do pcall(function() for i=1,20 do KnitPackages.MoneyCollectionService.RF.CollectMoney:InvokeServer("PlaceableArea_"..i) task.wait(0.1) end end) task.wait(featureValues.AutoCollectMoneyDelay) end end) end; AutoSave() end })
    UIElements.AutoCollectMoneyDelay = Tabs.Money:Slider({ Title = "Collect Delay", Value = {Min=5,Max=60,Default=featureValues.AutoCollectMoneyDelay}, Step=1, Callback = function(v) featureValues.AutoCollectMoneyDelay=tonumber(v)or 5; AutoSave() end })
end

do
    Tabs.Buy_Bait:Section({Title = "Bait Shop"})
    UIElements.RestockBaitNotify=Tabs.Buy_Bait:Toggle({Title="Restock Info",Desc="Notifies on restock.",Value=featureState.RestockBaitNotify,Callback=function(v)featureState.RestockBaitNotify=v;AutoSave()end})
    task.spawn(function() local bst=player.PlayerGui:WaitForChild("BaitShop"):WaitForChild("BaitShop"):WaitForChild("Timer") local ntc=false while task.wait(0.5)do if featureState.RestockBaitNotify and bst and bst.Visible then local t=bst.Text if t:find("New bait in")then local tis=tonumber(t:match("(%d+)s$")) if tis and tis<=3 and not ntc then WindUI:Notify({Title="Bait Shop",Content="Restocking soon!",Icon="info"}) ntc=true elseif not t:find("s$")or(tis and tis>3)then ntc=false end else ntc=false end end end end)
    local fbd={Worm={Price=100,UniL=15,LureS=0,R="Common"},Shrimp={Price=200,UniL=25,LureS=10,R="Common"},Eel={Price=275,UniL=30,LureS=50,R="Uncommon"},Kiwi={Price=325,UniL=35,LureS=20,R="Uncommon"},Banana={Price=350,UniL=35,LureS=5,R="Uncommon"},CoffeeBeans={Price=450,UniL=35,LureS=25,R="Rare"},Squid={Price=600,UniL=45,LureS=0,R="Rare"},Crab={Price=600,UniL=40,LureS=0,R="Rare"},Grape={Price=800,UniL=40,LureS=25,R="Epic"},Orange={Price=1200,UniL=40,LureS=15,R="Epic"},Tophat={Price=4250,UniL=30,LureS=10,R="Epic"},Watermelon={Price=5000,UniL=55,LureS=5,R="Legendary"},Dragonfruit={Price=5500,UniL=30,LureS=40,R="Legendary"},GoldenBanana={Price=15000,UniL=70,LureS=20,R="Legendary"}}
    local bls={} for n,d in pairs(fbd)do table.insert(bls,{name=n,data=d})end table.sort(bls,function(a,b)return a.data.Price<b.data.Price end)
    local bn={} for _,b in ipairs(bls)do table.insert(bn,b.name)end
    UIElements.AutoBuyBaitActive=Tabs.Buy_Bait:Toggle({Title="Auto Buy Baits",Value=featureState.AutoBuyBaitActive,Callback=function(v)featureState.AutoBuyBaitActive=v;AutoSave()end})
    UIElements.AutoBuyBait=Tabs.Buy_Bait:Dropdown({Title="Select Baits",Multi=true,AllowNone=true,Values=bn,Value=featureState.AutoBuyBait,Callback=function(v)featureState.AutoBuyBait=v;AutoSave()end})
    task.spawn(function()while task.wait(1)do if featureState.AutoBuyBaitActive and #featureState.AutoBuyBait>0 then for _,n in ipairs(featureState.AutoBuyBait)do pcall(function()KnitPackages.BaitService.RF.PurchaseBait:InvokeServer(n)end)task.wait(0.2)end end end end)
    for _,bi in ipairs(bls)do local n,d=bi.name,bi.data local desc=("Money: %s|Luck: %s%%|Lure Speed: %s%%|Rarity: %s"):format(formatMoney(d.Price),d.UniL,d.LureS,d.R) local btn=Tabs.Buy_Bait:Button({Title=n,Desc=desc,Callback=function()KnitPackages.BaitService.RF.PurchaseBait:InvokeServer(n)WindUI:Notify({Title="Purchase",Content="Buying "..n,Icon="info"})end})task.spawn(function()while task.wait(1)and Window and not Window.Destroyed do local sp=player.PlayerGui.BaitShop.BaitShop.Container:FindFirstChild(n)local st=" (Stock ?)"if sp and sp:FindFirstChild("Stock")then local cs=sp.Stock.Text if cs:lower():find("out of stock")then st=" (Out)"else local a=cs:match("x(%d+)")if a then st=" (x"..a..")"end end end local nt=n..st if btn.Title~=nt then btn:SetTitle(nt)end end end)end
end

do
    Tabs.Buy_Rod:Section({Title = "Purchase Rods"})
    local rd={WeakRod={Price=145000,D="Weak"},WoodenRod={Price=1750000,D="Sturdy"},ReinforcedRod={Price=10500000,D="Reinforced"},CoralRod={Price=50000000,D="Coral"},LightningRod={Price=250000000,D="Powerful"},FrozenRod={Price=5000000000,D="Coldest"},AstralRod={Price=17500000000,D="Celestial"},MagmaRod={Price=45500000000,D="Magma"},CupidRod={Price=125000000000,D="Cupid"}}
    local rl={} for n,d in pairs(rd)do table.insert(rl,{name=n,data=d})end table.sort(rl,function(a,b)return a.data.Price<b.data.Price end)
    for _,ri in ipairs(rl)do Tabs.Buy_Rod:Button({Title=ri.name,Desc=formatMoney(ri.data.Price).." | "..ri.data.D,Callback=function()KnitPackages.RodService.RF.PurchaseRod:InvokeServer(ri.name)WindUI:Notify({Title="Purchase",Content="Buying "..ri.name,Icon="info"})end})end
end

do
    Tabs.Buy_Supplies:Section({Title="Purchase Supplies"})
    UIElements.RestockSuppliesNotify=Tabs.Buy_Supplies:Toggle({Title="Restock Info",Value=featureState.RestockSuppliesNotify,Callback=function(v)featureState.RestockSuppliesNotify=v;AutoSave()end})
    task.spawn(function()local st=player.PlayerGui:WaitForChild("SuppliesShop"):WaitForChild("SuppliesShop"):WaitForChild("Timer")local n=false while task.wait(0.5)do if featureState.RestockSuppliesNotify and st and st.Visible then local t=st.Text if t:find("New supplies in")then local ti=tonumber(t:match("(%d+)s$"))if ti and ti<=3 and not n then WindUI:Notify({Title="Supplies",Content="Restocking!",Icon="info"})n=true elseif not t:find("s$")or(ti and ti>3)then n=false end else n=false end end end end)
    local sd={RustyWeightCharm={DN="Rusty Weight Charm",D="Heavier",P=350000},RustyMutationCharm={DN="Rusty Mutation Charm",D="Mutation",P=500000},WeightCharm={DN="Weight Charm",D="Greatly heavier",P=50000000},MutationCharm={DN="Mutation Charm",D="Greatly mutation",P=65000000},MutationStabilizer={DN="Mutation Stabilizer",D="Keeps mutation",P=100000000},EvolveCrystal={DN="Evolution Crystal",D="Evolve",P=1000000000},OverfeedCharm={DN="Overfeed Charm",D="Feed twice",P=2000000000},KeepersSeal={DN="Keeper's Seal",D="Prevent steal",P=3000000000}}
    local sl={} for k,d in pairs(sd)do table.insert(sl,{key=k,data=d})end table.sort(sl,function(a,b)return a.data.P<b.data.P end)
    local sk={} for _,s in ipairs(sl)do table.insert(sk,s.key)end
    UIElements.AutoBuySuppliesActive=Tabs.Buy_Supplies:Toggle({Title="Auto Buy",Value=featureState.AutoBuySuppliesActive,Callback=function(v)featureState.AutoBuySuppliesActive=v;AutoSave()end})
    UIElements.AutoBuySupplies=Tabs.Buy_Supplies:Dropdown({Title="Select Supplies",Multi=true,AllowNone=true,Values=sk,Value=featureState.AutoBuySupplies,Callback=function(v)featureState.AutoBuySupplies=v;AutoSave()end})
    task.spawn(function()while task.wait(1)do if featureState.AutoBuySuppliesActive and #featureState.AutoBuySupplies>0 then for _,k in ipairs(featureState.AutoBuySupplies)do local sp=player.PlayerGui.SuppliesShop.SuppliesShop.Container:FindFirstChild(k)if sp and sp:FindFirstChild("Stock")then local st=sp.Stock.Text if not st:lower():find("out")then local a=tonumber(st:match("x(%d+)"))if a and a>0 then KnitPackages.SuppliesService.RF.PurchaseItem:InvokeServer(k)task.wait(1)end end end end end end end)
    for _,si in ipairs(sl)do local btn=Tabs.Buy_Supplies:Button({Title=si.data.DN,Desc=formatMoney(si.data.P).."| "..si.data.D,Callback=function()KnitPackages.SuppliesService.RF.PurchaseItem:InvokeServer(si.key)WindUI:Notify({Title="Purchase",Content="Buying "..si.data.DN,Icon="info"})end})task.spawn(function()while task.wait(1)and Window and not Window.Destroyed do local sp=player.PlayerGui.SuppliesShop.SuppliesShop.Container:FindFirstChild(si.key)local st=" (Stock?)"if sp and sp:FindFirstChild("Stock")then local cs=sp.Stock.Text if cs:lower():find("out")then st=" (Out)"else local a=cs:match("x(%d+)")if a then st=" (x"..a..")"end end end if btn.Title~=si.data.DN..st then btn:SetTitle(si.data.DN..st)end end end)end
end

do
    Tabs.Visual:Section({Title = "Client-Sided Visuals"})
    UIElements.VisualMoney = Tabs.Visual:Toggle({Title="Visual Money",Value=featureState.VisualMoney,Callback=function(v)featureState.VisualMoney=v;AutoSave()end})
    UIElements.VisualMoneyValue = Tabs.Visual:Input({Title="Money Value",Placeholder="1000000",Value=featureValues.VisualMoneyValue,Callback=function(v)featureValues.VisualMoneyValue=formatMoney(tonumber(v:gsub("%D",""))or 0);AutoSave()end})
    UIElements.FriendBoostValue = Tabs.Visual:Input({Title="Friend Boost %",Placeholder="100",Value=featureValues.FriendBoostValue,Callback=function(v)local n=v:gsub("%D","") featureValues.FriendBoostValue=n player.PlayerGui.MainHUD.FriendBoost.Text="Friend Boost: "..(tonumber(n)or 0).."%";AutoSave()end})
    task.spawn(function() local ml=player.PlayerGui.MainHUD:WaitForChild("Money") while task.wait() do if featureState.VisualMoney then ml.Text=featureValues.VisualMoneyValue end end end)
end

do
    Tabs.Movement:Section({Title="Movement Exploits"})
    UIElements.WalkSpeed = Tabs.Movement:Toggle({Title="WalkSpeed",Value=featureState.WalkSpeed,Callback=function(s)featureState.WalkSpeed=s if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed=s and featureValues.WalkSpeedValue or 16 end AutoSave()end})
    UIElements.WalkSpeedValue = Tabs.Movement:Slider({Title="Speed Value",Value={Min=16,Max=200,Default=featureValues.WalkSpeedValue},Step=1,Callback=function(v)featureValues.WalkSpeedValue=tonumber(v)or 100 if featureState.WalkSpeed and player.Character and player.Character:FindFirstChild("Humanoid")then player.Character.Humanoid.WalkSpeed=featureValues.WalkSpeedValue end AutoSave()end})
    UIElements.InfiniteJump = Tabs.Movement:Toggle({Title="Infinite Jump",Value=featureState.InfiniteJump,Callback=function(v)featureState.InfiniteJump=v;AutoSave()end})
    game:GetService("UserInputService").JumpRequest:Connect(function()if featureState.InfiniteJump and player.Character and player.Character:FindFirstChild("Humanoid")then player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)end end)
    UIElements.NoClip = Tabs.Movement:Toggle({Title="No Clip",Value=featureState.NoClip,Callback=function(s)featureState.NoClip=s if not s and player.Character then for _,p in ipairs(player.Character:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=true end end end AutoSave()end})
    task.spawn(function()while task.wait(0.1)do if Window.Destroyed then break end if featureState.NoClip and player.Character then for _,p in ipairs(player.Character:GetDescendants())do if p:IsA("BasePart")and p.CanCollide then p.CanCollide=false end end end end end)
    player.CharacterAdded:Connect(function(c)if featureState.WalkSpeed then c:WaitForChild("Humanoid").WalkSpeed=featureValues.WalkSpeedValue end end)
end

local function LoadConfig(slot)
    local configName = "config_slot_" .. tostring(slot) .. ".json"
    if not isfile(ConfigFolder .. "/" .. configName) then
        WindUI:Notify({Title = "Info", Content = "No saved config in Slot " .. slot, Icon = "info"}) return
    end

    local success, data = pcall(function() return HttpService:JSONDecode(readfile(ConfigFolder .. "/" .. configName)) end)
    
    if not success or not data then
        WindUI:Notify({Title = "Error", Content = "Failed to load/parse config from Slot " .. slot, Icon = "alert-triangle"})
        return
    end

    local loadedState = data.State or {}
    local loadedValues = data.Values or {}

    -- **METODE BARU YANG PASTI BERHASIL**
    -- Kita tidak langsung menimpa state. Kita panggil :Set() untuk setiap elemen.
    -- Callback dari setiap elemen akan memperbarui featureState dan featureValues secara otomatis.
    -- Ini meniru interaksi pengguna dan memastikan UI diperbarui dengan benar.
    local tempAutoSave = featureState.AutoSave
    featureState.AutoSave = false -- Matikan auto-save sementara agar tidak menyimpan setiap perubahan saat loading

    for key, element in pairs(UIElements) do
        pcall(function()
            if loadedState[key] ~= nil then
                element:Set(loadedState[key])
            elseif loadedValues[key] ~= nil then
                if key == "AutoFishDelay" then
                    element:Set(loadedValues[key] .. "s")
                else
                    element:Set(loadedValues[key])
                end
            end
        end)
    end
    
    featureState.AutoSave = tempAutoSave -- Kembalikan status auto-save
    WindUI:Notify({Title = "Config Loaded", Content = "Settings from Slot " .. slot .. " loaded.", Icon = "check-circle"})
end

do
    Tabs.Experimental:Section({Title = "Configuration Management"})
    UIElements.AutoSave = Tabs.Experimental:Toggle({Title = "Auto Save Config", Desc = "Saves settings to the selected slot on change.", Value = featureState.AutoSave, Callback = function(v) featureState.AutoSave = v; if v then SaveConfig(currentConfigSlot); WindUI:Notify({Title="Auto Save Enabled", Content="Saving to Slot "..currentConfigSlot, Icon="toggle-right"}) else WindUI:Notify({Title="Auto Save Disabled", Icon="toggle-left"}) end end })
    Tabs.Experimental:Dropdown({Title = "Config Slot", Values = {"1", "2", "3"}, Value = tostring(currentConfigSlot), Callback = function(v) currentConfigSlot = tonumber(v); WindUI:Notify({Title="Slot Changed", Content="Now managing Slot "..currentConfigSlot, Icon="database"}) end })
    Tabs.Experimental:Button({Title = "Save to Selected Slot", Desc = "Manually save settings to the selected slot.", Callback = function() SaveConfig(currentConfigSlot); WindUI:Notify({Title="Config Saved", Content="Settings saved to Slot "..currentConfigSlot, Icon="save"}) end })
    Tabs.Experimental:Button({Title = "Load from Selected Slot", Desc = "Manually load settings from the selected slot.", Callback = function() LoadConfig(currentConfigSlot) end })
end

local VirtualUser = game:GetService("VirtualUser")
if player and VirtualUser then player.Idled:Connect(function() VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end) end

if Window then
    Window:SelectTab(1)
    WindUI:Notify({Title="Arcvour Script Ready",Content="All features loaded for Fish A Brainrot.",Duration=8,Icon="check-circle"})
end