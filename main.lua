--[[
	MODIFICATION NOTES:
	- Wrapped the entire script in a protected call (pcall) to catch any potential errors during loading and print them.
	- Added a more robust method to get the LocalPlayer and their PlayerGui, preventing timing-related errors.
	- Included more print statements to help debug if the script stops at a certain point.
--]]

local success, errorMessage = pcall(function()
	
	print("potato 64 Script: Initializing...")

	-- Services
	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")

	-- Main Script Variables
	local player = game:GetService("Players").LocalPlayer
	if not player then
		player = game:GetService("Players").PlayerAdded:Wait()
	end
	
	local playerGui = player:WaitForChild("PlayerGui")
	print("potato 64 Script: Player services and GUI ready.")

	local noclipEnabled = false
	local ownerUserId = 5450713868 -- You can change this to your own UserId to see the welcome message

	-- Check for mobile device
	local isMobile = UserInputService.TouchEnabled

	task.wait(1)
	print("potato 64 Script: Successfully loaded!")
	if player.UserId == ownerUserId then
		print("Welcome Owner: " .. player.Name)
	end

	-- State variables for toggles
	local autoCollecting = false
	local autoKeys = false
	local autoDance = false
	local brightLoop = nil

	-- Core Cheat Functions
	function esp()
		print("ESP Function Called (Disabled in Studio): This requires an executor to run.")
	end

	function toggleNoclip(state)
		noclipEnabled = state or not noclipEnabled
		print("Noclip Toggled: " .. tostring(noclipEnabled))
		local char = player.Character
		if char then
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = not noclipEnabled
				end
			end
		end
	end

	RunService.Stepped:Connect(function()
		if noclipEnabled and player.Character then
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)


	-- GUI SETUP --
	print("potato 64 Script: Creating GUI...")
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ExecutorGui"
	screenGui.Parent = playerGui -- Parent to the guaranteed PlayerGui
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Parent = screenGui
	mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
	mainFrame.BorderSizePixel = 0
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Position = UDim2.new(0.5, 0, -0.5, 0)
	if isMobile then
		mainFrame.Size = UDim2.new(0, 320, 0, 280) -- Smaller size for mobile
	else
		mainFrame.Size = UDim2.new(0, 550, 0, 380) -- Original size for desktop
	end
	mainFrame.Visible = false

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 12)
	uiCorner.Parent = mainFrame
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = Color3.fromRGB(80, 80, 90)
	uiStroke.Thickness = 1.5
	uiStroke.Parent = mainFrame

	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Parent = mainFrame
	titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	titleBar.BorderSizePixel = 0
	titleBar.Size = UDim2.new(1, 0, 0, 35)
	local titleCorner = Instance.new("UICorner", titleBar)
	titleCorner.CornerRadius = UDim.new(0, 12)
	local titleGradient = Instance.new("UIGradient", titleBar)
	titleGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 40))})
	titleGradient.Rotation = 90

	local logo = Instance.new("ImageLabel")
	logo.Name = "Logo"
	logo.Parent = titleBar
	logo.Image = "rbxassetid://99543355360177" -- Changed Asset ID
	logo.BackgroundTransparency = 1
	logo.Position = UDim2.new(0, 10, 0.5, 0)
	logo.AnchorPoint = Vector2.new(0, 0.5)
	logo.Size = UDim2.new(0, 25, 0, 25)

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Parent = titleBar
	titleLabel.BackgroundTransparency = 1
	titleLabel.Size = UDim2.new(0, 200, 1, 0)
	titleLabel.Position = UDim2.new(0, 45, 0, 0)
	titleLabel.Font = Enum.Font.GothamSemibold
	titleLabel.Text = "potato 64 Script"
	titleLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
	titleLabel.TextSize = 18
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left

	local closeButton = Instance.new("ImageButton")
	closeButton.Name = "CloseButton"
	closeButton.Parent = titleBar
	closeButton.BackgroundTransparency = 1
	closeButton.AnchorPoint = Vector2.new(1, 0.5)
	closeButton.Position = UDim2.new(1, -10, 0.5, 0)
	closeButton.Size = UDim2.new(0, 20, 0, 20)
	closeButton.Image = "rbxassetid://1351660348"
	closeButton.ImageColor3 = Color3.fromRGB(200, 200, 200)

	local clickSound = Instance.new("Sound", screenGui)
	clickSound.SoundId = "rbxassetid://913363290"
	local hoverSound = Instance.new("Sound", screenGui)
	hoverSound.SoundId = "rbxassetid://632121282"
	hoverSound.Volume = 0.5

	local tabContainer = Instance.new("Frame")
	tabContainer.Name = "TabContainer"
	tabContainer.Parent = mainFrame
	tabContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
	tabContainer.BorderSizePixel = 0
	tabContainer.Position = UDim2.new(0, 0, 0, 35)
	if isMobile then
		tabContainer.Size = UDim2.new(0, 100, 1, -35) -- Adjusted tab container for mobile
	else
		tabContainer.Size = UDim2.new(0, 130, 1, -35)
	end
	local tabLayout = Instance.new("UIListLayout", tabContainer)
	tabLayout.FillDirection = Enum.FillDirection.Vertical
	tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Padding = UDim.new(0, 10)
	tabLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	local contentContainer = Instance.new("Frame")
	contentContainer.Name = "ContentContainer"
	contentContainer.Parent = mainFrame
	contentContainer.BackgroundTransparency = 1
	contentContainer.BorderSizePixel = 0
	if isMobile then
		contentContainer.Position = UDim2.new(0, 100, 0, 35)
		contentContainer.Size = UDim2.new(1, -100, 1, -35)
	else
		contentContainer.Position = UDim2.new(0, 130, 0, 35)
		contentContainer.Size = UDim2.new(1, -130, 1, -35)
	end
	
	print("potato 64 Script: Core GUI elements created. Building functions and tabs...")

	-- UI Creation Functions
	local function createTab(name, order)
		local tabButton = Instance.new("TextButton", tabContainer)
		tabButton.Name = name .. "Tab"
		tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
		tabButton.Size = UDim2.new(0.85, 0, 0, 35)
		tabButton.LayoutOrder = order
		tabButton.Font = Enum.Font.GothamSemibold
		tabButton.Text = name
		tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
		if isMobile then
			tabButton.TextSize = 14
		else
			tabButton.TextSize = 16
		end
		local tabCorner = Instance.new("UICorner", tabButton)
		tabCorner.CornerRadius = UDim.new(0, 6)
		local tabStroke = Instance.new("UIStroke", tabButton)
		tabStroke.Color = Color3.fromRGB(60, 60, 70)
		tabStroke.Thickness = 1

		local contentFrame = Instance.new("ScrollingFrame", contentContainer)
		contentFrame.Name = name .. "Content"
		contentFrame.BackgroundTransparency = 1
		contentFrame.Size = UDim2.new(1, 0, 1, 0)
		contentFrame.Visible = false
		contentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
		contentFrame.ScrollBarThickness = 6
		contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		local contentLayout = Instance.new("UIListLayout", contentFrame)
		contentLayout.FillDirection = Enum.FillDirection.Vertical
		contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		contentLayout.Padding = UDim.new(0, 10)

		tabButton.MouseEnter:Connect(function()
			hoverSound:Play()
			if not contentFrame.Visible then
				TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 75)}):Play()
			end
		end)
		tabButton.MouseLeave:Connect(function()
			if not contentFrame.Visible then
				TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
			end
		end)
		tabButton.MouseButton1Click:Connect(function()
			clickSound:Play()
			for _, content in ipairs(contentContainer:GetChildren()) do
				if content:IsA("ScrollingFrame") then content.Visible = false end
			end
			for _, button in ipairs(tabContainer:GetChildren()) do
				if button:IsA("TextButton") then
					TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
				end
			end
			contentFrame.Visible = true
			TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 120, 255)}):Play()
		end)
		return contentFrame
	end

	local function createButton(parent, label, callback)
		local button = Instance.new("TextButton", parent)
		button.Name = label .. "Button"
		button.BackgroundColor3 = Color3.fromRGB(55, 95, 225)
		button.Size = UDim2.new(0.9, 0, 0, 35)
		button.Font = Enum.Font.GothamSemibold
		button.Text = label
		button.TextColor3 = Color3.fromRGB(240, 240, 240)
		button.TextSize = 15
		local buttonCorner = Instance.new("UICorner", button)
		buttonCorner.CornerRadius = UDim.new(0, 8)
		local buttonStroke = Instance.new("UIStroke", button)
		buttonStroke.Color = Color3.fromRGB(80, 120, 255)
		buttonStroke.Thickness = 1

		button.MouseEnter:Connect(function()
			hoverSound:Play()
			TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(75, 115, 245)}):Play()
		end)
		button.MouseLeave:Connect(function()
			TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 95, 225)}):Play()
		end)
		button.MouseButton1Click:Connect(function()
			clickSound:Play()
			TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0.88, 0, 0, 33)}):Play()
			task.wait(0.1)
			TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0.9, 0, 0, 35)}):Play()
			if callback then callback() end
		end)
	end

	local function createToggle(parent, label, callback)
		local toggleFrame = Instance.new("Frame", parent)
		toggleFrame.Name = label .. "Toggle"
		toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
		toggleFrame.Size = UDim2.new(0.9, 0, 0, 35)
		local toggleCorner = Instance.new("UICorner", toggleFrame)
		toggleCorner.CornerRadius = UDim.new(0, 8)
		local toggleStroke = Instance.new("UIStroke", toggleFrame)
		toggleStroke.Color = Color3.fromRGB(50, 50, 55)
		toggleStroke.Thickness = 1

		local toggleLabel = Instance.new("TextLabel", toggleFrame)
		toggleLabel.BackgroundTransparency = 1
		toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
		toggleLabel.Position = UDim2.new(0.05, 0, 0, 0)
		toggleLabel.Font = Enum.Font.Gotham
		toggleLabel.Text = label
		toggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
		toggleLabel.TextSize = 15
		toggleLabel.TextXAlignment = Enum.TextXAlignment.Left

		local switch = Instance.new("TextButton", toggleFrame)
		switch.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
		switch.AnchorPoint = Vector2.new(1, 0.5)
		switch.Position = UDim2.new(1, -10, 0.5, 0)
		switch.Size = UDim2.new(0, 50, 0, 22)
		switch.Text = ""
		local switchCorner = Instance.new("UICorner", switch)
		switchCorner.CornerRadius = UDim.new(1, 0)

		local knob = Instance.new("Frame", switch)
		knob.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
		knob.AnchorPoint = Vector2.new(0, 0.5)
		knob.Position = UDim2.new(0, 3, 0.5, 0)
		knob.Size = UDim2.new(0, 16, 0, 16)
		local knobCorner = Instance.new("UICorner", knob)
		knobCorner.CornerRadius = UDim.new(1, 0)

		local toggled = false
		switch.MouseButton1Click:Connect(function()
			clickSound:Play()
			toggled = not toggled
			local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			if toggled then
				TweenService:Create(knob, tweenInfo, {Position = UDim2.new(1, -19, 0.5, 0)}):Play()
				TweenService:Create(knob, tweenInfo, {BackgroundColor3 = Color3.fromRGB(80, 220, 80)}):Play()
			else
				TweenService:Create(knob, tweenInfo, {Position = UDim2.new(0, 3, 0.5, 0)}):Play()
				TweenService:Create(knob, tweenInfo, {BackgroundColor3 = Color3.fromRGB(220, 80, 80)}):Play()
			end
			if callback then callback(toggled) end
		end)
	end

	local function createSlider(parent, label, min, max, default, callback)
		local sliderFrame = Instance.new("Frame", parent)
		sliderFrame.Name = label .. "Slider"
		sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
		sliderFrame.Size = UDim2.new(0.9, 0, 0, 50) -- Taller for better interaction
		local sliderCorner = Instance.new("UICorner", sliderFrame)
		sliderCorner.CornerRadius = UDim.new(0, 8)

		local sliderLabel = Instance.new("TextLabel", sliderFrame)
		sliderLabel.BackgroundTransparency = 1
		sliderLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
		sliderLabel.Size = UDim2.new(0.5, 0, 0.4, 0)
		sliderLabel.Font = Enum.Font.Gotham
		sliderLabel.Text = label
		sliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
		sliderLabel.TextSize = 15
		sliderLabel.TextXAlignment = Enum.TextXAlignment.Left

		local valueLabel = Instance.new("TextLabel", sliderFrame)
		valueLabel.BackgroundTransparency = 1
		valueLabel.AnchorPoint = Vector2.new(1, 0)
		valueLabel.Position = UDim2.new(0.95, 0, 0.2, 0)
		valueLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
		valueLabel.Font = Enum.Font.GothamBold
		valueLabel.Text = tostring(default)
		valueLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
		valueLabel.TextSize = 15
		valueLabel.TextXAlignment = Enum.TextXAlignment.Right

		local track = Instance.new("Frame", sliderFrame)
		track.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
		track.Position = UDim2.new(0.5, 0, 0.75, 0)
		track.AnchorPoint = Vector2.new(0.5, 0.5)
		track.Size = UDim2.new(0.9, 0, 0, 6)
		local trackCorner = Instance.new("UICorner", track)
		trackCorner.CornerRadius = UDim.new(1, 0)

		local fill = Instance.new("Frame", track)
		fill.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
		local fillCorner = Instance.new("UICorner", fill)
		fillCorner.CornerRadius = UDim.new(1, 0)

		local knob = Instance.new("Frame", track)
		knob.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		knob.Size = UDim2.new(0, 16, 0, 16)
		knob.AnchorPoint = Vector2.new(0.5, 0.5)
		local knobCorner = Instance.new("UICorner", knob)
		knobCorner.CornerRadius = UDim.new(1, 0)

		local dragging = false
		local function updateSlider(inputPos)
			local relativePos = track.AbsolutePosition.X
			local size = track.AbsoluteSize.X
			local alpha = math.clamp((inputPos.X - relativePos) / size, 0, 1)
			local value = math.floor(min + (max - min) * alpha + 0.5)

			knob.Position = UDim2.new(alpha, 0, 0.5, 0)
			fill.Size = UDim2.new(alpha, 0, 1, 0)
			valueLabel.Text = tostring(value)
			if callback then callback(value) end
		end

		-- Set default value
		local defaultAlpha = (default - min) / (max - min)
		knob.Position = UDim2.new(defaultAlpha, 0, 0.5, 0)
		fill.Size = UDim2.new(defaultAlpha, 0, 1, 0)

		track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				updateSlider(input.Position)
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				updateSlider(input.Position)
			end
		end)
	end

	local function createLabel(parent, text)
		local label = Instance.new("TextLabel", parent)
		label.BackgroundTransparency = 1
		label.Size = UDim2.new(0.9, 0, 0, 30)
		label.Font = Enum.Font.Gotham
		label.Text = text
		label.TextColor3 = Color3.fromRGB(200, 200, 200)
		label.TextSize = 16
		label.TextXAlignment = Enum.TextXAlignment.Center
	end

	-- Create Tabs and Content
	local mainTab = createTab("Main", 1)
	local norTab = createTab("NOR Level", 2)
	local creditsTab = createTab("Credits", 3)
	local updatesTab = createTab("Updates", 4) -- New updates tab

	print("potato 64 Script: Populating tabs with content...")
	
	-- Add content to Main tab
	createButton(mainTab, "Anti Report", function()
		if player.Character and player.Character.Humanoid then
			player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		end
		print("Anti-Report: Nametag hidden. Screenshot prevention is executor-only.")
	end)
	createButton(mainTab, "ESP (PLAYERS)", esp)
	createToggle(mainTab, "Auto Collect", function(state)
		autoCollecting = state
		print("Auto Collect Toggled: "..tostring(state))
	end)
	createButton(mainTab, "Toggle NoClip", toggleNoclip)
	createButton(mainTab, "Fly WORKS", function() print("Fly Script (Disabled in Studio): This requires an executor.") end)
	createSlider(mainTab, "FOV", 70, 120, 70, function(value)
		if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = value end
	end)
	createButton(mainTab, "Loop Full Bright", function()
		if brightLoop then brightLoop:Disconnect(); brightLoop = nil; print("Full Bright Disabled.") return end
		brightLoop = RunService.RenderStepped:Connect(function()
			game.Lighting.Brightness = 2
			game.Lighting.ClockTime = 14
			game.Lighting.FogEnd = 100000
		end)
		print("Full Bright Enabled.")
	end)
	createButton(mainTab, "No Prompt CD", function()
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
		end
		print("All ProximityPrompt hold durations set to 0.")
	end)

	-- Add content to NOR Level tab
	createButton(norTab, "ESP SUS tree", function()
		local count = 0
		for _, g in pairs(workspace:GetDescendants()) do
			if g.Name == "SuspiciousTree" then Instance.new("Highlight", g); count = count + 1 end
		end
		print("Highlighted " .. count .. " 'SuspiciousTree' objects.")
	end)
	createToggle(norTab, "Auto Keys/Open", function(state)
		autoKeys = state
		print("Auto Keys/Open Toggled: "..tostring(state))
	end)
	createToggle(norTab, "Auto Dance OP", function(state)
		autoDance = state
		print("Auto Dance Toggled: "..tostring(state))
	end)

	-- Add content to Credits tab
	createLabel(creditsTab, "Credits: potatoking")
	createLabel(creditsTab, "Donation: potatoking.net/pay")

	-- Add content to Updates tab
	createLabel(updatesTab, "Auto kill NOR boss is coming soon.")
	createLabel(updatesTab, "Fly GUI is getting better.")


	-- GUI Management
	local function openGui()
		mainFrame.Visible = true
		TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
	end

	local function closeGui()
		local tween = TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1.5, 0)})
		tween:Play()
		tween.Completed:Wait()
		screenGui:Destroy()
	end

	closeButton.MouseButton1Click:Connect(closeGui)

	-- Draggable functionality
	local dragging, dragStart, startPos
	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
			input:GetPropertyChangedSignal("UserInputState"):Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	print("potato 64 Script: Setup complete. Opening GUI...")
	
	-- Initial Tab Selection & Open
	mainTab.Visible = true
	local mainTabButton = tabContainer:FindFirstChild("MainTab")
	if mainTabButton then
		mainTabButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
	end
	openGui()

end)

if not success then
	warn("potato 64 Script failed to load. Error: " .. tostring(errorMessage))
end
