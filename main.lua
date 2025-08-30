-- script made by potatoking (potatoking.net/pay for donations), template used by Gynixius
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local noclipEnabled = false
local ownerUserId = 3500870223

local NotificationModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local NotificationClient = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

local function sendNotification(title, description, notificationType, duration)
    local types = {
        default = {color = Color3.fromRGB(255, 255, 255), icon = "rbxassetid://13829412863"},
        success = {color = Color3.fromRGB(0, 255, 0), icon = "rbxassetid://13829412863"},
        warning = {color = Color3.fromRGB(255, 255, 0), icon = "rbxassetid://13829414882"},
        error = {color = Color3.fromRGB(255, 0, 0), icon = "rbxassetid://13829414882"}
    }
    local selectedType = types[notificationType] or types.default

    NotificationClient:Notify(
        {Title = title, Description = description, Icon = selectedType.icon},
        {OutlineColor = selectedType.color, Time = duration or 5, Type = "default"}
    )
end

sendNotification("Gynixius NOTIFY!", "Loading Script...", "default", 5)
wait(5)
sendNotification("Gynixius NOTIFY!", "Script Loaded! Credits to potatoking.net", "success", 10)
if LocalPlayer.UserId == ownerUserId then
    sendNotification("Welcome Owner", "Welcome back, " .. LocalPlayer.Name, "default", 5)
end

local espEnabled = false
local function toggleEsp(state)
    espEnabled = state
    getgenv().enabled = espEnabled
    getgenv().filluseteamcolor = false
    getgenv().outlineuseteamcolor = false
    getgenv().fillcolor = Color3.new(1, 0, 0)
    getgenv().outlinecolor = Color3.new(1, 1, 1)
    getgenv().filltrans = 0.7
    getgenv().outlinetrans = 0
    loadstring(game:HttpGet("https://gist.githubusercontent.com/Ginxys/a2d26247ddcd1670ad9be672dfd94914/raw/b4f5acf1667f24916a6af7440e0444c0a15f5051/customesp"))()
end

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://3320590485"
sound.Volume = 5
sound:Play()
sound.Parent = LocalPlayer

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    sendNotification("Noclip", noclipEnabled and "Enabled" or "Disabled", "warning", 4)
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

local success, library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew", true))()
end)

if not success or not library then
    sendNotification("Error", "Failed to load the UI Library. The script cannot continue.", "error", 10)
    return
end

local window = library:CreateWindow("Potato 64")

local mainTab = window:AddTab({ name = "Main" })
local visualsTab = window:AddTab({ name = "Visuals" })
local movementTab = window:AddTab({ name = "Movement" })
local miscTab = window:AddTab({ name = "Misc" })
local creditsTab = window:AddTab({ name = "Credits" })

mainTab:AddLabel({ text = "Core Functions" })

mainTab:AddButton({
    text = "Anti-Report",
    callback = function()
        pcall(function()
            LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
            sendNotification("Anti-Report", "Activated successfully!", "success", 5)
        end)
    end
})

mainTab:AddToggle({
    text = "Auto-Collect Items (OP)",
    flag = "AutoCollect",
    callback = function(value)
        _G.autoCollect = value
        if _G.autoCollect then
            while _G.autoCollect do
                if Workspace:FindFirstChild("Collectables") then
                    for _, item in ipairs(Workspace.Collectables:GetDescendants()) do
                        if item.Name == "Hitbox" then
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 0)
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 1)
                        end
                    end
                end
                wait(1)
            end
        end
    end
})

mainTab:AddToggle({
    text = "Auto-Open Doors/Keys (Nor Level)",
    flag = "AutoInteract",
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

mainTab:AddButton({
    text = "Remove Prompt Cooldown",
    callback = function()
        game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
        end)
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
        sendNotification("No Prompt CD", "All prompt cooldowns removed.", "success", 5)
    end
})

visualsTab:AddLabel({ text = "Visual Enhancements" })

visualsTab:AddToggle({
    text = "Player ESP",
    flag = "PlayerESP",
    callback = function(value)
        toggleEsp(value)
        sendNotification("Player ESP", value and "Enabled" or "Disabled", "default", 4)
    end
})

visualsTab:AddButton({
    text = "Highlight Suspicious Trees",
    callback = function()
        for _, item in ipairs(Workspace:GetDescendants()) do
            if item.Name == "SuspiciousTree" then
                local highlight = Instance.new("Highlight", item)
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
            end
        end
        sendNotification("ESP", "Highlighted all suspicious trees.", "success", 5)
    end
})

visualsTab:AddButton({
    text = "Full Bright",
    callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        sendNotification("Visuals", "Full Bright enabled.", "success", 4)
    end
})

visualsTab:AddSlider({
    text = "FOV",
    min = 70,
    max = 120,
    default = 70,
    callback = function(value)
        Workspace.Camera.FieldOfView = value
    end
})

movementTab:AddLabel({ text = "Character Movement" })

movementTab:AddButton({
    text = "Toggle Noclip",
    callback = function()
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        toggleNoclip()
    end
})

movementTab:AddButton({
    text = "Fly Script (Zynox)",
    callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynox-Dev/Zynox-Fly/refs/heads/main/Fly.lua"))()
        sendNotification("Movement", "Fly script loaded.", "success", 4)
    end
})

movementTab:AddButton({
    text = "Alternate Fly/Speed GUI",
    callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/U0wWyYc0"))()
        sendNotification("Movement", "Alternate movement GUI loaded.", "success", 4)
    end
})

miscTab:AddLabel({ text = "Miscellaneous Functions" })

miscTab:AddToggle({
    text = "Auto-Dance (OP)",
    flag = "AutoDance",
    callback = function(value)
        _G.autoDance = value
        if _G.autoDance then
            local danceRemote = ReplicatedStorage.Source.Puzzles.Part7.Darcy.Remotes.RegisterDance
            while _G.autoDance do
                for i = 1, 5 do
                    danceRemote:InvokeServer(i, "Dance" .. (i + 5))
                end
                wait(0.2)
            end
        end
    end
})

creditsTab:AddImage({
    image = "https://static.wikia.nocookie.net/roblox-piggy-wikia/images/6/60/PIG_64.jpg/revision/latest",
    height = 150
})
creditsTab:AddLabel({ text = "Credits: potatoking.net" })

creditsTab:AddButton({
    text = "Donate",
    callback = function()
        if setclipboard then
            setclipboard("potatoking.net/pay")
            sendNotification("Donate", "Donation link copied to clipboard!", "success", 5)
        else
            sendNotification("Error", "Could not copy link to clipboard.", "error", 5)
        end
    end
})

library:Init()

local function handleCommand(command)
    if LocalPlayer.UserId ~= ownerUserId then return end

    local args = {}
    for arg in command:gmatch("%S+") do table.insert(args, arg) end

    local cmd = args[1]:lower()
    table.remove(args, 1)

    if cmd == "!kick" and args[1] then
        local targetPlayer = Players:FindFirstChild(args[1])
        if targetPlayer then
            targetPlayer:Kick("Kicked by Owner")
            sendNotification("Admin", "Kicked " .. targetPlayer.Name, "success", 5)
        else
            sendNotification("Error", "Player not found: " .. args[1], "error", 5)
        end
    elseif cmd == "!notifyall" then
        local message = table.concat(args, " ")
        sendNotification("Owner Message", message, "default", 10)
    elseif cmd == "!say" then
        local message = table.concat(args, " ")
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end

LocalPlayer.Chatted:Connect(handleCommand)
