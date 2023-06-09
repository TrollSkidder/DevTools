# DevTools
This library is in alpha and may lack on features.

## Loadstring

```lua
local DevTools = loadstring(game:HttpGet("https://raw.githubusercontent.com/05-4/DevTools/main/index.lua"))()
```

## Initiating DevTools

```lua
local Window = DevTools:Init({
	Name = "Script Hub", -- [Required]
	Title = "DevTools", -- [Required]
	Description = "by SoftSync", -- [Required]
	Icon = "rbxassetid://6031280882", -- [Optional]
	LoadingBackgroundImage = "rbxassetid://13677037989", -- [Optional]
	
	Options = {
		KillYourself = false, -- [Optional] (Unfortunately) Set this to true to reset character on launch
		FOVAnimations = false, -- [Optional] Set this to true to enable FOV Animations (In Development)
	}
})
```

## Create a Tab

```lua
local Tab = Window:CreateTab({ Name = "Player", Icon = "rbxassetid://6034287594" })
```

## Example

```lua
local DevTools = loadstring(game:HttpGet("https://raw.githubusercontent.com/05-4/DevTools/main/index.lua"))()

local Window = DevTools:Init({
	Name = "Example",
	Title = "Example",
	Description = "by TeamName",
	Icon = "rbxassetid://6031280882",
	LoadingBackgroundImage = "rbxassetid://13677037989",
	
	Options = {
		KillYourself = false,
		FOVAnimations = false,
	}
})

local Tab = Window:CreateTab({ Name = "Player", Icon = "rbxassetid://6034287594" })

Tab:CreateSection("Button")

Tab:CreateButton({
	Name = "Reset Character",
	Callback = function()
		Player.Character:BreakJoints()
	end,
})

Tab:CreateSection("Toggle")

local LoopReset = false

Tab:CreateToggle({
	Name = "Loop Reset Character",
	Callback = function(Value)
		LoopReset = Value
	end,
})

RunService.RenderStepped:Connect(function()
	if LoopReset and Player.Character then
		Player.Character:BreakJoints()
	end
end)

Tab:CreateSection("Input")

Tab:CreateInput({
	Name = "Input",
	Callback = function(Value)
		print(Value)
	end,
})

Tab:CreateLargeInput({
	Name = "Large Input",
	Callback = function(Value)
		print(Value)
	end,
})
```
