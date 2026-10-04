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

function Library:CreateWindow(configName)
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

	-- 6. Nút Đóng
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

	-- 7. Kéo thả MainFrame (Đã sửa lỗi cú pháp ở đây)
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
	return Window
end

return Library
