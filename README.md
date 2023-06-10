# DevTools

DevTools provides various features and functionalities that can be integrated into your script to streamline the development process. The library is constantly evolving, and your feedback is highly appreciated. If you find any bugs, please join our [Discord server](https://discord.com/invite/RZHFJjXd3m).

![image](DevTools_Alpha_Banner.png)

## Loadstring

To begin using DevTools, you need to import the library into your project. Here's an example of how to import DevTools:

```lua
local DevTools = loadstring(game:HttpGet("https://raw.githubusercontent.com/05-4/DevTools/main/index.lua"))()
```

## Initiating DevTools

After loading DevTools, you can initiate it by creating a new window.You have the option to set parameters like an icon and a loading background image. These customization options allow you to create a visually appealing interface for your users needs.

```lua
local Window = DevTools:Init({
    Name = "Script Hub", -- Required: Provide a name for the window
    Title = "DevTools", -- Required: Set the title of the loading screen
    Description = "by SoftSync", -- Required: Add a brief description for the loading screen
    Icon = "rbxassetid://6031280882", -- Optional: Set an icon for the window
    LoadingBackgroundImage = "rbxassetid://13677037989", -- Optional: Set a background image for the loading screen
    Options = {
        KillYourself = false, -- Optional: Set to true to reset character on launch
        FOVAnimations = false, -- Optional: Set to true to enable FOV Animations
    }
})
```

DevTools offers some essential features to help you build a powerful development interface:

## Tabs

Tabs allow you to organize related features or functionalities. You can create multiple tabs to represent different categories, here's an example:

```lua
local Tab = Window:CreateTab({ Name = "Player", Icon = "rbxassetid://6034287594" })
```

## Sections

Within each tab, you can further divide the content into sections. Sections act as titles to divide your features yet again, making a visually appealing and spacious interface

```lua
Tab:CreateSection("Buttons")
```

## Buttons

Buttons are interactive elements that execute when clicked (I can't believe I have to explain this). You can define a button's name and associate a callback function to perform actions like resetting a character or triggering an event:

```lua
Tab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        DevTools.Player:Kill()
    end,
})
```

## Toggles

Toggles are interactive switches that enable or disable specific functionalities or behaviors. The callbacks value will be true when toggled on and false when it's toggled off. Toggles are off by default, though we're adding the option to set a default value: 

```lua
local LoopReset = false

Tab:CreateToggle({
    Name = "Loop Reset Character",
    Callback = function(Value)
        LoopReset = Value
    end,
})

game:GetService("RunService").RenderStepped:Connect(function()
	if LoopReset then
		DevTools.Player:Kill()
	end
end)
```

## Input Fields

DevTools provides input fields, you can create simple input fields or larger input fields based on your needs. These fields enable you to gather text from the user. Inputs will execute your callback with the text value when changed:

```lua
Tab:CreateInput({
    Name = "Input",
    Callback = function(Value)
        print(Value)
    end,
})
```

## Example Script

Here's everything put together:

```lua
local DevTools = loadstring(game:HttpGet("https://raw.githubusercontent.com/05-4/DevTools/main/index.lua"))()

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

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

# Notes

We'd like to thank our developers for helping us with DevTools.

Website: [softsync.org](https://softsync.org)
Terms of Use: [softsync.org/about](https://softsync.org/about)
Discord Server: [softsync.org/discord](https://softsync.org/discord)
