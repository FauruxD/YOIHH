return function(gameStatusData)
    local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    if not WindUI then return end

    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")
    local MarketplaceService = game:GetService("MarketplaceService")
    local player = Players.LocalPlayer
    local startTime = os.time()

    if not player or not replicatedStorage then return end

    do
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
            local gradient = Instance.new("UIGradient")
            gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#8C46FF")), ColorSequenceKeypoint.new(1, Color3.fromHex("#BE78FF")) })
            gradient.Rotation = 90
            gradient.Parent = label
            TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0, TextSize = 60}):Play()
            table.insert(letters, label)
            wait(0.15)
        end

        wait(2.5)
        tweenOutAndDestroy()
    end

    function gradient(text, startColor, endColor)
        if not text or not startColor or not endColor then return "" end
        local result = ""
        for i = 1, #text do
            local t = (i - 1) / math.max(#text - 1, 1)
            local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
            local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
            local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
            result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
        end
        return result
    end

    WindUI:AddTheme({ Name = "Arcvour", Accent = "#4B2D82", Dialog = "#1E142D", Outline = "#46375A", Text = "#E5DCEA", Placeholder = "#A898C2", Background = "#221539", Button = "#8C46FF", Icon = "#A898C2" })
    WindUI:SetTheme("Arcvour")

    local fetchedKey = "faru"

    local ConfigElements = {}
    local Window = WindUI:CreateWindow({
        Title = gradient("ArcvourHUB", Color3.fromHex("#8C46FF"), Color3.fromHex("#BE78FF")),
        Icon = "rbxassetid://90566677928169",
        Author = "Fish It",
        Size = UDim2.fromOffset(500, 320),
        Folder = "ArcvourHUB_Config",
        Transparent = false,
        Theme = "Arcvour",
        ToggleKey = Enum.KeyCode.K,
        SideBarWidth = 160,
        KeySystem = {
            Key = fetchedKey,
            URL = "https://t.me/arcvourscript",
            Note = "Enter the key provided to access the script.",
            SaveKey = true
        }
    })

    if not Window then return end

    local floatingButtonGui = Instance.new("ScreenGui")
    floatingButtonGui.Name = "ArcvourToggleGUI"
    floatingButtonGui.IgnoreGuiInset = true
    floatingButtonGui.ResetOnSpawn = false
    floatingButtonGui.Parent = game.CoreGui
    floatingButtonGui.Enabled = false

    local floatingButton = Instance.new("ImageButton", floatingButtonGui)
    floatingButton.Name = "ArcvourToggle"
    floatingButton.Size = UDim2.new(0, 40, 0, 40)
    floatingButton.Position = UDim2.new(0, 70, 0, 70)
    floatingButton.BackgroundColor3 = Color3.fromHex("#1E142D")
    floatingButton.Image = "rbxassetid://90566677928169"
    floatingButton.AutoButtonColor = true

    Instance.new("UICorner", floatingButton).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", floatingButton)
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromHex("#BE78FF")
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local gradientStroke = Instance.new("UIGradient", stroke)
    gradientStroke.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromHex("#8C46FF")), ColorSequenceKeypoint.new(1, Color3.fromHex("#BE78FF"))}
    gradientStroke.Rotation = 45

    local dragging, dragStart, startPos
    floatingButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging, dragStart, startPos = true, input.Position, floatingButton.Position; input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end)
    game:GetService("UserInputService").InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart; floatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
    floatingButton.MouseButton1Click:Connect(function() floatingButtonGui.Enabled = false; Window:Open() end)

    Window:OnDestroy(function() floatingButtonGui:Destroy() end)
    Window:DisableTopbarButtons({"Close", "Minimize"})
    Window:CreateTopbarButton("HideButton", "x", function() Window:Close(); floatingButtonGui.Enabled = true end, 999)

    local HubSection = Window:Section({ Title = "Arcvour Hub", Opened = true })
    local GameSection = Window:Section({ Title = "Game Features", Opened = true })

    local HubTabs = {
        Home = HubSection:Tab({ Title = "Home", Icon = "layout-dashboard", ShowTabTitle = true }),
        GameStatus = HubSection:Tab({ Title = "Game Status", Icon = "server-cog", ShowTabTitle = true }),
        ServerInfo = HubSection:Tab({ Title = "Server Info", Icon = "server", ShowTabTitle = true }),
        Webhook = HubSection:Tab({ Title = "Webhook", Icon = "webhook", ShowTabTitle = true }),
        Movement = HubSection:Tab({ Title = "Movement", Icon = "send", ShowTabTitle = true })
    }

    do
        HubTabs.Home:Paragraph({ Title = "Welcome to ArcvourHUB", Desc = "ArcvourHUB is a universal script hub designed to provide the best experience across various Roblox games. Enjoy powerful, user-friendly, and consistently updated features.", Image = "rbxassetid://90566677928169", ImageSize = 24, Color = Color3.fromHex("#BE78FF") })
        HubTabs.Home:Section({ Title = "Developer Team" })
        HubTabs.Home:Paragraph({ Title = "Arcvour", Desc = "Owner", Image = "rbxassetid://126197686455127", ImageSize = 32 })
        HubTabs.Home:Paragraph({ Title = "Fmanha", Desc = "Owner 2", Image = "rbxassetid://72647963301851", ImageSize = 32 })
        HubTabs.Home:Paragraph({ Title = "Solehudin", Desc = "Partner", Image = "rbxassetid://130653496711990", ImageSize = 32 })
        HubTabs.Home:Section({ Title = "Community" })
        local discordInviteCode, discordApiUrl = "UJMwhrrvxt", "https://discord.com/api/v9/invites/UJMwhrrvxt?with_counts=true"
        local DiscordInfo = HubTabs.Home:Paragraph({ Title = "Discord Server", Desc = "Loading...", Image = "rbxassetid://73242804704566", ImageSize = 32 })
        local telegramUsername = "arcvourscript"
        local TelegramInfo = HubTabs.Home:Paragraph({ Title = "Telegram Channel", Desc = "Loading...", Image = "rbxassetid://73242804704566", ImageSize = 32 })
        
        task.spawn(function()
            while task.wait(10) do
                if Window.Destroyed then break end
                local success, response = pcall(game.HttpGet, game, discordApiUrl, true)
                if success and response then
                    local data = HttpService:JSONDecode(response)
                    if data and data.guild then
                        local desc = string.format('<font color="#52525b">•</font> Members : %d\n<font color="#16a34a">•</font> Online : %d', data.approximate_member_count, data.approximate_presence_count)
                        DiscordInfo:SetTitle(data.guild.name)
                        DiscordInfo:SetDesc(desc)
                    else DiscordInfo:SetDesc("Failed to load data.") end
                else DiscordInfo:SetDesc("Failed to connect to Discord API.") end
            end
        end)

        task.spawn(function()
            local telegramApiUrl = "http://104.248.153.156:4000/telegram-info"
            while task.wait(10) do
                if Window.Destroyed then break end
                local success, response = pcall(game.HttpGet, game, telegramApiUrl, true)
                if success and response then
                    local data = HttpService:JSONDecode(response)
                    if data and data.name and data.members then
                        TelegramInfo:SetTitle(data.name)
                        TelegramInfo:SetDesc(string.format("Members: %d", data.members))
                    else
                        TelegramInfo:SetDesc("Failed to parse data.")
                    end
                else
                    TelegramInfo:SetDesc("Failed to connect to API.")
                end
            end
        end)

        HubTabs.Home:Section({ Title = "Links" })
        HubTabs.Home:Paragraph({ Title = "YouTube", Desc = "youtube.com/@arcvour", Image = "youtube", Color = Color3.fromHex("#FF0000"), Buttons = {{ Title = "Copy Link", Icon = "copy", Variant = "Tertiary", Callback = function() setclipboard("https://youtube.com/@arcvour"); WindUI:Notify({ Title = "Copied!", Content = "YouTube link copied to clipboard.", Duration = 3 }) end }} })
        HubTabs.Home:Paragraph({ Title = "Discord", Desc = "discord.gg/"..discordInviteCode, Image = "message-square", Color = Color3.fromHex("#5865F2"), Buttons = {{ Title = "Copy Link", Icon = "copy", Variant = "Tertiary", Callback = function() setclipboard("https://discord.gg/"..discordInviteCode); WindUI:Notify({ Title = "Copied!", Content = "Discord link copied to clipboard.", Duration = 3 }) end }} })
        HubTabs.Home:Paragraph({ Title = "Telegram", Desc = "t.me/"..telegramUsername, Image = "send", Color = Color3.fromHex("#2AABEE"), Buttons = {{ Title = "Copy Link", Icon = "copy", Variant = "Tertiary", Callback = function() setclipboard("https.me/"..telegramUsername); WindUI:Notify({ Title = "Copied!", Content = "Telegram link copied to clipboard.", Duration = 3 }) end }} })
    end

    do
        if gameStatusData and type(gameStatusData) == "table" then
            local currentGameInfo = nil
            for _, gameInfo in ipairs(gameStatusData) do
                for _, placeId in ipairs(gameInfo.PlaceIds) do
                    if placeId == game.PlaceId then
                        currentGameInfo = gameInfo
                        break
                    end
                end
                if currentGameInfo then break end
            end

            HubTabs.GameStatus:Section({ Title = "Current Game" })
            if currentGameInfo then
                HubTabs.GameStatus:Paragraph({
                    Title = currentGameInfo.Name,
                    Desc = string.format("Version: %s\nStatus: %s", currentGameInfo.Version, currentGameInfo.Status),
                    Image = currentGameInfo.Icon,
                    ImageSize = 32
                })
            end
            
            HubTabs.GameStatus:Section({ Title = "Other Games" })
            for _, gameInfo in ipairs(gameStatusData) do
                if gameInfo ~= currentGameInfo then
                    HubTabs.GameStatus:Paragraph({
                        Title = gameInfo.Name,
                        Desc = string.format("Version: %s\nStatus: %s", gameInfo.Version, gameInfo.Status),
                        Image = gameInfo.Icon,
                        ImageSize = 32
                    })
                end
            end
        end
    end

    do
        HubTabs.ServerInfo:Section({ Title = "Local Player" })
        local runtimeLabel = HubTabs.ServerInfo:Paragraph({ Title = "Run Time", Desc = "0 minute(s), 0 second(s)" })
        HubTabs.ServerInfo:Paragraph({ Title = "Player ID", Desc = tostring(player.UserId), Buttons = {{ Title = "Copy", Icon = "copy", Variant = "Tertiary", Callback = function() setclipboard(tostring(player.UserId)) end }} })
        HubTabs.ServerInfo:Paragraph({ Title = "Appearance ID", Desc = tostring(player.CharacterAppearanceId), Buttons = {{ Title = "Copy", Icon = "copy", Variant = "Tertiary", Callback = function() setclipboard(tostring(player.CharacterAppearanceId)) end }} })
        HubTabs.ServerInfo:Section({ Title = "Statistics" })
        local playerCountLabel = HubTabs.ServerInfo:Paragraph({ Title = "Players", Desc = #Players:GetPlayers().."/"..Players.MaxPlayers })
        local pingLabel = HubTabs.ServerInfo:Paragraph({ Title = "Ping", Desc = "Loading..." })
        HubTabs.ServerInfo:Paragraph({ Title = "Place ID", Desc = tostring(game.PlaceId), Buttons = {{ Title = "Copy", Icon = "copy", Variant = "Tertiary", Callback = function() setclipboard(tostring(game.PlaceId)) end }} })
        local success, placeInfo = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
        local placeName = success and placeInfo.Name or "Unknown"
        HubTabs.ServerInfo:Paragraph({ Title = "Place Name", Desc = placeName, Buttons = {{ Title = "Copy", Icon = "copy", Variant = "Tertiary", Callback = function() setclipboard(placeName) end }} })
        task.spawn(function()
            while task.wait(1) do
                if Window.Destroyed then break end
                local elapsed = os.time() - startTime; local minutes = math.floor(elapsed / 60); local seconds = elapsed % 60
                runtimeLabel:SetDesc(string.format("%d minute(s), %d second(s)", minutes, seconds))
                playerCountLabel:SetDesc(tostring(#Players:GetPlayers()).."/"..tostring(Players.MaxPlayers))
                pingLabel:SetDesc(tostring(math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())).." ms")
            end
        end)
    end

    do
        local movementState = { WalkSpeed = false, InfiniteJump = false, NoClip = false }
        local WalkSpeedSlider
        HubTabs.Movement:Toggle({ Title = "Enable WalkSpeed", Value = false, Callback = function(s) movementState.WalkSpeed = s; if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = s and (tonumber(WalkSpeedSlider.Value.Default) or 16) or 16 end end })
        WalkSpeedSlider = HubTabs.Movement:Slider({ Title = "WalkSpeed Value", Value = { Min = 16, Max = 200, Default = 100 }, Step = 1, Callback = function(v) if movementState.WalkSpeed and player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = tonumber(v) or 16 end end })
        HubTabs.Movement:Toggle({ Title = "Enable Infinite Jump", Value = false, Callback = function(v) movementState.InfiniteJump = v end })
        game:GetService("UserInputService").JumpRequest:Connect(function() if movementState.InfiniteJump and player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)
        HubTabs.Movement:Toggle({ Title = "Enable No Clip", Value = false, Callback = function(s) movementState.NoClip = s; if not s and player.Character then for _, p in ipairs(player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end end })
        task.spawn(function() while task.wait(0.1) do if Window.Destroyed then break end; if movementState.NoClip and player.Character then for _, p in ipairs(player.Character:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end end end end end)
        player.CharacterAdded:Connect(function(c) local h = c:WaitForChild("Humanoid", 5); if movementState.WalkSpeed and h then h.WalkSpeed = tonumber(WalkSpeedSlider.Value.Default) or 16 end end)
    end

    do
        local webhookState = { 
            enabled = false, 
            connection = nil, 
            lastFish = "", 
            lastSend = 0,
            selectedTiers = {},
            discordId = "",
            customUrl = ""
        }
        local proxyUrl = "http://104.248.153.156:4003/notify"

        local tierMap = {
            [5] = "Legendary",
            [6] = "Mythic",
            [7] = "SECRET"
        }

        local function findItemModule(fullName)
            local itemsFolder = replicatedStorage:FindFirstChild("Items")
            if not itemsFolder then return nil end
            local cleanedName = fullName:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")
            local bestMatch = nil
            local longestMatchLength = 0
            for _, itemModule in ipairs(itemsFolder:GetChildren()) do
                if itemModule:IsA("ModuleScript") then
                    if cleanedName:find(itemModule.Name, 1, true) then
                        if #itemModule.Name > longestMatchLength then
                            longestMatchLength = #itemModule.Name
                            bestMatch = itemModule
                        end
                    end
                end
            end
            return bestMatch
        end

        local function sendDataToProxy(data)
            task.spawn(function()
                pcall(function()
                    data.customUrl = webhookState.customUrl
                    HttpService:RequestAsync({
                        Url = proxyUrl,
                        Method = "POST",
                        Headers = { ["Content-Type"] = "application/json" },
                        Body = HttpService:JSONEncode(data)
                    })
                end)
            end)
        end
        
        HubTabs.Webhook:Section({ Title = "Discord Notifications" })
        HubTabs.Webhook:Toggle({
            Title = "Enable Fish Catch Notifications",
            Desc = "Sends a notification to Discord when a fish is caught.",
            Value = false,
            Callback = function(value)
                webhookState.enabled = value
                if value then
                    task.spawn(function()
                        while webhookState.enabled and task.wait(0.5) do
                            local smallNotif = player.PlayerGui:FindFirstChild("Small Notification")
                            if smallNotif and smallNotif.Enabled and not (webhookState.connection and webhookState.connection.Connected) then
                                local container = smallNotif:FindFirstChild("Display", true) and smallNotif.Display:FindFirstChild("Container", true)
                                if container then
                                    local itemNameLabel = container:FindFirstChild("ItemName", true)
                                    local rarityLabel = container:FindFirstChild("Rarity", true)
                                    if itemNameLabel and rarityLabel then
                                        webhookState.connection = itemNameLabel:GetPropertyChangedSignal("Text"):Connect(function()
                                            local currentTime = os.time()
                                            if currentTime - webhookState.lastSend < 2 then return end

                                            local fishName = itemNameLabel.Text
                                            local rarity = rarityLabel.Text
                                            if fishName ~= "" and fishName ~= webhookState.lastFish then
                                                webhookState.lastFish = fishName
                                                webhookState.lastSend = currentTime
                                                
                                                local assetId, tierNumber, sellPrice = nil, nil, nil
                                                local variantName = fishName:match("%((.-)%)")
                                                
                                                local itemModule = findItemModule(fishName)
                                                if itemModule then
                                                    local s, itemData = pcall(require, itemModule)
                                                    if s and itemData and itemData.Data then
                                                        assetId = itemData.Data.Icon and itemData.Data.Icon:match("%d+")
                                                        tierNumber = itemData.Data.Tier
                                                        sellPrice = itemData.Data.SellPrice
                                                    end
                                                end
                                                
                                                local tierName = tierMap[tierNumber]
                                                if tierName then
                                                    if #webhookState.selectedTiers == 0 or table.find(webhookState.selectedTiers, tierName) then
                                                        sendDataToProxy({
                                                            discordId = webhookState.discordId,
                                                            fishName = fishName,
                                                            rarity = rarity,
                                                            assetId = assetId,
                                                            tierName = tierName,
                                                            sellPrice = sellPrice,
                                                            variantName = variantName
                                                        })
                                                    end
                                                end
                                            end
                                        end)
                                    end
                                end
                            elseif not (smallNotif and smallNotif.Enabled) and (webhookState.connection and webhookState.connection.Connected) then
                                webhookState.connection:Disconnect()
                                webhookState.connection = nil
                            end
                        end
                    end)
                else
                    if webhookState.connection and webhookState.connection.Connected then
                        webhookState.connection:Disconnect()
                        webhookState.connection = nil
                    end
                end
            end
        })

        HubTabs.Webhook:Dropdown({
            Title = "Notify for Tiers",
            Desc = "Select which high-level tiers to notify for. (None = All Legendary+)",
            Values = {"Legendary", "Mythic", "SECRET"},
            Multi = true,
            AllowNone = true,
            Callback = function(value)
                webhookState.selectedTiers = value
            end
        })

        HubTabs.Webhook:Section({ Title = "Advanced Settings (Optional)" })
        HubTabs.Webhook:Input({
            Title = "Discord User ID (Optional)",
            Placeholder = "Enter your ID to get tagged",
            Type = "Input",
            Callback = function(value)
                webhookState.discordId = value:match("%d+") or ""
            end
        })
        HubTabs.Webhook:Input({
            Title = "Custom Webhook URL (Optional)",
            Placeholder = "Enter your own Discord webhook URL",
            Type = "Input",
            Callback = function(value)
                webhookState.customUrl = value:match("^%s*(.-)%s*$") or ""
            end
        })
    end

    do
        local GameTabs = {
            Farming = GameSection:Tab({ Title = "Farming", Icon = "fish", ShowTabTitle = true }),
            Edit_Stats = GameSection:Tab({ Title = "Edit Stats", Icon = "file-pen", ShowTabTitle = true }),
            Spawn_Boat = GameSection:Tab({ Title = "Spawn Boat", Icon = "ship", ShowTabTitle = true }),
            Buy_Rod = GameSection:Tab({ Title = "Buy Rod", Icon = "anchor", ShowTabTitle = true }),
            Buy_Weather = GameSection:Tab({ Title = "Buy Weather", Icon = "cloud", ShowTabTitle = true }),
            Buy_Baits = GameSection:Tab({ Title = "Buy Baits", Icon = "bug", ShowTabTitle = true }),
            TP_Islands = GameSection:Tab({ Title = "TP Islands", Icon = "map-pin", ShowTabTitle = true }),
            TP_Shop = GameSection:Tab({ Title = "TP Shop", Icon = "shopping-cart", ShowTabTitle = true }),
            TP_NPC = GameSection:Tab({ Title = "TP NPC", Icon = "users", ShowTabTitle = true }),
            TP_Player = GameSection:Tab({ Title = "TP Player", Icon = "user-round-search", ShowTabTitle = true })
        }

        local featureState = { AutoFish = false, AutoSellAll = false, AutoSellOnEquip = false }
        local statValues = { FishingLuck = nil, ShinyChance = nil, MutationChance = nil }

        GameTabs.Farming:Section({ Title = "Auto Features" })
        
        local AutoSellAllToggle = GameTabs.Farming:Toggle({
            Title = "Auto Sell All Fish", Desc = "Warning: This feature will sell all fish", Value = false,
            Callback = function(value)
                featureState.AutoSellAll = value
                if value then
                    task.spawn(function()
                        while featureState.AutoSellAll and player do
                            pcall(function()
                                if not (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then return end
                                local npcContainer = replicatedStorage:FindFirstChild("NPC")
                                local alexNpc = npcContainer and npcContainer:FindFirstChild("Alex")
                                if not alexNpc then
                                    featureState.AutoSellAll = false
                                    if AutoSellAllToggle then AutoSellAllToggle:Set(false) end
                                    return
                                end
                                local originalCFrame = player.Character.HumanoidRootPart.CFrame
                                player.Character.HumanoidRootPart.CFrame = CFrame.new(alexNpc.WorldPivot.Position)
                                task.wait(1)
                                replicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/SellAllItems"):InvokeServer()
                                task.wait(1)
                                player.Character.HumanoidRootPart.CFrame = originalCFrame
                            end)
                            task.wait(20)
                        end
                    end)
                end
            end
        })
        
        local oldNamecall
        GameTabs.Farming:Toggle({
            Title = "Auto Sell Equipped Fish", Desc = "Warning: Make sure to click the fish you want to sell", Value = false,
            Callback = function(value)
                featureState.AutoSellOnEquip = value
                if value then
                    if not oldNamecall then
                        pcall(function()
                            local netFolder = replicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")
                            local equipItemEvent = netFolder:WaitForChild("RE/EquipItem")
                            local sellItemFunc = netFolder:WaitForChild("RF/SellItem")
                            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                                if featureState.AutoSellOnEquip and self == equipItemEvent and getnamecallmethod() == "FireServer" then
                                    local args, itemId = {...}, args[1]
                                    if type(itemId) == "string" then
                                        task.spawn(function()
                                            task.wait()
                                            if featureState.AutoSellOnEquip then pcall(sellItemFunc.InvokeServer, sellItemFunc, itemId) end
                                        end)
                                    end
                                end
                                return oldNamecall(self, ...)
                            end)
                        end)
                    end
                else
                    if oldNamecall and unhookmetamethod then unhookmetamethod(game, "__namecall"); oldNamecall = nil end
                end
            end
        })
        
        GameTabs.Farming:Toggle({
            Title = "Enable Auto Fish", Desc = "Automatically catches fish.", Value = false,
            Callback = function(value)
                featureState.AutoFish = value
                if value then
                    pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RE/EquipToolFromHotbar"):FireServer(1) end)
                    task.wait(1)
                    task.spawn(function()
                        while featureState.AutoFish and player do
                            pcall(function()
                                local netFolder = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")
                                netFolder:WaitForChild("RF/ChargeFishingRod"):InvokeServer(1752984487.133336)
                                task.wait()
                                netFolder:WaitForChild("RF/RequestFishingMinigameStarted"):InvokeServer(-0.7499996423721313, 1)
                                task.wait()
                                local fishingCompletedEvent = netFolder:WaitForChild("RE/FishingCompleted")
                                for i = 1, 25 do
                                    if not featureState.AutoFish then break end
                                    fishingCompletedEvent:FireServer()
                                    task.wait(0.1)
                                end
                            end)
                            if featureState.AutoFish then task.wait(0.1) end
                        end
                    end)
                end
            end
        })
        
        GameTabs.Edit_Stats:Section({ Title = "Edit Visual Stats" })
        GameTabs.Edit_Stats:Input({ Title = "Fishing Luck", Placeholder = "Enter a number (e.g., 99999)", Type = "Input", Callback = function(v) statValues.FishingLuck = tonumber(v) end })
        GameTabs.Edit_Stats:Button({ Title = "Set Fishing Luck", Callback = function() end })
        GameTabs.Edit_Stats:Input({ Title = "Shiny Chance", Placeholder = "Enter a number (e.g., 99999)", Type = "Input", Callback = function(v) statValues.ShinyChance = tonumber(v) end })
        GameTabs.Edit_Stats:Button({ Title = "Set Shiny Chance", Callback = function() end })
        GameTabs.Edit_Stats:Input({ Title = "Mutation Chance", Placeholder = "Enter a number (e.g., 99999)", Type = "Input", Callback = function(v) statValues.MutationChance = tonumber(v) end })
        GameTabs.Edit_Stats:Button({ Title = "Set Mutation Chance", Callback = function() end })
        GameTabs.Edit_Stats:Section({ Title = "Rod Modifier" })
        GameTabs.Edit_Stats:Button({
            Title = "Apply Max Stats to Skinned Rod", Desc = "Modifies the stats of your currently equipped skinned rod.",
            Callback = function()
                local backpackDisplay = player.PlayerGui:FindFirstChild("Backpack", true) and player.PlayerGui.Backpack:FindFirstChild("Display", true)
                if not backpackDisplay then return end
                local itemsFolder = replicatedStorage:FindFirstChild("Items")
                if not itemsFolder then return end
                for _, tile in ipairs(backpackDisplay:GetChildren()) do
                    if tile.Name == "Tile" then
                        local skinActiveLabel = tile:FindFirstChild("Inner", true) and tile.Inner:FindFirstChild("Tags", true) and tile.Inner.Tags:FindFirstChild("SkinActive", true)
                        local itemNameLabel = tile:FindFirstChild("Inner", true) and tile.Inner:FindFirstChild("Tags", true) and tile.Inner.Tags:FindFirstChild("ItemName", true)
                        if skinActiveLabel and itemNameLabel and skinActiveLabel.Text == "★ SKIN ★" then
                            local moduleName = "!!! " .. itemNameLabel.Text
                            local rodModule = itemsFolder:FindFirstChild(moduleName)
                            if rodModule then
                                local success, rodData = pcall(require, rodModule)
                                if success and type(rodData) == "table" then
                                    rodData.VisualClickPowerPercent, rodData.MaxWeight = 99999999, 99999999
                                    if rodData.RollData then rodData.RollData.BaseLuck = 99999999 end
                                end
                            end
                        end
                    end
                end
            end
        })

        GameTabs.Spawn_Boat:Section({ Title = "Standard Boats" })
        local standard_boats = { { Name = "Small Boat", ID = 1 }, { Name = "Kayak", ID = 2 }, { Name = "Jetski", ID = 3 }, { Name = "Highfield Boat", ID = 4 }, { Name = "Speed Boat", ID = 5 }, { Name = "Fishing Boat", ID = 6 }, { Name = "Mini Yacht", ID = 14 }, { Name = "Hyper Boat", ID = 7 }, { Name = "Frozen Boat", ID = 11 }, { Name = "Cruiser Boat", ID = 13 } }
        for _, boatData in ipairs(standard_boats) do GameTabs.Spawn_Boat:Button({ Title = boatData.Name, Callback = function() pcall(function() local net = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"); net:WaitForChild("RF/DespawnBoat"):InvokeServer(); task.wait(3); net:WaitForChild("RF/SpawnBoat"):InvokeServer(boatData.ID) end) end }) end
        GameTabs.Spawn_Boat:Section({ Title = "Other Boats" })
        local other_boats = { { Name = "Alpha Floaty", ID = 8 }, { Name = "DEV Evil Duck 9000", ID = 9 }, { Name = "Festive Duck", ID = 10 }, { Name = "Santa Sleigh", ID = 12 } }
        for _, boatData in ipairs(other_boats) do GameTabs.Spawn_Boat:Button({ Title = boatData.Name, Callback = function() pcall(function() local net = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"); net:WaitForChild("RF/DespawnBoat"):InvokeServer(); task.wait(3); net:WaitForChild("RF/SpawnBoat"):InvokeServer(boatData.ID) end) end }) end

        GameTabs.Buy_Rod:Section({ Title = "Purchase Rods" })
        local itemsFolder = replicatedStorage:FindFirstChild("Items")
        if itemsFolder then
            local rodItems = {}
            for _, itemModule in ipairs(itemsFolder:GetChildren()) do
                if itemModule:IsA("ModuleScript") then
                    local s, itemData = pcall(require, itemModule)
                    if s and type(itemData) == "table" and itemData.Data and itemData.Data.Type == "Fishing Rods" and itemData.Price then
                        table.insert(rodItems, {Name = itemData.Data.Name, ID = itemData.Data.Id, Price = itemData.Price})
                    end
                end
            end
            table.sort(rodItems, function(a, b) return a.Price < b.Price end)
            for _, rodData in ipairs(rodItems) do
                GameTabs.Buy_Rod:Button({ Title = rodData.Name, Callback = function() pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/PurchaseFishingRod"):InvokeServer(rodData.ID) end) end })
            end
        end

        local weatherState = { enabled = false, selectedWeathers = {} }
        local weathers = { "Wind", "Snow", "Cloudy", "Storm", "Radiant", "Shark Hunt" }
        GameTabs.Buy_Weather:Toggle({
            Title = "Enable Auto Buy Weather",
            Value = false,
            Callback = function(value)
                weatherState.enabled = value
                if value then
                    task.spawn(function()
                        while weatherState.enabled do
                            task.wait(1000)
                            if not weatherState.enabled then break end
                            for _, weatherName in ipairs(weatherState.selectedWeathers) do
                                pcall(function()
                                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/PurchaseWeatherEvent"):InvokeServer(weatherName)
                                end)
                                task.wait(1)
                            end
                        end
                    end)
                end
            end
        })
        GameTabs.Buy_Weather:Dropdown({
            Title = "Select Weather to Auto Buy",
            Values = weathers,
            Multi = true,
            AllowNone = true,
            Callback = function(value)
                weatherState.selectedWeathers = value
            end
        })
        GameTabs.Buy_Weather:Section({ Title = "Manual Purchase" })
        for _, weatherName in ipairs(weathers) do GameTabs.Buy_Weather:Button({ Title = weatherName, Callback = function() pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/PurchaseWeatherEvent"):InvokeServer(weatherName) end) end }) end

        GameTabs.Buy_Baits:Section({ Title = "Purchase Baits" })
        local baitsFolder = replicatedStorage:FindFirstChild("Baits")
        if baitsFolder then
            local baitItems = {}
            for _, itemModule in ipairs(baitsFolder:GetChildren()) do
                if itemModule:IsA("ModuleScript") then
                    local s, itemData = pcall(require, itemModule)
                    if s and type(itemData) == "table" and itemData.Data and itemData.Price then
                        table.insert(baitItems, {Name = itemData.Data.Name, ID = itemData.Data.Id, Price = itemData.Price})
                    end
                end
            end
            table.sort(baitItems, function(a, b) return a.Price < b.Price end)
            for _, baitData in ipairs(baitItems) do
                GameTabs.Buy_Baits:Button({ Title = baitData.Name, Callback = function() pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/PurchaseBait"):InvokeServer(baitData.ID) end) end })
            end
        end

        GameTabs.TP_Islands:Section({ Title = "Island Locations" })
        local locations = { "Coral Reefs", "Crater Island", "Esoteric Depths", "Kohana", "Kohana Volcano", "Stingray Shores", "Tropical Grove", "Lost Isle", "Lost Shore" }; table.sort(locations)
        for _, name in ipairs(locations) do GameTabs.TP_Islands:Button({ Title = name, Callback = function() if player.Character and player.Character.PrimaryPart then local islandPart = workspace:FindFirstChild("!!!! ISLAND LOCATIONS !!!!") and workspace["!!!! ISLAND LOCATIONS !!!!"]:FindFirstChild(name); if islandPart then player.Character.PrimaryPart.CFrame = CFrame.new(islandPart.Position) end end end }) end

        GameTabs.TP_Shop:Section({ Title = "Shop Locations" })
        local shop_npcs = { { Name = "Boats Shop", Path = "Boat Expert" }, { Name = "Rod Shop", Path = "Joe" }, { Name = "Bobber Shop", Path = "Seth" } }
        for _, npc_data in ipairs(shop_npcs) do GameTabs.TP_Shop:Button({ Title = npc_data.Name, Callback = function() if player.Character and player.Character.PrimaryPart then local npc_model = replicatedStorage:FindFirstChild("NPC") and replicatedStorage.NPC:FindFirstChild(npc_data.Path); if npc_model and npc_model.WorldPivot then player.Character.PrimaryPart.CFrame = CFrame.new(npc_model.WorldPivot.Position) end end end }) end
        GameTabs.TP_Shop:Button({ Title = "Weather Machine", Callback = function() if player.Character and player.Character.PrimaryPart then local islandPart = workspace:FindFirstChild("!!!! ISLAND LOCATIONS !!!!") and workspace["!!!! ISLAND LOCATIONS !!!!"]:FindFirstChild("Weather Machine"); if islandPart then player.Character.PrimaryPart.CFrame = CFrame.new(islandPart.Position) end end end })

        GameTabs.TP_NPC:Section({ Title = "NPC Locations" })
        local npc_names = { "Alex", "Billy Bob", "Boat Expert", "Burt", "Esoteric Gatekeeper", "Jed", "Jeffery", "Jess", "Joe", "Jones", "Lava Fisherman", "Lonely Fisherman", "McBoatson", "Ram", "Sam", "Santa", "Scientist", "Scott", "Seth", "Silly Fisherman", "Spokesperson", "Tim" }; table.sort(npc_names)
        for _, npc_name in ipairs(npc_names) do GameTabs.TP_NPC:Button({ Title = npc_name, Callback = function() if player.Character and player.Character.PrimaryPart then local npc_model = replicatedStorage:FindFirstChild("NPC") and replicatedStorage.NPC:FindFirstChild(npc_name); if npc_model and npc_model.WorldPivot then player.Character.PrimaryPart.CFrame = CFrame.new(npc_model.WorldPivot.Position) end end end }) end

        GameTabs.TP_Player:Section({ Title = "Teleport to Player" })
        local selectedPlayerName = nil
        local function getPlayerList() local list = {}; for _, p in ipairs(Players:GetPlayers()) do if p ~= player then table.insert(list, p.Name) end end; table.sort(list); return list end
        local playerDropdown = GameTabs.TP_Player:Dropdown({ Title = "Select Player", Values = getPlayerList(), AllowNone = true, Callback = function(v) selectedPlayerName = v end })
        GameTabs.TP_Player:Button({ Title = "Teleport to Selected Player", Callback = function() pcall(function() if not selectedPlayerName then return end; if player.Character and player.Character.PrimaryPart then local targetChar = workspace.Characters:FindFirstChild(selectedPlayerName); if targetChar and targetChar.PrimaryPart then player.Character.PrimaryPart.CFrame = targetChar.PrimaryPart.CFrame end end end) end })
        Players.PlayerAdded:Connect(function() if playerDropdown and not playerDropdown.Opened then playerDropdown:Refresh(getPlayerList()) end end)
        Players.PlayerRemoving:Connect(function() if playerDropdown and not playerDropdown.Opened then playerDropdown:Refresh(getPlayerList()) end end)

        task.spawn(function()
            while task.wait(0.5) do
                if Window and Window.Destroyed then break end
                pcall(function()
                    if not player or not player.PlayerGui then return end
                    local function findAndSetStat(statName, statValue, formatString, prefix)
                        if statValue then
                            local statTile = player.PlayerGui:FindFirstChild("Settings") and player.PlayerGui.Settings:FindFirstChild("StatTile", true)
                            if not statTile then return end
                            local labelToUpdate; if statName == "Fishing Luck" then local statFrame = statTile:FindFirstChild("Stat"); if statFrame and statFrame:FindFirstChild("Label") then labelToUpdate = statFrame.Label end else for _, child in ipairs(statTile:GetChildren()) do if child:IsA("Frame") and child:FindFirstChild("Label") and child.Label.Text:find(statName) then labelToUpdate = child.Label; break end end end
                            if labelToUpdate then local newText = string.format(formatString, prefix or "", statValue); if labelToUpdate.Text ~= newText then labelToUpdate.Text = newText end end
                        end
                    end
                    findAndSetStat("Fishing Luck", statValues.FishingLuck, "%sFishing Luck: +%s%%", ""); findAndSetStat("Shiny Chance", statValues.ShinyChance, "%sShiny Chance: %s%%", ""); findAndSetStat("Mutation Chance", statValues.MutationChance, "%sMutation Chance: +%s%%", "")
                end)
            end
        end)
    end

    local VirtualUser = game:GetService("VirtualUser")
    if player and VirtualUser then
        player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end

    if Window then
        Window:SelectTab(1)
        WindUI:Notify({ Title = "ArcvourHUB Ready", Content = "All features have been loaded. Enjoy!", Duration = 8, Icon = "check-circle" })
    end
end