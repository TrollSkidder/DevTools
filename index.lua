local Release = "v0.0.0"
local ConfigFolder = "devtools"
local ConfigExtension = ".ssync"

local DevTools = {
	Themes = {
		Dark = {
			PrimaryBackgroundColor = Color3.new(24, 24, 24),
			SecondaryBackgroundColor = Color3.new(19, 19, 19),

			PrimaryTextColor = Color3.new(200, 200, 200),
			SecondaryTextColor = Color3.new(150, 150, 150),
			PrimaryTabTextColor = Color3.new(175, 175, 175),
			SecondaryTabTextColor = Color3.new(150, 150, 150),
		}
	}
}


local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local InterfaceTemplate = (RunService:IsStudio() and Player.PlayerGui.DevUI_Main) or game:GetObjects("rbxassetid://13661638068")[1]

InterfaceTemplate.Enabled = false

local function AddDraggingFunctionality(DragPoint, MainFrame)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false

		DragPoint.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Dragging = true
				MousePos = Input.Position
				FramePos = MainFrame.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		DragPoint.InputChanged:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement then
				DragInput = Input
			end
		end)

		UserInputService.InputChanged:Connect(function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				TweenService:Create(MainFrame, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
			end
		end)
	end)
end

function CreateBlankWindow()
	local Interface = InterfaceTemplate:Clone()
	
	Interface.Enabled = true
	
	local Main = Interface:WaitForChild("Main")
	local ShadowFrame = Main:WaitForChild("Shadow")
	local Shadow = ShadowFrame:WaitForChild("ImageLabel")
	local Sidebar = Main:WaitForChild("Sidebar")
	local Topbar  = Main:WaitForChild("Topbar")
	local SideWindow = Main:WaitForChild("SideWindow")
	local Profile = Sidebar:WaitForChild("Profile")

	Interface.Parent = (RunService:IsStudio() and Player.PlayerGui) or CoreGui

	Profile.Avatar.ImageTransparency = 1
	Profile.Avatar.BackgroundTransparency = 1
	Profile.Username.TextTransparency = 1
	Profile.SubscriptionType.TextTransparency = 1
	Profile.Divider.BackgroundTransparency = 1

	Sidebar.BackgroundTransparency = 1
	Sidebar.Divider.BackgroundTransparency = 1
	Sidebar.CornerRepair.BackgroundTransparency = 1
	Sidebar.CornerRepair2.BackgroundTransparency = 1
	Topbar.BackgroundTransparency = 1
	Topbar.TextLabel.TextTransparency = 1
	Topbar.Minimise.ImageTransparency = 1
	Topbar.Close.ImageTransparency = 1
	Topbar.CornerRepair.BackgroundTransparency = 1
	Topbar.Divider.BackgroundTransparency = 1
	Topbar.Logo.ImageTransparency = 1

	Main.Size = UDim2.new(0, 400, 0, 250)

	Main.BackgroundTransparency = 1
	Shadow.ImageTransparency = 1
	
	return Interface
end

function Minimise(Window)
	local Interface = Window.Interface

	local Main = Interface:WaitForChild("Main")
	local ShadowFrame = Main:WaitForChild("Shadow")
	local Shadow = ShadowFrame:WaitForChild("ImageLabel")
	local Sidebar = Main:WaitForChild("Sidebar")
	local Topbar  = Main:WaitForChild("Topbar")
	local SideWindow = Main:WaitForChild("SideWindow")
	local Profile = Sidebar:WaitForChild("Profile")

	TweenService:Create(Profile.Avatar, TweenInfo.new(.1), { ImageTransparency = 1 }):Play()
	TweenService:Create(Profile.Avatar, TweenInfo.new(.1), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(Profile.Username, TweenInfo.new(.1), { TextTransparency = 1 }):Play()
	TweenService:Create(Profile.SubscriptionType, TweenInfo.new(.1), { TextTransparency = 1 }):Play()
	TweenService:Create(Profile.Divider, TweenInfo.new(.1), { BackgroundTransparency = 1 }):Play()

	TweenService:Create(Sidebar, TweenInfo.new(.1), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(Sidebar.Divider, TweenInfo.new(.1), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(Sidebar.CornerRepair, TweenInfo.new(.1), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(Sidebar.CornerRepair2, TweenInfo.new(.1), { BackgroundTransparency = 1 }):Play()
	
	TweenService:Create(Topbar.CornerRepair, TweenInfo.new(.2), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(Topbar.Divider, TweenInfo.new(.2), { BackgroundTransparency = 1 }):Play()
	
	TweenService:Create(Shadow, TweenInfo.new(.2), { ImageTransparency = .9 }):Play()
	TweenService:Create(Main, TweenInfo.new(.2), { Size = UDim2.new(0, 750, 0, 45), Position = Main.Position - UDim2.new(0, 0, 0, math.ceil(475 / 2) - 22) }):Play()
end

function Maximise(Window)
	local Interface = Window.Interface

	local Main = Interface:WaitForChild("Main")
	local ShadowFrame = Main:WaitForChild("Shadow")
	local Shadow = ShadowFrame:WaitForChild("ImageLabel")
	local Sidebar = Main:WaitForChild("Sidebar")
	local Topbar  = Main:WaitForChild("Topbar")
	local SideWindow = Main:WaitForChild("SideWindow")
	local Profile = Sidebar:WaitForChild("Profile")

	TweenService:Create(Profile.Avatar, TweenInfo.new(.25), { ImageTransparency = 0 }):Play()
	TweenService:Create(Profile.Avatar, TweenInfo.new(.25), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Profile.Username, TweenInfo.new(.25), { TextTransparency = 0 }):Play()
	TweenService:Create(Profile.SubscriptionType, TweenInfo.new(.25), { TextTransparency = 0 }):Play()
	TweenService:Create(Profile.Divider, TweenInfo.new(.25), { BackgroundTransparency = 0 }):Play()

	TweenService:Create(Sidebar, TweenInfo.new(.25), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Sidebar.Divider, TweenInfo.new(.25), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Sidebar.CornerRepair, TweenInfo.new(.25), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Sidebar.CornerRepair2, TweenInfo.new(.25), { BackgroundTransparency = 0 }):Play()

	TweenService:Create(Topbar.CornerRepair, TweenInfo.new(.1), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Topbar.Divider, TweenInfo.new(.1), { BackgroundTransparency = 0 }):Play()

	TweenService:Create(Shadow, TweenInfo.new(.1), { ImageTransparency = .4 }):Play()
	TweenService:Create(Main, TweenInfo.new(.1), { Size = UDim2.new(0, 750, 0, 475), Position = Main.Position + UDim2.new(0, 0, 0, math.ceil(475 / 2) - 22) }):Play()
end

function DevTools:Init(Settings)
	local Window = {}
	local Interface = CreateBlankWindow()
	
	Window.Interface = Interface
	Window._MINIMISED = false
	
	local Main = Interface:WaitForChild("Main")
	local ShadowFrame = Main:WaitForChild("Shadow")
	local Shadow = ShadowFrame:WaitForChild("ImageLabel")
	local Sidebar = Main:WaitForChild("Sidebar")
	local Topbar  = Main:WaitForChild("Topbar")
	local SideWindow = Main:WaitForChild("SideWindow")
	local Profile = Sidebar:WaitForChild("Profile")

	if not Settings then
		return
	end
	
	if Settings.ValidateUser then
		local UserValidated = Settings.ValidateUser(Window)
		
		if not UserValidated then
			Interface:Destroy()
			
			return error("DevTools Global Error: Forbidden")
		end
	end
	
	local function AnimateFOV(FOV, TweenTime, WaitTime, Reverse)
		if not Settings.Options or not Settings.Options.FOVAnimations then
			return
		end
		
		task.spawn(function()
			local Camera = workspace.CurrentCamera

			if Camera then
				local OldFOV = Camera.FieldOfView

				TweenService:Create(Camera, TweenInfo.new(TweenTime or .4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { FieldOfView = FOV }):Play()
				
				if not Reverse then
					return
				end

				task.wait(WaitTime or .8)

				TweenService:Create(Camera, TweenInfo.new(TweenTime or .4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { FieldOfView = OldFOV }):Play()
			end
		end)
	end

	-- // Initiate UI // --

	Profile.Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=48&h=48"
	Profile.Username.Text = Player.DisplayName
	Profile.SubscriptionType.Text = "Premium"

	Profile.Username.TextScaled = true

	Topbar.TextLabel.Text = Settings.Name or "SoftSync DevTools"
	Main.Title.Text = Settings.Title or "DevTools"
	Main.Team.Text = Settings.Subtitle or "by SoftSync"
	
	if Settings.LoadingBackgroundImage then
		Main.ImageLabel.Image = Settings.LoadingBackgroundImage
		TweenService:Create(Main.ImageLabel, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { ImageTransparency = 0 }):Play()
	end
	
	AnimateFOV(workspace.CurrentCamera.FieldOfView - 2.5, 1.25, 5.75, true)

	TweenService:Create(Main, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Shadow, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { ImageTransparency = 0.4 }):Play()

	task.wait(1)

	Main.Team.TextTransparency = 1
	Main.Title.TextTransparency = 1
	Main.Watermark.TextTransparency = 1

	Main.Team.Visible = true
	Main.Title.Visible = true
	Main.Watermark.Visible = true
	
	TweenService:Create(Main.Title, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 0 }):Play()
	
	task.wait(.35)

	TweenService:Create(Main.Team, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 0 }):Play()

	task.wait(1)

	TweenService:Create(Main.Watermark, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 0 }):Play()

	task.wait(3)
	
	TweenService:Create(Main.ImageLabel, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { ImageTransparency = 1 }):Play()
	TweenService:Create(Main.Title, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 1 }):Play()
	TweenService:Create(Main.Team, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 1 }):Play()
	TweenService:Create(Main.Watermark, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 1 }):Play()

	task.wait(.4)

	TweenService:Create(Main, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), { Size = UDim2.new(0, 750, 0, 475) }):Play()

	task.wait(1.3)

	TweenService:Create(Profile.Avatar, TweenInfo.new(.8), { ImageTransparency = 0 }):Play()
	TweenService:Create(Profile.Avatar, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Profile.Username, TweenInfo.new(.8), { TextTransparency = 0 }):Play()
	TweenService:Create(Profile.SubscriptionType, TweenInfo.new(.8), { TextTransparency = 0 }):Play()
	TweenService:Create(Profile.Divider, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Main, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Sidebar, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Topbar, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Topbar.TextLabel, TweenInfo.new(.8), { TextTransparency = 0 }):Play()
	TweenService:Create(Topbar.Minimise, TweenInfo.new(.8), { ImageTransparency = 0 }):Play()
	TweenService:Create(Topbar.Close, TweenInfo.new(.8), { ImageTransparency = 0 }):Play()
	TweenService:Create(Topbar.Divider, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()

	task.wait(.2)

	TweenService:Create(Sidebar.Divider, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Sidebar.CornerRepair, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Sidebar.CornerRepair2, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	TweenService:Create(Topbar.CornerRepair, TweenInfo.new(.8), { BackgroundTransparency = 0 }):Play()
	
	if Settings.Icon then
		task.wait(.2)
		
		Topbar.Logo.Image = Settings.Icon

		TweenService:Create(Topbar.Logo, TweenInfo.new(.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { ImageTransparency = 0 }):Play()
		TweenService:Create(Topbar.TextLabel, TweenInfo.new(.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Position = UDim2.new(0, 42, 0.2, 0) }):Play()
	end
	
	task.wait(.8)

	AddDraggingFunctionality(Topbar, Main)

	Topbar.Close.MouseButton1Click:Connect(function()
		Main:Destroy()
	end)
	
	Topbar.Minimise.MouseButton1Click:Connect(function()
		if Window._MINIMISED then
			TweenService:Create(Topbar.Minimise.Maximise, TweenInfo.new(.1), { ImageTransparency = 1 }):Play()
			TweenService:Create(Topbar.Minimise, TweenInfo.new(.2), { Rotation = 0 }):Play()
			
			Maximise(Window)
		else
			TweenService:Create(Topbar.Minimise.Maximise, TweenInfo.new(.1), { ImageTransparency = 0 }):Play()
			TweenService:Create(Topbar.Minimise, TweenInfo.new(.2), { Rotation = 90 }):Play()
			
			Minimise(Window)
		end
		
		Window._MINIMISED = not Window._MINIMISED
	end)
	
	if Settings.Options and Settings.Options.KillYourself and Player.Character then
		Player.Character:BreakJoints()
	end

	-- // Window Options // --
	local tabs = {}
	local Selected

	function Window:CreateTab(TabOptions)
		local TabWindow = SideWindow.Template.Template:Clone()
		local TabSelection = Sidebar.Tabs.Template:Clone()

		local Instances = 0
		local Tab = {}

		TabWindow.Visible = true
		TabWindow.Parent = SideWindow

		-- // Tween in // --

		if typeof(TabOptions) ~= "table" then
			TabSelection:Destroy()

			error("TabOptions must be a table.")
		end

		table.insert(tabs, {TabSelection})
		TabSelection.Name = "Tab_" .. #tabs
		TabWindow.Name = "Window_" .. #tabs

		if #tabs > 1 then
			TabSelection.Title.TextColor3 = Color3.fromRGB(150, 150, 150)
			TabSelection.Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
		else
			TabSelection.Title.TextColor3 = Color3.fromRGB(175, 175, 175)
			TabSelection.Icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
		end

		TabSelection.SelectionBox.BackgroundTransparency = 1
		TabSelection.Icon.ImageTransparency = 1
		TabSelection.Title.TextTransparency = 1

		TabSelection.Title.Position = UDim2.new(0, 16, 0.1, 0)
		TabSelection.Parent = Sidebar.Tabs

		TabSelection.Title.Text = TabOptions.Name or "Tab"
		TabSelection.Icon.Image = TabOptions.Icon or "rbxassetid://6034687957"

		if not TabOptions.Icon then
			TabSelection.Icon.Visible = false
		end

		TabSelection.Visible = true

		task.spawn(function()
			TweenService:Create(TabSelection.Title, TweenInfo.new(.8), { TextTransparency = 0 }):Play()
			
			if TabOptions.Icon then 
				TweenService:Create(TabSelection.Title, TweenInfo.new(.8), { Position = UDim2.new(0, 42, 0.1, 0) }):Play() 
			end
			
			task.wait(.4)
			
			TweenService:Create(TabSelection.Icon, TweenInfo.new(.8), { ImageTransparency = 0 }):Play()
		end)
		
		task.wait(.2)

		if #tabs < 2 then
			TabSelection.SelectionBox.Position = UDim2.new(0.5, -12, 0.5, 0)
			TweenService:Create(TabSelection.SelectionBox, TweenInfo.new(.4), { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
			TweenService:Create(TabSelection.SelectionBox, TweenInfo.new(.6), { BackgroundTransparency = 0 }):Play()

			SideWindow.UIPageLayout:JumpTo(TabWindow)
			Selected = TabSelection
		end

		TabSelection.Button.MouseButton1Click:Connect(function()
			if Selected == TabSelection then
				return
			end

			SideWindow.UIPageLayout:JumpTo(TabWindow)

			TabSelection.SelectionBox.Position = UDim2.new(0.5, -12, 0.5, 0)
			TabSelection.SelectionBox.BackgroundTransparency = 1

			TweenService:Create(TabSelection.SelectionBox, TweenInfo.new(.4), { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
			TweenService:Create(TabSelection.SelectionBox, TweenInfo.new(.6), { BackgroundTransparency = 0 }):Play()

			if Selected then
				TweenService:Create(Selected.SelectionBox, TweenInfo.new(.4), { Position = UDim2.new(0.5, -12, 0.5, 0) }):Play()
				TweenService:Create(Selected.SelectionBox, TweenInfo.new(.6), { BackgroundTransparency = 1 }):Play()
			end

			Selected = TabSelection
		end)

		-- // Tab Options // --
		function Tab:CreateSection(Name)
			local Section = TabWindow.Section:Clone()

			Instances += 1

			Section.LayoutOrder = Instances

			Section.Parent = TabWindow
			Section.Title.Text = Name or "Section"
			Section.Title.TextTransparency = 1

			Section.Visible = true

			Section.Name = "Section_" .. Instances

			TweenService:Create(Section.Title, TweenInfo.new(.4), { TextTransparency = 0 }):Play()
			task.wait(.2)
		end

		function Tab:CreateButton(Options)
			local Button = TabWindow.Button:Clone()

			if not Options.Name or not Options.Callback then
				Button:Destroy()

				return
			end

			Instances += 1

			Button.LayoutOrder = Instances

			Button.Parent = TabWindow
			Button.Title.Text = Options.Name

			Button.BackgroundTransparency = 1
			Button.Class.TextTransparency = 1
			Button.Title.TextTransparency = 1

			Button.UIStroke.Transparency = 1

			Button.Name = "Button_" .. Instances

			Button.Visible = true

			TweenService:Create(Button, TweenInfo.new(.4), { BackgroundTransparency = 0 }):Play()
			TweenService:Create(Button.Class, TweenInfo.new(.4), { TextTransparency = 0 }):Play()
			TweenService:Create(Button.Title, TweenInfo.new(.4), { TextTransparency = 0 }):Play()

			TweenService:Create(Button.UIStroke, TweenInfo.new(.4), { Transparency = 0 }):Play()

			task.wait(.2)

			Button.Button.MouseButton1Up:Connect(function()
				AnimateFOV(workspace.CurrentCamera.FieldOfView - 1, .1, .1, true)
				
				TweenService:Create(Button.Title, TweenInfo.new(.2), { TextColor3 = Color3.fromRGB(175, 175, 175) }):Play()
				TweenService:Create(Button.UIStroke, TweenInfo.new(.2), { Color = Color3.fromRGB(50, 50, 50) }):Play()
				task.wait(.2)
				TweenService:Create(Button.Title, TweenInfo.new(.2), { TextColor3 = Color3.fromRGB(150, 150, 150) }):Play()
				TweenService:Create(Button.UIStroke, TweenInfo.new(.2), { Color = Color3.fromRGB(40, 40, 40) }):Play()

				local _, err = pcall(Options.Callback)

				if err then
					print("DevTools Callback Error | "..err)
				end
			end)
		end

		function Tab:CreateToggle(Options)
			local Toggle = TabWindow.Toggle:Clone()

			if not Options.Name or not Options.Callback then
				Toggle:Destroy()

				return
			end

			Instances += 1

			Toggle.LayoutOrder = Instances

			Toggle.Parent = TabWindow
			Toggle.Title.Text = Options.Name

			Toggle.BackgroundTransparency = 1
			Toggle.Title.TextTransparency = 1
			Toggle.UIStroke.Transparency = 1

			Toggle.Name = "Toggle_" .. Instances
			Toggle.Visible = true

			TweenService:Create(Toggle, TweenInfo.new(.4), { BackgroundTransparency = 0 }):Play()
			TweenService:Create(Toggle.Title, TweenInfo.new(.4), { TextTransparency = 0 }):Play()

			TweenService:Create(Toggle.UIStroke, TweenInfo.new(.4), { Transparency = 0 }):Play()

			task.wait(.2)

			local Value = false

			Toggle.Button.MouseButton1Up:Connect(function()
				Value = not Value
				
				AnimateFOV(workspace.CurrentCamera.FieldOfView - 1, .1, .1, true)

				if Value then
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,12,0,12)}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 0.5, 0)}):Play()

					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(214, 165, 67)}):Play()
					TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Color = Color3.fromRGB(255, 197, 80)}):Play()

					task.wait(.05)

					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,17,0,17)}):Play()
				else
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,12,0,12)}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -40, 0.5, 0)}):Play()

					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
					TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Color = Color3.fromRGB(125, 125, 125)}):Play()

					task.wait(.05)

					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,17,0,17)}):Play()
				end

				local _, err = pcall(function()
					Options.Callback(Value)
				end)

				if err then
					print("DevTools Callback Error | "..err)
				end
			end)
		end

		function Tab:CreateInput(Options)
			local Input = TabWindow.Input:Clone()

			if not Options.Name or not Options.Callback then
				Input:Destroy()

				return
			end

			Instances += 1

			Input.LayoutOrder = Instances

			Input.Parent = TabWindow
			Input.Title.Text = Options.Name

			Input.BackgroundTransparency = 1
			Input.Title.TextTransparency = 1
			Input.UIStroke.Transparency = 1

			Input.Name = "Input_" .. Instances
			Input.Visible = true

			TweenService:Create(Input, TweenInfo.new(.4), { BackgroundTransparency = 0 }):Play()
			TweenService:Create(Input.Title, TweenInfo.new(.4), { TextTransparency = 0 }):Play()

			TweenService:Create(Input.UIStroke, TweenInfo.new(.4), { Transparency = 0 }):Play()

			task.wait(.2)

			Input.Frame.TextBox.Changed:Connect(function(Property)
				if Property ~= "Text" then
					return
				end
				
				local _, err = pcall(function()
					Options.Callback(Input.Frame.TextBox.Text)
				end)

				if err then
					print("DevTools Callback Error | "..err)
				end
			end)

			Input.Frame.TextBox.Focused:Connect(function()
				TweenService:Create(Input.Title, TweenInfo.new(.2), { TextColor3 = Color3.fromRGB(175, 175, 175) }):Play()
				TweenService:Create(Input.UIStroke, TweenInfo.new(.2), { Color = Color3.fromRGB(50, 50, 50) }):Play()
			end)

			Input.Frame.TextBox.FocusLost:Connect(function()
				TweenService:Create(Input.Title, TweenInfo.new(.2), { TextColor3 = Color3.fromRGB(150, 150, 150) }):Play()
				TweenService:Create(Input.UIStroke, TweenInfo.new(.2), { Color = Color3.fromRGB(40, 40, 40) }):Play()
			end)
		end

		function Tab:CreateLargeInput(Options)
			local Input = TabWindow.LargeInput:Clone()

			if not Options.Name or not Options.Callback then
				Input:Destroy()

				return
			end

			Instances += 1

			Input.LayoutOrder = Instances

			Input.Parent = TabWindow
			Input.Title.Text = Options.Name

			Input.BackgroundTransparency = 1
			Input.Title.TextTransparency = 1
			Input.UIStroke.Transparency = 1

			Input.Name = "Input_" .. Instances
			Input.Visible = true

			TweenService:Create(Input, TweenInfo.new(.4), { BackgroundTransparency = 0 }):Play()
			TweenService:Create(Input.Title, TweenInfo.new(.4), { TextTransparency = 0 }):Play()

			TweenService:Create(Input.UIStroke, TweenInfo.new(.4), { Transparency = 0 }):Play()

			task.wait(.2)

			Input.Frame.TextBox.Changed:Connect(function(Property)
				if Property ~= "Text" then
					return
				end
				
				local _, err = pcall(function()
					Options.Callback(Input.Frame.TextBox.Text)
				end)

				if err then
					print("DevTools Callback Error | "..err)
				end
			end)

			Input.Frame.TextBox.Focused:Connect(function()
				TweenService:Create(Input.Title, TweenInfo.new(.2), { TextColor3 = Color3.fromRGB(175, 175, 175) }):Play()
				TweenService:Create(Input.UIStroke, TweenInfo.new(.2), { Color = Color3.fromRGB(50, 50, 50) }):Play()
			end)

			Input.Frame.TextBox.FocusLost:Connect(function()
				TweenService:Create(Input.Title, TweenInfo.new(.2), { TextColor3 = Color3.fromRGB(150, 150, 150) }):Play()
				TweenService:Create(Input.UIStroke, TweenInfo.new(.2), { Color = Color3.fromRGB(40, 40, 40) }):Play()
			end)
		end

		function Tab:CreateLabel(Text)
			local Label = TabWindow.Label:Clone()

			Instances += 1

			Label.LayoutOrder = Instances

			Label.Parent = TabWindow
			Label.Title.Text = Text

			Label.BackgroundTransparency = 1
			Label.Class.TextTransparency = 1
			Label.Title.TextTransparency = 1

			Label.UIStroke.Transparency = 1

			Label.Name = "Button_" .. Instances

			Label.Visible = true

			TweenService:Create(Label.Class, TweenInfo.new(.4), { TextTransparency = 0 }):Play()
			TweenService:Create(Label.Title, TweenInfo.new(.4), { TextTransparency = 0 }):Play()

			TweenService:Create(Label.UIStroke, TweenInfo.new(.4), { Transparency = 0 }):Play()

			task.wait(.2)
		end

		return Tab
	end

	return Window
end

DevTools.Player = {}

function DevTools.Player:Kill()
	if Player.Character then
		Player.Character:BreakJoints()
	end
end

function DevTools.Player:Kick()
	Player:Kick()

	repeat until false
end

function DevTools.Player:SetSpeed(Speed)
	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		local Humanoid = Player.Character:FindFirstChild("Humanoid")

		Humanoid.WalkSpeed = Speed
	end
end

function DevTools.Player:SetJumpPower(JumpPower)
	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		local Humanoid = Player.Character:FindFirstChild("Humanoid")

		Humanoid.JumpPower = JumpPower
	end
end

return DevTools
