--[[
    Potato 64 - Fully Custom Script
    - GUI and Notifications are 100% self-made, no external libraries.
    - All original functions have been integrated.
    - UI is draggable, closable, and tabbed for ease of use.
]]

--// SERVICES AND CORE VARIABLES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local noclipEnabled = false
local ownerUserId = 3500870223

--// =================================================================================
--//  SECTION 1: SELF-MADE NOTIFICATION SYSTEM
--// =================================================================================

local notificationGui = Instance.new("ScreenGui")
notificationGui.Name = "PotatoNotificationGui"
notificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
notificationGui.ResetOnSpawn = false
notificationGui.Parent = game:GetService("CoreGui")

local function sendNotification(title, text, duration, color)
    local frame = Instance.new("Frame")
    frame.Name = "NotificationFrame"
    frame.Size = UDim2.new(0, 250, 0, 60)
    frame.Position = UDim2.new(1, 10, 0.5, 0) -- Start off-screen
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.BorderSizePixel = 0

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 6)

    local colorBar = Instance.new("Frame", frame)
    colorBar.Size = UDim2.new(0, 5, 1, 0)
    colorBar.BackgroundColor3 = color or Color3.fromRGB(130, 80, 255)
    colorBar.BorderSizePixel = 0
    local barCorner = Instance.new("UICorner", colorBar)
    barCorner.CornerRadius = UDim.new(0, 6)

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, -15, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Text = title or "Notification"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextSize = 16

    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, -15, 0, 25)
    textLabel.Position = UDim2.new(0, 10, 0, 25)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.SourceSans
    textLabel.Text = text or ""
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextSize = 14
    
    frame.Parent = notificationGui
    
    -- Animate
    local slideInInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local slideOutInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local slideIn = TweenService:Create(frame, slideInInfo, { Position = UDim2.new(1, -260, 0.5, 0) })
    local slideOut = TweenService:Create(frame, slideOutInfo, { Position = UDim2.new(1, 10, 0.5, 0) })
    
    slideIn:Play()
    task.wait(duration or 5)
    slideOut:Play()
    slideOut.Completed:Wait()
    frame:Destroy()
end

--// =================================================================================
--//  SECTION 2: CORE FEATURE FUNCTIONS
--// =================================================================================

local function esp()
    getgenv().enabled = true
    getgenv().filluseteamcolor = false
    getgenv().outlineuseteamcolor = false
    getgenv().fillcolor = Color3.new(1, 0, 0)
    getgenv().outlinecolor = Color3.new(1, 1, 1)
    getgenv().filltrans = 0.7
    getgenv().outlinetrans = 0
    loadstring(game:HttpGet("https://gist.githubusercontent.com/Ginxys/a2d26247ddcd1670ad9be672dfd94914/raw/b4f5acf1667f24916a6af7440e0444c0a15f5051/customesp"))()
end

local function unesp()
    getgenv().enabled = false
    loadstring(game:HttpGet("https://gist.githubusercontent.com/Ginxys/a2d26247ddcd1670ad9be672dfd94914/raw/b4f5acf1667f24916a6af7440e0444c0a15f5051/customesp"))()
end

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    sendNotification("Noclip", noclipEnabled and "Enabled" or "Disabled", 4, Color3.fromRGB(255, 170, 0))
end

RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

--// =================================================================================
--//  SECTION 3: SELF-MADE GUI
--// =================================================================================

local function createPotatoGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "PotatoGUI"
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui
    
    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 8)

    local topBar = Instance.new("Frame", mainFrame)
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    topBar.BorderSizePixel = 0
    local barCorner = Instance.new("UICorner", topBar)
    barCorner.CornerRadius = UDim.new(0, 8)
    
    local title = Instance.new("TextLabel", topBar)
    title.Size = UDim2.new(1, -30, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.SourceSansBold
    title.Text = "Potato 64 | by potatoking.net"
    title.TextColor3 = Color3.fromRGB(220, 220, 220)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextSize = 16

    local closeButton = Instance.new("TextButton", topBar)
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = topBar.BackgroundColor3
    closeButton.Text = "X"
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    closeButton.TextSize = 18
    closeButton.MouseButton1Click:Connect(function() gui:Destroy() end)

    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = UDim2.new(0, 120, 1, -30)
    tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    tabFrame.BorderSizePixel = 0

    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Size = UDim2.new(1, -120, 1, -30)
    contentFrame.Position = UDim2.new(0, 120, 0, 30)
    contentFrame.BackgroundColor3 = mainFrame.BackgroundColor3
    contentFrame.BorderSizePixel = 0

    local tabLayout = Instance.new("UIListLayout", tabFrame)
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local tabs = {}
    local contentPages = {}
    
    local function createTab(name)
        local page = Instance.new("ScrollingFrame", contentFrame)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundColor3 = contentFrame.BackgroundColor3
        page.BorderSizePixel = 0
        page.CanvasSize = UDim2.new(0, 0, 0, 0) -- Auto-size
        page.ScrollBarThickness = 5
        page.Visible = false
        local pageLayout = Instance.new("UIListLayout", page)
        pageLayout.Padding = UDim.new(0, 5)
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        Instance.new("UIPadding", page).PaddingLeft = UDim.new(0, 10)
        Instance.new("UIPadding", page).PaddingTop = UDim.new(0, 10)
        Instance.new("UIPadding", page).PaddingRight = UDim.new(0, 10)
        
        local button = Instance.new("TextButton", tabFrame)
        button.Name = name
        button.Size = UDim2.new(1, 0, 0, 35)
        button.BackgroundColor3 = tabFrame.BackgroundColor3
        button.Text = name
        button.Font = Enum.Font.SourceSansSemibold
        button.TextColor3 = Color3.fromRGB(180, 180, 180)
        button.TextSize = 16
        
        table.insert(tabs, button)
        contentPages[name] = page
        
        button.MouseButton1Click:Connect(function()
            for i, v in ipairs(tabs) do
                v.TextColor3 = Color3.fromRGB(180, 180, 180)
                v.BackgroundColor3 = tabFrame.BackgroundColor3
                contentPages[v.Name].Visible = false
            end
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundColor3 = mainFrame.BackgroundColor3
            page.Visible = true
        end)
        
        return page
    end
    
    -- Helper to create buttons/toggles inside a tab page
    local function createFeatureButton(parent, text, callback)
        local button = Instance.new("TextButton", parent)
        button.Size = UDim2.new(1, -20, 0, 30)
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        button.Text = text
        button.Font = Enum.Font.SourceSans
        button.TextColor3 = Color3.fromRGB(200, 200, 200)
        button.TextSize = 14
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 4)
        button.MouseButton1Click:Connect(callback)
        return button
    end
    
    local function createFeatureToggle(parent, text, flag, callback)
        local button = createFeatureButton(parent, text, nil)
        local onColor = Color3.fromRGB(76, 130, 90)
        local offColor = Color3.fromRGB(45, 45, 45)
        
        _G[flag] = false
        button.BackgroundColor3 = offColor
        
        button.MouseButton1Click:Connect(function()
            _G[flag] = not _G[flag]
            button.BackgroundColor3 = _G[flag] and onColor or offColor
            if callback then callback(_G[flag]) end
        end)
        return button
    end

    -- Create Tabs & Content
    local mainPage = createTab("Main")
    local norPage = createTab("NOR Level")
    local visualsPage = createTab("Visuals")
    local movementPage = createTab("Movement")

    -- Populate Main Page
    createFeatureButton(mainPage, "Anti-Report", function()
        pcall(function()
            LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
            sendNotification("Anti-Report", "Activated successfully!", 5, Color3.fromRGB(0, 255, 0))
        end)
    end)
    createFeatureToggle(mainPage, "Auto-Collect Items (OP)", "AutoCollect", function(state)
        task.spawn(function()
            while _G.AutoCollect do
                if Workspace:FindFirstChild("Collectables") then
                    for _, item in ipairs(Workspace.Collectables:GetDescendants()) do
                        if item.Name == "Hitbox" then
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 0)
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 1)
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end)
    createFeatureToggle(mainPage, "Auto-Dance (OP)", "AutoDance", function(state)
        task.spawn(function()
            while _G.AutoDance do
                if ReplicatedStorage:FindFirstChild("Source", true) then
                    local danceRemote = ReplicatedStorage.Source.Puzzles.Part7.Darcy.Remotes.RegisterDance
                    for i = 1, 5 do danceRemote:InvokeServer(i, "Dance" .. (i + 5)) end
                    task.wait(0.2)
                end
            end
        end)
    end)
    
    -- Populate NOR Level Page
    createFeatureToggle(norPage, "Auto Kill Boss", "AutoKillBoss", function(state)
        task.spawn(function()
            while _G.AutoKillBoss do
                if ReplicatedStorage:FindFirstChild("Source", true) then
                    for _, obj in ipairs(ReplicatedStorage.Source.Puzzles.Networking.__NETWORKINGOBJECTS:GetDescendants()) do
                        if obj.Name == "DamageBoss" then obj:FireServer() end
                    end
                end
                task.wait(0.5)
            end
        end)
    end)
    createFeatureToggle(norPage, "Auto Open Doors/Keys", "AutoInteractNor", function(state)
        if state then
            RunService:BindToRenderStep("AutoProximityPrompt", Enum.RenderPriority.Character.Value, function()
                if _G.AutoInteractNor and Workspace.Maps:FindFirstChild("WarehouseChase") then
                    for _, prompt in ipairs(Workspace.Maps.WarehouseChase.MapSetup:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                            prompt.HoldDuration = 0
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end)
        else
            if RunService:IsRenderStepped("AutoProximityPrompt") then
                RunService:UnbindFromRenderStep("AutoProximityPrompt")
            end
        end
    end)

    -- Populate Visuals Page
    createFeatureToggle(visualsPage, "Player ESP", "PlayerESP", function(state)
        if state then esp() else unesp() end
        sendNotification("Player ESP", state and "Enabled" or "Disabled", 4, Color3.fromRGB(255, 170, 0))
    end)
    createFeatureButton(visualsPage, "Full Bright (One Time)", function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.FogEnd = 100000;
        Lighting.GlobalShadows = false; Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        sendNotification("Visuals", "Full Bright applied.", 4, Color3.fromRGB(0, 255, 0))
    end)
    
    -- Populate Movement Page
    createFeatureButton(movementPage, "Toggle Noclip", toggleNoclip)
    createFeatureButton(movementPage, "Fly Script (Zynox)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynox-Dev/Zynox-Fly/refs/heads/main/Fly.lua"))() end)

    -- Draggable functionality
    local dragging, dragStart, startPos
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    topBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Final setup
    tabs[1].MouseButton1Click:Fire() -- Select first tab
    gui.Parent = game:GetService("CoreGui")
end

--// =================================================================================
--//  SECTION 4: SCRIPT INITIALIZATION
--// =================================================================================

-- Initial notifications with the custom system
sendNotification("Potato 64", "Loading Script...", 4, Color3.fromRGB(255, 170, 0))
task.wait(4)
sendNotification("Potato 64", "Script Loaded!", 5, Color3.fromRGB(0, 255, 0))
if LocalPlayer.UserId == ownerUserId then
    task.wait(1)
    sendNotification("Welcome, Owner", LocalPlayer.Name, 5, Color3.fromRGB(0, 170, 255))
end

-- Play sound
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://3320590485"
sound.Volume = 5
sound:Play()
sound.Parent = LocalPlayer

-- Create the GUI
createPotatoGUI()

-- Owner Commands
LocalPlayer.Chatted:Connect(function(msg)
    if LocalPlayer.UserId ~= ownerUserId then return end
    local args = msg:split(" ")
    local cmd = args[1]:lower()
    if cmd == "!kick" and args[2] then
        local target = Players:FindFirstChild(args[2])
        if target then
            target:Kick("Kicked by Owner")
            sendNotification("Admin", "Kicked " .. target.Name, 5, Color3.fromRGB(255, 0, 0))
        end
    end
end)
