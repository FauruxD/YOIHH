local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
if not WindUI then return end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
if not player or not replicatedStorage then return end

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

local keyUrl = "https://arcvourhub.my.id/key/KR.txt"
local fetchedKey

local success, response = pcall(function()
    return game:HttpGet(keyUrl, true)
end)

if success and response and type(response) == "string" then
    fetchedKey = response:match("^%s*(.-)%s*$")
else
    warn("ArcvourHUB: Gagal mengambil kunci dari URL. Akses skrip mungkin gagal.", response)
    fetchedKey = "FAILED_TO_FETCH_KEY_" .. math.random(1000, 9999)
end

local Window = WindUI:CreateWindow({
    Title = gradient("ArcvourHUB", Color3.fromHex("#8C46FF"), Color3.fromHex("#BE78FF")),
    Icon = "rbxassetid://90566677928169",
    Author = "Kayak Racing",
    Size = UDim2.fromOffset(520, 320),
    Folder = "ArcvourHUB_Config",
    Transparent = false,
    Theme = "Arcvour",
    ToggleKey = Enum.KeyCode.K,
    SideBarWidth = 160,
    KeySystem = {
        Key = fetchedKey,
        URL = "https://t.me/arcvourscript",
        Note = "Enter the key provided to access the script.",
        SaveKey = false
    }
})

if not Window then return end

Window:Tag({
    Title = "1.1.2",
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

local Tabs = {
    Farming = Window:Tab({ Title = "Farming", Icon = "shovel", ShowTabTitle = true }),
    Misc = Window:Tab({ Title = "Misc", Icon = "box", ShowTabTitle = true }),
    Movement = Window:Tab({ Title = "Movement", Icon = "send", ShowTabTitle = true })
}

local featureState = {
    AutoWin = false,
    AutoTrain = false,
    AutoRebirth = false,
    AutoSpin = false,
    AutoEquipBest = false,
    AutoClaimGifts = false,
    AutoClaimSeason = false,
    WalkSpeed = false,
    InfiniteJump = false,
    NoClip = false
}

local AutoWinDelaySlider
local AutoTrainDelaySlider
local currentStage = 1
local isAtTrainingArea = false
local trainingTeleportPosition = Vector3.new(126, 3, 32)

do
    Tabs.Farming:Section({ Title = "Race Farming" })
    
    local AutoWinToggle
    AutoWinToggle = Tabs.Farming:Toggle({
        Title = "Enable Auto Win",
        Desc = "Automatically completes the race repeatedly.",
        Value = false,
        Callback = function(value)
            featureState.AutoWin = value
            if value then
                currentStage = 1
            end
        end
    })

    AutoWinDelaySlider = Tabs.Farming:Slider({
        Title = "Auto Win Delay",
        Value = { Min = 0.01, Max = 3, Default = 0.5 },
        Step = 0.01,
        Callback = function(value) end
    })
    
    Tabs.Farming:Section({ Title = "Stat Farming" })
    
    local AutoTrainToggle
    AutoTrainToggle = Tabs.Farming:Toggle({
        Title = "Enable Auto Train",
        Desc = "Automatically trains your stats at the training area.",
        Value = false,
        Callback = function(value)
            featureState.AutoTrain = value
            isAtTrainingArea = false 
        end
    })

    AutoTrainDelaySlider = Tabs.Farming:Slider({
        Title = "Auto Train Delay",
        Value = { Min = 0.01, Max = 3, Default = 0.5 },
        Step = 0.01,
        Callback = function(value) end
    })

    Tabs.Farming:Toggle({
        Title = "Enable Auto Rebirth",
        Desc = "Automatically rebirths when you have enough wins.",
        Value = false,
        Callback = function(value)
            featureState.AutoRebirth = value
        end
    })
end

do
    Tabs.Misc:Section({ Title = "Automation" })
    
    Tabs.Misc:Toggle({
        Title = "Enable Auto Spin",
        Desc = "Automatically spins the wheel if you have spins.",
        Value = false,
        Callback = function(value)
            featureState.AutoSpin = value
        end
    })

    Tabs.Misc:Toggle({
        Title = "Enable Auto Equip Best",
        Desc = "Automatically equips your best pets.",
        Value = false,
        Callback = function(value)
            featureState.AutoEquipBest = value
        end
    })

    Tabs.Misc:Section({ Title = "Claiming" })
    
    Tabs.Misc:Toggle({
        Title = "Enable Auto Claim Gifts",
        Desc = "Automatically claims available online gifts.",
        Value = false,
        Callback = function(value)
            featureState.AutoClaimGifts = value
        end
    })

    Tabs.Misc:Toggle({
        Title = "Enable Auto Claim Season",
        Desc = "Automatically claims available season pass rewards.",
        Value = false,
        Callback = function(value)
            featureState.AutoClaimSeason = value
        end
    })
end

do
    local WalkSpeedSlider
    Tabs.Movement:Section({ Title = "Movement Exploits" })
    local WalkSpeedToggle
    WalkSpeedToggle = Tabs.Movement:Toggle({
        Title = "Enable WalkSpeed",
        Value = false,
        Callback = function(state)
            featureState.WalkSpeed = state
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = state and (tonumber(WalkSpeedSlider.Value.Default) or 16) or 16
            end
        end
    })
    WalkSpeedSlider = Tabs.Movement:Slider({
        Title = "WalkSpeed Value",
        Value = { Min = 16, Max = 200, Default = 100 },
        Step = 1,
        Callback = function(value)
            if featureState.WalkSpeed and player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = tonumber(value) or 16
            end
        end
    })
    Tabs.Movement:Toggle({
        Title = "Enable Infinite Jump",
        Value = false,
        Callback = function(v) featureState.InfiniteJump = v end
    })
    local UserInputService = game:GetService("UserInputService")
    if UserInputService then
        UserInputService.JumpRequest:Connect(function()
            if featureState.InfiniteJump and player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
    local NoClipToggle
    NoClipToggle = Tabs.Movement:Toggle({
        Title = "Enable No Clip",
        Value = false,
        Callback = function(state)
            featureState.NoClip = state
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
            if featureState.NoClip and player and player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                end
            end
        end
    end)
    if player then
        player.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid", 5)
            if featureState.WalkSpeed and humanoid then
                humanoid.WalkSpeed = tonumber(WalkSpeedSlider.Value.Default) or 16
            end
        end)
    end
end

task.spawn(function()
    local Modules = replicatedStorage:WaitForChild("Modules")
    local Common = require(Modules:WaitForChild("Common"))
    local Client = require(Modules:WaitForChild("Client"))
    local RebirthEvent = Common.Events.RebirthUp
    local WheelEvent = Common.Events.Wheel
    local PetEvent = Common.Events.PetEvent
    local ClaimEvent = Common.Events.Claim
    local SeasonEvent = Common.Events.Season
    local TrainEvent = replicatedStorage:WaitForChild("Warp"):WaitForChild("Index"):WaitForChild("Event"):WaitForChild("Reliable")
    
    local headlineLabel = player.PlayerGui:WaitForChild("MainUI"):WaitForChild("Top"):WaitForChild("RaceTimer"):WaitForChild("Headline")

    task.spawn(function()
        while task.wait(0.1) do
            local raceIsActive = headlineLabel and headlineLabel.Text ~= ""

            if featureState.AutoWin and raceIsActive then
                isAtTrainingArea = false
                local rootPart = player.Character and player.Character.HumanoidRootPart
                local track = workspace:FindFirstChild("Track")
                if rootPart and track then
                    local stageName = "Stage" .. string.format("%02d", currentStage)
                    local stage = track:FindFirstChild(stageName)
                    if stage then
                        local signPart = stage:FindFirstChild("Sign")
                        if signPart then
                            rootPart.CFrame = signPart.CFrame * CFrame.new(0, 3, 0)
                            firetouchinterest(rootPart, signPart, 0)
                            firetouchinterest(rootPart, signPart, 1)
                            currentStage = (currentStage % 18) + 1
                        end
                    end
                end
                task.wait(tonumber(AutoWinDelaySlider.Value.Default) or 0.5)
            elseif featureState.AutoTrain then
                local rootPart = player.Character and player.Character.HumanoidRootPart
                if rootPart then
                    if not isAtTrainingArea or (rootPart.Position - trainingTeleportPosition).Magnitude > 20 then
                        rootPart.CFrame = CFrame.new(trainingTeleportPosition)
                        isAtTrainingArea = true
                        task.wait(0.5)
                    end
                    for i = 1, 12 do
                        local args = { buffer.fromstring("\027"), buffer.fromstring("\254\002\000\006\005Power\001" .. string.char(i)) }
                        TrainEvent:FireServer(unpack(args))
                    end
                end
                task.wait(tonumber(AutoTrainDelaySlider.Value.Default) or 0.5)
            else
                isAtTrainingArea = false
            end
        end
    end)

    task.spawn(function()
        while task.wait(1) do
            if featureState.AutoRebirth then
                pcall(function()
                    local nextRebirthLevel = Client.Data.Rebirth + 1
                    local rebirthInfo = Common.Config.Rebirth.GetRebirth(nextRebirthLevel)
                    if rebirthInfo and Client.Wins.Get() >= rebirthInfo.Price then
                        RebirthEvent:Fire(true)
                    end
                end)
            end

            if featureState.AutoSpin then
                pcall(function()
                    if Client.Data.SpinCount > 0 then
                        WheelEvent:Invoke(1, true)
                    end
                end)
            end

            if featureState.AutoEquipBest then
                pcall(function()
                    if player:GetAttribute("PetsCount") > 0 then
                        PetEvent:Fire(true, "EquipBest")
                    end
                end)
            end

            if featureState.AutoClaimGifts then
                pcall(function()
                    for i = 1, 10 do
                        ClaimEvent:Fire(true, "Online", "OnlineGift" .. string.format("%03d", i))
                    end
                end)
            end

            if featureState.AutoClaimSeason then
                pcall(function()
                    for i = 1, 100 do
                        local seasonData = Common.Config.Season.GetSeasonData(i)
                        if seasonData then
                            SeasonEvent:Fire(true, "ClimFree", seasonData.Id)
                            SeasonEvent:Fire(true, "ClimPremium", seasonData.Id)
                        else
                            break
                        end
                    end
                end)
            end
        end
    end)
end)

local VirtualUser = game:GetService("VirtualUser")
if player and VirtualUser then
    player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

if Window then
    Window:SelectTab(1)
    WindUI:Notify({
        Title = "Arcvour Script Ready",
        Content = "All features have been loaded for Kayak Racing.",
        Duration = 8,
        Icon = "check-circle"
    })
end