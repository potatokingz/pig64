local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local noclipEnabled = false
local ownerUserId = 3500870223 -- Updated Owner ID

--// Use a stable and reliable UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// UNIFIED NOTIFICATION SYSTEM
local function sendNotification(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 5,
        Image = "rbxassetid://13829412863",
    })
end

--// INITIAL LOADING NOTIFICATIONS & SOUND
sendNotification("Potato 64", "Loading Script...", 5)
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://3320590485"
sound.Volume = 5
sound:Play()
sound.Parent = LocalPlayer
wait(5)
sendNotification("Potato 64", "Script Loaded! Credits to potatoking.net", 10)
if LocalPlayer.UserId == ownerUserId then
    sendNotification("Welcome Owner", "Welcome back, " .. LocalPlayer.Name, 5)
end

--// ORIGINAL ESP FUNCTIONS
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

--// Noclip Function
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    sendNotification("Noclip", noclipEnabled and "Enabled" or "Disabled", 4)
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

--// NEW GUI SETUP
local window = Rayfield:CreateWindow({
    Name = "Potato 64",
    LoadingTitle = "Loading Potato 64",
    LoadingSubtitle = "by potatoking.net",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Potato64",
        FileName = "Config"
    }
})

--// TABS
local mainTab = window:CreateTab("Main")
local norLevelTab = window:CreateTab("NOR Level")
local visualsTab = window:CreateTab("Visuals")
local movementTab = window:CreateTab("Movement")
local creditsTab = window:CreateTab("Credits")

--// MAIN TAB
mainTab:CreateSection("Core Functions")

mainTab:CreateButton({
    Name = "Anti-Report",
    Callback = function()
        pcall(function()
            LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
            sendNotification("Anti-Report", "Activated successfully!", 5)
        end)
    end,
})

mainTab:CreateToggle({
    Name = "Auto-Collect Items (OP)",
    CurrentValue = false,
    Flag = "AutoCollect",
    Callback = function(value)
        _G.autoCollect = value
        task.spawn(function()
            while _G.autoCollect do
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
    end,
})

mainTab:CreateToggle({
    Name = "Auto-Dance (OP)",
    CurrentValue = false,
    Flag = "AutoDance",
    Callback = function(value)
        _G.autoDance = value
        task.spawn(function()
            if _G.autoDance then
                local danceRemote = ReplicatedStorage:WaitForChild("Source"):WaitForChild("Puzzles"):WaitForChild("Part7"):WaitForChild("Darcy"):WaitForChild("Remotes"):WaitForChild("RegisterDance")
                while _G.autoDance do
                    for i = 1, 5 do
                        danceRemote:InvokeServer(i, "Dance" .. (i + 5))
                    end
                    task.wait(0.2)
                end
            end
        end)
    end,
})

mainTab:CreateButton({
    Name = "Remove Prompt Cooldown",
    Callback = function()
        game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
        end)
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
        sendNotification("No Prompt CD", "All prompt cooldowns removed.", 5)
    end,
})

--// NOR LEVEL TAB
norLevelTab:CreateSection("NOR Level Specific")

norLevelTab:CreateToggle({
    Name = "Auto Kill Boss",
    CurrentValue = false,
    Flag = "AutoKillBoss",
    Callback = function(value)
        _G.autoKill = value
        task.spawn(function()
            while _G.autoKill do
                for _, obj in ipairs(ReplicatedStorage.Source.Puzzles.Networking.__NETWORKINGOBJECTS:GetDescendants()) do
                    if obj.Name == "DamageBoss" then
                        obj:FireServer()
                    end
                end
                task.wait(0.5)
            end
        end)
    end,
})

norLevelTab:CreateToggle({
    Name = "Auto Open Doors/Keys",
    CurrentValue = false,
    Flag = "AutoInteractNor",
    Callback = function(value)
        _G.AutoE = value
        if _G.AutoE then
            RunService:BindToRenderStep("AutoProximityPrompt", Enum.RenderPriority.Character.Value, function()
                if _G.AutoE and Workspace.Maps:FindFirstChild("WarehouseChase") then
                    for _, prompt in ipairs(Workspace.Maps.WarehouseChase.MapSetup:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                            prompt.HoldDuration = 0
                            fireproximityprompt(prompt)
                        end
                    end
                else
                    RunService:UnbindFromRenderStep("AutoProximityPrompt")
                end
            end)
        else
            if RunService:IsRenderStepped("AutoProximityPrompt") then
                RunService:UnbindFromRenderStep("AutoProximityPrompt")
            end
        end
    end,
})

norLevelTab:CreateButton({
    Name = "ESP Suspicious Tree",
    Callback = function()
        for _, g in pairs(Workspace:GetDescendants()) do
            if g.Name == "SuspiciousTree" then
                if not g:FindFirstChild("RayfieldESP") then
                    local highlight = Instance.new("Highlight", g)
                    local UI = Instance.new("BillboardGui", g)
                    UI.Name = "RayfieldESP"
                    UI.Size = UDim2.new(0, 200, 0, 50)
                    UI.AlwaysOnTop = true
                    local Label = Instance.new("TextLabel", UI)
                    Label.Size = UDim2.new(1, 0, 1, 0)
                    Label.BackgroundTransparency = 1
                    Label.TextScaled = true
                    Label.Text = "SusTree"
                    Label.TextColor3 = Color3.new(1, 0, 0)
                    Label.Font = Enum.Font.Oswald
                    Label.TextStrokeTransparency = 0
                end
            end
        end
        sendNotification("ESP", "Highlighted all suspicious trees.", 5)
    end,
})

norLevelTab:CreateButton({
    Name = "Delete Nor Damage (May not work)",
    Callback = function()
        pcall(function()
            Workspace.Maps.WarehouseChase.MapSetup.PatrolAssets.PatrolNPCs.ChaseNor.HumanoidRootPart.CanTouch = false
            sendNotification("NOR Level", "Attempted to disable damage.", 4)
        end)
    end,
})

--// VISUALS TAB
visualsTab:CreateSection("Visual Enhancements")

visualsTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(value)
        if value then esp() else unesp() end
        sendNotification("Player ESP", value and "Enabled" or "Disabled", 4)
    end,
})

visualsTab:CreateButton({
    Name = "Loop Full Bright",
    Callback = function()
        if _G.brightLoop then
            _G.brightLoop:Disconnect()
            _G.brightLoop = nil
        end
        local Lighting = game:GetService("Lighting")
        _G.brightLoop = RunService.RenderStepped:Connect(function()
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end)
        sendNotification("Visuals", "Full Bright Loop enabled.", 4)
    end,
})

visualsTab:CreateSlider({
    Name = "FOV",
    Range = {70, 120},
    Increment = 1,
    Suffix = " FOV",
    CurrentValue = 70,
    Callback = function(value)
        Workspace.Camera.FieldOfView = value
    end,
})

--// MOVEMENT TAB
movementTab:CreateSection("Character Movement")

movementTab:CreateButton({
    Name = "Toggle Noclip",
    Callback = function()
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        toggleNoclip()
    end,
})

movementTab:CreateButton({
    Name = "Fly Script (Zynox)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynox-Dev/Zynox-Fly/refs/heads/main/Fly.lua"))()
    end,
})

movementTab:CreateButton({
    Name = "Alternate Fly/Speed GUI",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/U0wWyYc0"))()
    end,
})

--// CREDITS TAB
creditsTab:CreateSection()
creditsTab:CreateImage({
    Image = "https://static.wikia.nocookie.net/roblox-piggy-wikia/images/6/60/PIG_64.jpg/revision/latest",
    ImageHeight = 200
})
creditsTab:CreateLabel("Credits: potatoking.net")

creditsTab:CreateButton({
    Name = "Donate",
    Callback = function()
        if setclipboard then
            setclipboard("potatoking.net/pay")
            sendNotification("Donate", "Donation link copied to clipboard!", 5)
        else
            sendNotification("Error", "Could not copy link to clipboard.", 5)
        end
    end,
})

--// OWNER COMMANDS
local function handleCommand(command)
    if LocalPlayer.UserId ~= ownerUserId then return end

    local args = {}
    for arg in command:gmatch("%S+") do table.insert(args, arg) end

    local cmd = string.lower(args[1])
    local targetName = args[2]

    if cmd == "!kick" and targetName then
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer then
            targetPlayer:Kick("Kicked by Owner")
            sendNotification("Admin", "Kicked " .. targetPlayer.Name, 5)
        else
            sendNotification("Error", "Player not found: " .. targetName, 5)
        end
    elseif cmd == "!notify" then
        local message = table.concat(args, " ", 2)
        sendNotification("Owner Message", message, 10)
    elseif cmd == "!say" then
        local message = table.concat(args, " ", 2)
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end

LocalPlayer.Chatted:Connect(handleCommand)
