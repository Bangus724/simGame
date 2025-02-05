local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ReactFolder = ReplicatedStorage.Roact
local React = require(ReactFolder.React)
local ReactRoblox = require(ReactFolder.ReactRoblox)
local Presets = require(ReplicatedStorage.ReactPresets)

local PlayerGui = LocalPlayer.PlayerGui
local container = Presets.newScreenGui("MainUI")
local root = ReactRoblox.createRoot(container)

local function MainButtons()
	local ButtonProps:table = Presets.newSideButton()
	
	local oneButton = table.clone(ButtonProps)
	oneButton.Name = "OneButton"

	local twoButton = table.clone(ButtonProps)
	twoButton.Name = "TwoButton"

	return React.createElement(React.Fragment, nil, {
		oneButton = React.createElement("TextButton", oneButton),
		twoButton = React.createElement("TextButton", twoButton),
	})
end

local function holderFrame()
	local props = Presets.newFrame("HolderFrame")
	props.Position = UDim2.fromScale(0.5, 0.5)
	props.Size = UDim2.fromScale(1, 0.3)

	return props
end



local MainFrame = React.createElement("Frame", holderFrame(), {
	React.createElement(MainButtons), 
	React.createElement("UIGridLayout", {
		CellPadding = UDim2.fromScale(.1, .1),
		CellSize = UDim2.fromOffset(75, 75),
		FillDirection = Enum.FillDirection.Vertical

	}),
	React.createElement("UIPadding", {
		PaddingLeft = UDim.new(0, 10)
	})

})

print()
root:render(MainFrame)