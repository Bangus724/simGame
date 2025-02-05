local self = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReactFolder = ReplicatedStorage.Roact
local React = require(ReactFolder.React)
local ReactRoblox = require(ReactFolder.ReactRoblox)

function self.newFrame(name)
    return {
        Name = name or "Frame",
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Transparency = 1
    }
end

function self.newSideButton(name)
    return {
        Name = name or "TextButton",
        Size = UDim2.fromScale(.2, .2),
        SizeConstraint = Enum.SizeConstraint.RelativeXX
    }

end

function self.newScreenGui(name)
    local container = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    container.Name = name
    container.ResetOnSpawn = false
    container.IgnoreGuiInset = true

    return container
end

return self