--[=[
 d888b  db   db d888888b     .d888b.     db   db   db  .d8b.  
88' Y8b 88   88   `88'       VP  `8D     88   88   88 d8' `8b 
88      88   88    88           odD'     88   88   88 88ooo88 
88  ooo 88   88    88         .88'       88   88   88 88~~~88 
88. ~8~ 88b d88   .88.       j88.        88booo. 88b  d88 88   88     @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D     Y88888P ~Y8888P' YP   YP  CONVERTER 
]=]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local Library = {}

function Library:CreateWindow(config)
	local windowName = configName or "MyUI"
	
	-- 1. ScreenGui chính
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = windowName
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = playerGui

	-- 2. MainFrame
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 664, 0, 392)
	MainFrame.Position = UDim2.new(0.21154, 0, 0.18374, 0)
	MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BackgroundTransparency = 0.65
	MainFrame.BorderSizePixel = 0
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.Parent = ScreenGui

	-- Bo góc MainFrame
	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 8)
	MainCorner.Parent = MainFrame

	-- Nút tròn bên ngoài để bật/tắt Menu kèm hiệu ứng xoay 360 độ
	local ToggleMenuButton = Instance.new("ImageButton")
	ToggleMenuButton.Name = "ToggleMenuButton"
	ToggleMenuButton.Size = UDim2.new(0, 45, 0, 45)
	ToggleMenuButton.Position = UDim2.new(0.05, 0, 0.1, 0)
	ToggleMenuButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	ToggleMenuButton.BackgroundTransparency = 0.4
	ToggleMenuButton.BorderSizePixel = 0
	ToggleMenuButton.Image = "rbxassetid://96966121535917" -- Có thể thay ID ảnh tùy ý bạn
	ToggleMenuButton.Parent = ScreenGui

	local ToggleButtonCorner = Instance.new("UICorner")
	ToggleMenuButtonCorner.CornerRadius = UDim.new(1, 0)
	ToggleMenuButtonCorner.Parent = ToggleMenuButton

	local ToggleButtonStroke = Instance.new("UIStroke")
	ToggleButtonStroke.Color = Color3.fromRGB(255, 255, 255)
	ToggleButtonStroke.Thickness = 1.5
	ToggleButtonStroke.Parent = ToggleMenuButton

	local menuVisible = true
	local isRotating = false

	ToggleMenuButton.MouseButton1Click:Connect(function()
		menuVisible = not menuVisible
		MainFrame.Visible = menuVisible

		if not isRotating then
			isRotating = true
			local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local currentRotation = ToggleMenuButton.Rotation
			TweenService:Create(ToggleMenuButton, tweenInfo, {Rotation = currentRotation + 360}):Play()
			task.delay(0.4, function()
				isRotating = false
			end)
		end
	end)

	-- 3. Sidebar
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0, 133, 0, 370)
	Sidebar.Position = UDim2.new(0.01908, 0, 0.02532, 0)
	Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Sidebar.BackgroundTransparency = 0.4
	Sidebar.BorderSizePixel = 0
	Sidebar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Sidebar.Parent = MainFrame

	-- Bo góc Sidebar
	local SidebarCorner = Instance.new("UICorner")
	SidebarCorner.CornerRadius = UDim.new(0, 6)
	SidebarCorner.Parent = Sidebar

	-- 3.1 Hình ảnh bên phải Sidebar
	local SidebarImage = Instance.new("ImageLabel")
	SidebarImage.Name = "SidebarImage"
	SidebarImage.Size = UDim2.new(0, 100, 0, 100)
	SidebarImage.Position = UDim2.new(0, 142, 0.02532, 0)
	SidebarImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	SidebarImage.BackgroundTransparency = 0.5
	SidebarImage.BorderSizePixel = 0
	SidebarImage.Image = "rbxassetid://96966121535917"
	SidebarImage.Parent = MainFrame

	-- Bo góc cho ImageLabel
	local SidebarImageCorner = Instance.new("UICorner")
	SidebarImageCorner.CornerRadius = UDim.new(0, 6)
	SidebarImageCorner.Parent = SidebarImage

	-- 4. PagesContainer
	local PagesContainer = Instance.new("Frame")
	PagesContainer.Name = "PagesContainer"
	PagesContainer.Size = UDim2.new(0, 451, 0, 333)
	PagesContainer.Position = UDim2.new(0.25596, 0, 0.11899, 0)
	PagesContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	PagesContainer.BackgroundTransparency = 0.5
	PagesContainer.BorderSizePixel = 0
	PagesContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PagesContainer.Parent = MainFrame

	-- Bo góc PagesContainer
	local PagesCorner = Instance.new("UICorner")
	PagesCorner.CornerRadius = UDim.new(0, 6)
	PagesCorner.Parent = PagesContainer

	-- 5. Avatar ImageLabel
	local UserAvatar = Instance.new("ImageLabel")
	UserAvatar.Name = "UserAvatar"
	UserAvatar.Size = UDim2.new(0, 32, 0, 30)
	UserAvatar.Position = UDim2.new(0.89269, 0, 0.02532, 0)
	UserAvatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserAvatar.BorderSizePixel = 0
	UserAvatar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	UserAvatar.Parent = MainFrame

	local AvatarCorner = Instance.new("UICorner")
	AvatarCorner.CornerRadius = UDim.new(0, 50)
	AvatarCorner.Parent = UserAvatar

	-- Hiển thị tên tài khoản bên trái Avatar
	local UserNameLabel = Instance.new("TextLabel")
	UserNameLabel.Name = "UserNameLabel"
	UserNameLabel.Size = UDim2.new(0, 150, 0, 30)
	UserNameLabel.Position = UDim2.new(0.89269, -158, 0.02532, 0)
	UserNameLabel.BackgroundTransparency = 1
	UserNameLabel.Text = localPlayer.DisplayName
	UserNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserNameLabel.TextSize = 13
	UserNameLabel.TextXAlignment = Enum.TextXAlignment.Right
	UserNameLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	UserNameLabel.Parent = MainFrame

	task.spawn(function()
		local success, content = pcall(function()
			return Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
		end)
		if success then
			UserAvatar.Image = content
		end
	end)

	-- 6. Nút Đóng (CloseButton)
	local CloseButton = Instance.new("TextButton")
	CloseButton.Name = "CloseButton"
	CloseButton.Size = UDim2.new(0, 39, 0, 41)
	CloseButton.Position = UDim2.new(0.94088, 0, 0.86224, 0)
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.BackgroundTransparency = 3
	CloseButton.BorderSizePixel = 0
	CloseButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	CloseButton.TextSize = 14
	CloseButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	CloseButton.Parent = MainFrame

	CloseButton.MouseButton1Click:Connect(function()
		ScreenGui.Enabled = false
	end)

	-- 7. Nút Phóng To / Thu Nhỏ (MaximizeButton)
	local MaximizeButton = Instance.new("TextButton")
	MaximizeButton.Name = "MaximizeButton"
	MaximizeButton.Size = UDim2.new(0, 38, 0, 37)
	MaximizeButton.Position = UDim2.new(0.94088, 0, 0.7449, 0)
	MaximizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MaximizeButton.BackgroundTransparency = 3
	MaximizeButton.BorderSizePixel = 0
	MaximizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MaximizeButton.Text = "□"
	MaximizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	MaximizeButton.TextSize = 14
	MaximizeButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	MaximizeButton.Parent = MainFrame

	local normalMainSize = MainFrame.Size
	local normalMainPos = MainFrame.Position
	local targetMainSize = UDim2.new(0, 980, 0, 600)
	local targetMainPos = UDim2.new(0.5, -490, 0.5, -300)

	local scaleX = targetMainSize.X.Offset / normalMainSize.X.Offset
	local scaleY = targetMainSize.Y.Offset / normalMainSize.Y.Offset

	local originalData = {}
	for _, descendant in ipairs(MainFrame:GetDescendants()) do
		if descendant:IsA("GuiObject") then
			originalData[descendant] = {
				Size = descendant.Size,
				Position = descendant.Position
			}
		end
	end
	
	originalData[SidebarImage] = { Size = SidebarImage.Size, Position = SidebarImage.Position }

	local isMaximized = false
	local tweenInfoMax = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	MaximizeButton.MouseButton1Click:Connect(function()
		if not isMaximized then
			TweenService:Create(MainFrame, tweenInfoMax, {Size = targetMainSize, Position = targetMainPos}):Play()
			for obj, data in pairs(originalData) do
				if obj and obj.Parent then
					local newSize = UDim2.new(data.Size.X.Scale, data.Size.X.Offset * scaleX, data.Size.Y.Scale, data.Size.Y.Offset * scaleY)
					local newPos = UDim2.new(data.Position.X.Scale, data.Position.X.Offset * scaleX, data.Position.Y.Scale, data.Position.Y.Offset * scaleY)
					TweenService:Create(obj, tweenInfoMax, {Size = newSize, Position = newPos}):Play()
				end
			end
			isMaximized = true
			MaximizeButton.Text = "❐"
		else
			TweenService:Create(MainFrame, tweenInfoMax, {Size = normalMainSize, Position = normalMainPos}):Play()
			for obj, data in pairs(originalData) do
				if obj and obj.Parent then
					TweenService:Create(obj, tweenInfoMax, {Size = data.Size, Position = data.Position}):Play()
				end
			end
			isMaximized = false
			MaximizeButton.Text = "□"
		end
	end)

	-- 8. Kéo thả MainFrame (Draggable)
	local dragging, dragInput, dragStart, startPos
	MainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	MainFrame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	local Window = {}
	local firstTab = true

	function Window:AddTab(tabName)
		local TabButton = Instance.new("TextButton")
		TabButton.Name = "Btn" .. tabName
		TabButton.Size = UDim2.new(0, 133, 0, 37)
		TabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BackgroundTransparency = 0.3
		TabButton.BorderSizePixel = 0
		TabButton.Text = tabName
		TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
		TabButton.TextSize = 14
		TabButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TabButton.Parent = Sidebar

		-- Thanh viền chỉ báo (Indicator Bar) bên phải màu trắng neon
		local Indicator = Instance.new("Frame")
		Indicator.Name = "Indicator"
		Indicator.Size = UDim2.new(0, 4, 0, 20)
		Indicator.Position = UDim2.new(1, -8, 0.5, -10)
		Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Indicator.BorderSizePixel = 0
		Indicator.Visible = false
		Indicator.Parent = TabButton

		local IndicatorCorner = Instance.new("UICorner")
		IndicatorCorner.CornerRadius = UDim.new(1, 0)
		IndicatorCorner.Parent = Indicator

		local TabPage = Instance.new("ScrollingFrame")
		TabPage.Name = "Page" .. tabName
		TabPage.Size = UDim2.new(1, 0, 1, 0)
		TabPage.BackgroundTransparency = 1
		TabPage.BorderSizePixel = 0
		TabPage.Visible = false
		TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabPage.ScrollBarThickness = 4
		TabPage.Parent = PagesContainer

		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 6)
		UIListLayout.Parent = TabPage

		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			TabPage.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
		end)

		originalData[TabButton] = { Size = TabButton.Size, Position = TabButton.Position }
		originalData[TabPage] = { Size = TabPage.Size, Position = TabPage.Position }

		TabButton.MouseButton1Click:Connect(function()
			for _, child in ipairs(PagesContainer:GetChildren()) do
				if child:IsA("ScrollingFrame") then child.Visible = false end
			end
			for _, child in ipairs(Sidebar:GetChildren()) do
				if child:IsA("TextButton") then 
					child.TextColor3 = Color3.fromRGB(150, 150, 150)
					local ind = child:FindFirstChild("Indicator")
					if ind then ind.Visible = false end
				end
			end
			TabPage.Visible = true
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			Indicator.Visible = true
		end)

		-- Tự động chọn tab đầu tiên
		if firstTab then
			firstTab = false
			TabPage.Visible = true
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			Indicator.Visible = true
		end

		local TabObj = {}

		-- Thêm tiêu đề phân mục (Section Header) có viền trắng neon bên dưới
		function TabObj:AddSection(sectionName)
			local SectionFrame = Instance.new("Frame")
			SectionFrame.Name = "Section_" .. sectionName
			SectionFrame.Size = UDim2.new(1, -10, 0, 30)
			SectionFrame.BackgroundTransparency = 1
			SectionFrame.BorderSizePixel = 0
			SectionFrame.Parent = TabPage

			local SectionLabel = Instance.new("TextLabel")
			SectionLabel.Size = UDim2.new(1, 0, 1, -2)
			SectionLabel.BackgroundTransparency = 1
			SectionLabel.Text = sectionName
			SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			SectionLabel.TextSize = 14
			SectionLabel.TextXAlignment = Enum.TextXAlignment.Center
			SectionLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			SectionLabel.Parent = SectionFrame

			local SectionLine = Instance.new("Frame")
			SectionLine.Size = UDim2.new(1, 0, 0, 2)
			SectionLine.Position = UDim2.new(0, 0, 1, -2)
			SectionLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionLine.BorderSizePixel = 0
			SectionLine.Parent = SectionFrame

			originalData[SectionFrame] = { Size = SectionFrame.Size, Position = SectionFrame.Position }
		end

		function TabObj:AddToggle(toggleName, defaultState, callback)
			defaultState = defaultState or false
			callback = callback or function() end

			local ToggleButton = Instance.new("TextButton")
			ToggleButton.Name = "Toggle_" .. toggleName
			ToggleButton.Size = UDim2.new(1, -10, 0, 38)
			ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ToggleButton.BackgroundTransparency = 0.3
			ToggleButton.BorderSizePixel = 0
			ToggleButton.AutoButtonColor = false
			ToggleButton.Text = ""
			ToggleButton.Parent = TabPage

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = ToggleButton

			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Size = UDim2.new(1, -50, 1, 0)
			TitleLabel.Position = UDim2.new(0, 12, 0, 0)
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Text = toggleName
			TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			TitleLabel.TextSize = 14
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			TitleLabel.Parent = ToggleButton

			local SquareBox = Instance.new("Frame")
			SquareBox.Size = UDim2.new(0, 20, 0, 20)
			SquareBox.Position = UDim2.new(1, -30, 0.5, -10)
			SquareBox.BackgroundColor3 = defaultState and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
			SquareBox.BackgroundTransparency = defaultState and 0 or 1
			SquareBox.BorderSizePixel = 0
			SquareBox.Parent = ToggleButton

			local SquareCorner = Instance.new("UICorner")
			SquareCorner.CornerRadius = UDim.new(0, 4)
			SquareCorner.Parent = SquareBox

			local SquareStroke = Instance.new("UIStroke")
			SquareStroke.Color = Color3.fromRGB(255, 255, 255)
			SquareStroke.Thickness = 1.5
			SquareStroke.Parent = SquareBox

			local toggled = defaultState

			local function updateToggle(state)
				toggled = state
				local goalBgColor = toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
				local goalTransparency = toggled and 0 or 1

				TweenService:Create(SquareBox, TweenInfo.new(0.2), {BackgroundColor3 = goalBgColor, BackgroundTransparency = goalTransparency}):Play()

				task.spawn(function()
					pcall(callback, toggled)
				end)
			end

			ToggleButton.MouseButton1Click:Connect(function()
				updateToggle(not toggled)
			end)

			originalData[ToggleButton] = { Size = ToggleButton.Size, Position = ToggleButton.Position }

			return {
				Set = function(state)
					updateToggle(state)
				end,
				Get = function()
					return toggled
				end
			}
		end

		function TabObj:AddSlider(sliderName, minVal, maxVal, defaultVal, callback)
			minVal = minVal or 0
			maxVal = maxVal or 100
			defaultVal = defaultVal or minVal
			callback = callback or function() end

			local SliderFrame = Instance.new("Frame")
			SliderFrame.Name = "Slider_" .. sliderName
			SliderFrame.Size = UDim2.new(1, -10, 0, 50)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			SliderFrame.BackgroundTransparency = 0.3
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Parent = TabPage

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = SliderFrame

			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Size = UDim2.new(1, -24, 0, 25)
			TitleLabel.Position = UDim2.new(0, 12, 0, 4)
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Text = sliderName
			TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			TitleLabel.TextSize = 14
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			TitleLabel.Parent = SliderFrame

			local ValueLabel = Instance.new("TextLabel")
			ValueLabel.Size = UDim2.new(0, 50, 0, 25)
			ValueLabel.Position = UDim2.new(1, -62, 0, 4)
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.Text = tostring(defaultVal)
			ValueLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
			ValueLabel.TextSize = 14
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValueLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			ValueLabel.Parent = SliderFrame

			local SliderBar = Instance.new("Frame")
			SliderBar.Size = UDim2.new(1, -24, 0, 6)
			SliderBar.Position = UDim2.new(0, 12, 0, 34)
			SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			SliderBar.BorderSizePixel = 0
			SliderBar.Parent = SliderFrame

			local BarCorner = Instance.new("UICorner")
			BarCorner.CornerRadius = UDim.new(1, 0)
			BarCorner.Parent = SliderBar

			local SliderFill = Instance.new("Frame")
			local initScale = math.clamp((defaultVal - minVal) / (maxVal - minVal), 0, 1)
			SliderFill.Size = UDim2.new(initScale, 0, 1, 0)
			SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			SliderFill.BorderSizePixel = 0
			SliderFill.Parent = SliderBar

			local FillCorner = Instance.new("UICorner")
			FillCorner.CornerRadius = UDim.new(1, 0)
			FillCorner.Parent = SliderFill

			local currentVal = defaultVal
			local draggingSlider = false

			local function updateSlider(input)
				local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
				local val = math.floor(minVal + ((maxVal - minVal) * pos))
				
				SliderFill.Size = UDim2.new(pos, 0, 1, 0)
				ValueLabel.Text = tostring(val)
				currentVal = val

				task.spawn(function()
					pcall(callback, currentVal)
				end)
			end

			SliderBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingSlider = true
					updateSlider(input)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingSlider = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					updateSlider(input)
				end
			end)

			originalData[SliderFrame] = { Size = SliderFrame.Size, Position = SliderFrame.Position }

			return {
				Get = function()
					return currentVal
				end,
				Set = function(val)
					currentVal = math.clamp(val, minVal, maxVal)
					local pos = (currentVal - minVal) / (maxVal - minVal)
					SliderFill.Size = UDim2.new(pos, 0, 1, 0)
					ValueLabel.Text = tostring(currentVal)
					pcall(callback, currentVal)
				end
			}
		end

		return TabObj
	end

	return Window
end

return Library
