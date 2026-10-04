local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local Library = {}

function Library:CreateWindow(configName)
	local windowName = configName or "MyUI"
	
	-- 1. ScreenGui chính
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = windowName
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = playerGui

	-- 2. MainFrame (Kích thước gốc: 664 x 392)
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 664, 0, 392)
	MainFrame.Position = UDim2.new(0.21154, 0, 0.18374, 0)
	MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BackgroundTransparency = 0.65
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = ScreenGui

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 8)
	MainCorner.Parent = MainFrame

	-- Nút tròn bên ngoài bật/tắt Menu kèm xoay 360 độ
	local ToggleMenuButton = Instance.new("ImageButton")
	ToggleMenuButton.Name = "ToggleMenuButton"
	ToggleMenuButton.Size = UDim2.new(0, 45, 0, 45)
	ToggleMenuButton.Position = UDim2.new(0.05, 0, 0.1, 0)
	ToggleMenuButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	ToggleMenuButton.BackgroundTransparency = 0.4
	ToggleMenuButton.BorderSizePixel = 0
	ToggleMenuButton.Image = "rbxassetid://96966121535917"
	ToggleMenuButton.Parent = ScreenGui

	local ToggleButtonCorner = Instance.new("UICorner")
	ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
	ToggleButtonCorner.Parent = ToggleMenuButton

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

	-- 3. Sidebar (Chứa danh sách các Tab)
	local Sidebar = Instance.new("ScrollingFrame")
	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0, 133, 0, 310)
	Sidebar.Position = UDim2.new(0.01908, 0, 0.15, 0)
	Sidebar.BackgroundTransparency = 1
	Sidebar.BorderSizePixel = 0
	Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
	Sidebar.ScrollBarThickness = 2
	Sidebar.Parent = MainFrame

	local SidebarLayout = Instance.new("UIListLayout")
	SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SidebarLayout.Padding = UDim.new(0, 5)
	SidebarLayout.Parent = Sidebar

	SidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Sidebar.CanvasSize = UDim2.new(0, 0, 0, SidebarLayout.AbsoluteContentSize.Y + 10)
	end)

	-- 3.1 Hình ảnh logo bên trái/trên Sidebar
	local SidebarImage = Instance.new("ImageLabel")
	SidebarImage.Name = "SidebarImage"
	SidebarImage.Size = UDim2.new(0, 133, 0, 40)
	SidebarImage.Position = UDim2.new(0.01908, 0, 0.02532, 0)
	SidebarImage.BackgroundTransparency = 1
	SidebarImage.BorderSizePixel = 0
	SidebarImage.Image = "rbxassetid://96966121535917"
	SidebarImage.ScaleType = Enum.ScaleType.Fit
	SidebarImage.Parent = MainFrame

	-- 4. PagesContainer (Khung chứa nội dung các Tab)
	local PagesContainer = Instance.new("Frame")
	PagesContainer.Name = "PagesContainer"
	PagesContainer.Size = UDim2.new(0, 485, 0, 333)
	PagesContainer.Position = UDim2.new(0.25596, 0, 0.11899, 0)
	PagesContainer.BackgroundTransparency = 1
	PagesContainer.BorderSizePixel = 0
	PagesContainer.Parent = MainFrame

	-- 5. Avatar & Tên tài khoản
	local UserAvatar = Instance.new("ImageLabel")
	UserAvatar.Name = "UserAvatar"
	UserAvatar.Size = UDim2.new(0, 32, 0, 30)
	UserAvatar.Position = UDim2.new(0.89269, 0, 0.02532, 0)
	UserAvatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserAvatar.BorderSizePixel = 0
	UserAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	UserAvatar.Parent = MainFrame

	local AvatarCorner = Instance.new("UICorner")
	AvatarCorner.CornerRadius = UDim.new(0, 50)
	AvatarCorner.Parent = UserAvatar

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

	-- 6. Nút Phóng to / Thu nhỏ (Maximize) & Nút Đóng (Close)
	local CloseButton = Instance.new("TextButton")
	CloseButton.Name = "CloseButton"
	CloseButton.Size = UDim2.new(0, 30, 0, 30)
	CloseButton.Position = UDim2.new(0.94, 0, 0.88, 0)
	CloseButton.BackgroundTransparency = 1
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.TextSize = 16
	CloseButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	CloseButton.Parent = MainFrame

	CloseButton.MouseButton1Click:Connect(function()
		ScreenGui.Enabled = false
	end)

	local MaximizeButton = Instance.new("TextButton")
	MaximizeButton.Name = "MaximizeButton"
	MaximizeButton.Size = UDim2.new(0, 30, 0, 30)
	MaximizeButton.Position = UDim2.new(0.88, 0, 0.88, 0)
	MaximizeButton.BackgroundTransparency = 1
	MaximizeButton.Text = "□"
	MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MaximizeButton.TextSize = 16
	MaximizeButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	MaximizeButton.Parent = MainFrame

	local isMaximized = false
	MaximizeButton.MouseButton1Click:Connect(function()
		isMaximized = not isMaximized
		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		if isMaximized then
			MaximizeButton.Text = "❐"
			TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 850, 0, 500)}):Play()
		else
			MaximizeButton.Text = "□"
			TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 664, 0, 392)}):Play()
		end
	end)

	-- 7. Kéo thả MainFrame
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

	-- 8. Các phương thức quản lý Tab & Thành phần UI
	local Window = {}
	local firstTab = true

	function Window:AddTab(tabName)
		local TabButton = Instance.new("TextButton")
		TabButton.Name = "Btn_" .. tabName
		TabButton.Size = UDim2.new(1, 0, 0, 35)
		TabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		TabButton.BackgroundTransparency = 0.5
		TabButton.BorderSizePixel = 0
		TabButton.Text = "  " .. tabName
		TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
		TabButton.TextSize = 14
		TabButton.TextXAlignment = Enum.TextXAlignment.Left
		TabButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TabButton.Parent = Sidebar

		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 6)
		BtnCorner.Parent = TabButton

		local TabPage = Instance.new("ScrollingFrame")
		TabPage.Name = "Page_" .. tabName
		TabPage.Size = UDim2.new(1, 0, 1, 0)
		TabPage.BackgroundTransparency = 1
		TabPage.BorderSizePixel = 0
		TabPage.Visible = false
		TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabPage.ScrollBarThickness = 4
		TabPage.Parent = PagesContainer

		local PageLayout = Instance.new("UIListLayout")
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 6)
		PageLayout.Parent = TabPage

		PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
		end)

		TabButton.MouseButton1Click:Connect(function()
			for _, child in ipairs(PagesContainer:GetChildren()) do
				if child:IsA("ScrollingFrame") then child.Visible = false end
			end
			for _, child in ipairs(Sidebar:GetChildren()) do
				if child:IsA("TextButton") then 
					child.TextColor3 = Color3.fromRGB(150, 150, 150)
					child.BackgroundTransparency = 0.5
				end
			end
			TabPage.Visible = true
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			TabButton.BackgroundTransparency = 0.2
		end)

		if firstTab then
			firstTab = false
			TabPage.Visible = true
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			TabButton.BackgroundTransparency = 0.2
		end

		local TabObj = {}

		function TabObj:AddSection(sectionName)
			local SectionFrame = Instance.new("Frame")
			SectionFrame.Size = UDim2.new(1, -10, 0, 25)
			SectionFrame.BackgroundTransparency = 1
			SectionFrame.Parent = TabPage

			local SectionLabel = Instance.new("TextLabel")
			SectionLabel.Size = UDim2.new(1, 0, 1, 0)
			SectionLabel.BackgroundTransparency = 1
			SectionLabel.Text = sectionName
			SectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			SectionLabel.TextSize = 13
			SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
			SectionLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			SectionLabel.Parent = SectionFrame
		end

		function TabObj:AddToggle(toggleName, defaultState, callback)
			defaultState = defaultState or false
			callback = callback or function() end

			local ToggleBtn = Instance.new("TextButton")
			ToggleBtn.Size = UDim2.new(1, -10, 0, 38)
			ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ToggleBtn.BackgroundTransparency = 0.3
			ToggleBtn.BorderSizePixel = 0
			ToggleBtn.AutoButtonColor = false
			ToggleBtn.Text = ""
			ToggleBtn.Parent = TabPage

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 6)
			Corner.Parent = ToggleBtn

			local Title = Instance.new("TextLabel")
			Title.Size = UDim2.new(1, -50, 1, 0)
			Title.Position = UDim2.new(0, 12, 0, 0)
			Title.BackgroundTransparency = 1
			Title.Text = toggleName
			Title.TextColor3 = Color3.fromRGB(220, 220, 220)
			Title.TextSize = 14
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.Parent = ToggleBtn

			local SquareBox = Instance.new("Frame")
			SquareBox.Size = UDim2.new(0, 20, 0, 20)
			SquareBox.Position = UDim2.new(1, -30, 0.5, -10)
			SquareBox.BackgroundColor3 = defaultState and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
			SquareBox.BackgroundTransparency = defaultState and 0 or 1
			SquareBox.BorderSizePixel = 0
			SquareBox.Parent = ToggleBtn

			local BoxCorner = Instance.new("UICorner")
			BoxCorner.CornerRadius = UDim.new(0, 4)
			BoxCorner.Parent = SquareBox

			local BoxStroke = Instance.new("UIStroke")
			BoxStroke.Color = Color3.fromRGB(255, 255, 255)
			BoxStroke.Thickness = 1.5
			BoxStroke.Parent = SquareBox

			local toggled = defaultState
			ToggleBtn.MouseButton1Click:Connect(function()
				toggled = not toggled
				SquareBox.BackgroundColor3 = toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
				SquareBox.BackgroundTransparency = toggled and 0 or 1
				task.spawn(function() pcall(callback, toggled) end)
			end)
		end

		function TabObj:AddDropdown(dropdownName, optionsList, defaultOption, callback)
			optionsList = optionsList or {}
			defaultOption = defaultOption or optionsList[1] or ""
			callback = callback or function() end

			local DropdownFrame = Instance.new("Frame")
			DropdownFrame.Size = UDim2.new(1, -10, 0, 38)
			DropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			DropdownFrame.BackgroundTransparency = 0.3
			DropdownFrame.BorderSizePixel = 0
			DropdownFrame.ClipsDescendants = true
			DropdownFrame.Parent = TabPage

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 6)
			Corner.Parent = DropdownFrame

			local TitleBtn = Instance.new("TextButton")
			TitleBtn.Size = UDim2.new(1, 0, 0, 38)
			TitleBtn.BackgroundTransparency = 1
			TitleBtn.Text = "  " .. dropdownName .. ": " .. tostring(defaultOption)
			TitleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
			TitleBtn.TextSize = 14
			TitleBtn.TextXAlignment = Enum.TextXAlignment.Left
			TitleBtn.Parent = DropdownFrame

			local DropdownListLayout = Instance.new("UIListLayout")
			DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			DropdownListLayout.Padding = UDim.new(0, 2)
			DropdownListLayout.Parent = DropdownFrame

			local isOpen = false
			local selectedVal = defaultOption

			TitleBtn.MouseButton1Click:Connect(function()
				isOpen = not isOpen
				if isOpen then
					DropdownFrame.Size = UDim2.new(1, -10, 0, 38 + (#optionsList * 32) + 5)
				else
					DropdownFrame.Size = UDim2.new(1, -10, 0, 38)
				end
			end)

			for _, opt in ipairs(optionsList) do
				local OptBtn = Instance.new("TextButton")
				OptBtn.Size = UDim2.new(1, -16, 0, 30)
				OptBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				OptBtn.BackgroundTransparency = 0.5
				OptBtn.BorderSizePixel = 0
				OptBtn.Text = tostring(opt)
				OptBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
				OptBtn.TextSize = 13
				OptBtn.Parent = DropdownFrame

				local OptCorner = Instance.new("UICorner")
				OptCorner.CornerRadius = UDim.new(0, 4)
				OptCorner.Parent = OptBtn

				OptBtn.MouseButton1Click:Connect(function()
					selectedVal = opt
					TitleBtn.Text = "  " .. dropdownName .. ": " .. tostring(selectedVal)
					isOpen = false
					DropdownFrame.Size = UDim2.new(1, -10, 0, 38)
					task.spawn(function() pcall(callback, selectedVal) end)
				end)
			end
		end

		return TabObj
	end

	return Window
end

return Library
