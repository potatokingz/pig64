--[[
    Potato 64 - 100% Custom & Fixed
    - GUI and Notifications are completely self-made. NO LIBRARIES.
    - Fixed the critical bug that prevented the GUI from loading.
    - Fixed the error in the owner command system.
    - Added Right Control keybind to toggle the GUI.
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

--// UTILITY FUNCTION (Fixes owner commands)
local function string_split(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}; i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str; i = i + 1
    end
    return t
end

--// =================================================================================
--//  SECTION 1: SELF-MADE NOTIFICATION SYSTEM
--// =================================================================================

local notificationGui = Instance.new("ScreenGui")
notificationGui.Name = "PotatoNotificationGui"
notificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
notificationGui.ResetOnSpawn = false
notificationGui.Parent = game:GetService("CoreGui")

local function sendNotification(title, text, duration, color)
    task.spawn(function()
        local frame = Instance.new("Frame")
        frame.Name = "NotificationFrame"
        frame.Size = UDim2.new(0, 250, 0, 60)
        frame.Position = UDim2.new(1, 10, 0.8, 0)
        frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        frame.BorderSizePixel = 0
        frame.Parent = notificationGui

        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
        
        local colorBar = Instance.new("Frame", frame)
        colorBar.Size = UDim2.new(0, 5, 1, 0)
        colorBar.BackgroundColor3 = color or Color3.fromRGB(130, 80, 255)
        colorBar.BorderSizePixel = 0
        Instance.new("UICorner", colorBar).CornerRadius = UDim.new(0, 6)

        local titleLabel = Instance.new("TextLabel", frame)
        titleLabel.Size = UDim2.new(1, -15, 0, 25); titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1; titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.Text = title or "Notification"; titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left; titleLabel.TextSize = 16

        local textLabel = Instance.new("TextLabel", frame)
        textLabel.Size = UDim2.new(1, -15, 0, 25); textLabel.Position = UDim2.new(0, 10, 0, 25)
        textLabel.BackgroundTransparency = 1; textLabel.Font = Enum.Font.SourceSans
        textLabel.Text = text or ""; textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        textLabel.TextXAlignment = Enum.TextXAlignment.Left; textLabel.TextSize = 14
        
        local slideIn = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { Position = UDim2.new(1, -260, 0.8, 0) })
        local slideOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { Position = UDim2.new(1, 10, 0.8, 0) })
        
        slideIn:Play()
        task.wait(duration or 5)
        slideOut:Play()
        slideOut.Completed:Wait()
        frame:Destroy()
    end)
end

--// =================================================================================
--//  SECTION 2: CORE FEATURE FUNCTIONS
--// =================================================================================

local function esp() loadstring(game:HttpGet("https://gist.githubusercontent.com/Ginxys/a2d26247ddcd1670ad9be672dfd94914/raw/b4f5acf1667f24916a6af7440e0444c0a15f5051/customesp"))() end
local function unesp() getgenv().enabled = false end
getgenv().enabled = false; getgenv().filluseteamcolor = false; getgenv().outlineuseteamcolor = false; getgenv().fillcolor = Color3.new(1, 0, 0); getgenv().outlinecolor = Color3.new(1, 1, 1); getgenv().filltrans = 0.7; getgenv().outlinetrans = 0

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    sendNotification("Noclip", noclipEnabled and "Enabled" or "Disabled", 4, Color3.fromRGB(255, 170, 0))
end

RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

--// =================================================================================
--//  SECTION 3: SELF-MADE GUI
--// =================================================================================

local function createPotatoGUI()
    local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    gui.Name = "PotatoGUI"
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Name = "MainFrame"; mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175); mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0; Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
    
    local topBar = Instance.new("Frame", mainFrame)
    topBar.Size = UDim2.new(1, 0, 0, 30); topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    topBar.BorderSizePixel = 0; Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 8)
    
    local title = Instance.new("TextLabel", topBar)
    title.Size = UDim2.new(1, 0, 1, 0); title.Position = UDim2.new(0, 10, 0, 0); title.BackgroundTransparency = 1
    title.Font = Enum.Font.SourceSansBold; title.Text = "Potato 64 | by potatoking.net"
    title.TextColor3 = Color3.fromRGB(220, 220, 220); title.TextXAlignment = Enum.TextXAlignment.Left; title.TextSize = 16

    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = UDim2.new(0, 120, 1, -30); tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28); tabFrame.BorderSizePixel = 0
    Instance.new("UIListLayout", tabFrame).Padding = UDim.new(0, 5)

    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Size = UDim2.new(1, -120, 1, -30); contentFrame.Position = UDim2.new(0, 120, 0, 30)
    contentFrame.BackgroundColor3 = mainFrame.BackgroundColor3; contentFrame.BorderSizePixel = 0

    local tabs, contentPages = {}, {}
    local function createTab(name)
        local page = Instance.new("ScrollingFrame", contentFrame)
        page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundColor3 = contentFrame.BackgroundColor3
        page.BorderSizePixel = 0; page.ScrollBarThickness = 5; page.Visible = false
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y -- CRITICAL FIX
        local pageLayout = Instance.new("UIListLayout", page); pageLayout.Padding = UDim.new(0, 5)
        Instance.new("UIPadding", page).Padding = UDim.new(0, 10)
        
        local button = Instance.new("TextButton", tabFrame)
        button.Name = name; button.Size = UDim2.new(1, 0, 0, 35); button.BackgroundColor3 = tabFrame.BackgroundColor3
        button.Font = Enum.Font.SourceSansSemibold; button.TextColor3 = Color3.fromRGB(180, 180, 180); button.TextSize = 16; button.Text = name
        
        table.insert(tabs, button); contentPages[name] = page
        
        button.MouseButton1Click:Connect(function()
            for _, v in ipairs(tabs) do
                contentPages[v.Name].Visible = false
                v.TextColor3 = Color3.fromRGB(180, 180, 180); v.BackgroundColor3 = tabFrame.BackgroundColor3
            end
            page.Visible = true
            button.TextColor3 = Color3.fromRGB(255, 255, 255); button.BackgroundColor3 = mainFrame.BackgroundColor3
        end)
        return page
    end
    
    local function createFeature(parent, type, text, flag, callback)
        local button = Instance.new("TextButton", parent)
        button.Size = UDim2.new(1, -10, 0, 30); button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        button.Font = Enum.Font.SourceSans; button.TextColor3 = Color3.fromRGB(200, 200, 200); button.TextSize = 14; button.Text = text
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 4)
        
        if type == "Button" then
            button.MouseButton1Click:Connect(callback)
        elseif type == "Toggle" then
            local onColor, offColor = Color3.fromRGB(76, 130, 90), Color3.fromRGB(45, 45, 45)
            _G[flag] = false; button.BackgroundColor3 = offColor
            button.MouseButton1Click:Connect(function()
                _G[flag] = not _G[flag]; button.BackgroundColor3 = _G[flag] and onColor or offColor
                if callback then callback(_G[flag]) end
            end)
        end
    end
    
    local mainPage = createTab("Main"); local norPage = createTab("NOR Level"); local visualsPage = createTab("Visuals"); local movementPage = createTab("Movement")

    createFeature(mainPage, "Button", "Anti-Report", nil, function()
        pcall(function() if LocalPlayer.Character then LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end; setfflag("AbuseReportScreenshot", "False"); setfflag("AbuseReportScreenshotPercentage", "0"); sendNotification("Anti-Report", "Activated successfully!", 5, Color3.fromRGB(0, 255, 0)) end)
    end)
    createFeature(mainPage, "Toggle", "Auto-Collect Items", "AutoCollect", function() task.spawn(function() while _G.AutoCollect do if Workspace:FindFirstChild("Collectables") then for _, item in ipairs(Workspace.Collectables:GetDescendants()) do if item.Name == "Hitbox" then firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 0); firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 1) end end end; task.wait(1) end end) end)
    createFeature(mainPage, "Toggle", "Auto-Dance", "AutoDance", function() task.spawn(function() while _G.AutoDance do if ReplicatedStorage:FindFirstChild("Source", true) then for i=1,5 do ReplicatedStorage.Source.Puzzles.Part7.Darcy.Remotes.RegisterDance:InvokeServer(i, "Dance" .. (i+5)) end; task.wait(0.2) end end end) end)
    
    createFeature(norPage, "Toggle", "Auto Kill Boss", "AutoKillBoss", function() task.spawn(function() while _G.AutoKillBoss do if ReplicatedStorage:FindFirstChild("Source", true) then for _, obj in ipairs(ReplicatedStorage.Source.Puzzles.Networking.__NETWORKINGOBJECTS:GetDescendants()) do if obj.Name == "DamageBoss" then obj:FireServer() end end end; task.wait(0.5) end end) end)
    createFeature(norPage, "Toggle", "Auto Open Doors/Keys", "AutoInteractNor", function(state) if not state and RunService:IsRenderStepped("AutoProximityPrompt") then RunService:UnbindFromRenderStep("AutoProximityPrompt") else RunService:BindToRenderStep("AutoProximityPrompt", Enum.RenderPriority.Character.Value, function() if _G.AutoInteractNor and Workspace.Maps:FindFirstChild("WarehouseChase") then for _, p in ipairs(Workspace.Maps.WarehouseChase.MapSetup:GetDescendants()) do if p:IsA("ProximityPrompt") and p.Enabled then p.HoldDuration=0; fireproximityprompt(p) end end end end) end end)

    createFeature(visualsPage, "Toggle", "Player ESP", "PlayerESP", function(state) if state then esp() else unesp() end; sendNotification("Player ESP", state and "Enabled" or "Disabled", 4, Color3.fromRGB(255, 170, 0)) end)
    createFeature(visualsPage, "Button", "Full Bright", nil, function() local l=game:GetService("Lighting");l.Brightness=2;l.ClockTime=14;l.FogEnd=100000;l.GlobalShadows=false;l.OutdoorAmbient=Color3.fromRGB(128,128,128); sendNotification("Visuals", "Full Bright applied", 4,Color3.fromRGB(0,255,0)) end)

    createFeature(movementPage, "Button", "Toggle Noclip", nil, toggleNoclip)
    createFeature(movementPage, "Button", "Fly Script (Zynox)", nil, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynox-Dev/Zynox-Fly/refs/heads/main/Fly.lua"))() end)

    tabs[1].MouseButton1Click:Fire()
    
    local dragging,dragStart,startPos; topBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging,dragStart,startPos=true,i.Position,mainFrame.Position end end); topBar.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end); UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local d=i.Position-dragStart; mainFrame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)
    UserInputService.InputBegan:Connect(function(input, gp) if gp then return end; if input.KeyCode == Enum.KeyCode.RightControl then mainFrame.Visible = not mainFrame.Visible end end)
end

--// =================================================================================
--//  SECTION 4: SCRIPT INITIALIZATION
--// =================================================================================

sendNotification("Potato 64", "Loading Script...", 4, Color3.fromRGB(255, 170, 0))
task.wait(4)
sendNotification("Potato 64", "Script Loaded!", 5, Color3.fromRGB(0, 255, 0))
if LocalPlayer.UserId == ownerUserId then task.wait(1); sendNotification("Welcome, Owner", LocalPlayer.Name, 5, Color3.fromRGB(0, 170, 255)) end

local sound = Instance.new("Sound", LocalPlayer); sound.SoundId = "rbxassetid://3320590485"; sound.Volume = 5; sound:Play()
createPotatoGUI()

LocalPlayer.Chatted:Connect(function(msg)
    if LocalPlayer.UserId ~= ownerUserId then return end
    local args = string_split(msg, " ")
    local cmd = args[1]:lower()
    if cmd == "!kick" and args[2] then
        local target = Players:FindFirstChild(args[2])
        if target then target:Kick("Kicked by Owner"); sendNotification("Admin", "Kicked " .. target.Name, 5, Color3.fromRGB(255, 0, 0)) end
    end
end)
