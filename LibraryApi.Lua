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

	local isMaximized = false
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	MaximizeButton.MouseButton1Click:Connect(function()
		if not isMaximized then
			TweenService:Create(MainFrame, tweenInfo, {Size = targetMainSize, Position = targetMainPos}):Play()
			for obj, data in pairs(originalData) do
				if obj and obj.Parent then
					local newSize = UDim2.new(data.Size.X.Scale, data.Size.X.Offset * scaleX, data.Size.Y.Scale, data.Size.Y.Offset * scaleY)
					local newPos = UDim2.new(data.Position.X.Scale, data.Position.X.Offset * scaleX, data.Position.Y.Scale, data.Position.Y.Offset * scaleY)
					TweenService:Create(obj, tweenInfo, {Size = newSize, Position = newPos}):Play()
				end
			end
			isMaximized = true
			MaximizeButton.Text = "❐"
		else
			TweenService:Create(MainFrame, tweenInfo, {Size = normalMainSize, Position = normalMainPos}):Play()
			for obj, data in pairs(originalData) do
				if obj and obj.Parent then
					TweenService:Create(obj, tweenInfo, {Size = data.Size, Position = data.Position}):Play()
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

		local TabPage = Instance.new("ScrollingFrame") -- Đổi thành ScrollingFrame để chứa nhiều item không bị tràn
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
				if child:IsA("TextButton") then child.TextColor3 = Color3.fromRGB(150, 150, 150) end
			end
			TabPage.Visible = true
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		end)

		local TabObj = {}

		-- ** HÀM THÊM TOGGLE (BẬT / TẮT CHỨC NĂNG) **
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

			-- Khung Switch nhỏ bên phải
			local SwitchBg = Instance.new("Frame")
			SwitchBg.Size = UDim2.new(0, 38, 0, 20)
			SwitchBg.Position = UDim2.new(1, -46, 0.5, -10)
			SwitchBg.BackgroundColor3 = defaultState and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(50, 50, 50)
			SwitchBg.BorderSizePixel = 0
			SwitchBg.Parent = ToggleButton

			local SwitchCorner = Instance.new("UICorner")
			SwitchCorner.CornerRadius = UDim.new(1, 0)
			SwitchCorner.Parent = SwitchBg

			local SwitchCircle = Instance.new("Frame")
			SwitchCircle.Size = UDim2.new(0, 16, 0, 16)
			SwitchCircle.Position = defaultState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
			SwitchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SwitchCircle.BorderSizePixel = 0
			SwitchCircle.Parent = SwitchBg

			local CircleCorner = Instance.new("UICorner")
			CircleCorner.CornerRadius = UDim.new(1, 0)
			CircleCorner.Parent = SwitchCircle

			local toggled = defaultState

			local function updateToggle(state)
				toggled = state
				local goalBgColor = toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(50, 50, 50)
				local goalCirclePos = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)

				TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = goalBgColor}):Play()
				TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {Position = goalCirclePos}):Play()

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

		-- ** HÀM THÊM SLIDER (KÉO CHỈNH THÔNG SỐ) **
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

			-- Thanh chứa slider
			local SliderBar = Instance.new("Frame")
			SliderBar.Size = UDim2.new(1, -24, 0, 6)
			SliderBar.Position = UDim2.new(0, 12, 0, 34)
			SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			SliderBar.BorderSizePixel = 0
			SliderBar.Parent = SliderFrame

			local BarCorner = Instance.new("UICorner")
			BarCorner.CornerRadius = UDim.new(1, 0)
			BarCorner.Parent = SliderBar

			-- Phần màu xanh thể hiện giá trị đã kéo
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
