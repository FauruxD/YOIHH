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
    if not player then return end

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

            local gradient = Instance.new("UIGradient")
            gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#8C46FF")), ColorSequenceKeypoint.new(1, Color3.fromHex("#BE78FF")) })
            gradient.Rotation = 90
            gradient.Parent = label

            local tweenIn = TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0, TextSize = 60})
            tweenIn:Play()

            table.insert(letters, label)
            wait(0.15)
        end

        wait(2.5)
        tweenOutAndDestroy()
        wait(1)
    end

    WindUI:AddTheme({
        Name = "Arcvour",
        Accent = "#4B2D82",
        Dialog = "#1E142D",
        Outline = "#46375A",
        Text = "#E5DCEA",
        Placeholder = "#A898C2",
        Background = "#221539",
        Button = "#8C46FF",
        Icon = "#A898C2"
    })
    WindUI:SetTheme("Arcvour")

    local function InitializeMainScript()
        if not player or not replicatedStorage then return end

        local proMgsRemote = replicatedStorage:WaitForChild("ProMgs", 5) and replicatedStorage.ProMgs:WaitForChild("RemoteEvent", 5)
        local msgRemote = replicatedStorage:WaitForChild("Msg", 5) and replicatedStorage.Msg:WaitForChild("RemoteEvent", 5)
        if not proMgsRemote or not msgRemote then
            warn("Failed to find required RemoteEvents. Script may not function fully.")
            return
        end

        local capturedJumpRandom = nil
        local capturedLandingRandom = nil
        local capturedWinsRandom = nil
        local capturedCrystalRandom = nil
        local coinEventFormat = nil

        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if self == proMgsRemote and method == "FireServer" and args[1] then
                local eventId = args[1]
                if eventId == "JumpResults" then
                    if args[2] and args[3] then
                        capturedJumpRandom = args[2]
                        coinEventFormat = 1
                    end
                elseif eventId == "LandingResults" then
                    capturedLandingRandom = args[2]
                elseif eventId == "ClaimRooftopWinsReward" then
                    capturedWinsRandom = args[2]
                elseif eventId == "ClaimRooftopMagicToken" then
                    capturedCrystalRandom = args[2]
                end
            end
            return oldNamecall(self, ...)
        end)

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
        
        local Window = WindUI:CreateWindow({
            Title = gradient("ArcvourHUB", Color3.fromHex("#8C46FF"), Color3.fromHex("#BE78FF")),
            Icon = "rbxassetid://90566677928169",
            Author = "Climb And Jump Tower",
            Size = UDim2.fromOffset(500, 320),
            Folder = "ArcvourHUB_Config",
            Transparent = false,
            Theme = "Arcvour",
            ToggleKey = Enum.KeyCode.K,
            SideBarWidth = 160
        })

        if not Window then return end

        Window:Tag({
            Title = "PREMIUM",
            Color = Color3.fromHex("#3f1687")
        })

        local floatingButtonGui = Instance.new("ScreenGui")
        floatingButtonGui.Name = "ArcvourToggleGUI"
        floatingButtonGui.IgnoreGuiInset = true
        floatingButtonGui.ResetOnSpawn = false
        floatingButtonGui.Parent = game.CoreGui
        floatingButtonGui.Enabled = false

        local floatingButton = Instance.new("ImageButton")
        floatingButton.Size = UDim2.new(0, 40, 0, 40)
        floatingButton.Position = UDim2.new(0, 70, 0, 70)
        floatingButton.BackgroundColor3 = Color3.fromHex("#1E142D")
        floatingButton.Image = "rbxassetid://90566677928169"
        floatingButton.Name = "ArcvourToggle"
        floatingButton.AutoButtonColor = true
        floatingButton.Parent = floatingButtonGui

        local corner = Instance.new("UICorner", floatingButton)
        corner.CornerRadius = UDim.new(0, 8)

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1.5
        stroke.Color = Color3.fromHex("#BE78FF")
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = floatingButton

        local gradientStroke = Instance.new("UIGradient")
        gradientStroke.Color = ColorSequence.new { ColorSequenceKeypoint.new(0, Color3.fromHex("#8C46FF")), ColorSequenceKeypoint.new(1, Color3.fromHex("#BE78FF")) }
        gradientStroke.Rotation = 45
        gradientStroke.Parent = stroke

        local dragging, dragInput, dragStart, startPos

        floatingButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = floatingButton.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        floatingButton.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                floatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        floatingButton.MouseButton1Click:Connect(function()
            floatingButtonGui.Enabled = false
            pcall(function() Window:Open() end)
        end)

        Window:OnDestroy(function()
            floatingButtonGui:Destroy()
        end)

        Window:DisableTopbarButtons({"Close", "Minimize"})
        Window:CreateTopbarButton("MinimizeButton", "x", function()
            pcall(function() Window:Close() end)
            floatingButtonGui.Enabled = true
        end, 999)

        local HubSection = Window:Section({ Title = "Arcvour Hub", Opened = true })
        local GameSection = Window:Section({ Title = "Game Features", Opened = true })

        local HubTabs = {
            Home = HubSection:Tab({ Title = "Home", Icon = "layout-dashboard", ShowTabTitle = true }),
            GameStatus = HubSection:Tab({ Title = "Game Status", Icon = "server-cog", ShowTabTitle = true }),
            ServerInfo = HubSection:Tab({ Title = "Server Info", Icon = "server", ShowTabTitle = true }),
            Movement = HubSection:Tab({ Title = "Movement", Icon = "send", ShowTabTitle = true })
        }

        local GameTabs = {
            Farming = GameSection:Tab({ Title = "Farming", Icon = "dollar-sign", ShowTabTitle = true }),
            Hatching = GameSection:Tab({ Title = "Hatching", Icon = "egg", ShowTabTitle = true }),
            AutoFuse = GameSection:Tab({ Title = "Auto Fuse (WARNING)", Icon = "combine", ShowTabTitle = true }),
            Misc = GameSection:Tab({ Title = "Misc", Icon = "gift", ShowTabTitle = true }),
            UI = GameSection:Tab({ Title = "UI", Icon = "layout-template", ShowTabTitle = true }),
            Teleport = GameSection:Tab({ Title = "Teleport", Icon = "map-pin", ShowTabTitle = true }),
            Visuals = GameSection:Tab({ Title = "Visuals", Icon = "eye", ShowTabTitle = true }),
            Event = GameSection:Tab({ Title = "Angels vs Demons", Icon = "swords", ShowTabTitle = true })
        }

        if not GameTabs.Farming or not GameTabs.Hatching or not GameTabs.AutoFuse or not GameTabs.Misc or not GameTabs.UI or not GameTabs.Teleport or not GameTabs.Visuals or not GameTabs.Event then
            warn("Failed to create one or more game tabs.")
            return
        end
        
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
            HubTabs.Home:Paragraph({ Title = "Telegram", Desc = "t.me/"..telegramUsername, Image = "send", Color = Color3.fromHex("#2AABEE"), Buttons = {{ Title = "Copy Link", Icon = "copy", Variant = "Tertiary", Callback = function() setclipboard("https://t.me/"..telegramUsername); WindUI:Notify({ Title = "Copied!", Content = "Telegram link copied to clipboard.", Duration = 3 }) end }} })
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
        
        local coinAmount = nil
        local WalkSpeedSlider
        local farmDelayValue = 2
        local winsClaimDelay = 15

        local autoFarmState = {
            AutoCoins = false,
            AutoWins = false,
            AutoCrystal = false,
            AutoHatch = false,
            WalkSpeed = false,
            InfiniteJump = false,
            NoClip = false,
            AutoClaimGift = false,
            AutoDailySpin = false,
            AutoClaimIndex = false,
            AutoBuyWings = false,
            AutoBuySneakyPet = false,
            AutoLevelUpTokens = false,
            AutoClaimAFKRewards = false,
            AutoClaimPotions = false,
            AutoClaimEventTokens = false,
            AutoFuse = false
        }
        
        local autoFuseSettings = {
            PetNames = {},
            Rarities = {},
            Sizes = {},
            FuseTypes = {},
            Interval = 5,
            EnableNotifications = true
        }

        do
            GameTabs.Farming:Section({ Title = "Auto Farm Coins" })
            GameTabs.Farming:Paragraph({ Title = "Note", Desc = "A faster delay requires a lower height setting, while a slower delay allows for a greater height. Purchase better wings to increase your maximum height." })

            GameTabs.Farming:Input({
                Title = "Height Amount",
                Placeholder = "Enter height",
                Callback = function(text)
                    local num = tonumber(text)
                    coinAmount = (num and num > 0) and num or 119.5846266746521
                end
            })

            GameTabs.Farming:Slider({
                Title = "Auto Coins Delay (s)",
                Value = { Min = 1, Max = 15, Default = 2 },
                Step = 1,
                Callback = function(value)
                    farmDelayValue = tonumber(value) or 2
                end
            })

            local AutoCoinsToggle
            AutoCoinsToggle = GameTabs.Farming:Toggle({
                Title = "Auto Coins",
                Desc = "Requires Height",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoCoins = value
                    if value and player and coinAmount ~= nil then
                        if not coinAmount or type(coinAmount) ~= "number" or coinAmount <= 0 then
                            WindUI:Notify({ Title = "Action Required", Content = "Please enter a valid height amount before starting.", Duration = 6, Icon = "alert-triangle" })
                            if AutoCoinsToggle then AutoCoinsToggle:Set(false) end
                            autoFarmState.AutoCoins = false
                            return
                        end

                        WindUI:Notify({ Title = "Success", Content = "Auto farming main loop has started.", Duration = 5, Icon = "check" })

                        task.spawn(function()
                            local winsTokenTimer = 0
                            while autoFarmState.AutoCoins and player do
                                local canProceed = capturedJumpRandom and capturedLandingRandom
                                if canProceed and proMgsRemote then
                                    pcall(function()
                                        local jumpArgs = {"JumpResults", capturedJumpRandom, coinAmount}
                                        proMgsRemote:FireServer(unpack(jumpArgs))
                                        local landingArgs = {"LandingResults", capturedLandingRandom}
                                        proMgsRemote:FireServer(unpack(landingArgs))
                                    end)
                                else
                                    WindUI:Notify({ Title = "Waiting...", Content = "Capturing game data. Please move your character to start.", Duration = 3, Icon = "loader" })
                                    task.wait(1)
                                end

                                task.wait(farmDelayValue)
                                winsTokenTimer = winsTokenTimer + farmDelayValue

                                if not autoFarmState.AutoCoins or not player then break end

                                if winsTokenTimer >= winsClaimDelay and proMgsRemote then
                                    if autoFarmState.AutoWins and capturedWinsRandom then
                                        task.wait(1)
                                        pcall(function()
                                            local winsArgs = {"ClaimRooftopWinsReward", capturedWinsRandom}
                                            proMgsRemote:FireServer(unpack(winsArgs))
                                        end)
                                    end
                                    winsTokenTimer = 0
                                end
                                task.wait(0.1)
                            end
                        end)
                    end
                end
            })
        end

        do
            GameTabs.Farming:Section({ Title = "Auto Farm Wins & Crystal" })
            GameTabs.Farming:Paragraph({ Title = "Note", Desc = "Auto Coins must be enabled for this to work. You must be at the top of a tower for Auto Wins. Auto Crystal depends on server value." })

            GameTabs.Farming:Slider({
                Title = "Claim Delay (s)",
                Value = { Min = 5, Max = 30, Default = 15 },
                Step = 1,
                Callback = function(value)
                    winsClaimDelay = tonumber(value) or 15
                end
            })

            GameTabs.Farming:Toggle({ Title = "Auto Wins", Desc = "Requires Auto Coins", Value = false, Callback = function(v) autoFarmState.AutoWins = v end })
            GameTabs.Farming:Toggle({ Title = "Auto Crystal", Desc = "Requires Auto Coins", Value = false, Callback = function(v) autoFarmState.AutoCrystal = v end })
        end

        do
            GameTabs.Hatching:Section({ Title = "Auto Hatch Eggs" })

            local orderedEggNames = {"Egg 1 (Eiffel Tower)", "Egg 2 (Eiffel Tower)", "Egg 3 (Eiffel Tower)","Egg 1 (Empire State Bulding)", "Egg 2 (Empire State Bulding)", "Egg 3 (Empire State Bulding)","Egg 1 (Oriental Pearl Tower)", "Egg 2 (Oriental Pearl Tower)","Egg 1 (Big Ben)", "Egg 2 (Big Ben)","Egg 1 (Obelisk)", "Egg 2 (Obelisk)","Egg 1 (Leaning Tower)", "Egg 2 (Leaning Tower)","Egg 1 (Burj Khalifa Tower)", "Egg 2 (Burj Khalifa Tower)", "Egg 3 (Burj Khalifa Tower)","Egg 1 (Pixel World)", "Egg 2 (Pixel World)", "Egg 3 (Pixel World)","Egg 1 (Tokyo Tower)", "Egg 2 (Tokyo Tower)", "Egg 3 (Tokyo Tower)", "Egg 1 (Petronas Towers)", "Egg 2 (Petronas Towers)", "Egg 3 (Petronas Towers)", "Egg 1 (Mount Everest)", "Egg 2 (Mount Everest)", "Egg 1 (CN Tower)", "Egg 2 (CN Tower)", "Egg 3 (CN Tower)"}
            local eggLookupTable = {["Egg 1 (Eiffel Tower)"]=7000001,["Egg 2 (Eiffel Tower)"]=7000002,["Egg 3 (Eiffel Tower)"]=7000003,["Egg 1 (Empire State Bulding)"]=7000004,["Egg 2 (Empire State Bulding)"]=7000005,["Egg 3 (Empire State Bulding)"]=7000006,["Egg 1 (Oriental Pearl Tower)"]=7000007,["Egg 2 (Oriental Pearl Tower)"]=7000008,["Egg 1 (Big Ben)"]=7000009,["Egg 2 (Big Ben)"]=7000010,["Egg 1 (Obelisk)"]=7000011,["Egg 2 (Obelisk)"]=7000012,["Egg 1 (Leaning Tower)"]=7000013,["Egg 2 (Leaning Tower)"]=7000014,["Egg 1 (Burj Khalifa Tower)"]=7000015,["Egg 2 (Burj Khalifa Tower)"]=7000016,["Egg 3 (Burj Khalifa Tower)"]=7000017,["Egg 1 (Pixel World)"]=7000018,["Egg 2 (Pixel World)"]=7000019,["Egg 3 (Pixel World)"]=7000020,["Egg 1 (Tokyo Tower)"]=7000021,["Egg 2 (Tokyo Tower)"]=7000022,["Egg 3 (Tokyo Tower)"]=7000023, ["Egg 1 (Petronas Towers)"]=7000026, ["Egg 2 (Petronas Towers)"]=7000027, ["Egg 3 (Petronas Towers)"]=7000028, ["Egg 1 (Mount Everest)"]=7000029, ["Egg 2 (Mount Everest)"]=7000030, ["Egg 1 (CN Tower)"]=7000031, ["Egg 2 (CN Tower)"]=7000032, ["Egg 3 (CN Tower)"]=7000033}
            local selectedEggID = eggLookupTable[orderedEggNames[1]]
            local hatchAmount = 1

            GameTabs.Hatching:Dropdown({
                Title = "Select Egg",
                Values = orderedEggNames,
                Value = orderedEggNames[1],
                Callback = function(selectedEggName) selectedEggID = eggLookupTable[selectedEggName] or eggLookupTable[orderedEggNames[1]] end
            })

            GameTabs.Hatching:Dropdown({
                Title = "Select Hatch Amount",
                Values = {"1x Hatch", "3x Hatch (Gamepass Required)", "10x Hatch (Gamepass Required)"},
                Value = "1x Hatch",
                Callback = function(selectedHatch)
                    if selectedHatch == "1x Hatch" then hatchAmount = 1
                    elseif selectedHatch == "3x Hatch (Gamepass Required)" then hatchAmount = 3
                    elseif selectedHatch == "10x Hatch (Gamepass Required)" then hatchAmount = 10
                    end
                end
            })

            local AutoHatchToggle
            AutoHatchToggle = GameTabs.Hatching:Toggle({
                Title = "Auto Hatch",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoHatch = value
                    if value and player and selectedEggID and hatchAmount then
                        if not selectedEggID or not hatchAmount then
                            WindUI:Notify({ Title = "Action Required", Content = "Please select an egg and a hatch amount first.", Duration = 6, Icon = "alert-triangle" })
                            if AutoHatchToggle then AutoHatchToggle:Set(false) end
                            autoFarmState.AutoHatch = false
                            return
                        end
                        WindUI:Notify({ Title = "Success", Content = "Auto Hatching has started.", Duration = 5, Icon = "check" })
                        task.spawn(function()
                            while autoFarmState.AutoHatch and player do
                                if msgRemote and replicatedStorage:FindFirstChild("Tool") and replicatedStorage.Tool:FindFirstChild("DrawUp") and replicatedStorage.Tool.DrawUp:FindFirstChild("Msg") then
                                    pcall(function()
                                        msgRemote:FireServer("\230\138\189\232\155\139\229\188\149\229\175\188\231\187\147\230\157\159")
                                        replicatedStorage.Tool.DrawUp.Msg.DrawHero:InvokeServer(selectedEggID, hatchAmount)
                                    end)
                                end
                                task.wait(0.1)
                            end
                        end)
                    end
                end
            })
        end
        
        do
            GameTabs.AutoFuse:Section({ Title = "Fuse Configuration" })

            GameTabs.AutoFuse:Input({
                Title = "Pet Names (comma-separated) (Opsional)",
                Placeholder = "e.g., bird pet,jawara pet",
                Callback = function(text)
                    local names = {}
                    for name in string.gmatch(text, "([^,]+)") do
                        local trimmedName = name:match("^%s*(.-)%s*$"):lower()
                        if trimmedName ~= "" then
                            table.insert(names, trimmedName)
                        end
                    end
                    autoFuseSettings.PetNames = names
                end
            })

            GameTabs.AutoFuse:Dropdown({
                Title = "Select Rarity",
                Values = {"Rare", "Epic", "Legendary", "Mysterious", "Immortal", "Secret"},
                Multi = true,
                AllowNone = true,
                Callback = function(selection)
                    autoFuseSettings.Rarities = selection
                end
            })

            GameTabs.AutoFuse:Dropdown({
                Title = "Select Size",
                Values = {"Normal", "Big", "Huge"},
                Multi = true,
                AllowNone = true,
                Callback = function(selection)
                    autoFuseSettings.Sizes = selection
                end
            })

            GameTabs.AutoFuse:Dropdown({
                Title = "Select Fuse Type",
                Values = {"Normal -> Shiny", "Shiny -> Rainbow"},
                Multi = true,
                AllowNone = true,
                Callback = function(selection)
                    autoFuseSettings.FuseTypes = selection
                end
            })

            GameTabs.AutoFuse:Slider({
                Title = "Fuse Loop Interval (s)",
                Value = { Min = 5, Max = 60, Default = 5 },
                Step = 1,
                Callback = function(value)
                    autoFuseSettings.Interval = tonumber(value) or 5
                end
            })

            GameTabs.AutoFuse:Toggle({ Title = "Enable Notifications", Value = true, Callback = function(v) autoFuseSettings.EnableNotifications = v end })

            GameTabs.AutoFuse:Toggle({
                Title = "Enable Auto Fuse",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoFuse = value
                    if value then
                        if autoFuseSettings.EnableNotifications then
                            WindUI:Notify({ Title = "Auto Fuse Started", Content = "Scanning and fusing pets based on your configuration.", Duration = 5, Icon = "check-circle" })
                        end
                        
                        task.spawn(function()
                            local playerGui = player:WaitForChild("PlayerGui")
                            local screenGui = playerGui:WaitForChild("ScreenGui")
                            local petOpenButton = screenGui:WaitForChild("Main"):WaitForChild("Right"):WaitForChild("SubButtons2"):WaitForChild("Pet"):WaitForChild("Button")
                            local petsUIFrame = screenGui:WaitForChild("Pets")
                            
                            local petsFrame = petsUIFrame:WaitForChild("Frame")
                            local scrollPetFrame = petsFrame:WaitForChild("ScrollPet")
                            local petDetailFrame = petsFrame:WaitForChild("\229\189\147\229\137\141\233\128\137\228\184\173\231\154\132\230\173\166\229\153\168")
                            local remoteFunction = replicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction")

                            local onlyIDObject = petDetailFrame and petDetailFrame:FindFirstChild("OnlyID")
                            local itemNameObject = petDetailFrame and petDetailFrame:FindFirstChild("itemName")
                            local rarityObject = petDetailFrame and petDetailFrame:FindFirstChild("Level")
                            local bestPetStatObject = petDetailFrame and petDetailFrame:FindFirstChild("\231\153\190\229\136\134\230\175\148\229\174\160\231\137\169")
                            
                            if not (petOpenButton and petsUIFrame and onlyIDObject and itemNameObject and rarityObject and bestPetStatObject and remoteFunction) then
                                if autoFuseSettings.EnableNotifications then
                                    WindUI:Notify({ Title = "Error", Content = "Could not find necessary UI components for Auto Fuse.", Duration = 6, Icon = "alert-triangle" })
                                end
                                autoFarmState.AutoFuse = false
                                return
                            end

                            local function sanitizeText(text)
                                if type(text) ~= "string" then return "" end
                                return text:gsub("<[^<>]+>", ""):match("^%s*(.-)%s*$") or ""
                            end
                            
                            local function checkPetPassesFilter(petData)
                                local nameLower = petData.name:lower()

                                if nameLower:find("^huge rainbow ", 1, true) or nameLower:find("^rainbow ", 1, true) then
                                    return false
                                end

                                if petData.bestPetStat and petData.bestPetStat:find("%%", 1, true) then
                                    return false
                                end
                                
                                if #autoFuseSettings.PetNames > 0 then
                                    local nameMatch = false
                                    for _, targetName in ipairs(autoFuseSettings.PetNames) do
                                        if nameLower:find(targetName, 1, true) then
                                            nameMatch = true
                                            break
                                        end
                                    end
                                    if not nameMatch then return false end
                                end

                                if #autoFuseSettings.Rarities > 0 and not table.find(autoFuseSettings.Rarities, petData.rarity) then
                                    return false
                                end

                                local isShiny = nameLower:find("^shiny ", 1, true)
                                local isBig = nameLower:find("^big ", 1, true)
                                local isHuge = nameLower:find("^huge ", 1, true)
                                
                                local isNormalSize = not isBig and not isHuge

                                local passesSize = #autoFuseSettings.Sizes == 0 or
                                    (table.find(autoFuseSettings.Sizes, "Normal") and isNormalSize) or
                                    (table.find(autoFuseSettings.Sizes, "Big") and isBig) or
                                    (table.find(autoFuseSettings.Sizes, "Huge") and isHuge)

                                if not passesSize then return false end

                                local passesFuseType = #autoFuseSettings.FuseTypes == 0 or
                                    (table.find(autoFuseSettings.FuseTypes, "Normal -> Shiny") and not isShiny) or
                                    (table.find(autoFuseSettings.FuseTypes, "Shiny -> Rainbow") and isShiny)
                                
                                if not passesFuseType then return false end

                                return true
                            end

                            while autoFarmState.AutoFuse and player do
                                local isPetUIVisible = petsUIFrame.Visible
                                local clickCount = isPetUIVisible and 3 or 2
                                for i = 1, clickCount do
                                    if not autoFarmState.AutoFuse then break end
                                    pcall(function() firesignal(petOpenButton.MouseButton1Click) end)
                                    task.wait(0.25)
                                end

                                if not autoFarmState.AutoFuse then break end

                                local petIconsToScan = {}
                                for _, petIcon in ipairs(scrollPetFrame:GetChildren()) do
                                    if petIcon.Name == "Temp" and petIcon:IsA("ImageButton") then
                                        table.insert(petIconsToScan, petIcon)
                                    end
                                end

                                if #petIconsToScan == 0 then
                                    if autoFuseSettings.EnableNotifications then
                                        WindUI:Notify({ Title = "Info", Content = "No pets found in UI to scan.", Duration = 4, Icon = "info" })
                                    end
                                    task.wait(autoFuseSettings.Interval)
                                    continue
                                end

                                local allPetsData = {}
                                local seenIDs_ThisCycle = {}

                                for _, petIcon in ipairs(petIconsToScan) do
                                    if not autoFarmState.AutoFuse then break end
                                    
                                    pcall(function() firesignal(petIcon.MouseButton1Click) end)
                                    task.wait(0.01)
                                    
                                    local currentID = onlyIDObject.Value
                                    if currentID and not seenIDs_ThisCycle[currentID] then
                                        seenIDs_ThisCycle[currentID] = true
                                        local petDataItem = {
                                            name = sanitizeText(itemNameObject.Text),
                                            rarity = sanitizeText(rarityObject.Text),
                                            id = currentID,
                                            bestPetStat = sanitizeText(bestPetStatObject.Text)
                                        }
                                        table.insert(allPetsData, petDataItem)
                                    end
                                end

                                if not autoFarmState.AutoFuse then break end

                                local filteredPets = {}
                                for _, petData in ipairs(allPetsData) do
                                    if checkPetPassesFilter(petData) then
                                        table.insert(filteredPets, petData)
                                    end
                                end

                                local groupedPets = {}
                                for _, petData in ipairs(filteredPets) do
                                    local key = petData.name
                                    if not groupedPets[key] then groupedPets[key] = {} end
                                    table.insert(groupedPets[key], petData.id)
                                end

                                local didFuse = false
                                for petName, ids in pairs(groupedPets) do
                                    while #ids >= 5 do
                                        if not autoFarmState.AutoFuse then break end
                                        didFuse = true
                                        local mainPetID = table.remove(ids, 1)
                                        local fuseList = { table.remove(ids, 1), table.remove(ids, 1), table.remove(ids, 1), table.remove(ids, 1) }
                                        
                                        local args = { "MergePet", { mainOnlyID = mainPetID, FusePetVt = fuseList } }
                                        local success, result = pcall(function() return remoteFunction:InvokeServer(unpack(args)) end)

                                        if autoFuseSettings.EnableNotifications then
                                            if success then
                                                WindUI:Notify({Title = "Fuse Success", Content = "Fused 5x " .. petName, Duration = 3, Icon="check"})
                                            else
                                                WindUI:Notify({Title = "Fuse Failed", Content = "Failed to fuse " .. petName, Duration = 3, Icon="x"})
                                            end
                                        end
                                        task.wait(1.5)
                                    end
                                    if not autoFarmState.AutoFuse then break end
                                end
                                
                                if not didFuse and autoFuseSettings.EnableNotifications then
                                    WindUI:Notify({Title = "Auto Fuse", Content = "No fusable pets found in this cycle.", Duration = 4, Icon = "info"})
                                end

                                task.wait(autoFuseSettings.Interval)
                            end
                        end)
                    else
                        if autoFuseSettings.EnableNotifications then
                            WindUI:Notify({ Title = "Auto Fuse Stopped", Content = "The process has been terminated.", Duration = 4, Icon = "x-circle" })
                        end
                    end
                end
            })
        end

        do
            GameTabs.Misc:Section({ Title = "Auto Claim" })
            GameTabs.Misc:Toggle({
                Title = "Auto Claim Gifts",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoClaimGift = value
                    if value and player and msgRemote then
                        task.spawn(function()
                            while autoFarmState.AutoClaimGift and player do
                                for i = 1, 12 do
                                    pcall(function()
                                        local args = {"GetOnlineAward", i}
                                        msgRemote:FireServer(unpack(args))
                                    end)
                                    task.wait(0.1)
                                end
                                task.wait(5)
                            end
                        end)
                    end
                end
            })

            GameTabs.Misc:Section({ Title = "Daily Spin" })
            GameTabs.Misc:Toggle({
                Title = "Auto Daily Spin",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoDailySpin = value
                    if value and player then
                        task.spawn(function()
                            local dailySpinRemote = replicatedStorage:WaitForChild("System", 5) and replicatedStorage.System:WaitForChild("SystemDailyLottery", 5) and replicatedStorage.System.SystemDailyLottery:WaitForChild("Spin", 5)
                            if not dailySpinRemote then
                                WindUI:Notify({ Title = "Error", Content = "Daily Spin remote not found.", Duration = 5, Icon = "alert-triangle" })
                                return
                            end
                            while autoFarmState.AutoDailySpin and player do
                                pcall(function()
                                    dailySpinRemote:InvokeServer()
                                end)
                                task.wait(300)
                            end
                        end)
                    end
                end
            })
            
            GameTabs.Misc:Section({ Title = "Pet Index" })
            GameTabs.Misc:Toggle({
                Title = "Auto Claim Index Rewards",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoClaimIndex = value
                    if value and player and msgRemote then
                        task.spawn(function()
                            while autoFarmState.AutoClaimIndex and player do
                                for i = 1, 11 do
                                    if not autoFarmState.AutoClaimIndex then break end
                                    pcall(function()
                                        local args = {"GetIndexReward", i}
                                        msgRemote:FireServer(unpack(args))
                                    end)
                                    task.wait(0.2)
                                end
                                task.wait(300)
                            end
                        end)
                    end
                end
            })
        end

        do
            GameTabs.UI:Section({ Title = "Quick UI Access" })
            
            local uiLoadStatus = {}

            local function teleportAndOpenUI(locationName, targetPosition, uiName)
                task.spawn(function()
                    local char = player.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then
                        return
                    end
                    
                    local rootPart = char.HumanoidRootPart
                    local originalCFrame = rootPart.CFrame

                    if not uiLoadStatus[uiName] then
                        uiLoadStatus[uiName] = true
                        
                        local originalAnchored = rootPart.Anchored
                        rootPart.Anchored = true
                        rootPart.CFrame = CFrame.new(targetPosition)
                        task.wait(3)
                        rootPart.Anchored = originalAnchored
                        rootPart.CFrame = originalCFrame
                        task.wait(0.5)
                    end
                    
                    pcall(function()
                        rootPart.CFrame = CFrame.new(targetPosition)
                        task.wait()
                        
                        local uiElement = player.PlayerGui:WaitForChild("ScreenGui"):WaitForChild(uiName, 5)
                        
                        rootPart.CFrame = originalCFrame

                        if uiElement then
                            uiElement.Visible = true
                            
                            local visibilityConnection
                            visibilityConnection = uiElement:GetPropertyChangedSignal("Visible"):Connect(function()
                                if not uiElement.Visible then
                                    uiElement.Visible = true
                                end
                            end)
                            
                            task.delay(2, function()
                                if visibilityConnection then
                                    visibilityConnection:Disconnect()
                                end
                            end)
                        end
                    end)
                end)
            end

            GameTabs.UI:Button({
                Title = "Open Wing Shop",
                Callback = function()
                    teleportAndOpenUI("Wing Shop", Vector3.new(-69, 5, -5004), "WingShop")
                end
            })

            GameTabs.UI:Button({
                Title = "Open Wing Enchant",
                Callback = function()
                    teleportAndOpenUI("Wing Enchant", Vector3.new(-6, 10, -4998), "WingEnchantment")
                end
            })

            GameTabs.UI:Button({
                Title = "Open Titan Machine",
                Callback = function()
                    teleportAndOpenUI("Titan Machine", Vector3.new(9984, 3, -3), "Titan Pet")
                end
            })

            GameTabs.UI:Button({
                Title = "Open Enchant UI",
                Callback = function()
                    teleportAndOpenUI("Enchant UI", Vector3.new(5017, 5, 23), "MagicPet")
                end
            })

            GameTabs.UI:Button({
                Title = "Reset All UIs",
                Callback = function()
                    local uiNames = {"WingShop", "WingEnchantment", "Titan Pet", "MagicPet"}
                    local screenGui = player.PlayerGui:FindFirstChild("ScreenGui")
                    if not screenGui then return end

                    for _, uiName in ipairs(uiNames) do
                        local uiElement = screenGui:FindFirstChild(uiName)
                        if uiElement then
                            uiElement.Visible = false
                        end
                    end
                    WindUI:Notify({Title = "Success", Content = "All UIs have been hidden.", Duration = 3, Icon = "check"})
                end
            })
        end

        do
            HubTabs.Movement:Section({ Title = "Climb Settings" })
            HubTabs.Movement:Toggle({ Title = "Auto Climb", Value = false, Callback = function(state)
                if player and player.Setting and player.Setting:FindFirstChild("isAutoOn") then
                    player.Setting.isAutoOn.Value = state and 1 or 0
                end
            end })
            HubTabs.Movement:Toggle({ Title = "Auto Super Climb", Value = false, Callback = function(state)
                if player and player.Setting and player.Setting:FindFirstChild("isAutoCllect") then
                    player.Setting.isAutoCllect.Value = state and 1 or 0
                end
            end })

            HubTabs.Movement:Section({ Title = "Movement Exploits" })

            local WalkSpeedToggle
            WalkSpeedToggle = HubTabs.Movement:Toggle({
                Title = "Enable WalkSpeed",
                Value = false,
                Callback = function(state)
                    autoFarmState.WalkSpeed = state
                    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid.WalkSpeed = state and (tonumber(WalkSpeedSlider.Value.Default) or 16) or 16
                    end
                end
            })
            WalkSpeedSlider = HubTabs.Movement:Slider({
                Title = "WalkSpeed Value",
                Value = { Min = 16, Max = 200, Default = 100 },
                Step = 1,
                Callback = function(value)
                    if autoFarmState.WalkSpeed and player and player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid.WalkSpeed = tonumber(value) or 16
                    end
                end
            })

            HubTabs.Movement:Toggle({
                Title = "Enable Infinite Jump",
                Value = false,
                Callback = function(v) autoFarmState.InfiniteJump = v end
            })
            local UserInputService = game:GetService("UserInputService")
            if UserInputService then
                UserInputService.JumpRequest:Connect(function()
                    if autoFarmState.InfiniteJump and player and player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            end

            local NoClipToggle
            NoClipToggle = HubTabs.Movement:Toggle({
                Title = "Enable No Clip",
                Value = false,
                Callback = function(state)
                    autoFarmState.NoClip = state
                    if not state and player and player.Character then
                        for _, part in ipairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") then part.CanCollide = true end
                        end
                    end
                end
            })
            task.spawn(function()
                while task.wait(0.1) do
                    if Window and Window.Destroyed then break end
                    if autoFarmState.NoClip and player and player.Character then
                        for _, part in ipairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                        end
                    end
                end
            end)

            if player then
                player.CharacterAdded:Connect(function(character)
                    local humanoid = character:WaitForChild("Humanoid", 5)
                    if autoFarmState.WalkSpeed and humanoid then
                        humanoid.WalkSpeed = tonumber(WalkSpeedSlider.Value.Default) or 16
                    end
                end)
            end
        end

        do
            GameTabs.Teleport:Section({ Title = "Tower Locations" })

            local teleportLocations = {
                { Name = "Eiffel Tower", WorldID = 1 },
                { Name = "Empire State Building", WorldID = 2 },
                { Name = "Oriental Pearl Tower", WorldID = 3 },
                { Name = "Big Ben", WorldID = 4 },
                { Name = "Obelisk", WorldID = 5 },
                { Name = "Leaning Tower", WorldID = 6 },
                { Name = "Burj Khalifa Tower", WorldID = 7 },
                { Name = "Pixel World", WorldID = 8 },
                { Name = "Tokyo Tower", WorldID = 9 },
                { Name = "Petronas Towers", WorldID = 10 },
                { Name = "Mount Everest", WorldID = 11 },
                { Name = "CN Tower", WorldID = 12 }
            }

            for _, location in ipairs(teleportLocations) do
                GameTabs.Teleport:Button({
                    Title = location.Name,
                    Callback = function()
                        if msgRemote then
                            local args = { "TeleportToTargetWorld", location.WorldID }
                            msgRemote:FireServer(unpack(args))
                            WindUI:Notify({ Title = "Teleporting...", Content = "Attempting to teleport to " .. location.Name, Duration = 3, Icon = "send" })
                        else
                            WindUI:Notify({ Title = "Error", Content = "Teleport remote not found.", Duration = 4, Icon = "alert-triangle" })
                        end
                    end
                })
            end
        end

        do
            GameTabs.Visuals:Section({ Title = "Display Settings" })
            GameTabs.Visuals:Toggle({ Title = "Hide Pets", Value = false, Callback = function(state)
                if player and player.Setting and player.Setting:FindFirstChild("ShowPets") then
                    player.Setting.ShowPets.Value = state and 0 or 1
                end
            end })
            GameTabs.Visuals:Toggle({ Title = "Hide JumpPals", Value = false, Callback = function(state)
                if player and player.Setting and player.Setting:FindFirstChild("ShowJumpPal") then
                    player.Setting.ShowJumpPal.Value = state and 0 or 1
                end
            end })
        end

        do
            GameTabs.Event:Section({ Title = "Event Features" })

            GameTabs.Event:Toggle({
                Title = "Auto Buy Wings",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoBuyWings = value
                    if value then
                        task.spawn(function()
                            while autoFarmState.AutoBuyWings and player do
                                if msgRemote then
                                    for wingId = 13000, 13011 do
                                        if not autoFarmState.AutoBuyWings then break end
                                        pcall(function()
                                            local args = {"BuyWing", wingId}
                                            msgRemote:FireServer(unpack(args))
                                        end)
                                        task.wait(0.1)
                                    end
                                else
                                    autoFarmState.AutoBuyWings = false
                                    break
                                end
                                if not autoFarmState.AutoBuyWings then break end
                                task.wait(10)
                            end
                        end)
                    end
                end
            })

            GameTabs.Event:Toggle({
                Title = "Auto Buy Sneaky Pet",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoBuySneakyPet = value
                    if value then
                        task.spawn(function()
                            while autoFarmState.AutoBuySneakyPet and player do
                                if msgRemote then
                                    pcall(function()
                                        local args = {"\229\141\135\231\186\167\229\174\160\231\137\169"}
                                        msgRemote:FireServer(unpack(args))
                                    end)
                                else
                                    autoFarmState.AutoBuySneakyPet = false
                                    break
                                end
                                if not autoFarmState.AutoBuySneakyPet then break end
                                task.wait(10)
                            end
                        end)
                    end
                end
            })

            GameTabs.Event:Toggle({
                Title = "Auto Level Up Tokens",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoLevelUpTokens = value
                    if value then
                        task.spawn(function()
                            while autoFarmState.AutoLevelUpTokens and player do
                                if msgRemote then
                                    pcall(function()
                                        msgRemote:FireServer("LvlUp_Tokens")
                                    end)
                                else
                                    autoFarmState.AutoLevelUpTokens = false
                                    break
                                end
                                task.wait(10)
                            end
                        end)
                    end
                end
            })

            GameTabs.Event:Toggle({
                Title = "Auto Claim Event AFK Rewards",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoClaimAFKRewards = value
                    if value then
                        task.spawn(function()
                            local afkRemote = replicatedStorage:WaitForChild("Msg", 5) and replicatedStorage.Msg:WaitForChild("RemoteFunction", 5)
                            if not afkRemote then
                                autoFarmState.AutoClaimAFKRewards = false
                                return
                            end
                            
                            while autoFarmState.AutoClaimAFKRewards and player do
                                pcall(function()
                                    afkRemote:InvokeServer("ClaimEventAFKReward")
                                end)
                                task.wait(10)
                            end
                        end)
                    end
                end
            })

            GameTabs.Event:Toggle({
                Title = "Auto Claim Potions",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoClaimPotions = value
                    if value then
                        task.spawn(function()
                            while autoFarmState.AutoClaimPotions and player do
                                local buffsFolder = workspace:FindFirstChild("EventEssentials") and workspace.EventEssentials:FindFirstChild("Buffs")
                                if buffsFolder and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                    local rootPart = player.Character.HumanoidRootPart
                                    for _, buff in ipairs(buffsFolder:GetChildren()) do
                                        if not autoFarmState.AutoClaimPotions then break end
                                        local potionPart = buff:FindFirstChild("Cylinder004") or buff:FindFirstChild("Hitbox")
                                        if potionPart then
                                            pcall(firetouchinterest, rootPart, potionPart, 0)
                                            task.wait(0.1)
                                        end
                                    end
                                end
                                task.wait(10)
                            end
                        end)
                    end
                end
            })

            GameTabs.Event:Toggle({
                Title = "Auto Claim Event Tokens",
                Value = false,
                Callback = function(value)
                    autoFarmState.AutoClaimEventTokens = value
                    if value then
                        task.spawn(function()
                            while autoFarmState.AutoClaimEventTokens and player do
                                local tokensFolder = workspace:FindFirstChild("EventEssentials") and workspace.EventEssentials:FindFirstChild("CollectableTokens")
                                if tokensFolder and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                    local rootPart = player.Character.HumanoidRootPart
                                    for _, tokenModel in ipairs(tokensFolder:GetChildren()) do
                                        if not autoFarmState.AutoClaimEventTokens then break end
                                        local tokenPart = tokenModel:FindFirstChild("EventToken")
                                        if tokenPart then
                                            pcall(firetouchinterest, rootPart, tokenPart, 0)
                                            task.wait(0.1)
                                        end
                                    end
                                end
                                task.wait(10)
                            end
                        end)
                    end
                end
            })
        end

        local VirtualUser = game:GetService("VirtualUser")
        if player and VirtualUser then
            player.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end

        local function setupAutoCrystalLogic()
            local magicTokenValue = player and player:FindFirstChild("Whether_MagicToken_appears_nextTime")
            if not magicTokenValue then
                WindUI:Notify({ Title = "Info", Content = "Auto Crystal value not found, checking periodically...", Duration = 5, Icon = "info" })
                task.spawn(function()
                    while not magicTokenValue and player do
                        magicTokenValue = player and player:FindFirstChild("Whether_MagicToken_appears_nextTime")
                        if magicTokenValue then break end
                        task.wait(1)
                    end
                    if magicTokenValue and player then
                        WindUI:Notify({ Title = "Success", Content = "Auto Crystal value detected, enabling logic.", Duration = 5, Icon = "check" })
                        local lastValue = magicTokenValue.Value
                        local crystalTask = nil

                        magicTokenValue.Changed:Connect(function(newValue)
                            if autoFarmState.AutoCoins and autoFarmState.AutoCrystal and capturedCrystalRandom and proMgsRemote and player then
                                if newValue == 1 and lastValue == 0 then
                                    if crystalTask then
                                        task.cancel(crystalTask)
                                    end
                                    crystalTask = task.spawn(function()
                                        while magicTokenValue.Value == 1 and autoFarmState.AutoCoins and autoFarmState.AutoCrystal and player do
                                            pcall(function()
                                                local crystalArgs = {"ClaimRooftopMagicToken", capturedCrystalRandom}
                                                proMgsRemote:FireServer(unpack(crystalArgs))
                                            end)
                                            task.wait(0.5)
                                        end
                                    end)
                                end
                                lastValue = newValue
                            end
                        end)
                    end
                end)
            else
                local lastValue = magicTokenValue.Value
                local crystalTask = nil

                magicTokenValue.Changed:Connect(function(newValue)
                    if autoFarmState.AutoCoins and autoFarmState.AutoCrystal and capturedCrystalRandom and proMgsRemote and player then
                        if newValue == 1 and lastValue == 0 then
                            if crystalTask then
                                task.cancel(crystalTask)
                            end
                            crystalTask = task.spawn(function()
                                while magicTokenValue.Value == 1 and autoFarmState.AutoCoins and autoFarmState.AutoCrystal and player do
                                    pcall(function()
                                        local crystalArgs = {"ClaimRooftopMagicToken", capturedCrystalRandom}
                                        proMgsRemote:FireServer(unpack(crystalArgs))
                                    end)
                                    task.wait(0.5)
                                end
                            end)
                        end
                        lastValue = newValue
                    end
                end)
            end
        end

        setupAutoCrystalLogic()

        if Window then
            Window:SelectTab(1)
            WindUI:Notify({
                Title = "Arcvour Script Ready",
                Content = "All features have been loaded.",
                Duration = 8,
                Icon = "check-circle"
            })
        end
    end

    local VALIDATION_URL = "https://arcvourhub.my.id/api/user"

    local function ValidateUser()
        WindUI:Notify({Title = "Authenticating...", Content = "Verifying premium access...", Duration = 3, Icon = "loader"})
        
        local payload = HttpService:JSONEncode({
            user_id = tostring(player.UserId)
        })

        local success, response_body = pcall(function()
            return game:HttpPost(VALIDATION_URL, payload, "application/json")
        end)

        if not success then
            WindUI:Notify({Title = "Authentication Failed", Content = "Could not connect to the server. Please check your internet and try again.", Duration = 10, Icon = "alert-triangle"})
            return false
        end
        
        local success_decode, response_data = pcall(HttpService.JSONDecode, HttpService, response_body)
        if not success_decode then
            WindUI:Notify({Title = "Authentication Failed", Content = "Invalid server response. Please contact support.", Duration = 10, Icon = "alert-triangle"})
            return false
        end

        if response_data and response_data.success then
            WindUI:Notify({Title = "Authentication Successful", Content = "Welcome, " .. player.Name .. "!", Duration = 8, Icon = "check-circle"})
            return true
        else
            local error_message = response_data and response_data.message or "You are not whitelisted for this script."
            WindUI:Notify({Title = "Access Denied", Content = error_message, Duration = 10, Icon = "x-circle"})
            return false
        end
    end

    if ValidateUser() then
        InitializeMainScript()
    end
end