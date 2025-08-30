--// SERVICES AND VARIABLES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local noclipEnabled = false
local ownerUserId = 3500870223 -- Your Owner ID

--// CUSTOM NOTIFICATION SYSTEM
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

-- A centralized function for sending your preferred notifications
local function sendAppNotification(title, description, color, duration)
    Notification:Notify(
        {Title = title, Description = description},
        {OutlineColor = color or Color3.fromRGB(255, 255, 255), Time = duration or 5, Type = "default"}
    )
end

--// INITIAL LOADING NOTIFICATIONS & SOUND
sendAppNotification("Potato 64", "Loading Script...", Color3.fromRGB(255, 255, 0), 5)
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://3320590485"
sound.Volume = 5
sound:Play()
sound.Parent = LocalPlayer
wait(5)
sendAppNotification("Potato 64", "Script Loaded! Credits to potatoking.net", Color3.fromRGB(0, 255, 0), 10)
if LocalPlayer.UserId == ownerUserId then
    sendAppNotification("Welcome Owner", "Welcome back, " .. LocalPlayer.Name, Color3.fromRGB(0, 170, 255), 5)
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
    sendAppNotification("Noclip", noclipEnabled and "Enabled" or "Disabled", Color3.fromRGB(255, 255, 0), 4)
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

--// YOUR UI LIBRARY
local success, library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew", true))()
end)

if not success or not library then
    sendAppNotification("Fatal Error", "Failed to load the Tora UI Library. Script cannot continue.", Color3.fromRGB(255, 0, 0), 15)
    return
end

--// GUI SETUP - TWO WINDOWS AS PER ORIGINAL SCRIPT
local window = library:CreateWindow("Potato 64 - Main")
local window2 = library:CreateWindow("Potato 64 - NOR Level")

--// -- MAIN WINDOW --
window:AddLabel({ text = "Main Functions" })

window:AddButton({
    text = "Anti-Report",
    callback = function()
        pcall(function()
            LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
            sendAppNotification("Anti-Report", "Activated successfully!", Color3.fromRGB(0, 255, 0), 5)
        end)
    end
})

window:AddToggle({
    text = "Player ESP",
    flag = "PlayerESP",
    callback = function(value)
        if value then esp() else unesp() end
        sendAppNotification("Player ESP", value and "Enabled" or "Disabled", Color3.fromRGB(255, 255, 0), 4)
    end
})

window:AddToggle({
    text = "Auto-Collect Items (OP)",
    flag = "AutoCollect",
    callback = function(value)
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
    end
})

window:AddToggle({
    text = "Auto-Dance (OP)",
    flag = "AutoDance",
    callback = function(value)
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
    end
})

window:AddLabel({ text = "Movement" })

window:AddButton({ text = "Toggle Noclip", callback = toggleNoclip })
window:AddButton({ text = "Fly Script (Zynox)", callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynox-Dev/Zynox-Fly/refs/heads/main/Fly.lua"))() end })
window:AddButton({ text = "Fly/Speed GUI (Alternate)", callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/U0wWyYc0"))() end })

window:AddLabel({ text = "Visuals" })

window:AddButton({
    text = "Loop Full Bright",
    callback = function()
        if _G.brightLoop then _G.brightLoop:Disconnect(); _G.brightLoop = nil end
        local Lighting = game:GetService("Lighting")
        _G.brightLoop = RunService.RenderStepped:Connect(function()
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end)
        sendAppNotification("Visuals", "Full Bright Loop enabled.", Color3.fromRGB(0, 255, 0), 4)
    end
})

window:AddSlider({ text = "FOV", min = 70, max = 120, callback = function(v) Workspace.Camera.FieldOfView = v end })

window:AddLabel({ text = "Credits: potatoking.net" })

window:AddButton({
    text = "Donate (Copy Link)",
    callback = function()
        if setclipboard then
            setclipboard("potatoking.net/pay")
            sendAppNotification("Donate", "Donation link copied to clipboard!", Color3.fromRGB(0, 255, 0), 5)
        else
            sendAppNotification("Error", "Could not copy link to clipboard.", Color3.fromRGB(255, 0, 0), 5)
        end
    end
})
window:AddImage({ image = "https://static.wikia.nocookie.net/roblox-piggy-wikia/images/6/60/PIG_64.jpg/revision/latest", height = 150 })

--// -- NOR LEVEL WINDOW --
window2:AddLabel({ text = "NOR Level Specific Functions" })

window2:AddToggle({
    text = "Auto Kill Boss",
    flag = "AutoKillBoss",
    callback = function(value)
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
    end
})

window2:AddToggle({
    text = "Auto Open Doors/Keys",
    flag = "AutoInteractNor",
    callback = function(value)
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
    end
})

window2:AddButton({
    text = "ESP Suspicious Tree",
    callback = function()
        for _, g in pairs(Workspace:GetDescendants()) do
            if g.Name == "SuspiciousTree" then
                pcall(function()
                    if g:FindFirstChild("BillboardGui") then g:FindFirstChild("BillboardGui"):Destroy() end
                    local UI = Instance.new("BillboardGui", g)
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
                end)
            end
        end
        sendAppNotification("ESP", "Highlighted all suspicious trees.", Color3.fromRGB(0, 255, 0), 5)
    end
})

window2:AddButton({
    text = "Delete Nor Damage (May not work)",
    callback = function()
        pcall(function()
            Workspace.Maps.WarehouseChase.MapSetup.PatrolAssets.PatrolNPCs.ChaseNor.HumanoidRootPart.CanTouch = false
            sendAppNotification("NOR Level", "Attempted to disable damage.", Color3.fromRGB(255, 255, 0), 4)
        end)
    end
})

--// INITIALIZE THE UI
library:Init()

--// OWNER COMMANDS
local function handleCommand(command)
    if LocalPlayer.UserId ~= ownerUserId then return end
    local args = {}
    for arg in command:gmatch("%S+") do table.insert(args, arg) end
    local cmd = string.lower(args[1])
    if cmd == "!kick" and args[2] then
        local targetPlayer = Players:FindFirstChild(args[2])
        if targetPlayer then
            targetPlayer:Kick("Kicked by Owner")
            sendAppNotification("Admin", "Kicked " .. targetPlayer.Name, Color3.fromRGB(0, 255, 0), 5)
        else
            sendAppNotification("Error", "Player not found: " .. args[2], Color3.fromRGB(255, 0, 0), 5)
        end
    elseif cmd == "!notify" then
        local message = table.concat(args, " ", 2)
        sendAppNotification("Owner Message", message, Color3.fromRGB(0, 170, 255), 10)
    elseif cmd == "!say" then
        local message = table.concat(args, " ", 2)
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end

LocalPlayer.Chatted:Connect(handleCommand)
