local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Roact.React)
local ReactRoblox = require(ReplicatedStorage.Roact.ReactRoblox)

local Players = game:GetService("Players")
local app
local Update = React.Component:extend("Update")

local function BlockColor(props)
	
	return ReactRoblox.createElement(React.Portal, {
		target = workspace
	}, {
		MainPart = React.createElement("Part", {
			Anchored = true,
			Position = Vector3.new(0, 5, 0),
			Color = props.color
			
		}, {
			ClickActivate = React.createElement("ClickDetector", {
				[React.Event.MouseClick] = function()
					props.invokeClick()
				end,

			})
		})
	})
	
end

function Update:init()
	self.state = {
		color = Color3.fromRGB(0,0,0),
		genNum = math.random(10, 20)
	}

	self.count, self.countUpdate = React.createBinding(0)
	self.buttonRef = React.createRef()

	print(self.state.genNum)
	
end

function Update:render()
	local count = self.count:getValue()
	local color = self.state.color 
	
	local genTable = {
		color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
		
	}
	
	local function state()

		if count == self.state.genNum then
			React.unmount(app)
			return 
		end

		self.countUpdate(self.count:getValue() + 1)
		
		print(self.buttonRef:getValue().Text)

		self:setState(function(state)
			
			return genTable

		end)

		
	end
	print()
	return React.createElement("ScreenGui", {}, {
		myElement = React.createElement("TextButton", {
			Size = UDim2.new(0, 50, 0, 50),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundColor3 = color,
			Text = self.count:map(function(value)
				return count
			end),
			[React.Ref] = self.buttonRef,
			[React.Event.MouseButton1Click] = state,
		}), 
		
		part = React.createElement(BlockColor, {
			color = color,
			invokeClick = state,	
		})
		
	})
end

function Update:willUnmount()
	local count = self.count
	local color = self.state.color 
	
	print("State was clicked " .. count:getValue() .. " times!")
	
end

local mainElement = React.createElement(Update)

app = ReactRoblox.createRoot(mainElement, Players.LocalPlayer.PlayerGui, "UI")

wait(10)

--React.unmount(app)