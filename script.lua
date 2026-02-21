-- === Main UI + รวมทุกสคริปต์ ===
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- เคลียร์ของเก่า
local old = PlayerGui:FindFirstChild("MainUI")
if old then old:Destroy() end

-- ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainUI"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- ฟังก์ชันลากได้
local function makeDraggable(frame)
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		local goal = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		TweenService:Create(frame, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = goal}):Play()
	end
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and input == dragInput then update(input) end
	end)
end

-- กรอบหลัก
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 1300, 0, 700)
MainFrame.Position = UDim2.new(0.5, -430, 0.5, -280)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Visible = false
-- ====== PRO KEY UI ======
local RunService = game:GetService("RunService")

local correctKey = "ezmxixy1992"

-- Background Blur
local blur = Instance.new("BlurEffect")
blur.Size = 18
blur.Parent = game.Lighting

-- Main Key Frame
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 420, 0, 230)
KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -115)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.BackgroundTransparency = 0.1
KeyFrame.Parent = ScreenGui

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Parent = KeyFrame

-- RGB Border
local hue = 0
RunService.RenderStepped:Connect(function()
	hue += 0.004
	if hue > 1 then hue = 0 end
	stroke.Color = Color3.fromHSV(hue,1,1)
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "🔐เจ้าของ IG:ezmxixy "
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = KeyFrame

-- TextBox
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1,-60,0,50)
KeyBox.Position = UDim2.new(0,30,0,80)
KeyBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.PlaceholderText = "Kuy ไรสัส"
KeyBox.TextScaled = true
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,12)

-- Glow Effect
local glow = Instance.new("UIStroke")
glow.Color = Color3.fromRGB(0,255,255)
glow.Thickness = 2
glow.Parent = KeyBox

-- Button
local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(1,-60,0,50)
Submit.Position = UDim2.new(0,30,0,150)
Submit.BackgroundColor3 = Color3.fromRGB(0,170,255)
Submit.Text = "UNLOCK"
Submit.TextColor3 = Color3.new(1,1,1)
Submit.TextScaled = true
Submit.Font = Enum.Font.GothamBold
Submit.Parent = KeyFrame

Instance.new("UICorner", Submit).CornerRadius = UDim.new(0,12)

-- Button Hover Glow
Submit.MouseEnter:Connect(function()
	TweenService:Create(Submit,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(0,200,255)}):Play()
end)

Submit.MouseLeave:Connect(function()
	TweenService:Create(Submit,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(0,170,255)}):Play()
end)

-- Wrong Shake Effect
local function shake()
	for i=1,6 do
		KeyFrame.Position += UDim2.new(0, math.random(-6,6), 0, 0)
		task.wait(0.03)
	end
	KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -115)
end

-- Click
Submit.MouseButton1Click:Connect(function()
	if KeyBox.Text == correctKey then
		
		-- Fade Out
		TweenService:Create(KeyFrame,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
		task.wait(0.4)
		
		KeyFrame:Destroy()
		blur:Destroy()
		MainFrame.Visible = true
		
	else
		KeyBox.Text = "ACCESS DENIED"
		KeyBox.TextColor3 = Color3.fromRGB(255,0,0)
		shake()
		task.wait(1)
		KeyBox.Text = ""
		KeyBox.TextColor3 = Color3.new(1,1,1)
	end
end)

makeDraggable(MainFrame)

local mainCorner = Instance.new("UICorner"); mainCorner.CornerRadius = UDim.new(0, 20); mainCorner.Parent = MainFrame
local mainStroke = Instance.new("UIStroke"); mainStroke.Color = Color3.fromRGB(255,255,255); mainStroke.Thickness = 2; mainStroke.Parent = MainFrame

-- Header
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 44)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
HeaderFrame.BorderSizePixel = 0
HeaderFrame.Parent = MainFrame

local headerCorner = Instance.new("UICorner"); headerCorner.CornerRadius = UDim.new(0, 12); headerCorner.Parent = HeaderFrame
local headerStroke = Instance.new("UIStroke"); headerStroke.Color = Color3.fromRGB(255,255,255); headerStroke.Thickness = 1; headerStroke.Parent = HeaderFrame

local HeaderLabel = Instance.new("TextLabel")
HeaderLabel.Size = UDim2.new(1, -20, 1, 0)
HeaderLabel.Position = UDim2.new(0, 10, 0, 0)
HeaderLabel.BackgroundTransparency = 1
HeaderLabel.Text = "Thanakrit Version_2.0👑"
HeaderLabel.TextColor3 = Color3.fromRGB(255,255,255)
HeaderLabel.Font = Enum.Font.GothamBold
HeaderLabel.TextScaled = true
HeaderLabel.Parent = HeaderFrame

-- พื้นที่เก็บ Panel
local PanelContainer = Instance.new("Frame")
PanelContainer.Size = UDim2.new(1, -40, 1, -96)
PanelContainer.Position = UDim2.new(0, 20, 0, 56)
PanelContainer.BackgroundTransparency = 1
PanelContainer.Parent = MainFrame

local HLayout = Instance.new("UIListLayout")
HLayout.FillDirection = Enum.FillDirection.Horizontal
HLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
HLayout.VerticalAlignment = Enum.VerticalAlignment.Top
HLayout.Padding = UDim.new(0, 20)
HLayout.Parent = PanelContainer

-- ฟังก์ชันสร้าง Panel
local function createPanel(title)
	local Panel = Instance.new("Frame")
	Panel.Size = UDim2.new(0, 270, 1, -20)
	Panel.BackgroundColor3 = Color3.fromRGB(30,30,30)
	Panel.BorderSizePixel = 0
	Panel.Parent = PanelContainer

	local pCorner = Instance.new("UICorner"); pCorner.CornerRadius = UDim.new(0, 12); pCorner.Parent = Panel
	local pStroke = Instance.new("UIStroke"); pStroke.Color = Color3.fromRGB(0,0,0); pStroke.Thickness = 2; pStroke.Parent = Panel

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, 0, 0, 32)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = title
	TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextScaled = true
	TitleLabel.Parent = Panel

	local Content = Instance.new("ScrollingFrame")
	Content.Size = UDim2.new(1, -10, 1, -42)
	Content.Position = UDim2.new(0, 5, 0, 36)
	Content.BackgroundTransparency = 1
	Content.ScrollBarThickness = 6
	Content.BorderSizePixel = 0
	Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Content.CanvasSize = UDim2.new(0, 0, 0, 0)
	Content.Parent = Panel

	local List = Instance.new("UIListLayout")
	List.Padding = UDim.new(0, 6)
	List.SortOrder = Enum.SortOrder.LayoutOrder
	List.Parent = Content

	return Panel, Content
end

-- ฟังก์ชันปุ่ม
local function createPlayerButton(parent, playerName, onClick)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.TextScaled = true
	btn.TextWrapped = true
	btn.AutoButtonColor = true
	btn.Text = playerName
	btn.Parent = parent
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = btn
	btn.MouseButton1Click:Connect(onClick)
	return btn
end

local function createScriptToggle(parent, label, callbackOnOff)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 34)
	btn.BackgroundColor3 = Color3.fromRGB(0,140,0)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.TextScaled = true
	btn.TextWrapped = true
	btn.Text = "[OFF] "..label
	btn.Parent = parent
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = btn
	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = (state and "[ON] " or "[OFF] ")..label
		callbackOnOff(state, btn)
	end)
	return btn
end

local function createScriptRun(parent, label, runFunc)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 34)
	btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.TextScaled = true
	btn.TextWrapped = true
	btn.Text = "Run : "..label
	btn.Parent = parent
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = btn
	btn.MouseButton1Click:Connect(function() pcall(runFunc) end)
	return btn
end

-- 3 Panel
local WarpPanel, WarpContent   = createPanel("วาปไปหาผู้เล่น")
local SpecPanel, SpecContent   = createPanel("ดูจอผู้เล่น")
local MenuPanel, MenuContent   = createPanel("ทำต่อเองไอสัส")
local ScriptsPanel, ScriptsContent = createPanel("รวมทุกสคริป")

-- Warp Players
local function rebuildWarp()
	for _, ch in ipairs(WarpContent:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= Player then
			createPlayerButton(WarpContent, p.Name, function()
				local me = Player.Character
				local target = p.Character
				if me and target and me:FindFirstChild("HumanoidRootPart") and target:FindFirstChild("HumanoidRootPart") then
					me:MoveTo(target.HumanoidRootPart.Position)
				end
			end)
		end
	end
end
rebuildWarp()
Players.PlayerAdded:Connect(rebuildWarp)
Players.PlayerRemoving:Connect(rebuildWarp)

-- Spectate
local currentSpectate = nil
local spectateButtons = {}

local function applySpectateVisuals()
	for plr, btn in pairs(spectateButtons) do
		if plr == currentSpectate then
			btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
			btn.BackgroundTransparency = 0.35
		else
			btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
			btn.BackgroundTransparency = 0
		end
	end
end

local function rebuildSpectate()
	for _, ch in ipairs(SpecContent:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
	spectateButtons = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= Player then
			local btn = createPlayerButton(SpecContent, p.Name, function()
				if currentSpectate == p then
					local hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
					if hum then Camera.CameraSubject = hum end
					currentSpectate = nil
				else
					local hum = p.Character and p.Character:FindFirstChild("Humanoid")
					if hum then
						Camera.CameraSubject = hum
						currentSpectate = p
					end
				end
				applySpectateVisuals()
			end)
			spectateButtons[p] = btn
		end
	end
	applySpectateVisuals()
end
rebuildSpectate()
Players.PlayerAdded:Connect(rebuildSpectate)
Players.PlayerRemoving:Connect(function(plr)
	if plr == currentSpectate then
		local hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
		if hum then Camera.CameraSubject = hum end
		currentSpectate = nil
	end
	rebuildSpectate()
end)

Player.CharacterAdded:Connect(function()
	if currentSpectate == nil then
		local hum = Player.Character:WaitForChild("Humanoid", 5)
		if hum then Camera.CameraSubject = hum end
	end
end)

-- Toggle/Run Scripts
local ToggleScripts = {}
local RunScripts = {}

local function refreshScriptsPanel()
	for _, v in pairs(ScriptsContent:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
	for _, s in ipairs(ToggleScripts) do
		createScriptToggle(ScriptsContent, s.label, s.callback)
	end
	for _, s in ipairs(RunScripts) do
		createScriptRun(ScriptsContent, s.label, s.callback)
	end
end

local function addToggleScript(label, callback)
	table.insert(ToggleScripts, {label=label, callback=callback})
	refreshScriptsPanel()
end

local function addRunScript(label, callback)
	table.insert(RunScripts, {label=label, callback=callback})
	refreshScriptsPanel()
end

-- ESP
-- ESP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local espEnabled = false
local espObjects = {}
local connections = {}

local function clearESP()
	for _, v in pairs(espObjects) do
		if v and v.Parent then v:Destroy() end
	end
	for _, c in pairs(connections) do
		if c then c:Disconnect() end
	end
	espObjects = {}
	connections = {}
end

local function createESP(player)
	if not player.Character then return end
	local head = player.Character:FindFirstChild("Head")
	if not head then return end
	
	-- ชื่อบนหัว
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.AlwaysOnTop = true
	billboard.StudsOffset = Vector3.new(0, 2, 0)
	billboard.Parent = head

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1,0,1,0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = player.Name
	nameLabel.TextScaled = true
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.Parent = billboard

	-- Highlight เรืองแสง
	local highlight = Instance.new("Highlight")
	highlight.Adornee = player.Character
	highlight.FillTransparency = 0.4
	highlight.OutlineTransparency = 0
	highlight.Parent = player.Character

	table.insert(espObjects, billboard)
	table.insert(espObjects, highlight)

	-- 🌈 ระบบสีรุ้ง
	local hue = 0
	local connection
	connection = RunService.RenderStepped:Connect(function()
		if not player.Character or not player.Character.Parent then
			connection:Disconnect()
			return
		end
		
		hue = (hue + 0.01) % 1
		local color = Color3.fromHSV(hue,1,1)

		nameLabel.TextColor3 = color
		highlight.FillColor = color
		highlight.OutlineColor = color
	end)

	table.insert(connections, connection)
end
local function updateESP()
	clearESP()
	if espEnabled then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= Player then
				createESP(plr)
			end
		end
	end
end
Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		wait(1)
		if espEnabled then createESP(plr) end
	end)
end)
Players.PlayerRemoving:Connect(updateESP)

-- Toggle Scripts
addToggleScript("ESP Payer", function(state) espEnabled = state updateESP() end)

local clickTPActive = false
local mouse = Player:GetMouse()
mouse.Button1Down:Connect(function()
	if clickTPActive and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
		local pos = mouse.Hit + Vector3.new(0,2.5,0)
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X,pos.Y,pos.Z)
	end
end)
addToggleScript("Teleport", function(state) clickTPActive = state end)

-- Infinite Jump
local infiniteJump = false
game:GetService("UserInputService").JumpRequest:Connect(function()
	if infiniteJump and Player.Character then
		local hum = Player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)
addToggleScript("Infinite Jump", function(state) infiniteJump = state end)

--  Scripts

addRunScript("กระจายออกนอกโลก⬇️⬇️", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_5wpM7bBcOPspmX7lQ3m75SrYNWqxZ858ai3tJdEAId6jSI05IOUB224FQ0VSAswH.lua.txt', true))()
end)

addRunScript("ใช้ร่วมกับอันด้านบน⏫⏫", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/3LD4D0/FE-TROLLING-PLAYER-R6-R15/6eff8792afed57458d5114478b453a6f6bce5799/Fe%20trolling%20Player%20R6%20AND%20R15"))()
end)

addRunScript("Speed", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/PrototypeRBLX/Speed-Script/main/README.md', true))()
end)

addRunScript("เดินทะลุ", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/2JZWpiKn", true))()
end)

addRunScript("เช็คเพื่อน", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/itsryp/roblox-scripts/main/friendviewer.lua"))()
end)

addRunScript("ล็อกโหดสำหรับ เเนว FPS", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Aimbot-Mobile-34677"))()
end)


addRunScript("ซูมเข้าออกไม่จำกัด", function()
	repeat task.wait() until game:IsLoaded()
local plr = game.Players.LocalPlayer

local function unlock()
    pcall(function()
        plr.CameraMaxZoomDistance = 1e9
        plr.CameraMinZoomDistance = 0
        plr.CameraMode = Enum.CameraMode.Classic
    end)
end

unlock()

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0,50,0,50)
btn.Position = UDim2.new(0.07,0,0.45,0)
btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
btn.Text = "ZOOM"
btn.TextColor3 = Color3.new(1,1,1)
btn.TextSize = 12
btn.Active = true
btn.Draggable = true

Instance.new("UICorner",btn).CornerRadius = UDim.new(1,0)

local on = true

btn.MouseButton1Click:Connect(function()
    on = not on

    if on then
        btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
        unlock()
    else
        btn.BackgroundColor3 = Color3.fromRGB(120,20,20)

        pcall(function()
            plr.CameraMaxZoomDistance = 128
            plr.CameraMinZoomDistance = 0.5
        end)
    end
end)

task.spawn(function()
    while task.wait(2) do
        if on then
            unlock()
        end
    end
end)

plr.CharacterAdded:Connect(function()
    task.wait(1)
    if on then unlock() end
end)
end)

addRunScript("เช็คคนเข้าออก", function()
    local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- สร้าง ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "JoinLeaveUI"
gui.Parent = player:WaitForChild("PlayerGui")

-- กล่องหลัก
local container = Instance.new("Frame")
container.Size = UDim2.new(0, 300, 1, -20)
container.Position = UDim2.new(1, -320, 0, 10)
container.BackgroundTransparency = 1
container.Parent = gui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = container
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

-- ฟังก์ชันสร้างแจ้งเตือน
local function createNotification(text, color)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 280, 0, 50)
	frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	frame.BackgroundTransparency = 0.1
	frame.BorderSizePixel = 0
	frame.Position = UDim2.new(1, 300, 0, 0)
	frame.Parent = container
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = frame
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = 2
	stroke.Parent = frame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.Parent = frame
	
	-- Slide In
	local tweenIn = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, 0, 0, 0)
	})
	tweenIn:Play()
	
	task.wait(3)
	
	-- Slide Out
	local tweenOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Position = UDim2.new(1, 300, 0, 0)
	})
	tweenOut:Play()
	
	tweenOut.Completed:Wait()
	frame:Destroy()
end

-- คนเข้า
Players.PlayerAdded:Connect(function(plr)
	if plr ~= player then
		createNotification(plr.Name .. " เข้าร่วมเซิร์ฟเวอร์", Color3.fromRGB(0,255,120))
	end
end)

-- คนออก
Players.PlayerRemoving:Connect(function(plr)
	createNotification(plr.Name .. " ออกจากเซิร์ฟเวอร์", Color3.fromRGB(255,80,80))
end)
end)

addRunScript("สคริปรวม V1)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/TOUxIllIll0O00OO/RobloxscriptTOU/refs/heads/main/TOU%20HUB((Mixed)"))()
end)

addRunScript("สคริปรวม V2", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/2737di/roblox/refs/heads/main/ฟ"))();
end)

addRunScript("สคริปรวม ของดีมี F3X V3", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/Pyjiz4ME",true))()
end)

-- Exit
local ExitButton = Instance.new("TextButton")
ExitButton.Size = UDim2.new(0, 66, 0, 26)
ExitButton.Position = UDim2.new(1, -78, 1, -38)
ExitButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ExitButton.TextColor3 = Color3.fromRGB(255,255,255)
ExitButton.TextScaled = true
ExitButton.Text = "Exit"
ExitButton.AutoButtonColor = true
ExitButton.Parent = MainFrame
local exitC = Instance.new("UICorner"); exitC.CornerRadius = UDim.new(0, 6); exitC.Parent = ExitButton
ExitButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Pumpkin
local Pumpkin = Instance.new("TextButton")
Pumpkin.Name = "PumpkinToggle"
Pumpkin.Size = UDim2.new(0, 96, 0, 25)
Pumpkin.Position = UDim2.new(0, 15, 0.25, -48)
Pumpkin.BackgroundTransparency = 1
Pumpkin.Text = ""
local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.new(1,0,1,0)
Icon.BackgroundTransparency = 1
Icon.Image = "รอเติมรูปภาพ ID"
Icon.Parent = Pumpkin
Pumpkin.TextScaled = true
Pumpkin.Parent = ScreenGui
makeDraggable(Pumpkin)

Pumpkin.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
UIS.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.F1 then MainFrame.Visible = not MainFrame.Visible end
end)
-- ===== RGB EFFECT =====
local RunService = game:GetService("RunService")

local hue = 0

RunService.RenderStepped:Connect(function()
    hue = hue + 0.001
    if hue > 1 then
        hue = 0
    end

    local rgbColor = Color3.fromHSV(hue, 1, 1)

    -- เปลี่ยนสีขอบ
    mainStroke.Color = rgbColor

    -- เปลี่ยนสีพื้นหลัง (ปรับความเข้มลงนิด)
    MainFrame.BackgroundColor3 = Color3.fromHSV(hue, 0.6, 0.4)
end)
